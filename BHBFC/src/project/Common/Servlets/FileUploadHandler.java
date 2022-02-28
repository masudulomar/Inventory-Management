package project.Common.Servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import project.Utilities.DBUtils;


@WebServlet("/FileUploadHandler")
public class FileUploadHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String UPLOAD_DIRECTORY = "C:/uploads";  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadHandler() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //process only if its multipart content
		Connection con = null;
		DBUtils dbUtils = new DBUtils();	
		            con = dbUtils.GetConnection();

		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				for (FileItem item : multiparts) {

					if (!item.isFormField()) {
						String filename = new File(item.getName()).getName();						
						String OrderNumber=filename.substring(0, filename.indexOf(".pdf"));						
						InputStream fileContent = item.getInputStream();
						PreparedStatement pstmt = con.prepareStatement("insert into  hr_office_order_file (entity_num,Entry_sl, file_name, file_doc, office_order) values (?,HR_FILE_SL.NEXTVAL,?,?,?)");
						pstmt.setString(1, "1");
						pstmt.setString(2, filename);
						pstmt.setBinaryStream(3, fileContent, item.getSize());
						pstmt.setString(4, OrderNumber);
						pstmt.execute();						
					}
				}
				request.setAttribute("message", "File Uploaded Successfully");
			} catch (Exception ex) {
				request.setAttribute("message", "File Upload Failed due to " + ex);
			}

		}else{
            request.setAttribute("message", "Sorry this Servlet only handles file upload request");
        }
     
        PrintWriter writer = response.getWriter();
        writer.println("<html><center>File uploaded successfully!<center></html>");
        writer.flush();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
