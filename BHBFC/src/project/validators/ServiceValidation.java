package project.validators;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import project.Common.Infos.SblapiInfo;
import project.Service.ApiCaller;
import project.Service.SmsService;
import project.Utilities.ApplicationLog;
import project.Utilities.DBUtils;
import project.Utilities.ProjectUtils;

public class ServiceValidation {
	Map<String, String> ResultMap = new HashMap<String, String>();
	public ServiceValidation() {
		ResultMap.clear();
	}
	public Map<String, String> FetchAccountDetails(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		if (DataMap.get("LocationCode").toString().equals(null) || DataMap.get("LocationCode").toString().equals("")
				|| DataMap.get("LocationCode").toString() == "" || DataMap.get("LocationCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DBUtils ob = new DBUtils();
			String sql = "SELECT LOC_CODE,LOAN_CASE,LN_CATAGORY,LOAN_CODE,BORROWER_NAME,LN_TYPE, PROD_NATURE,SITE_ADD,ADDRESS,decode(EMAIL_ID,'','NF',EMAIL_ID)EMAIL_ID,decode(PHONE_NUMBER,'','NF',PHONE_NUMBER)PHONE_NUMBER \r\n" + 
					"  FROM SS_LOANACC_DATA\r\n" + 
					" where LOC_CODE = ?\r\n" + 
					"   and LOAN_CASE = ?\r\n" + 
					"   and LN_CATAGORY = ?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("LocationCode").toString());
				stmt.setString(2, DataMap.get("LoanAcc").toString());
				stmt.setString(3, DataMap.get("LocationCatagory").toString());
				
				rs = stmt.executeQuery();
				if (!rs.next()) {
					ResultMap.put("ERROR_MSG", "Loan Account Does not Exist!!(Upto 2019-2020 Final Closing)");
				} else {					
						ResultSetMetaData rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							try {
								ResultMap.put(rsmd.getColumnName(i),
										StringUtils.isBlank(rs.getObject(i).toString()) ? ""
												: rs.getObject(i).toString());
							} catch (Exception e) {
								//System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
								e.printStackTrace();
							}
						}
					
				}
			} catch (SQLException e) {
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
	
	
	
	public Map<String, String> FetchAPIData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		if (DataMap.get("OfficeCode").toString().equals(null) || DataMap.get("OfficeCode").toString().equals("")
				|| DataMap.get("OfficeCode").toString() == "" || DataMap.get("OfficeCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DBUtils ob = new DBUtils();
			String sql = "select LOC_CODE,LOAN_CODE,BORROWER_NAME,decode(BORROWER_F_NAME,'','NF',BORROWER_F_NAME)BORROWER_F_NAME,SITE_LOCATION,MAILING_LOCATION,LN_STATUS, DECODE(NID,'','NF',NID)NID, DECODE(TIN,'','NF',TIN)TIN   ,DECODE(MAIL_ID,'','NF',MAIL_ID)MAIL_ID,DECODE(MOBILE_NO,'','NF',MOBILE_NO)MOBILE_NO from loan_account where loc_code = ?  and loan_code = ?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("OfficeCode").toString());
				//stmt.setString(2, DataMap.get("ProductNature").toString());
				stmt.setString(2, DataMap.get("LoanCode").toString());
				
				rs = stmt.executeQuery();
				if (rs.next()) {			
						ResultSetMetaData rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							try {
								ResultMap.put(rsmd.getColumnName(i),
										StringUtils.isBlank(rs.getObject(i).toString()) ? ""
												: rs.getObject(i).toString());
							} catch (Exception e) {
								System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
								e.printStackTrace();
							}
						}
					
				}
			} catch (SQLException e) {
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
	
	public String isNewEntryCheck(String OfficeCode, String LoanCode, String productNature) {
		String MessageStatus = null;
		DBUtils ob = new DBUtils();
		String sql = "select count(*) count  from loan_account where loc_code = ?    and loan_code = ?";
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int exist = 0;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, OfficeCode);
			//stmt.setString(2, productNature);
			stmt.setString(2, LoanCode);
			rs = stmt.executeQuery();
			if (rs.next()) {
				exist = rs.getInt("count");
			}
			if (exist == 0) {
				MessageStatus = "NEW";
			} else {
				MessageStatus = "MOD";
			}

		} catch (SQLException e) {
			MessageStatus = "00";

		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return MessageStatus;
	}
	
	public boolean isModifyNameAndStatus(String OfficeCode, String LoanCode, String productNature, String borrowerName,
			String Status) {

		DBUtils ob = new DBUtils();
		boolean bool = false;
		String sql = "select a.borrower_name,a.ln_status from loan_account a where  a.loc_code=? and a.loan_code=?";
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.prepareStatement(sql);
		//	stmt.setString(1, productNature);
			stmt.setString(1, OfficeCode);
			stmt.setString(2, LoanCode);
			rs = stmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("BORROWER_NAME").toString().equals(borrowerName)
						&& rs.getString("LN_STATUS").toString().equals(Status)) {
					bool = false;
				} else {
					bool = true;
				}
			}

		} catch (SQLException e) {
			bool = false;
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return bool;
	}
	
	
	public Map<String, String> UpdateAPIData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		Map<String, String> apiparameter = new HashMap<String, String>();
		Map<String, String> TokenResponse = new HashMap<String, String>();
		Map<String, String> ResponseMessage = new HashMap<String, String>();
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		String Message=null;
		String Token="";
		try {
			 Message = isNewEntryCheck(DataMap.get("OfficeCode").toString(), DataMap.get("LoanCode").toString(),DataMap.get("ProductNature").toString());
			if (Message.equals("NEW")) {				
				try {
					ApplicationLog.LMSLoging(DataMap,"API-Add");
					
					apiparameter.put("Username",SblapiInfo.Username);
					apiparameter.put("password",SblapiInfo.password);
				//	apiparameter.put("APIDOC",SblapiInfo.AuthenticationTokenGenLink);
				    TokenResponse =ProjectUtils.JasonStringToHashMap( new ApiCaller(SblapiInfo.AuthenticationTokenGenLink).PushDataToSbl(apiparameter));				
					apiparameter.clear();	
					
					apiparameter.put("token",TokenResponse.get("TOKEN"));
					apiparameter.put("accountNo",DataMap.get("LoanCode").toString());
					apiparameter.put("branchCode",DataMap.get("OfficeCode").toString());
					apiparameter.put("branchName",DataMap.get("branchName").toString());
					apiparameter.put("accountName",DataMap.get("BorrowerName").toString());
					apiparameter.put("mobileNo",DataMap.get("PhoneNumber").toString());		
					ResponseMessage =ProjectUtils.JasonStringToHashMap(new ApiCaller(SblapiInfo.LoanDataInfoSavelink).PushDataToSbl(apiparameter));
					System.out.print(ResponseMessage);
					
					if(ResponseMessage.isEmpty()) {
						ResultMap.put("ERROR_MSG", "API does not response properly");
					}
					else {
						if(!ResponseMessage.get("StatusCode").equals("200")) {
							ResultMap.put("ERROR_MSG", ResponseMessage.get("StatusMsg"));
						}
					}
					
					
					apiparameter.clear();
					ResponseMessage.clear();
				}catch(Exception e) {
					e.printStackTrace();
				}
												
			} else if (Message.equals("MOD")) {
				
				if (isModifyNameAndStatus(DataMap.get("OfficeCode").toString(), DataMap.get("LoanCode").toString(),
						DataMap.get("ProductNature").toString(), DataMap.get("BorrowerName").toString(),
						DataMap.get("lnstatus").toString())) {
					
					try {
						ApplicationLog.LMSLoging(DataMap,"API-Mod");
						
						apiparameter.put("Username",SblapiInfo.Username);
						apiparameter.put("password",SblapiInfo.password);
					    TokenResponse =ProjectUtils.JasonStringToHashMap( new ApiCaller(SblapiInfo.AuthenticationTokenGenLink).PushDataToSbl(apiparameter));				
						apiparameter.clear();				
						apiparameter.put("token",TokenResponse.get("TOKEN"));
						apiparameter.put("accountNo",DataMap.get("LoanCode").toString());
						apiparameter.put("branchCode",DataMap.get("OfficeCode").toString());
						apiparameter.put("accountName",DataMap.get("BorrowerName").toString());
						apiparameter.put("accountStatus",DataMap.get("lnstatus").toString());	
						apiparameter.put("mobileNo",DataMap.get("PhoneNumber").toString());		
					    ResponseMessage =ProjectUtils.JasonStringToHashMap(new ApiCaller(SblapiInfo.LoanDataInfoUpdatelink).PushDataToSbl(apiparameter));
						System.out.print(ResponseMessage);
						if(ResponseMessage.isEmpty()) {
							ResultMap.put("ERROR_MSG", "API does not response properly");
						}
						else {
							if(!ResponseMessage.get("StatusCode").equals("200")) {
								ResultMap.put("ERROR_MSG", ResponseMessage.get("StatusMsg"));
							}
						}
						apiparameter.clear();
						ResponseMessage.clear();
						
					}catch(Exception e) {
						e.printStackTrace();
					}	
															
				}
			}
			System.out.println(Message);
		}catch(Exception e) {
			ResultMap.put("ERROR_MSG", e.getMessage());
		}
		try {
			if(ResultMap.get("ERROR_MSG").equals("")) {						
				try {
					con = ob.GetConnection();
					cstmt = con.prepareCall("CALL PKG_API.sp_loan_account_info(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					cstmt.setString(1, DataMap.get("OfficeCode").toString());
					cstmt.setString(2, DataMap.get("LoanCode").toString());
					cstmt.setString(3, DataMap.get("ProductNature").toString());
					cstmt.setString(4, DataMap.get("BorrowerName").toString());
					cstmt.setString(5, DataMap.get("FathersName").toString());
					cstmt.setString(6, DataMap.get("lnstatus").toString());					
					cstmt.setString(7, DataMap.get("MailAddress").toString());
					cstmt.setString(8, DataMap.get("PhoneNumber").toString());
					cstmt.setString(9, DataMap.get("SiteLocation").toString());
					cstmt.setString(10, DataMap.get("Address").toString());
					cstmt.setString(11, DataMap.get("NID").toString());
					cstmt.setString(12, DataMap.get("TIN").toString());					
					cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
					cstmt.execute();
					String error = cstmt.getString(13);
					if (error != null) {
						ResultMap.put("ERROR_MSG",  error);
					} else
						ResultMap.put("SUCCESS", "Record Successfully Completed!");
				} catch (SQLException e) {
					ResultMap.put("ERROR_MSG", " Error in UpdateAPIData");
					e.printStackTrace();
				} 			
			}
						
		}catch(Exception e) {
			
		}finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	

		return ResultMap;
	}
	
