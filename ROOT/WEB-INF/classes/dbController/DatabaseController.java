package dbController;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.ResultSet;
import java.util.*;

/**
 * Servlet implementation class for Servlet: DatabaseController
 *
 */
public class DatabaseController {
  static final long serialVersionUID = 1L;
  /**
   * A handle to the connection to the DBMS.
   */
  protected Connection connection_;
  /**
   * A handle to the statement.
   */
  protected Statement statement_;
  /**
   * The connect string to specify the location of DBMS
   */
  protected String connect_string_ = null;
  /**
   * The password that is used to connect to the DBMS.
   */
  protected String password = null;
  /**
   * The username that is used to connect to the DBMS.
   */
  protected String username = null;


  public DatabaseController() {
    // your cs login name
    username = "luye";
    // your Oracle password, NNNN is the last four digits of your CSID
    password = "a2575";
    connect_string_ = "jdbc:oracle:thin:@aloe.cs.arizona.edu:1521:oracle";
  }


  /**
   * Closes the DBMS connection that was opened by the open call.
   */
  public void Close() {
    try {
      statement_.close();
      connection_.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    connection_ = null;
  }


  /**
   * Commits all update operations made to the dbms.
   * If auto-commit is on, which is by default, it is not necessary to call
   * this method.
   */
  public void Commit() {
    try {
      if (connection_ != null && !connection_.isClosed())
        connection_.commit();
    } catch (SQLException e) {
      System.err.println("Commit failed");
      e.printStackTrace();
    }
  }

  public void Open() {
  try {
      Class.forName("oracle.jdbc.OracleDriver");
      connection_ = DriverManager.getConnection(connect_string_, username, password);
      statement_ = connection_.createStatement();
      return;
  } catch (SQLException sqlex) {
      sqlex.printStackTrace();
  } catch (ClassNotFoundException e) {
      e.printStackTrace();
      System.exit(1); //programemer/dbsm error
  } catch (Exception ex) {
      ex.printStackTrace();
      System.exit(2);
  }
    }


  public Vector<String> FindAllProducts() {
    String sql_query = "SELECT * FROM mingjunz.account order by ID";
    try {
      ResultSet rs  = statement_.executeQuery(sql_query);
      Vector<String> result_employees = new Vector<String>();
      while (rs.next()) {
        String temp_record = rs.getInt("ID") + "##" + rs.getString("ACCNAME") + "##" + rs.getString("PASSWORD") + "##" + rs.getString("USERTYPE") + "##" + rs.getString("FIRSTNAME") + "##" + rs.getString("LASTNAME") + "##" + rs.getString("ADDRESS") + "##" + rs.getString("PHONE");
        result_employees.add(temp_record);
      }
      return result_employees;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
    }
    return null;
  }

  // have a tiny error here when your table is empty and the id cannot insert corrert.
  // Change id arrt function to auto_increament when you have time :)
  public int InsertUser(String accname, String password, String usertype){
    String query = "INSERT INTO mingjunz.account VALUES ((select max(ID)+1 from mingjunz.account), '" + accname + "', '" + password + "', '" + usertype + "', NULL, NULL, NULL, NULL)";
    try {
      statement_.executeQuery(query);
      statement_.executeQuery("commit");
      return 1;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
       return 0;
    }
  }

  public int AddUser(String username, String password, String user_type, String first_name, String last_name, String address, String phone){
    String query = "INSERT INTO mingjunz.account VALUES ((select max(ID)+1 from mingjunz.account), '" + username + "', '" + password + "', '" + user_type + "', '" + first_name + "', '" + last_name + "', '" + address + "', '" + phone + "')";
    try {
      statement_.executeQuery(query);
      statement_.executeQuery("commit");
      return 1;
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
      return 0;
    }    
  }

  public boolean CheckUser(String accname){
      String query =  "select * from mingjunz.account where accname ='" + accname + "'";
      try {
            ResultSet rs  = statement_.executeQuery(query);
            if(rs.next()){
              return true; //existed
            }else{
              return false;
            }
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
            return true;
        }
    }


  public boolean HaveAccount(String accname, String password){
    String query = "select * from mingjunz.account where accname ='" + accname + "' and password='" + password + "'";
    try {
      ResultSet rs  = statement_.executeQuery(query);
      if(rs.next()){
        return true; //existed
      }else{
        return false;
      }
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
      return false;
    }
  }

  public int GetUserType(String accname){
    String query = "select * from mingjunz.account where accname='"+accname+"'"; 
    try {
      String temp = "";
      ResultSet rs  = statement_.executeQuery(query);
      while(rs.next()){
        temp = rs.getString("USERTYPE");
      }
      if(temp.equals("customer")==true){
        return 0;
      }else if(temp.equals("employee")==true){
        return 1;
      }else if(temp.equals("manager")==true){
        return 2;
      }else{
        return 3;
      }
    } catch (SQLException sqlex) {
      sqlex.printStackTrace();
      return 4;
    }
  }

  public int RemoveUser(String s_id){
    int temp = Integer.parseInt(s_id);
    String query = "delete from mingjunz.account where id=" + temp;
    try{
      statement_.executeQuery(query);
      statement_.executeQuery("commit");
      return 1;
    }catch (SQLException sqlex) {
      sqlex.printStackTrace();
      System.exit(-1);
    }
    return 0;
  }

  public boolean isManager(String s_id){
    int id = Integer.parseInt(s_id);
    String query = "select usertype from mingjunz.account where id=" + id;
    try {
      String temp = "";
      ResultSet rs  = statement_.executeQuery(query);
      while(rs.next()){
        temp = rs.getString("USERTYPE");
      }
      if(temp.equals("manager")==true){
        return true;
      }else{
        return false;
      }
    }catch (SQLException sqlex) {
      sqlex.printStackTrace();
      System.exit(-1);
    }
    return false;
  }

    public boolean IsVaildID1(String target){
      try{
        int num = Integer.parseInt(target);
        return true;
      }catch (NumberFormatException ex) {
        ex.printStackTrace();
        return false;
      }
    }


    public int IsVaildID2(String target) {
      int id=Integer.parseInt(target);
      String sql_query = "SELECT count(*) FROM mingjunz.account WHERE  id="+id;
      int i=0;
      try {
        ResultSet rs  = statement_.executeQuery(sql_query);
        while (rs.next()) {
          return rs.getInt("count(*)");
        }
      } catch (SQLException sqlex) {
        sqlex.printStackTrace();    
      }
      return 0;
    }

    public void UpdateCustomerFirstName(int id, String fn){
        String insertTableSQL1="UPDATE mingjunz.account SET firstName='"+fn+"' where id=" + id;
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void UpdateCustomerPW(int id, String pass){
        String insertTableSQL1="UPDATE mingjunz.account SET password='"+pass+"' where id=" + id;
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void UpdateCustomerUsername(int id, String name){
        String insertTableSQL1="UPDATE mingjunz.account SET accname='"+name+"' where id=" + id;
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void UpdateCustomerLastName(int id, String ln){
        String insertTableSQL1="UPDATE mingjunz.account SET lastName='"+ln+"' where id=" + id;
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void UpdateCustomerAddress(int id, String address){
        String insertTableSQL1="UPDATE mingjunz.account SET address='"+address+"' where id=" + id;
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void UpdateCustomerPhone(int id, String phone){
        String insertTableSQL1="UPDATE mingjunz.account SET phone='"+phone+"' where id=" + id;
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void UpdateUsertype(int id, String ut){
        String insertTableSQL1="UPDATE mingjunz.account SET usertype='"+ut+"' where id=" + id;
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }


  
}
