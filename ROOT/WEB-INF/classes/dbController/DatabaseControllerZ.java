package dbController;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.sql.ResultSet;
import java.util.*;

/**
 * Servlet implementation class for Servlet: DatabaseController
 *
 */
public class DatabaseControllerZ {
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
    
    protected int currUserId=-1;
    
    protected String currUserName;
    
    protected String userType;
    
    protected String sql_query;
    
    
    public DatabaseControllerZ() {
        // your cs login name
        username = "mingjunz";
        // your Oracle password, NNNN is the last four digits of your CSID
        password = "a7569";
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
        sql_query = "SELECT * FROM yilingding.product order by id";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_products = new Vector<String>();
            while (rs.next()) {
                String temp_record = rs.getInt("id") + "##" + rs.getString("NAME") +
                "##" + rs.getString("image") + "##" +rs.getDouble("price") + "##" + rs.getInt("quantity");
                sql_query=sql_query+temp_record;
                result_products.add(temp_record);
            }
            Commit();
            return result_products;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    
    public void setUser(String username){
        currUserName=username;
        sql_query = "SELECT id, usertype FROM mingjunz.account where accname=\'"+username+"\'";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            if(rs.next()){
                currUserId = rs.getInt("id");
                userType=rs.getString("usertype");
                Commit();
            }
        }catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
    }
    
