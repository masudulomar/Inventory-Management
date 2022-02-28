package project.Common.Servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

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
 * Servlet implementation class AdminReportServlet
 */
@WebServlet("/AdminReportServlet")
public class AdminReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminReportServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DBUtils dbUtils = new DBUtils();
		Map<String, Object> parameter = new HashMap<String, Object>();
		String LoggedBranch = request.getParameter("loggedBranch");
		String BranchCode = request.getParameter("BranchCode");
		String ReportType = request.getParameter("ReportType");
		String report_path = GetReportPath(ReportType);
		String ProjectPath = ProjectUtils.GetProjectPath();

		Map<String, String> brn_info = new HashMap<String, String>();

		if (ReportType.equals("rDesignationWiseOrganogramSummaryReport")) {
			if (BranchCode.equals("0")) {
				brn_info.put("branch_code", LoggedBranch);
			} else {
				brn_info.put("branch_code", BranchCode);
			}
		} else {
			brn_info.put("branch_code", LoggedBranch);
		}

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
		parameter.put("SUBREPORT_DIR", ProjectPath + CommonInfo._REPORT_DIR_HRM);

		if (ReportType.equals("rdesignationWiseEmployeeReport") || ReportType.equals("rbranchWiseEmployeeReport")) {
			parameter.put("P_BRANCH", BranchCode);
			parameter.put("P_DEPT_CODE", request.getParameter("DeptName"));
			parameter.put("P_DESINGATION_CODE", request.getParameter("newDesignation"));
		} else if (ReportType.equals("rDegreeWiseEmployeeReport")) {
			parameter.put("p_DegreeCode", request.getParameter("NameofExam"));
		} else if (ReportType.equals("rLeaveWiseEmployeeReport")) {
			parameter.put("p_LeaveType", request.getParameter("LeaveType"));
			parameter.put("p_empId", request.getParameter("EmpID"));
		} else if (ReportType.equals("rOfficeWiseDetailsOrganogramReport")
				|| ReportType.equals("rDesignationWiseOrganogramSummaryReport")) {

			String DeptCode = request.getParameter("DeptName");
			if (BranchCode.equals("0")) {
				BranchCode = "%";
			}
			if (DeptCode.equals("0")) {
				DeptCode = "%";
			}
			parameter.put("P_BRANCH", BranchCode);
			parameter.put("P_DEPT_CODE", DeptCode);
		}
		else if (ReportType.equals("rCatagoryWiseOrganogramSummaryReport")) {
			parameter.put("p_Category", request.getParameter("CatagoryType"));
		}
		else if (ReportType.equals("rTrainingData")) {
			parameter.put("p_empId", request.getParameter("empId"));			
		}
		else if (ReportType.equals("rTrainingInstitute")) {
			parameter.put("p_InstituteCode", request.getParameter("NameofInstitute"));			
		}
		else if (ReportType.equals("rTrainingSubject")) {
			parameter.put("p_SubjectCode", request.getParameter("SubjectOfTraining"));			
		}
		
		try {
			File file = new File(ProjectPath + report_path);
			con = dbUtils.GetConnection();
			byte[] bytes = JasperRunManager.runReportToPdf(file.getCanonicalPath(), parameter, con);
			//JRProperties.setProperty("net.sf.jasperreports.default.pdf.font.name", "Helvetica");
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
	private String GetReportPath(String ReportType) {
		String ReportPath = "";

		if (ReportType.equals("rdesignationWiseEmployeeReport")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_employeeList_ByDesignation.jasper";
		} else if (ReportType.equals("rbranchWiseEmployeeReport")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_employeeList_ByOffice.jasper";
		} else if (ReportType.equals("rDegreeWiseEmployeeReport")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_educationDataByDegree.jasper";
		} else if (ReportType.equals("rLeaveWiseEmployeeReport")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_LeaveDataByPF.jasper";
		} else if (ReportType.equals("rOfficeWiseDetailsOrganogramReport")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_organogram_officeWiseDesignation.jasper";
		} else if (ReportType.equals("rDesignationWiseOrganogramSummaryReport")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_organogram_summaryByDesigignation.jasper";
		}
		else if (ReportType.equals("rBranchWiseEmployeeOrganogramSummaryReport")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_organogram_officeWisePerson.jasper";
		}
		else if (ReportType.equals("rTrainingData")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_traininginfo.jasper";
		}
		else if (ReportType.equals("rCatagoryWiseOrganogramSummaryReport")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_organogram_officeCatagoryAndDesignation.jasper";
		}
		else if (ReportType.equals("rTrainingData")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_traininginfo.jasper";
		}
		else if (ReportType.equals("rTrainingInstitute")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_trainingInstituteWiseReport.jasper";
		}
		else if (ReportType.equals("rTrainingSubject")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_trainingSubjectWiseReport.jasper";
		}
		else if (ReportType.equals("rTrainingInstituteList")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_InstituteList.jasper";
		}
		else if (ReportType.equals("rTrainingSubjectList")) {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "hr_TrainingList.jasper";
		}
		else {
			ReportPath = CommonInfo._REPORT_DIR_HRM + "EmployeeList.jasper";
		}
		return ReportPath;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
