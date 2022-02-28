package project.validators;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import project.Service.SmsService;
import project.Utilities.DBUtils;
import project.Utilities.ProjectUtils;

public class AdminOperation {
	Map<String, String> ResultMap = new HashMap<String, String>();

	public AdminOperation() {
		ResultMap.clear();
	}

	public Map<String, String> EmployeeInfoUpdation(Map DataMap) {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.SP_EMPLOYEE_UPDATION(?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("EmployeeId").toString());
			cstmt.setString(2, DataMap.get("new_branch").toString());
			cstmt.setString(3, DataMap.get("new_basic").toString());
			cstmt.setString(4, DataMap.get("new_designation").toString());
			cstmt.setString(5, DataMap.get("effective_date").toString());
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(6);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  Updating Employee Information!");
			} else
				ResultMap.put("SUCCESS", "Data Successfully Updated!");
		} catch (SQLException e) {
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

	public Map<String, String> PfActivationIMethod(Map DataMap) {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.sp_emp_activation(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("EmployeeId").toString());
			cstmt.setString(2, DataMap.get("ActivationType").toString());
			cstmt.setString(3, DataMap.get("effective_date").toString());
			cstmt.setString(4, DataMap.get("AttachedBranch").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  PF Activation Method!");
			} else
				ResultMap.put("SUCCESS", "PF Activation Successfully Updated!");
		} catch (SQLException e) {
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

	public Map<String, String> AddNewEmployee(Map DataMap) {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {

			con = ob.GetConnection();
			cstmt = con
					.prepareCall("CALL PKG_PRMS.SP_NEW_EMPLOYEE_INSERTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("EmployeeId").toString());
			cstmt.setString(2, DataMap.get("EmployeeName").toString());
			cstmt.setString(3, DataMap.get("BranchCode").toString());
			cstmt.setString(4, DataMap.get("Designation").toString());
			cstmt.setString(5, DataMap.get("JoiningDate").toString());
			cstmt.setString(6, DataMap.get("DeptCode").toString());
			cstmt.setString(7, DataMap.get("GenderType").toString());
			cstmt.setString(8, DataMap.get("BloodGrp").toString());
			cstmt.setString(9, DataMap.get("Rhfactor").toString());
			cstmt.setString(10, DataMap.get("DOB").toString());
			cstmt.setString(11, DataMap.get("contactNo").toString());
			cstmt.setString(12, DataMap.get("TIN").toString());
			cstmt.setString(13, DataMap.get("email").toString());
			cstmt.setString(14, DataMap.get("SeniorityCode").toString());
			cstmt.setString(15, DataMap.get("Address").toString());
			cstmt.setString(16, DataMap.get("EntdBy").toString());
			cstmt.setString(17, DataMap.get("ReligionType").toString());
			cstmt.setString(18, DataMap.get("HighestDegree").toString());
			cstmt.setString(19, DataMap.get("homeDist").toString());
			cstmt.setString(20, DataMap.get("NID").toString());
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(21);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  AddNewEmployee!\n" + error);
			} else
				ResultMap.put("SUCCESS", "Data Successfully Updated!");
		} catch (SQLException e) {
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

	public Map<String, String> FetchEmpData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		ResultMap.put("ERROR_MSG", "");
		if (DataMap.get("UserBranchCode").toString().equals(null) || DataMap.get("UserBranchCode").toString().equals("")
				|| DataMap.get("UserBranchCode").toString() == "" || DataMap.get("UserBranchCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DBUtils ob = new DBUtils();
			ResultSet rs = null;
			String sql = "SELECT EMP_BRN_CODE,      " + "       EMP_NAME," + "       DESIG_CODE ,"
					+ "       TO_CHAR(JOINING_DATE,'dd-mon-yyyy') JOINING_DATE," + "       GENDER,"
					+ "       BLOOD_GRP," + "       RHFACTOR," + "       TIN_NO," + "       EMAIL,"
					+ "       CONTACT_NO," + "       TO_CHAR(DOB,'dd-mon-yyyy') DOB," + "       ADDRESS,"
					+ "       RELIGION," + "       EMP_DEPT_CODE,"
					+ "	DESIG_SENIORITY_CODE, HIGHEST_DEGREE,HOME_DISTRICT,NID " + "  FROM PRMS_EMPLOYEE E"
					+ "  JOIN PRMS_EMP_SAL S" + "    ON (E.EMP_ID = S.EMP_ID)" + " WHERE E.EMP_ID = ?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("EmployeeId").toString());
				rs = stmt.executeQuery();
				if (rs.next()) {
					if (rs.getString("EMP_BRN_CODE").equals(DataMap.get("UserBranchCode").toString())
							|| DataMap.get("UserBranchCode").toString().equals("9999")) {
						ResultSetMetaData rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							try {
								ResultMap.put(rsmd.getColumnName(i),
										StringUtils.isBlank(rs.getObject(i).toString()) ? ""
												: rs.getObject(i).toString());
							} catch (Exception e) {
								System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
							}
						}
					} else {
						ResultMap.put("ERROR_MSG", "Employee doesn't belong to this Branch!");
					}
				}
				System.out.println(ResultMap);
			} catch (SQLException e) {
				ResultMap.put("ERROR_MSG", "Error in FetchEmpData");
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

	public Map<String, String> FetchEmplpyeeData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		ResultMap.put("ERROR_MSG", "");
		if (DataMap.get("UserBranchCode").toString().equals(null) || DataMap.get("UserBranchCode").toString().equals("")
				|| DataMap.get("UserBranchCode").toString() == "" || DataMap.get("UserBranchCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DBUtils ob = new DBUtils();
			ResultSet rs = null;
			String sql = "select  EMP_ID,EMP_NAME,JOINING_DESIG, TO_CHAR(JOINING_DATE,'dd-mon-yyyy')JOINING_DATE, NAMEBANGLA,FATHERSNAMEBANGLA,MOTHERSNAMEBANGLA ,JOINING_QUOTA,GENDER,BLOOD_GRP,RHFACTOR,TIN_NO,EMAIL,CONTACT_NO,TO_CHAR(DOB,'dd-mon-yyyy')DOB  ,ADDRESS,RELIGION,HIGHEST_DEGREE,HOME_DISTRICT,NID,FATHERS_NAME,MOTHERS_NAME,JOINING_OFFICE,JOINING_GRADE,JOINING_SCAL,MARITAL_STATUS,PASSPORT_NUMBER,PERMANENT_ADDRESS,EMERGENCY_CONTACT,EMERGENCY_PHONE,JOINING_DEPT,SENIORITY_CODE\r\n"
					+ " from prms_employee e where e.emp_id=? ";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("EmployeeId").toString());
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
				System.out.println(ResultMap);
			} catch (SQLException e) {
				ResultMap.put("ERROR_MSG", "Error in FetchEmpData");
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
	
	public Map<String, String> FetchOrderRelatedData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		ResultMap.put("ERROR_MSG", "");
		if (DataMap.get("UserBranchCode").toString().equals(null) || DataMap.get("UserBranchCode").toString().equals("")
				|| DataMap.get("UserBranchCode").toString() == "" || DataMap.get("UserBranchCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DBUtils ob = new DBUtils();
			ResultSet rs = null;
			String sql = "select s.emp_id,e.emp_name,s.new_basic,(select m.brn_name from prms_mbranch m where m.brn_code=s.emp_brn_code)||'('||s.emp_brn_code||')' branch_name,(select d.designation_desc from prms_designation d where d.designation_code = s.desig_code) Designation from prms_emp_sal s join prms_employee e   on (s.emp_id = e.emp_id) where e.emp_id = ?\r\n" ;
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("EmployeeId").toString());
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
				System.out.println(ResultMap);
			} catch (SQLException e) {
				ResultMap.put("ERROR_MSG", "Error in FetchEmpData");
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
	
	

	public Map<String, String> SaveNewEmployee(Map DataMap) {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");

		System.out.println(DataMap);
		try {
				con = ob.GetConnection();
				cstmt = con.prepareCall("CALL pkg_hrm.SP_NEW_EMPLOYEE_INSERTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				cstmt.setString(1, DataMap.get("EmployeeId").toString());
				cstmt.setString(2, DataMap.get("EmployeeName").toString());
				cstmt.setString(3, DataMap.get("FatherName").toString());
				cstmt.setString(4, DataMap.get("MotherName").toString());
				cstmt.setString(5, DataMap.get("BranchCode").toString());
				cstmt.setString(6, DataMap.get("Designation").toString());
				cstmt.setString(7, DataMap.get("JoiningDate").toString());
				cstmt.setString(8, DataMap.get("DeptCode").toString());
				cstmt.setString(9, DataMap.get("Grade").toString());
				cstmt.setString(10, DataMap.get("Scale").toString());
				cstmt.setString(11, DataMap.get("Quota").toString());
				cstmt.setString(12, DataMap.get("GenderType").toString());
				cstmt.setString(13, DataMap.get("BloodGrp").toString());
				cstmt.setString(14, DataMap.get("Rhfactor").toString());
				cstmt.setString(15, DataMap.get("DOB").toString());
				cstmt.setString(16, DataMap.get("contactNo").toString());
				cstmt.setString(17, DataMap.get("TIN").toString());
				cstmt.setString(18, DataMap.get("email").toString());
				cstmt.setString(19, DataMap.get("SeniorityCode").toString());
				cstmt.setString(20, DataMap.get("Address").toString());
				cstmt.setString(21, DataMap.get("PermanentAddress").toString());
				cstmt.setString(22, DataMap.get("EntdBy").toString());
				cstmt.setString(23, DataMap.get("ReligionType").toString());
				cstmt.setString(24, DataMap.get("homeDist").toString());
				cstmt.setString(25, DataMap.get("NID").toString());
				cstmt.setString(26, DataMap.get("MaritalStatus").toString());
				cstmt.setString(27, DataMap.get("PassportNo").toString());
				cstmt.setString(28, DataMap.get("EmergencyContact").toString());
				cstmt.setString(29, DataMap.get("EmergencyPhone").toString());				
				cstmt.setString(30, DataMap.get("EmployeeNameB").toString());
				cstmt.setString(31, DataMap.get("FatherNameB").toString());
				cstmt.setString(32, DataMap.get("MotherNameB").toString());
				
				cstmt.registerOutParameter(33, java.sql.Types.VARCHAR);
				cstmt.execute();
			    String error = cstmt.getString(33);
			    
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  AddNewEmployee!\n" + error);
			} else
				ResultMap.put("SUCCESS", "Data Successfully Updated!");
		} catch (Exception e) {
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
	
	
	public Map<String, String> SaveEducation(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		con = ob.GetConnection();
		LinkedList<Map> GridMap = new LinkedList<Map>();
		GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
		ListIterator<Map> tranItems = GridMap.listIterator(0);
		try {
			while (tranItems.hasNext()) {
				Map<String, String> TransactionClause = new HashMap<String, String>();
				TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
				cstmt = con.prepareCall("CALL pkg_hrm.sp_education_data(?,?,?,?,?,?,?,?,?,?)");
				cstmt.setString(1,TransactionClause.get("id1").substring(0, TransactionClause.get("id1").indexOf("#")));
				cstmt.setString(2,TransactionClause.get("id2").substring(0, TransactionClause.get("id2").indexOf("#")));
				cstmt.setString(3, TransactionClause.get("id3"));
				cstmt.setString(4, TransactionClause.get("id4"));
				cstmt.setString(5, TransactionClause.get("id5"));
				cstmt.setString(6, TransactionClause.get("id6"));
				cstmt.setString(7, TransactionClause.get("id7"));
				cstmt.setString(8, TransactionClause.get("id8"));
				cstmt.setString(9, DataMap.get("User_Id").toString());
				cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
				cstmt.execute();
				String error = cstmt.getString(10);
				if (error != null) {
					ResultMap.put("ERROR_MSG", "Error in  SaveEducation!\n" + error);
					break;
				}
				cstmt.close();
			}
		}

		catch (Exception e) {
			ResultMap.put("ERROR_MSG", "Error in  SaveEducation!");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		ResultMap.put("SUCCESS", "Data Successfully Updated!");
		return ResultMap;
	}
	
	public Map<String, String> SaveProfessional(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		con = ob.GetConnection();
		LinkedList<Map> GridMap = new LinkedList<Map>();
		GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
		ListIterator<Map> tranItems = GridMap.listIterator(0);
		try {
			while (tranItems.hasNext()) {
				Map<String, String> TransactionClause = new HashMap<String, String>();
				TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
				cstmt = con.prepareCall("CALL pkg_hrm.sp_Profession_data(?,?,?,?,?,?,?)");
				cstmt.setString(1,TransactionClause.get("id1").substring(0, TransactionClause.get("id1").indexOf("#")));
				cstmt.setString(2,TransactionClause.get("id2").substring(0, TransactionClause.get("id2").indexOf("#")));
				cstmt.setString(3, TransactionClause.get("id3"));
				cstmt.setString(4, TransactionClause.get("id4"));
				cstmt.setString(5, TransactionClause.get("id5"));				
				cstmt.setString(6, DataMap.get("User_Id").toString());
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				cstmt.execute();
				String error = cstmt.getString(7);
				if (error != null) {
					ResultMap.put("ERROR_MSG", "Error in  SaveProfessional!\n" + error);
					break;
				}
				cstmt.close();
			}
		}

		catch (Exception e) {
			ResultMap.put("ERROR_MSG", "Error in  SaveProfessional!");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		ResultMap.put("SUCCESS", "Data Successfully Updated!");
		return ResultMap;
	}
	
	public Map<String, String> SaveAwardData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		con = ob.GetConnection();
		LinkedList<Map> GridMap = new LinkedList<Map>();
		GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
		ListIterator<Map> tranItems = GridMap.listIterator(0);
		try {
			while (tranItems.hasNext()) {
				Map<String, String> TransactionClause = new HashMap<String, String>();
				TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
				cstmt = con.prepareCall("CALL pkg_hrm.sp_Reward_data(?,?,?,?,?,?,?)");
				cstmt.setString(1,TransactionClause.get("id1").substring(0, TransactionClause.get("id1").indexOf("#")));
				cstmt.setString(2,TransactionClause.get("id2"));
				cstmt.setString(3, TransactionClause.get("id3"));
				cstmt.setString(4, TransactionClause.get("id4"));
				cstmt.setString(5, TransactionClause.get("id5"));				
				cstmt.setString(6, DataMap.get("User_Id").toString());
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				cstmt.execute();
				String error = cstmt.getString(7);
				if (error != null) {
					ResultMap.put("ERROR_MSG", "Error in  SaveAwardData!\n" + error);
					break;
				}
				cstmt.close();
			}
		}

		catch (Exception e) {
			ResultMap.put("ERROR_MSG", "Error in  SaveAwardData!");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		ResultMap.put("SUCCESS", "Data Successfully Updated!");
		return ResultMap;
	}
	
	
	public Map<String, String> AuthorizeOrder(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;
		con = ob.GetConnection();		
		Map<String, String> OrderDetailsmap = new HashMap<String, String>();		
		OrderDetailsmap=ProjectUtils.OrderTokenizer(DataMap.get("OrderDetails").toString());	
		String sql = "select s.emp_id, s.contact_no,  'You, Mr.' || s.emp_name || ' has been transfered to ' || b.brn_name ||\r\n"
				+ "       case k.attach_dept_code\r\n"
				+ "         when 0 then\r\n"
				+ "          ''\r\n"
				+ "         else\r\n"
				+ "          ' (' || (select m.dept_name\r\n"
				+ "                     from prms_brn_department m\r\n"
				+ "                    where m.dept_code = k.attach_dept_code) || ')'\r\n"
				+ "       end message\r\n"
				+ "\r\n"
				+ "  from hr_transfer_order k\r\n"
				+ "  join prms_employee s\r\n"
				+ "    on (k.empid = s.emp_id)\r\n"
				+ "  join prms_mbranch b\r\n"
				+ "    on (k.post_branch_code = b.brn_code)" ;

		
		try {
			stmt = con.prepareStatement(sql);		
			rs = stmt.executeQuery();
			while(rs.next()) {
				 Map<String, String> smsmap = new HashMap<String, String>();
					smsmap=SmsService.sendsms(rs.getString(1), rs.getString(2), rs.getString(3));					
					System.out.println(smsmap);
			}			   
		}
		catch (Exception e) {
			ResultMap.put("ERROR_MSG", "Error in  AuthorizeOrder!");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		ResultMap.put("SUCCESS", "Office Order Sucessfully Authorized !");
		return ResultMap;
	}
	
	public Map<String, String> SaveTrainingData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		con = ob.GetConnection();
		LinkedList<Map> GridMap = new LinkedList<Map>();
		GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
		ListIterator<Map> tranItems = GridMap.listIterator(0);
		try {
			while (tranItems.hasNext()) {
				Map<String, String> TransactionClause = new HashMap<String, String>();
				TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
				cstmt = con.prepareCall("CALL pkg_hrm.sp_Training_data(?,?,?,?,?,?,?)");
				cstmt.setString(1,TransactionClause.get("id1").substring(0, TransactionClause.get("id1").indexOf("#")));
				cstmt.setString(2,TransactionClause.get("id2"));
				cstmt.setString(3, TransactionClause.get("id5").substring(0, TransactionClause.get("id5").indexOf("#")));
				cstmt.setString(4, TransactionClause.get("id3"));
				cstmt.setString(5, TransactionClause.get("id4"));				
				cstmt.setString(6, DataMap.get("User_Id").toString());
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				cstmt.execute();
				String error = cstmt.getString(7);
				if (error != null) {
					ResultMap.put("ERROR_MSG", "Error in  SaveTrainingData!\n" + error);
					break;
				}
				cstmt.close();
			}
		}

		catch (Exception e) {
			ResultMap.put("ERROR_MSG", "Error in  SaveTrainingData!");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		ResultMap.put("SUCCESS", "Data Successfully Updated!");
		return ResultMap;
	}
  	
	public Map<String, String> SaveLeaveData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		con = ob.GetConnection();
		LinkedList<Map> GridMap = new LinkedList<Map>();
		GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
		ListIterator<Map> tranItems = GridMap.listIterator(0);
		try {
			while (tranItems.hasNext()) {
				Map<String, String> TransactionClause = new HashMap<String, String>();
				TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
				cstmt = con.prepareCall("CALL pkg_hrm.sp_leave_data(?,?,?,?,?,?,?,?)");
				cstmt.setString(1,TransactionClause.get("id1").substring(0, TransactionClause.get("id1").indexOf("#")));
				cstmt.setString(2, TransactionClause.get("id2").substring(0, TransactionClause.get("id2").indexOf("#")));
				cstmt.setString(3, TransactionClause.get("id3"));
				cstmt.setString(4, TransactionClause.get("id4"));
				cstmt.setString(5, TransactionClause.get("id5"));
				cstmt.setString(6, TransactionClause.get("id6").substring(0, TransactionClause.get("id6").indexOf("#")));
				cstmt.setString(7, DataMap.get("User_Id").toString());
				cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
				cstmt.execute();
				String error = cstmt.getString(8);
				if (error != null) {
					ResultMap.put("ERROR_MSG", "Error in  SaveTrainingData!\n" + error);
					break;
				}
				cstmt.close();
			}
		}

		catch (Exception e) {
			ResultMap.put("ERROR_MSG", "Error in  SaveLeaveData!");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		ResultMap.put("SUCCESS", "Data Successfully Updated!");
		return ResultMap;
	}
  	
	public Map<String, String> TransferOrderPosting(Map DataMap) {
		
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		PreparedStatement _stmt = null;
		int Batch_sl=0;
		con = ob.GetConnection();
		ResultMap.put("ERROR_MSG", "");
		LinkedList<Map> GridMap = new LinkedList<Map>();
		
		try {
			con.setAutoCommit(false);
			cstmt = con.prepareCall("CALL pkg_hrm.sp_get_order_serial(?,?)");
			cstmt.setString(1, DataMap.get("orderDate").toString());
			cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
			cstmt.execute();
		    Batch_sl = cstmt.getInt(2);
			cstmt.close();	
			
			GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
			ListIterator<Map> tranItems = GridMap.listIterator(0);		
			while (tranItems.hasNext()) {
				Map<String, String> TransactionClause = new HashMap<String, String>();
				TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
				cstmt = con.prepareCall("CALL pkg_hrm.sp_order_transfer(?,?,?,?,?,?)");				
				cstmt.setString(1, TransactionClause.get("id1").substring(0, TransactionClause.get("id1").indexOf("#")));
				cstmt.setString(2, DataMap.get("orderDate").toString());
				cstmt.setInt(3,Batch_sl);
				cstmt.setString(4, TransactionClause.get("id4").substring(0, TransactionClause.get("id4").indexOf("#")));
				cstmt.setString(5, TransactionClause.get("id5").substring(0, TransactionClause.get("id5").indexOf("#")));
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.execute();
				String message=cstmt.getString(6);
				cstmt.close();
				if(!(message==null||message.equalsIgnoreCase(""))) {
					throw new Exception(message);
				}
			}
			_stmt = con.prepareStatement("insert into hr_order_list (ORDER_DATE, ORDERSL, ORDER_TYPE, MANUAL_ORDER_NUMBER,effective_date, REMARKS, ENTRY_BY ,ENTRY_ON) values(?,?,?,?,?,?,?,sysdate)");
			_stmt.setString(1, DataMap.get("orderDate").toString());
			_stmt.setInt(2, Batch_sl);
			_stmt.setString(3, "TO");
			_stmt.setString(4, DataMap.get("OfficeOrderNo").toString());
			_stmt.setString(5, DataMap.get("EffectiveDate").toString());
			_stmt.setString(6, DataMap.get("Remarks").toString());
			_stmt.setString(7, DataMap.get("User_Id").toString());
			_stmt.executeUpdate();
			_stmt.close();
			con.commit();
			
		}catch(Exception e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			ResultMap.put("ERROR_MSG", "Error in TransferOrderPosting");
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
				
		ResultMap.put("SUCCESS", "Transfer order Successfully Updated and Sytem Order serial: " +Batch_sl +" Dated on "+DataMap.get("orderDate").toString());
		return ResultMap;
	}
	
	public Map<String, String> PromotionOrderPosting(Map DataMap) {
		
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		PreparedStatement _stmt = null;
		int Batch_sl=0;
		con = ob.GetConnection();
		ResultMap.put("ERROR_MSG", "");
		LinkedList<Map> GridMap = new LinkedList<Map>();
		
		try {
			
			con.setAutoCommit(false);
			cstmt = con.prepareCall("CALL pkg_hrm.sp_get_order_serial(?,?)");
			cstmt.setString(1, DataMap.get("orderDate").toString());
			cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
			cstmt.execute();
			 Batch_sl = cstmt.getInt(2);
			cstmt.close();	
			
			GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
			ListIterator<Map> tranItems = GridMap.listIterator(0);		
			while (tranItems.hasNext()) {
				Map<String, String> TransactionClause = new HashMap<String, String>();
				TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
				cstmt = con.prepareCall("CALL pkg_hrm.sp_order_promotion(?,?,?,?,?,?,?,?)");				
				cstmt.setString(1, TransactionClause.get("id1").substring(0, TransactionClause.get("id1").indexOf("#")));
				cstmt.setString(2, DataMap.get("orderDate").toString());
				cstmt.setInt(3,Batch_sl);
				cstmt.setString(4, TransactionClause.get("id2").substring(0, TransactionClause.get("id2").indexOf("#")));
				cstmt.setString(5, TransactionClause.get("id3").substring(0, TransactionClause.get("id3").indexOf("#")));
				cstmt.setString(6, TransactionClause.get("id4").substring(0, TransactionClause.get("id4").indexOf("#")));
				cstmt.setString(7, TransactionClause.get("id5").substring(0, TransactionClause.get("id5").indexOf("#")));
				cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
				cstmt.execute();
				String message=cstmt.getString(8);
				cstmt.close();
				if(!(message==null||message.equalsIgnoreCase(""))) {
					throw new Exception(message);
				}
			}
			_stmt = con.prepareStatement("insert into hr_order_list (ORDER_DATE, ORDERSL, ORDER_TYPE, MANUAL_ORDER_NUMBER,effective_date, REMARKS, ENTRY_BY ,ENTRY_ON) values(?,?,?,?,?,?,?,sysdate)");
			_stmt.setString(1, DataMap.get("orderDate").toString());
			_stmt.setInt(2, Batch_sl);
			_stmt.setString(3, "PO");
			_stmt.setString(4, DataMap.get("OfficeOrderNo").toString());
			_stmt.setString(5, DataMap.get("EffectiveDate").toString());
			_stmt.setString(6, DataMap.get("Remarks").toString());
			_stmt.setString(7, DataMap.get("User_Id").toString());
			_stmt.executeUpdate();
			_stmt.close();
			con.commit();
			
			
		}catch(Exception e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			ResultMap.put("ERROR_MSG", "Error in PromotionOrderPosting");
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
				
		ResultMap.put("SUCCESS", "Promotion Data  Successfully Updated and Sytem Order serial: " +Batch_sl +" Dated on "+DataMap.get("orderDate").toString());
		return ResultMap;
	}
	
	public Map<String, String> SalaryIncrementPosting(Map DataMap) {
		
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		PreparedStatement _stmt = null;
		int Batch_sl=0;
		con = ob.GetConnection();
		ResultMap.put("ERROR_MSG", "");
		LinkedList<Map> GridMap = new LinkedList<Map>();
		
		try {
			
			con.setAutoCommit(false);
			cstmt = con.prepareCall("CALL pkg_hrm.sp_get_order_serial(?,?)");
			cstmt.setString(1, DataMap.get("orderDate").toString());
			cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
			cstmt.execute();
			Batch_sl = cstmt.getInt(2);
			cstmt.close();				
			GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
						
			ListIterator<Map> tranItems = GridMap.listIterator(0);		
			while (tranItems.hasNext()) {
				Map<String, String> TransactionClause = new HashMap<String, String>();
				TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
				cstmt = con.prepareCall("CALL pkg_hrm.sp_order_increment(?,?,?,?,?,?)");				
				cstmt.setString(1, TransactionClause.get("id1").substring(0, TransactionClause.get("id1").indexOf("#")));
				cstmt.setString(2, DataMap.get("orderDate").toString());
				cstmt.setInt(3,Batch_sl);
				cstmt.setString(4, TransactionClause.get("id2"));
				cstmt.setString(5, TransactionClause.get("id5"));
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.execute();
				String message=cstmt.getString(6);
				cstmt.close();
				if(!(message==null||message.equalsIgnoreCase(""))) {
					throw new Exception(message);
				}
			}
			_stmt = con.prepareStatement("insert into hr_order_list (ORDER_DATE, ORDERSL, ORDER_TYPE, MANUAL_ORDER_NUMBER,effective_date, REMARKS, ENTRY_BY ,ENTRY_ON) values(?,?,?,?,?,?,?,sysdate)");
			_stmt.setString(1, DataMap.get("orderDate").toString());
			_stmt.setInt(2, Batch_sl);
			_stmt.setString(3, "IO");
			_stmt.setString(4, DataMap.get("OfficeOrderNo").toString());
			_stmt.setString(5, "");
			_stmt.setString(6, DataMap.get("Remarks").toString());
			_stmt.setString(7, DataMap.get("User_Id").toString());
			_stmt.executeUpdate();
			_stmt.close();
			con.commit();
			
		}catch(Exception e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			ResultMap.put("ERROR_MSG", "Error in SalaryIncrementPosting");
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
				
		ResultMap.put("SUCCESS", "Salary Increment Data Successfully Updated and Sytem Order serial: " +Batch_sl +" Dated on "+DataMap.get("orderDate").toString());
		return ResultMap;
	}
}