    public void storeStock(int pronum, int quan){
        sql_query = "UPDATE yilingding.product set quantity="+quan+"where id="+pronum;
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            if(rs.next()){
                Commit();
            }
        }catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
    }
    
    public Vector<String> getAllSupplyOrder(){
        sql_query = "SELECT * FROM mingjunz.orderlist where ordertype='supply' order by ordernum";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_supply_order = new Vector<String>();
            while (rs.next()) {
                String temp_record = rs.getInt("ORDERNUM") + "##";
                String temp = rs.getString("purchaseDate");
                temp=temp.substring(0,(temp).indexOf(" "));
                temp_record=temp_record + temp + "##" + rs.getString("PRODName") + "##" + rs.getString("accName") + "##" + rs.getInt("qty");
                result_supply_order.add(temp_record);
            }
            Commit();
            return result_supply_order;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    
    public  Vector<String> getSupplyOrderFilter(String date, String pronum, String id){
        date="TO_DATE('"+date+"','YYYY-MM-DD')";
        if (date.equals("none")){
            if(pronum.equals("none")){
                sql_query= "SELECT * FROM mingjunz.orderlist where ordertype='supply'" +
                "and accname='"+id+"' order by ordernum";
            }else{
                if(id.equals("none")){
                    sql_query= "SELECT * FROM mingjunz.orderlist where ordertype='supply'" +
                    "and prodname='"+pronum+"' order by ordernum";
                }else{
                    sql_query= "SELECT * FROM mingjunz.orderlist where ordertype='supply'" +
                    "and prodname='"+pronum+"' and accname='"+id+"' order by ordernum";
                }
            }
        }else{
            if(pronum.equals("none")){
                if(id.equals("none")){
                    sql_query= "SELECT * FROM mingjunz.orderlist where ordertype='supply'" +
                    "and purchasedate="+date+" order by ordernum";
                }else{
                    sql_query= "SELECT * FROM mingjunz.orderlist where ordertype='supply'" +
                    "and purchasedate="+date+" and accname='"+id+"' order by ordernum";
                }
            }else{
                if(id.equals("none")){
                    sql_query= "SELECT * FROM mingjunz.orderlist where ordertype='supply'" +
                    "and purchasedate="+date+" and prodname='"+pronum+"' order by ordernum";
                }else{
                    sql_query= "SELECT * FROM mingjunz.orderlist where ordertype='supply'" +
                    "and purchasedate="+date+" and prodname='"+pronum+"' "+
                    "and accname='"+id+"' order by ordernum";
                }
            }
        }
        
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_supply_order = new Vector<String>();
            while (rs.next()) {
                String temp_record = rs.getInt("ORDERNUM") + "##";
                String temp = rs.getString("purchaseDate");
                temp=temp.substring(0,(temp).indexOf(" "));
                temp_record=temp_record + temp + "##" + rs.getString("PRODName") + "##" + rs.getString("accName") + "##" + rs.getInt("qty");
                result_supply_order.add(temp_record);
            }
            Commit();
            return result_supply_order;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    
    public  Vector<String> getAllXactDate(){
        String sql_query = "SELECT distinct purchasedate FROM mingjunz.orderlist where ordertype='supply' order by purchasedate";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_xact = new Vector<String>();
            while (rs.next()) {
                String temp_record = rs.getString("purchasedate");
                temp_record=(temp_record).substring(0,(temp_record).indexOf(" "));
                result_xact.add(temp_record);
            }
            Commit();
            return result_xact;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    
    public  Vector<String> getAllProNum(){
        String sql_query = "SELECT distinct prodname FROM mingjunz.orderlist where ordertype='supply' order by prodname";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_xact = new Vector<String>();
            while (rs.next()) {
                String temp_record =""+ rs.getString("prodname");
                result_xact.add(temp_record);
            }
            Commit();
            return result_xact;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    
    public  Vector<String> getAllUserId(){
        String sql_query = "SELECT distinct accname FROM mingjunz.orderlist where ordertype='supply' order by accname";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            Vector<String> result_xact = new Vector<String>();
            while (rs.next()) {
                String temp_record =""+ rs.getString("accname");
                result_xact.add(temp_record);
            }
            Commit();
            return result_xact;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }
    
    public void placeSupplyOrder(String max, String proname, String price, String qty){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date dateobj = new Date();
        String time=df.format(dateobj);
        sql_query = "INSERT INTO mingjunz.orderlist values ("+max+", '"+getUserName()+"', '"+proname+
        "', 'supply', "+price+", "+qty+", Date '" +time+ "', null)";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            updateStockQty2(proname, qty);
            Commit();
        }catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
    }
    
    public void placeInstoreOrder(String max, String proname, String price, String qty){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date dateobj = new Date();
        String time=df.format(dateobj);
        sql_query = "INSERT INTO mingjunz.orderlist values ("+max+", '"+getUserName()+"', '"+proname+
        "', 'instore', "+price+", "+qty+", Date '" +time+ "', null)";
        try {
            ResultSet rs  = statement_.executeQuery(sql_query);
            updateStockQty(proname, qty);
            Commit();
        }catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
    }
    
    public void updateStockQty(String proname, String qty){
    int qtt=Integer.parseInt(qty);
    	sql_query="SELECT id, quantity from yilingding.product where name='"+proname+"'";
        try{
            ResultSet rs=statement_.executeQuery(sql_query);
            if (rs.next()) {
                int id =rs.getInt("id");
                int quan=rs.getInt("quantity");
                storeStock(id, quan-qtt);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public void updateStockQty2(String proname, String qty){
    int qtt=Integer.parseInt(qty);
    	sql_query="SELECT id, quantity from yilingding.product where name='"+proname+"'";
        try{
            ResultSet rs=statement_.executeQuery(sql_query);
            if (rs.next()) {
                int id =rs.getInt("id");
                int quan=rs.getInt("quantity");
                storeStock(id, quan+qtt);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public int getNextSupplyOrderNum(){
        String query1="select ordernum from mingjunz.orderlist order by ordernum desc";
        int max=0;
        try {
            ResultSet rs  = statement_.executeQuery(query1);
            if(rs.next()){
                max = rs.getInt("ordernum");
                max=max+1;
                Commit();
                return max;
            }
        }catch (SQLException sqlex) {
            sqlex.printStackTrace();
            return -1;
        }
        return 0;
    }
    
    public void InsertIntoCart(String prodid, String prodname, String price, String qty){
        sql_query="INSERT INTO yilingding.cart VALUES ("+prodid+", "+currUserId+", '"+prodname+"', '"+currUserName+"', "+price+", "+qty+",current_timestamp)";
        try{
            statement_.executeUpdate(sql_query);
            statement_.executeUpdate("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public void RemoveCart(){
    	sql_query="delete from yilingding.cart where cid="+currUserId;
        try{
            statement_.executeUpdate(sql_query);
            statement_.executeUpdate("commit");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public Vector<String> FindAllCarts() {
        String sql_query = "SELECT * FROM yilingding.cart WHERE username='"+currUserName+"'";
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
    
    public String getUserType(){
        return userType;
    }
    
    public String getUserName(){
        return currUserName;
    }
    
    public int getUserId(){
        return currUserId;
    }
    
    public String getQuery(){
        return sql_query;
    }
    
}
