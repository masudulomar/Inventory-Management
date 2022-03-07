package project.validators;

import java.io.Reader;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.commons.lang.StringUtils;
import project.Utilities.DBUtils;
import project.Utilities.ProjectUtils;

public class InventoryValidation {
	Map<String, String> ResultMap = new HashMap<String, String>();
	public InventoryValidation() {
		ResultMap.clear();
	}
	
	public Map<String, String> GLCodeValidation(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		String glname = null;
		String glcode = null;
		try {
			StringTokenizer et = new StringTokenizer(DataMap.get("gldescription").toString(), ":");
			 glname = et.nextToken();
			 glcode = et.nextToken();
		}
		catch(Exception e) {
			ResultMap.put("ERROR_MSG", "Invalid GL Format");
		}
		
		if(ResultMap.get("ERROR_MSG").equals("")||ResultMap.get("ERROR_MSG")==null) {
			DBUtils ob = new DBUtils();
			String sql = " SELECT * FROM as_glcodelist l where l.entity_num=1 and l.glcode=? and tran_YN='Y' ";
			Connection con = ob.GetConnection();
			ResultSet rs = null;
			PreparedStatement stmt = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, glcode);
				rs = stmt.executeQuery();
				if (rs.next()) {
					ResultMap.put("ERROR_MSG", "");
				} else {
					ResultMap.put("ERROR_MSG", "Record not Found " + glname + " ->" + glcode);
				}

			} catch (SQLException e) {
				ResultMap.put("ERROR_MSG", e.getMessage().toString());
				e.printStackTrace();
			} finally {
				try {
					con.close();
					stmt.close();
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}		
		return ResultMap;
	}
	
