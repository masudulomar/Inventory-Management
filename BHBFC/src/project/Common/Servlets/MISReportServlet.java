package project.Common.Servlets;

import java.io.File;
import java.io.IOException;
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

import net.sf.jasperreports.engine.JasperRunManager;
import project.Common.Infos.CommonInfo;
import project.Utilities.DBUtils;
import project.Utilities.ProjectUtils;
import project.validators.PRMSValidator;

/**
 * Servlet implementation class MISReportServlet
 */
@WebServlet("/MISReportServlet")
public class MISReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MISReportServlet() {
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
		String ReportType = request.getParameter("ReportType");
		String BranchCode = request.getParameter("BranchCode");
		String report_path = GetReportPath(ReportType);
		String ProjectPath = ProjectUtils.GetProjectPath();

		Map<String, String> brn_info = new HashMap<String, String>();
		brn_info.put("branch_code", BranchCode);
		PRMSValidator branValidator = new PRMSValidator();
		try {
			brn_info = branValidator.BranchKeyPress(brn_info);
			parameter.put("BRANCH_NAME", brn_info.get("BRN_NAME"));
			parameter.put("BRANCH_ADDRESS", brn_info.get("BRN_ADDRESS"));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		parameter.put("LOGO_PATH", ProjectPath + CommonInfo._LOGO_PATH3);
		parameter.put("M_LOGO", ProjectPath + CommonInfo._LOGO_PATH_2);
		parameter.put("SUBREPORT_DIR", ProjectPath + CommonInfo._REPORT_DIR_MIS);
		parameter.put("FromDate", request.getParameter("FromDate"));
		parameter.put("ToDate", request.getParameter("ToDate"));
		parameter.put("P_BRANCH", BranchCode);

		if (ReportType.equals("LoanRecoverySummary") || ReportType.equals("AuditDisposalSummary")
				|| ReportType.equals("KharidabariSummary") || ReportType.equals("CourtcaseSummary")
				|| ReportType.equals("LoanSanctionDisburseSummary") || ReportType.equals("allLoanItemSummaryLoan")
				|| ReportType.equals("allOthersItemSummaryLoan")|| ReportType.equals("misBranchSummary") ||ReportType.equals("ZoneWiseSummary") ) {

			parameter.put("P_TARGET_CODE", request.getParameter("TargetCode"));

		} else if (ReportType.equals("RecoveryPerformance") || ReportType.equals("ClassifiedRecoveryPerformance")
				|| ReportType.equals("MiscCCPerformance") || ReportType.equals("ExecutionCCPerformance")
				|| ReportType.equals("PossesionKharidabariPerformance")
				|| ReportType.equals("SaleKharidabariPerformance") || ReportType.equals("commercialAuditPerformance")
				|| ReportType.equals("PostAuditPerformance") || ReportType.equals("LoanSanctionPerformance")
				|| ReportType.equals("LoanDisbursePerformance") || ReportType.equals("DeedReturnPerformance")) {
			parameter.put("P_REPORT_TYPE", ReportType);
			parameter.put("P_TARGET_CODE", request.getParameter("TargetCode"));
			parameter.put("P_PERFORMANCE_TYPE", request.getParameter("performanceType"));
		}

		try {
			File file = new File(ProjectPath + report_path);
			con = dbUtils.GetConnection();
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	private String GetReportPath(String ReportType) {
		String ReportPath = "";
		if (ReportType.equals("misBranchSummary")) {
			//ReportPath = CommonInfo._REPORT_DIR_MIS + "MisBranchWiseSummaryReport.jasper";
			ReportPath = CommonInfo._REPORT_DIR_MIS + "BranchWiseSummaryReport.jasper";
			
		} else if (ReportType.equals("misLoanSaction")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "BranchLoanSanction.jasper";
		} else if (ReportType.equals("misLoanDisburse")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "BranchLoanDisburseReport.jasper";
		}

		else if (ReportType.equals("misAuditObjection")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "BranchWiseAuditBojectionDisposal.jasper";
		} else if (ReportType.equals("misCaseSettlement")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "BranchWiseCourtCaseSettlement.jasper";
		} else if (ReportType.equals("misKharidabari")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "BranchWiseKharidabari.jasper";
		} else if (ReportType.equals("misLoanRecovery")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "BranchWiseLoanRecoveryData.jasper";
		} else if (ReportType.equals("misDeedReturn")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "BranchWiseDeedReturn.jasper";
		} else if (ReportType.equals("misConsolidateReport")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "SummarizedInformationTargetAndAchievment.jasper";
		} else if (ReportType.equals("misConsolidateReportOthers")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "SummarizedInformationTargetAndAchievment_others.jasper";
		} else if (ReportType.equals("ZoneWiseSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "ZoneWiseSummaryReport.jasper";
		} else if (ReportType.equals("LoanRecoverySummary")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "RecoveryItemSummaryReport.jasper";
		} else if (ReportType.equals("AuditDisposalSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "AudittemSummaryReport.jasper";
		} else if (ReportType.equals("KharidabariSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "KharidabariItemSummary.jasper";
		} else if (ReportType.equals("CourtcaseSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "CourtCaseItemSummary.jasper";
		} else if (ReportType.equals("LoanSanctionDisburseSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "LoanItemSummary.jasper";
		} else if (ReportType.equals("allLoanItemSummaryLoan")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "allILoanitemSummaryReport.jasper";
		} else if (ReportType.equals("allOthersItemSummaryLoan")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "allIOtheritemSummaryReport.jasper";
		}

		else if (ReportType.equals("RecoveryPerformance") || ReportType.equals("ClassifiedRecoveryPerformance")
				|| ReportType.equals("MiscCCPerformance") || ReportType.equals("ExecutionCCPerformance")
				|| ReportType.equals("PossesionKharidabariPerformance")
				|| ReportType.equals("SaleKharidabariPerformance") || ReportType.equals("commercialAuditPerformance")
				|| ReportType.equals("PostAuditPerformance") || ReportType.equals("LoanSanctionPerformance")
				|| ReportType.equals("LoanDisbursePerformance") || ReportType.equals("DeedReturnPerformance")) {
			ReportPath = CommonInfo._REPORT_DIR_MIS + "performanceEvalution.jasper";
		}

		return ReportPath;
	}

}
