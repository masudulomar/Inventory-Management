package project.Common.Servlets;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.Utilities.DBUtils;

/**
 * Servlet implementation class FileDownloadHandler
 */
@WebServlet("/FileDownloadHandler")
public class FileDownloadHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileDownloadHandler() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DBUtils dbUtils = new DBUtils();
		con = dbUtils.GetConnection();
		ResultSet result = null;
		PreparedStatement stmt = null;
		byte[] bytes = null;
		String sql = " select k.office_order,k.file_name,k.file_doc from hr_office_order_file  k where k.entry_sl=? ";
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(request.getParameter("officeOrder")));
			result = stmt.executeQuery();
			
			if (result.next()) {
				Blob blob = result.getBlob(3);
				bytes = blob.getBytes(1L, (int) blob.length());
			}
			
			

		} catch (Exception e) {

		} finally {
			try {
				con.close();
				result.close();
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		response.setContentType("application/pdf");
		response.setContentLength(bytes.length);
		ServletOutputStream outputStream = response.getOutputStream();
		outputStream.write(bytes, 0, bytes.length);
		outputStream.flush();
		outputStream.close();

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
