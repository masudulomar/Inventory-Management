package project.validators;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import project.Utilities.DBUtils;

public class XmlDataFetch {
	Map<String, String> ResultMap = new HashMap<String, String>();

	public XmlDataFetch() {
		ResultMap.clear();
	}
	public Map<String, String> xmlLoanAccountData(Map DataMap) {
	ResultMap.put("ERROR_MSG", "");
	
	
    LinkedHashMap<String, String> lhm  = new LinkedHashMap<String, String>(); 
	
	DBUtils ob = new DBUtils();
	ResultSet rs=null;
	String sql = "select l.loc_code office_code,o.loc_desc office_name,l.loan_acc loan_acc,l.name1 borrower,\r\n" + 
			"l.loan_product,l.loan_type,l.sanc_amt,to_char(l.sanc_date,'DD/MM/RRRR') san_date from ln_account l join office_description o on\r\n" + 
			"(l.loc_code=o.loc_code)\r\n" + 
			"where l.db_type<>'DEF01'";
	Connection con = ob.GetConnection();
	PreparedStatement stmt = null;
	try {
		stmt = con.prepareStatement(sql);
		 rs = stmt.executeQuery();
		if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						lhm.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}				
			} 
		}
		System.out.println(lhm);
	} catch (SQLException e) {
		ResultMap.put("ERROR_MSG", "Error in xmlLoanAccountData");
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
	return lhm;
}
}
