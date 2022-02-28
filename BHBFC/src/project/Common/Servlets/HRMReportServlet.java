package project.Common.Servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

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
 * Servlet implementation class HRMReportServlet
 */
@WebServlet("/HRMReportServlet")
public class HRMReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HRMReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DBUtils dbUtils = new DBUtils();
		Map<String, Object> parameter = new HashMap<String, Object>();
		String LoggedBranch = request.getParameter("loggedBranch");
		String ReportType = request.getParameter("ReportType");
		String ProjectPath = ProjectUtils.GetProjectPath();
		String OrderDetails = request.getParameter("OrderDetails");
		Map<String, String> OrderDetailsmap = new HashMap<String, String>();		
		OrderDetailsmap=ProjectUtils.OrderTokenizer(OrderDetails);
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
		con = dbUtils.GetConnection();
		parameter.put("LOGO_PATH", ProjectPath + CommonInfo._LOGO_PATH);
		parameter.put("M_LOGO", ProjectPath + CommonInfo._LOGO_PATH_2);
		parameter.put("SUBREPORT_DIR", ProjectPath + CommonInfo._REPORT_DIR_HRM);
		parameter.put("P_ORDER_DATE", OrderDetailsmap.get("OD"));
		parameter.put("P_ORDER_SERIAL", OrderDetailsmap.get("SL"));
		
		
		String report_path = GetReportPath(ReportType,OrderDetailsmap.get("OT"));		
		System.out.println(OrderDetailsmap);
		
		
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	private String GetReportPath(String ReportType,String OrderType) {
		String ReportPath = "";
		if (OrderType.equals("TO")) {
			ReportPath= CommonInfo._REPORT_DIR_HRM + "hr_transfer_order.jasper";
		}
		else if (OrderType.equals("PO")) {
			ReportPath= CommonInfo._REPORT_DIR_HRM + "hr_promotion_order.jasper";
		}else if (OrderType.equals("IO")) {
			ReportPath= CommonInfo._REPORT_DIR_HRM + "hr_increment_order.jasper";
		}
		
		
		
		return ReportPath;
	}
}
