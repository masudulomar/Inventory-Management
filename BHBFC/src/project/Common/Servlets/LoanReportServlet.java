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
 * Servlet implementation class LoanReportServlet
 */
@WebServlet("/LoanReportServlet")
public class LoanReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoanReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		DBUtils dbUtils = new DBUtils();
		Map<String, Object> parameter = new HashMap<String, Object>();			
		String LoanType = request.getParameter("LoanType");			
		String branchCode = request.getParameter("BranchCode");
		String LoggedBranch=request.getParameter("loggedBranch");		
		String employeeId=request.getParameter("EmployeeId");
		String FinYear=request.getParameter("FinYear");
		String UpToDate=request.getParameter("UpToDate");
						
		String report_path=GetReportPath(LoanType);
		String ProjectPath=ProjectUtils.GetProjectPath();
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
		
		parameter.put("LOGO_PATH", ProjectPath+CommonInfo._LOGO_PATH);
		parameter.put("M_LOGO", ProjectPath+CommonInfo._LOGO_PATH_2);
		parameter.put("SUBREPORT_DIR", ProjectPath+CommonInfo._REPORT_DIR_ELMS);
		
		if(branchCode.equals("NA")) {
			//parameter.put("P_BRANCH", branchCode);
			branchCode="";
		}
		parameter.put("p_branch", branchCode);
		parameter.put("p_empId", employeeId);
		parameter.put("p_FinYear", FinYear);
		parameter.put("p_LoanType", LoanType);
		parameter.put("p_UptoDate", "");
		try {
			File file = new File(ProjectPath+report_path);
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
		}
		finally {
			try {
				con.close();				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	private String GetReportPath(String LoanType){
		String ReportPath="";
		if(!LoanType.equalsIgnoreCase("PF")){
			ReportPath= CommonInfo._REPORT_DIR_ELMS + "LoanStatement.jasper";
		}
		else
		{
			ReportPath= CommonInfo._REPORT_DIR_ELMS + "pf_statement_new.jasper";
		}
		return ReportPath;
		
	}
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}
}
