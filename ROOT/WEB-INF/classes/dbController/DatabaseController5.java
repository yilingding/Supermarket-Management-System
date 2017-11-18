
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
public class DatabaseController5 {
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
    
    
    public DatabaseController5() {
        // your cs login name
        username = "yilingding";
        // your Oracle password, NNNN is the last four digits of your CSID
        password = "a8520";
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
    
    public void InsertIntoCart(String id,String name, String username, String price, String number){
        Double price1=Double.parseDouble(price);
        int number1=Integer.parseInt(number);
        int id1=Integer.parseInt(id);
        //change 2 to customer id
        String insertTableSQL1="INSERT INTO yilingding.cart VALUES ("+id1+", 2, '"+name+"', '"+username+"', "+price1+", "+number1+",current_timestamp)";
        try{
            statement_.executeUpdate(insertTableSQL1);
            statement_.executeUpdate("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public Vector<String> FindAllProducts() {
        String sql_query = "SELECT * FROM yilingding.product ";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_employees = new Vector<String>();
            while (rs.next()) {
                String temp_record = rs.getString("id") + "##" + rs.getString("name") +
                "##" + rs.getDouble("price") + "##" + rs.getInt("quantity")+ "##" + rs.getString("image");
                result_employees.add(temp_record);
            }
            return result_employees;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    public Vector<String> FindAllCarts(String name) {
        String sql_query = "SELECT * FROM yilingding.cart WHERE username='"+name+"'";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_employees = new Vector<String>();
            while (rs.next()) {
                String temp_record =rs.getInt("id")+"##"+ rs.getString("name") + "##"+ rs.getDouble("price") + "##" + rs.getInt("quantity") ;
                result_employees.add(temp_record);
            }
            return result_employees;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    public Vector<String> FindAllOrders(String name) {
        String sql_query = "SELECT * FROM mingjunz.orderlist WHERE accName='"+name+"'";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_employees = new Vector<String>();
            while (rs.next()) {
                String temp_record =rs.getInt("orderNum")+"##"+ rs.getString("prodName") + "##"+rs.getInt("QTY")+"##"+ rs.getDouble("price") + "##" + rs.getString("purchaseDate") +"##" + rs.getString("pickupDate")+"##" + rs.getString("ordertype") ;
                result_employees.add(temp_record);
            }
            return result_employees;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    public Vector<String> FindStoreOrders() {
        String sql_query = "SELECT * FROM mingjunz.orderlist WHERE ordertype='instore'";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_employees = new Vector<String>();
            while (rs.next()) {
                String temp_record =rs.getInt("orderNum")+"##"+ rs.getString("accName")+"##"+ rs.getString("prodName") + "##"+rs.getInt("QTY")+"##"+ rs.getDouble("price") + "##" + rs.getString("purchaseDate") +"##" + rs.getString("pickupDate")+"##" + rs.getString("ordertype") ;
                result_employees.add(temp_record);
            }
            return result_employees;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    public Vector<String> FindOnlineOrders() {
        String sql_query = "SELECT * FROM mingjunz.orderlist WHERE ordertype='online'";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_employees = new Vector<String>();
            while (rs.next()) {
                String temp_record =rs.getInt("orderNum")+"##"+ rs.getString("accName")+"##"+ rs.getString("prodName") + "##"+rs.getInt("QTY")+"##"+ rs.getDouble("price") + "##" + rs.getString("purchaseDate") +"##" + rs.getString("pickupDate")+"##" + rs.getString("ordertype") ;
                result_employees.add(temp_record);
            }
            return result_employees;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    public void UpdateCart(String id, String username, String price, String number){
        Double price1=Double.parseDouble(price);
        int number1=Integer.parseInt(number);
        int id1=Integer.parseInt(id);
        String insertTableSQL1="UPDATE yilingding.cart SET quantity=quantity+"+number1+"where username='"+username+"' AND id="+id1;
        try{
            statement_.executeUpdate(insertTableSQL1);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public void UpdateCustomerFirstName(String username, String fn){
        String insertTableSQL1="UPDATE mingjunz.account SET firstName='"+fn+"' where accname='"+username+"'";
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println("e.getMessage()");
        }
    }
    
    public void UpdateCustomerPass(String username, String pass){
        String insertTableSQL1="UPDATE mingjunz.account SET password='"+pass+"' where accname='"+username+"'";
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println("e.getMessage()");
        }
    }
    
    public void UpdateCustomerLastName(String username, String ln){
        String insertTableSQL1="UPDATE mingjunz.account SET lastName='"+ln+"' where accname='"+username+"'";
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void UpdateCustomerAddress(String username, String address){
        String insertTableSQL1="UPDATE mingjunz.account SET address='"+address+"' where accname='"+username+"'";
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public void UpdateCustomerPhone(String username, String phone){
        String insertTableSQL1="UPDATE mingjunz.account SET phone='"+phone+"' where accname='"+username+"'";
        try{
            statement_.executeQuery(insertTableSQL1);
            statement_.executeQuery("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    
    
    public Vector<String> FindAllOrderDetail(String name) {
        String sql_query = "SELECT * FROM yilingding.orderdetail WHERE username='"+name+"'";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_employees = new Vector<String>();
            while (rs.next()) {
                String temp_record =rs.getInt("ordernumber")+"##"+ rs.getString("firstName")+"##"+ rs.getString("lastName")+"##"+ rs.getString("address")+"##"+ rs.getString("phone")+"##"+ rs.getString("payment") + "##"+ rs.getDouble("price") + "##" + rs.getString("purchaseDate") ;
                result_employees.add(temp_record);
            }
            return result_employees;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    
    
    public Vector<String> Findaccount(String name) {
        String sql_query = "SELECT * FROM mingjunz.account where ACCNAME='"+name+"'";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_employees = new Vector<String>();
            while (rs.next()) {
                String temp_record = rs.getInt("id")+ "##" + rs.getString("accname") + "##" +rs.getString("password") + "##" + rs.getString("firstName") +
                "##" + rs.getString("lastName") + "##" +rs.getString("address")+ "##" +rs.getString("phone");
                result_employees.add(temp_record);
            }
            return result_employees;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    
    public int FindOrderNumber() {
        String sql_query = "SELECT count(distinct orderNum) from mingjunz.orderlist ";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }
    
    
    public int FindNumberOfOrder() {
        String sql_query = "SELECT count(*) FROM yilingding.orderdetail ";
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
    //dbcontroller.InsertIntoOrderList(1,"st", 'yiling', "50", "5","250");
    public void InsertIntoOrderList(int orderNumber,String productname, String username, String price, String quantity,double totalprice,String pickupDate){
        double price1=Double.parseDouble(price);
        int quantity1=Integer.parseInt(quantity);
        
        String insertTableSQL1="INSERT INTO mingjunz.orderlist VALUES ("+orderNumber+", '"+username+"', '"+productname+"', 'online', "+price1+", "+quantity1+",current_timestamp, Date'"+pickupDate+"')";
        try{
            statement_.executeUpdate(insertTableSQL1);
            statement_.executeUpdate("commit");
            return;
            //return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            return;
            //return false;
        }
        //return false;
    }
    
    public void InsertOrderDetails(int orderNumber, String username, String firstName,String lastName,String address, String phone, String payment,  double totalPrice){
        
	       String insertTableSQL1="INSERT INTO yilingding.orderdetail VALUES ("+orderNumber+", '"+username+"', '"+firstName+"', '"+lastName+"', '"+address+"', '"+phone+"', '"+payment+"', 'supply', "+totalPrice+",current_timestamp)";
        try{
            statement_.executeUpdate(insertTableSQL1);
            statement_.executeUpdate("commit");
            return;
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public int ExistId(String id,String name) {
        int id1=Integer.parseInt(id);
        String sql_query = "SELECT count(*) FROM yilingding.cart WHERE  id="+id1+"AND username='"+name+"'" ;
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
    
    public int ExistInCart(String id,String name) {
        int id1=Integer.parseInt(id);
        String sql_query = "SELECT count(*) FROM yilingding.cart WHERE  id="+id1+"AND username='"+name+"'" ;
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
    
    public void clearMycart(String name) {
        String sql_query = "DELETE FROM yilingding.cart WHERE username='"+name+"'";
        try {
            statement_.executeUpdate(sql_query);
            
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        
    }
    
    
    public void updateQuantity(String name,int quantity) {
        int now=checkCart(name,quantity);
        int update=now-quantity;
        
        String insertTableSQL2="UPDATE yilingding.product SET quantity="+update+"where name='"+name+"'";
        try{
            statement_.executeUpdate(insertTableSQL2);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        
    }
    public int  getCart(String name,int quantity) {
        String sql_query = "SELECT quantity FROM yilingding.cart WHERE name='"+name+"'";
        int now=0;
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            while (rs.next()) {
                now= rs.getInt("quantity");
            }
            return now;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
        
    }
    
    public int  checkCart(String name,int quantity) {
        String sql_query = "SELECT quantity FROM yilingding.product WHERE name='"+name+"'";
        int now=0;
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            while (rs.next()) {
                now= rs.getInt("quantity");
            }
            return now;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
        
    }
    
    
    
    public void deleteOrder(int name) {
        String sql_query = "DELETE FROM mingjunz.orderlist WHERE orderNum="+name;
        try {
            statement_.executeUpdate(sql_query);
            
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        
    }
    
}
