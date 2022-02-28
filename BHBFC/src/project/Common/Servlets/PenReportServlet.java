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

import project.Common.Infos.CommonInfo;
import project.Utilities.DBUtils;
import project.Utilities.ProjectUtils;
import project.validators.PRMSValidator;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 * Servlet implementation class PenReportServlet
 */
@WebServlet("/PenReportServlet")
public class PenReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PenReportServlet() {
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
		String ReportType = request.getParameter("ReportType");
		String report_path = GetReportPath(ReportType);
		String ProjectPath = ProjectUtils.GetProjectPath();
		Map<String, String> brn_info = new HashMap<String, String>();
		brn_info.put("branch_code", LoggedBranch);
		PRMSValidator branValidator = new PRMSValidator();
		try {
			brn_info = branValidator.BranchKeyPress(brn_info);
			parameter.put("BRANCH_NAME", brn_info.get("BRN_NAME"));
			parameter.put("BRANCH_ADDRESS", brn_info.get("BRN_ADDRESS"));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		parameter.put("LOGO_PATH", ProjectPath + CommonInfo._LOGO_PATH);
		parameter.put("M_LOGO", ProjectPath + CommonInfo._LOGO_PATH_2);
		parameter.put("SUBREPORT_DIR", ProjectPath + CommonInfo._REPORT_DIR_PN);
		parameter.put("P_BRANCH", LoggedBranch);
		parameter.put("P_YEAR", request.getParameter("Year"));
		parameter.put("P_MONTH", request.getParameter("MonthCode"));

		if (ReportType.equalsIgnoreCase("pfSummaryReport")) {
			
			parameter.put("p_FinYear", request.getParameter("financialYear"));
		}
		else if (ReportType.equalsIgnoreCase("pfIndividualReport")) {
        	parameter.put("p_branch", "");
			parameter.put("p_FinYear", request.getParameter("financialYear"));
		}
		else if (ReportType.equalsIgnoreCase("PensionCertificate")) {
			if (request.getParameter("NothiNo").equalsIgnoreCase("N/A")) {
				parameter.put("P_NOTHI", null);
			} else {
				parameter.put("P_NOTHI", request.getParameter("NothiNo"));
			}
			parameter.put("P_FIN_YEAR", request.getParameter("financialYear").substring(0, 4));
			parameter.put("P_FIN_YEAR2", request.getParameter("financialYear").substring(5, 9));
		}
		else if(ReportType.equalsIgnoreCase("PensionBonusDetails")||ReportType.equalsIgnoreCase("PensionBonusAdvice")) {
			parameter.put("BonusType", request.getParameter("BonusType"));
			if (request.getParameter("pensionDist").equals("A")) {
				parameter.put("PensionBranchLocation", "%%");
			} else {
				parameter.put("PensionBranchLocation", request.getParameter("pensionDist"));
			}

		}
		else {
			if (request.getParameter("pensionDist").equals("A")) {
				parameter.put("PensionBranchLocation", "%%");
			} else {
				parameter.put("PensionBranchLocation", request.getParameter("pensionDist"));
			}

			parameter.put("BranchLocation", request.getParameter("pensionDist"));
        	  if (request.getParameter("ActivationType").equals("B")) {
  				parameter.put("ActivationType", "%%");
  			} else {
  				parameter.put("ActivationType", request.getParameter("ActivationType"));
  			}
          		
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
	private String GetReportPath(String LoanType) {
		String ReportPath = "";
		if (LoanType.equalsIgnoreCase("PensionRpt")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionDetailsReport.jasper";
		} else if (LoanType.equalsIgnoreCase("PensionAdvice")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionAdviceReport.jasper";
		} else if (LoanType.equalsIgnoreCase("PensionDeduction")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionDeductionReport.jasper";
		} else if (LoanType.equalsIgnoreCase("PensionerDetails")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionerDetails.jasper";
		} else if (LoanType.equalsIgnoreCase("InharitanceDetails")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "InharitanceDetails.jasper";
		} else if (LoanType.equalsIgnoreCase("PensionAdviceByBranch")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionAdviceReportByBank.jasper";
		} else if (LoanType.equalsIgnoreCase("PensionerDetailsByType")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionerDetailsByType.jasper";
		} else if (LoanType.equalsIgnoreCase("ArearReportDetails")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "ArearReportDetails.jasper";
		} else if (LoanType.equalsIgnoreCase("PensionCertificate")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionCertificate.jasper";
		}
		else if (LoanType.equalsIgnoreCase("PensionBonusDetails")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionBonusDetailsReport.jasper";
		}
		else if (LoanType.equalsIgnoreCase("PensionBonusAdvice")) {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionBonusAdviceReport.jasper";
		}
		else if (LoanType.equalsIgnoreCase("pfSummaryReport")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "pf_summaryReport.jasper";
		}
		else if (LoanType.equalsIgnoreCase("pfIndividualReport")) {
			ReportPath = CommonInfo._REPORT_DIR_ELMS + "pf_statement_new.jasper";
		}

		else {
			ReportPath = CommonInfo._REPORT_DIR_PN + "PensionPayslipReport.jasper";
		}

		return ReportPath;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
