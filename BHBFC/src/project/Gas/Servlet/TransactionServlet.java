package project.Gas.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


import project.Delegators.CommonFacade;
import project.Utilities.ProjectUtils;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TransactionServlet() {
		super();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
				
		Map<String, String> InputMap = new HashMap<String, String>();		
		String jasonString = request.getParameter("DataString");		
		Map<String, String> DataMap = new HashMap<String, String>();
		Map<String, String> OutputMap = new HashMap<String, String>();
		String GsonString = "";			
		try {
			String ProjectPath=ProjectUtils.GetProjectPath();
			DataMap = ProjectUtils.JasonStringToHashMap(jasonString);
			DataMap.put("ProjectPath", ProjectPath);
			OutputMap = CommonFacade.SessionFacade(DataMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		Gson gsonObj = new Gson();
		GsonString = gsonObj.toJson(OutputMap);
		
		response.setContentType("text/html;charset=UTF-8;");
	    response.setCharacterEncoding("UTF-8");
	    ServletOutputStream out = response.getOutputStream();
	    out.write(GsonString.getBytes("UTF-8"));
	    out.flush();
	    out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