	public Map<String, String> UpdateBorrowerDeduction(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "UPDATE SS_LOANACC_DATA  SET EMAIL_ID=? , PHONE_NUMBER=?\r\n" + 
				" WHERE LOC_CODE = ?\r\n" + 
				"   AND LOAN_CASE =?\r\n" + 
				"   AND LN_CATAGORY = ? ";
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("MailAddress").toString());
			stmt.setString(2, DataMap.get("PhoneAddress").toString());
			stmt.setString(3, DataMap.get("LocationCode").toString());
			stmt.setString(4, DataMap.get("LoanAcc").toString());
			stmt.setString(5, DataMap.get("LocationCatagory").toString());
			stmt.executeUpdate();
			ResultMap.put("SUCCESS", "Borrower Email and Phone number Sucessfully Updated");
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating Borrower Email and Phone number");
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public void CallSMSAPI(String nothi,int Year,int monthcode,int sucessor_sl ,String sms, String mobile)  {
		DBUtils ob = new DBUtils();
		PreparedStatement stmt = null;	
		Connection con = ob.GetConnection();
		String sql="INSERT INTO PEN_SMS_DATA (NOTHI_NO,YEAR,MONTH_CODE,TRAN_SL,SMS_BODY,MOBILE,RESPONSE_BODY,STATUS_CODE,STATUS_MESSAGE) VALUES(?,?,?,?,?,?,?,?,?)";
		Map<String, String> smsmap = new HashMap<String, String>();
		
		try {
			String csmsid=StringUtils.leftPad(nothi, 4, "0")+Year+StringUtils.leftPad(monthcode+"",2,"0")+ StringUtils.leftPad(sucessor_sl+"",2,"0");
			smsmap=SmsService.sendsms(csmsid,mobile, sms);				
			stmt = con.prepareStatement(sql);
			stmt.setString(1, nothi);
			stmt.setInt(2, Year);
			stmt.setInt(3, monthcode);
			stmt.setInt(4, sucessor_sl);
			stmt.setString(5, sms);
			stmt.setString(6, mobile);
			stmt.setString(7, smsmap.get("ResponseBody").toString());
			stmt.setString(8, smsmap.get("Status").toString());
			stmt.setString(9, smsmap.get("StatusMessage").toString());
			stmt.executeUpdate();			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				con.close();
				stmt.close();				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public Map<String, String> BulkMessageService(Map DataMap) {
		DBUtils ob = new DBUtils();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		ResultMap.put("ERROR_MSG", "");
		String sql = "select NOTHI_NO,year,month_code,TRAN_SL,'Monthly Pension Advice of '||substr(decode(a.month_code,'1','January','2','February','3','March','4','April','5','May','6','June','7','July','8','August','9','September','10','October','11','November','December'),1,3)||'/'||a.year ||' BDT '||  trim(TO_CHAR(NET_PAYMENT, '9999999.99'))||' has been sent to your SBL A/C ***'||substr(a.bank_account,11,3) SMS,decode(sucessor_name,'',(select e.contact_no from pen_employee e where e.nothi_num=a.nothi_no),(select h.contact_no from pen_inheritance h where h.nothi_num=a.nothi_no and h.successor_sl=a.tran_sl))mobile from pen_transation_details a   \r\n" + 
				"  where a.entity_num = 1    \r\n" + 
				"      and a.year = ?  \r\n" + 
				"      and a.month_code = ?     \r\n" + 
				"      and  activationtype ='Y'    \r\n" + 
				"      and NET_PAYMENT<>0 and \r\n" + 
				"      decode(sucessor_name,'',(select e.contact_no from pen_employee e where e.nothi_num=a.nothi_no),(select h.contact_no from pen_inheritance h where h.nothi_num=a.nothi_no and h.successor_sl=a.tran_sl))<>'N/A' \r\n" + 
				"      and length (decode(sucessor_name,'',(select e.contact_no from pen_employee e where e.nothi_num=a.nothi_no),(select h.contact_no from pen_inheritance h where h.nothi_num=a.nothi_no and h.successor_sl=a.tran_sl)))=11\r\n" ;
		Connection con = ob.GetConnection();
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("Year").toString());
			stmt.setString(2, DataMap.get("MonthCode").toString());
			rs = stmt.executeQuery();
			while (rs.next()) {
				try {
					CallSMSAPI(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getString(5),rs.getString(6));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			ResultMap.put("ERROR_MSG", "Error in BulkMessageService" + e.getMessage());
		}
		finally {
			try {
				con.close();
				stmt.close();				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		ResultMap.put("SUCCESS", " SMSs have been sent sucessfully!!");
		return ResultMap;
	}

	
}
