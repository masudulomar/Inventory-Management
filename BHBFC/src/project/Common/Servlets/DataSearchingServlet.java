package project.Common.Servlets;

import java.io.File;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.Common.Infos.CommonInfo;
import project.Utilities.DBUtils;
import project.Utilities.ProjectUtils;
import project.validators.PRMSValidator;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 * Servlet implementation class DataSearchingServlet
 */
@WebServlet("/DataSearchingServlet")
public class DataSearchingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DataSearchingServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DBUtils dbUtils = new DBUtils();
		Map<String, Object> parameter = new HashMap<String, Object>();
		String LoggedBranch = request.getParameter("loggedBranch");
		String Branchcode = request.getParameter("BranchCode");
		String ReportType = request.getParameter("ReportType");
		String ProductNature="";
		String ProjectPath = ProjectUtils.GetProjectPath();

		Map<String, String> brn_info = new HashMap<String, String>();
		brn_info.put("branch_code", Branchcode);
		PRMSValidator branValidator = new PRMSValidator();
		try {
			brn_info = branValidator.BranchKeyPress(brn_info);
			parameter.put("BRANCH_NAME", brn_info.get("BRN_NAME"));
			parameter.put("BRANCH_ADDRESS", brn_info.get("BRN_ADDRESS"));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		con = dbUtils.GetConnection();
		parameter.put("LOGO_PATH", ProjectPath + CommonInfo._LOGO_PATH);
		parameter.put("M_LOGO", ProjectPath + CommonInfo._LOGO_PATH_2);
		parameter.put("SUBREPORT_DIR", ProjectPath + CommonInfo._REPORT_DIR_PN);

		if (ReportType.equals("PrintAccountList")) {
			parameter.put("P_branch_code", Branchcode);
		} else if (ReportType.equals("SonaliPaymentSlip")) {
			parameter.put("P_branch_code", Branchcode);
			parameter.put("p_loanCode", request.getParameter("LoanCode"));
			parameter.put("SONALI_LOGO", ProjectPath + CommonInfo.SONALIBANKLOGO);
			parameter.put("SONALIBANK_HEADER", ProjectPath + CommonInfo.SONALIBANKHEADER);
		} else if (ReportType.equals("FeesCollection")||ReportType.equals("FeesCollectionSummary")  ||ReportType.equals("BeftnCollection")|| ReportType.equals("FeesCollectionPurpose") ||ReportType.equals("FeesCollectionSummaryCutoff") ) {
			if(Branchcode.equalsIgnoreCase("9999")) {
				parameter.put("P_branch_code", "%");
			}
			else
			{
				parameter.put("P_branch_code", Branchcode);
			}
			
			parameter.put("p_fromDate", request.getParameter("FromDate"));
			parameter.put("p_toDate",  request.getParameter("ToDate"));
			
			
		} else if (ReportType.equals("branchloanststus") || ReportType.equals("ExpiredLoanCase")) {
			parameter.put("p_BranchCode", Branchcode);
			parameter.put("P_FinYear", request.getParameter("FinYear"));
		} else if (ReportType.equals("branchloanststusall") || ReportType.equals("branchloanststusNatue")||   ReportType.equals("branchloanststusall_slab")||ReportType.equals("branchloanststusNatue_slab")
				||   ReportType.equals("obsiConsolidate")||ReportType.equals("obsibyNature")) {
			parameter.put("p_BranchCode", Branchcode);
			parameter.put("P_FinYear", request.getParameter("FinYear"));
		} else if (ReportType.equals("SingleAccountRecovery")) {
			parameter.put("p_BranchCode", Branchcode);
			parameter.put("P_FinYear", request.getParameter("FinYear"));
			parameter.put("p_loanCode", request.getParameter("LoanCodeNo"));
		} else if (ReportType.equals("ActiveLoanList")) {
			parameter.put("p_BranchCode", Branchcode);
		}
		 else if (ReportType.equals("BankSummary")) {
				parameter.put("p_branch", Branchcode);
				parameter.put("p_product", request.getParameter("ProductType"));
				parameter.put("p_Nature", request.getParameter("ProductNature"));
				parameter.put("p_type", request.getParameter("LoanType"));
				parameter.put("p_from_date", request.getParameter("FromDate"));
				parameter.put("p_to_date", request.getParameter("ToDate"));
				String BankCode=request.getParameter("BankCode");
				parameter.put("p_Bank", BankCode.equals("0")? "%%":BankCode);
		}
		 else if (ReportType.equals("BankSuspense")) {
				parameter.put("p_branch",  Branchcode.equals("9999")? "%":Branchcode);
				parameter.put("p_from_date", request.getParameter("FromDate"));
				parameter.put("p_to_date", request.getParameter("ToDate"));
				String BankCode=request.getParameter("BankCode");
				parameter.put("p_Bank", BankCode.equals("0")? "%":BankCode);
		}
		 else if (ReportType.equals("rconsolidatedClassification")) {			 
			 parameter.put("P_fin_year", request.getParameter("FinYear"));
			 parameter.put("p_status", request.getParameter("StatusType"));
		}
		
		else if (ReportType.equals("PersonalLedger")) {
			String LoanAc=request.getParameter("LoanCodeNo");
			CallableStatement cstmt = null;
			try {
				cstmt = con.prepareCall("CALL pkg_Report_LMS.sp_product_nature(?,?,?)");
				cstmt.setString(1, Branchcode);
				cstmt.setString(2, LoanAc);
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.execute();
				ProductNature = cstmt.getString(3);
				cstmt.close();
				
				if(ProductNature.equals("GOV")) {
					ReportType="PersonalLedgerGov";
				}
				else if(ProductNature.equals("EMI")) {
					ReportType="PersonalLedgerEmi";
				}
				else if(ProductNature.equals("ISF")) {
					ReportType="PersonalLedgerIsf";
				}
				else if(ProductNature.equals("OCR")) {
					ReportType="PersonalLedgerOcr";
				}
				else
				{
					ReportType="PersonalLedgerOld";
				}
				
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			parameter.put("p_BranchCode", Branchcode);
			parameter.put("P_FinYear", request.getParameter("FinYear"));
			parameter.put("p_LoanAC", LoanAc);
			parameter.put("p_prinType", request.getParameter("PrintType"));
		}
		else if (ReportType.equals("LoanLedgerSummary")) {
			String ProductType = request.getParameter("ProductType");

			if (ProductType.equals("8")) {
				ReportType = "LoanLedgerSummary";
			} else {
				ReportType = "LoanLedgerSummaryOld";
			}

			parameter.put("p_BranchCode", Branchcode);
			parameter.put("P_FinYear", request.getParameter("FinYear"));
			parameter.put("p_loanType", request.getParameter("LoanType"));
			parameter.put("p_prinType", request.getParameter("PrintType"));

		}
		
		
		String report_path = GetReportPath(ReportType);
		try {
			File file = new File(ProjectPath + report_path);
			
			byte[] bytes = JasperRunManager.runReportToPdf(file.getCanonicalPath(), parameter, con);

			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream outputStream = response.getOutputStream();
			outputStream.write(bytes, 0, bytes.length);
			outputStream.flush();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	private String GetReportPath(String LoanType) {
		String ReportPath = "";
		if (LoanType.equals("BranchLoan")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "BranchWiseLoanAcc.jasper";
		} else if (LoanType.equals("SonaliPaymentSlip")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "SonaliMemoBook.jasper";
		} else if (LoanType.equals("FeesCollection")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "FeeCollectionReport.jasper";
		} 
		else if (LoanType.equals("FeesCollectionSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "FeeCollectionSummaryAPI.jasper";
		} 
		else if (LoanType.equals("FeesCollectionPurpose")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "FeeCollectionReportByPurpose.jasper";
		} 		
		else if (LoanType.equals("FeesCollectionSummaryCutoff")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "FeeCollectionSummaryAPICutDate.jasper";
		}
		else if (LoanType.equals("BankSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "BankSummary.jasper";
		}
		else if (LoanType.equals("BankSuspense")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "lmsMemoSuspenseList.jasper";
		}		
		else if (LoanType.equals("PrintAccountList")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "BranchAccountList.jasper";
		} else if (LoanType.equals("branchloanststus")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "LoanRecoveryReport.jasper";
		} 		
		else if (LoanType.equals("branchloanststusall_slab")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "LoanRecoverySlabConsolidate.jasper";
		} else if (LoanType.equals("branchloanststusNatue_slab")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "LoanRecoverySlabByNature.jasper";
		}		
		else if (LoanType.equals("branchloanststusall")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "LoanRecoveryReportConsolidate.jasper";
		} else if (LoanType.equals("branchloanststusNatue")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "LoanRecoveryReportByNature.jasper";
		}		
		else if (LoanType.equals("obsiConsolidate")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "LoanOBSIByConrolidated.jasper";
		} else if (LoanType.equals("obsibyNature")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "LoanOBSIByNature.jasper";
		}						
		else if (LoanType.equals("ExpiredLoanCase")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "ExpiredLoanCase.jasper";
		} else if (LoanType.equals("BeftnCollection")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "BeftnCollection.jasper";
		} else if (LoanType.equals("SingleAccountRecovery")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "SingleAccountRecovery.jasper";
		} else if (LoanType.equals("ActiveLoanList")) {
			ReportPath = CommonInfo._REPORT_DIR_DST + "ActiveLoanAccountList.jasper";
		}
		else if(LoanType.equalsIgnoreCase("PersonalLedgerGov")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "lms_personal_ledger_gov.jasper";
		}
		else if(LoanType.equalsIgnoreCase("PersonalLedgerOld")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "lms_personal_ledger_old.jasper";
		}
		else if(LoanType.equalsIgnoreCase("PersonalLedgerEmi")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "lms_personal_ledger_emi.jasper";
		}else if(LoanType.equalsIgnoreCase("PersonalLedgerIsf")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "lms_personal_ledger_isf.jasper";
		}
		else if(LoanType.equalsIgnoreCase("PersonalLedgerOcr")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "lms_personal_ledger_ocr.jasper";
		}				
		else if(LoanType.equalsIgnoreCase("LoanLedgerSummary")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "lms_LoanLedgerSummary.jasper";
		}
		else if(LoanType.equalsIgnoreCase("LoanLedgerSummaryOld")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "lms_LoanLedgerSummaryOld.jasper";
		}
		else if(LoanType.equalsIgnoreCase("rconsolidatedClassification")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "lms_classification_report.jasper";
		}
		
		
		else {
			ReportPath = CommonInfo._REPORT_DIR_DST + "SearchingTools.jasper";
		}
		return ReportPath;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