	public Map<String, String> FetchItemDetails(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "SELECT ENTITY, BRANCH_CODE, ITEM_CODE,ITEM_DESC,(SELECT l.glname FROM as_glcodelist l where l.glcode=  DEBIT_GL)||':'||DEBIT_GL DEBIT_GL, (SELECT l.glname FROM as_glcodelist l where l.glcode=  CREDIT_GL)||':'||CREDIT_GL CREDIT_GL , ENTY_BY, TO_CHAR(ENTY_DATE, 'DD-MON-YYYY') ENTY_DATE, REMARKS  FROM as_itemlist i where i.entity=1 and BRANCH_CODE=? and i.item_code=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("BranchCode").toString());
			stmt.setString(2, DataMap.get("ItemCode").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			} 

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> AddItemDetailsParam(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");

		StringTokenizer et = new StringTokenizer(DataMap.get("DRglCode").toString(), ":");
		String drglname = et.nextToken();
		String drglcode = et.nextToken();
		StringTokenizer st = new StringTokenizer(DataMap.get("CRglCode").toString(), ":");
		String crglname = st.nextToken();
		String crglcode = st.nextToken();

		if (drglcode.equals(crglcode)) {
			ResultMap.put("ERROR_MSG", "Debit And Credit GL Must Be Different");
		} else {
			try {
				con = ob.GetConnection();
				cstmt = con.prepareCall("CALL pkg_param.sp_item_creation(?,?,?,?,?,?,?,?,?)");
				cstmt.setString(1, DataMap.get("BranchCode").toString());
				cstmt.setString(2, DataMap.get("ItemCode").toString());
				cstmt.setString(3, DataMap.get("ItemName").toString());

				cstmt.setString(4, drglcode);
				cstmt.setString(5, crglcode);

				cstmt.setString(6, DataMap.get("ItemEntyDate").toString());
				cstmt.setString(7, DataMap.get("itemremarks").toString());
				cstmt.setString(8, DataMap.get("User_Id").toString());
				cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
				cstmt.execute();
				String error = cstmt.getString(9);

				if (error != null) {
					ResultMap.put("ERROR_MSG", error + " " + drglname + " " + crglname);
				} else
					ResultMap.put("SUCCESS", "Item Sucessfully Created/update for this item code: "
							+ DataMap.get("ItemCode").toString() + " and name: " + DataMap.get("ItemName").toString());

			} catch (SQLException e) {
				ResultMap.put("ERROR_MSG", e.getMessage().toString());
				e.printStackTrace();
			} finally {
				try {
					con.close();
					cstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return ResultMap;
	}
	public Map<String, String> FetchGLCodeDetails(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "SELECT GLCODE,GLNAME,GL_TYPE,INC_EXP,CAP_REV,SUB_GL,MAINHEAD,REMARKS,\r\n" + 
				"      to_char( decode(MOD_BY,'null',ENTY_ON,'',ENTY_ON,mod_on)) ENTY_ON\r\n" + 
				"      \r\n" + 
				"  FROM AS_GLCODELIST I where i.entity_num=1 and i.glcode=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("glcode").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			} 

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> FetchProductMisc(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glcode)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(pkg_param.fn_misc_data(?))) ORDER BY glcode ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> FetchGLData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glname)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(pkg_param.fn_get_glcode(?))) ORDER BY glname ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchGLStatementData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glname)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(pkg_param.fn_get_glcode_statement(?))) ORDER BY glname ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				
				if(clob!=null) {
					Reader r = clob.getCharacterStream();
					StringBuffer buffer = new StringBuffer();
					int ch;
					while ((ch = r.read()) != -1) {
						buffer.append("" + (char) ch);
					}
					ResultMap.put("GL_LIST", buffer.toString());
				}
				else {
					ResultMap.put("GL_LIST", "Not Applicable:000000000");
				}
				
			}

		} catch (Exception e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchGLReconciliationData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glname)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(pkg_param.fn_get_glcode_reconciliation(?))) ORDER BY glname ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				
				if(clob!=null) {
					Reader r = clob.getCharacterStream();
					StringBuffer buffer = new StringBuffer();
					int ch;
					while ((ch = r.read()) != -1) {
						buffer.append("" + (char) ch);
					}
					ResultMap.put("GL_LIST", buffer.toString());
				}
				else {
					ResultMap.put("GL_LIST", "Not Applicable:000000000");
				}
				
			}

		} catch (Exception e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchBranchGLDataData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glname)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(pkg_param.fn_get_branch_glcode(?))) ORDER BY glname ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				
				if(clob!=null) {
					Reader r = clob.getCharacterStream();
					StringBuffer buffer = new StringBuffer();
					int ch;
					while ((ch = r.read()) != -1) {
						buffer.append("" + (char) ch);
					}
					ResultMap.put("GL_LIST", buffer.toString());
				}
				else {
					ResultMap.put("GL_LIST", "Not Applicable:000000000");
				}
				
			}

		} catch (Exception e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> FetchGLDataforRegister(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glcode)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (select * from as_glcodelist g where   sub_gl='0' and g.glcode <>'170000000'\r\n" + 
				"union \r\n" + 
				"SELECT * FROM as_glcodelist k where k.glcode in ('172000000','173000000','171000000') ) ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			//stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchGLData_OBL(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glcode)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(PKG_PARAM.fn_GLCODE(?)) where tran_gl='Y') ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	public Map<String, String> FetchGLListBranch(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, g.glcode || ':' || g.glname, ',').extract('//text()') order by glcode)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from AS_glcodelist g where g.slot_yn='Y'" ;
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchItemData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "SELECT  listagg(ITEM_LIST,',') WITHIN GROUP (ORDER BY ITEM_LIST) ITEM_LIST from (SELECT ITEM_LIST FROM ( \r\n" + 
				"        SELECT g.item_code||':'||g.item_desc ITEM_LIST FROM as_itemlist g where branch_code=?))";			
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("BranchCode").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			} 

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}//
	
	
	public Map<String, String> BranchGLOpening(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_param.sp_branch_ledger_Opening(?,?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("glcode").toString());
			cstmt.setString(3, DataMap.get("GLName").toString());				
			cstmt.setString(4, DataMap.get("AccRemarks").toString());
			cstmt.setString(5, DataMap.get("entryDate").toString());
			cstmt.setString(6, DataMap.get("User_Id").toString());				
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(8);
			String newglcode = cstmt.getString(7);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "New glcode sucessfully created and code is:  "+ newglcode+":"+ DataMap.get("GLName").toString());
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	public Map<String, String> GLSetupFunction(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_param.sp_gl_setup(?,?,?,?,?,?,?,?,?,?,?)");			
			cstmt.setString(1, DataMap.get("glcode").toString());
			cstmt.setString(2, DataMap.get("glname").toString());
			cstmt.setString(3, DataMap.get("gltype").toString());
			cstmt.setString(4, DataMap.get("subgl").toString());
			cstmt.setString(5, DataMap.get("headglcode").toString().equals("")||DataMap.get("headglcode").toString().equals("N/A")? "":DataMap.get("headglcode").toString());
			cstmt.setString(6, DataMap.get("expendituretype").toString());
			cstmt.setString(7, DataMap.get("incometype").toString());
			cstmt.setString(8, DataMap.get("entyDate").toString());
			cstmt.setString(9, DataMap.get("glremarks").toString());
			
			cstmt.setString(10, DataMap.get("User_Id").toString());
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(11);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "GL Sucessfully Created/update for this item code: " + DataMap.get("glcode").toString()+" and name: "+DataMap.get("glname").toString());
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> GetBranchList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, BRN_CODE || ':' || BRN_NAME, ',').extract('//text()') order by BRN_CODE)\r\n" + 
				"                    .getclobval(), +            ',') BRANCH_LIST\r\n" + 
				"     from (SELECT M.BRN_CODE,M.BRN_NAME FROM PRMS_MBRANCH M ) ORDER BY BRN_CODE ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("BRANCH_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("BRANCH_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
		
	public Map<String, String> GetGradeList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, grade_code || ':' || Scale, ',').extract('//text()') order by grade_code)\r\n" + 
				"                    .getclobval(), +            ',') SCALE_LIST\r\n" + 
				"     from (select p.grade_code,p.grade_description||'('||p.start_amount||'-'||p.end_amount||')' Scale from hrm_payscale p  ) ORDER BY grade_code ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("SCALE_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("SCALE_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	public Map<String, String> GetDegreeList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, DEGREE_CODE || ':' || DEGREE_DESCRIPTION, ',').extract('//text()') order by DEGREE_CODE)\r\n" + 
				"                    .getclobval(), +            ',') DEGREE_LIST\r\n" + 
				"     from (select DEGREE_CODE,DEGREE_DESCRIPTION from hr_degreeParam where degree_type=?  ) ORDER BY DEGREE_CODE ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("DegreeType").toString());
			
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("DEGREE_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("DEGREE_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> GetInstituteList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, INST_CODE || ':' || INST_NAME, '#').extract('//text()') order by INST_CODE)\r\n" + 
				"                    .getclobval(), +            '#') INSTITUTE_LIST \r\n" + 
				"     from (select INST_CODE, INST_NAME from hr_institute ) ORDER BY INST_CODE ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("INSTITUTE_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("INSTITUTE_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> GetTrainingSubject(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, SUBJECT_CODE || ':' || SUBJECT_DESC, '#').extract('//text()') order by SUBJECT_CODE)\r\n" + 
				"                    .getclobval(), +            '#') SUBJECT_LIST \r\n" + 
				"     from (select SUBJECT_CODE, SUBJECT_DESC from HR_Traning_subject ) ORDER BY SUBJECT_CODE ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("SUBJECT_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("SUBJECT_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> GetLeaveList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();		
		String sql = "select rtrim(xmlagg(xmlelement(e, LEAVE_CODE || ':' || LEAVE_DESCRIPTION, ',').extract('//text()') order by LEAVE_CODE)\r\n" + 
				"                    .getclobval(), +            ',') LEAVE_LIST \r\n" + 
				"     from (select LEAVE_CODE,LEAVE_DESCRIPTION from hr_leave_param ) ORDER BY LEAVE_CODE ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);			
			rs = stmt.executeQuery();
			if (rs.next()) {
				Clob clob = rs.getClob("LEAVE_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("LEAVE_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	
	
	public Map<String, String> GetDesignationList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, designation_code || ':' || designation_desc, ',').extract('//text()') order by designation_code)\r\n" + 
				"                    .getclobval(), +            ',') DESIGNATION_LIST\r\n" + 
				"     from (select d.designation_code,d.designation_desc from prms_designation d  ) ORDER BY designation_code ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("DESIGNATION_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("DESIGNATION_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> GetDepartmentList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, dept_code || ':' || dept_name, '@').extract('//text()') order by dept_code)\r\n" + 
				"                    .getclobval(), +            '@') DEPT_LIST\r\n" + 
				"     from (select d.dept_code,d.dept_name from prms_brn_department d  ) ORDER BY dept_code ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("DEPT_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("DEPT_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchOrderList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, OrderKey || '#' || OrderValue, ':').extract('//text()') order by OrderKey)\r\n" + 
				"             .getclobval(),\r\n" + 
				"             ':') ORDER_LIST\r\n" + 
				"  from (select 'OD,'||l.order_date ||'@SL,'|| l.ordersl ||'@OT,'|| l.order_type OrderKey,'Date [ '||l.order_date ||' ] Order SL ['|| l.ordersl ||'] Order Type ['|| decode(l.order_type,'PO','Promotion Order','IO','Increment Order','TO','Transfer Order')||']' OrderValue from hr_order_list l where l.order_date=?)\r\n" + 
				" ORDER BY OrderKey\r\n" + 
				" ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("OrderDate").toString());
			rs = stmt.executeQuery();
			try {
				if (rs.next()) {
					Clob clob = rs.getClob("ORDER_LIST");
					Reader r = clob.getCharacterStream();
					StringBuffer buffer = new StringBuffer();
					int ch;
					while ((ch = r.read()) != -1) {
						buffer.append("" + (char) ch);
					}
					ResultMap.put("ORDER_LIST", buffer.toString());
				}
			}catch(Exception e){
				ResultMap.put("ORDER_LIST", "000000000#No Order Found");
			}
			

		} catch (Exception e) {
			ResultMap.put("ORDER_LIST", "000000000#No Order Found");
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> GetOfficeOrderList(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, entry_sl || ':' || office_order, '#').extract('//text()') order by entry_sl)\r\n" + 
				"                    .getclobval(), +            '#') ORDER_LIST \r\n" + 
				"     from (select k.entry_sl ,k.office_order  from hr_office_order_file  k ) ORDER BY entry_sl ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("ORDER_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("ORDER_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchInstituteName(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "select *from hr_institute t where t.inst_code=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("InstituteCode").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			} 

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchTrainingSubject(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "select *from hr_traning_subject t where t.subject_code=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("TrainingCode").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			} 

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
}
