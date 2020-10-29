package database;

import java.sql.*;
//import javax.sql.*;
//import javax.naming.*;
import java.util.*;

public class DBAO {
	private ArrayList<Map<String, ?>> cars;
	Connection con;
	private boolean conFree = true;

	// Database configuration
	public static String url = "jdbc:mysql://localhost:3306/ATS";
	public static String dbdriver = "com.mysql.cj.jdbc.Driver";
	public static String username = "root";
	public static String password = "password";

	public DBAO() throws Exception {
		try {
			Class.forName(dbdriver);
			con = DriverManager.getConnection(url, username, password);
		} catch (Exception ex) {
			System.out.println("Exception in BookDBAO: " + ex);
			throw new Exception("Couldn't open connection to database: " + ex.getMessage());
		}
	}

	public void remove() {
		try {
			con.close();
		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}
	}

	protected synchronized Connection getConnection() {
		while (conFree == false) {
			try {
				wait();
			} catch (InterruptedException e) {
			}
		}

		conFree = false;
		notify();

		return con;
	}

	protected synchronized void releaseConnection() {
		while (conFree == true) {
			try {
				wait();
			} catch (InterruptedException e) {
			}
		}

		conFree = true;
		notify();
	}

	public ArrayList<Map<String, ?>> getCars() {
		cars = new ArrayList<Map<String, ?>>();
		Map<String, Object> car = new HashMap<String, Object>();

		try {
			String selectStatement = "select * from cars";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			ResultSet rs = prepStmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					String name = rsmd.getColumnName(i);
					car.put(name, rs.getString(i));
				}
				cars.add(car);
				car = new HashMap<String, Object>();
			}
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		Collections.shuffle(cars);
//        Collections.sort(cars);

		return cars;
	}

	public ArrayList<Map<String, ?>> getCars(String col, String order) {
		cars = new ArrayList<Map<String, ?>>();
		Map<String, Object> car = new HashMap<String, Object>();
		String order_by = "order by " + '`' + col + '`' + " " + order;

		try {
			String selectStatement = "select * from cars" + " " + order_by;
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			ResultSet rs = prepStmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					String name = rsmd.getColumnName(i);
					car.put(name, rs.getString(i));
				}
				cars.add(car);
				car = new HashMap<String, Object>();
			}
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
//        Collections.sort(cars);

		return cars;
	}

	public Map<String, ?> getCarDetail(String id) {
		Map<String, Object> car = new HashMap<String, Object>();

		try {
			String selectStatement = "select * from cars where ID = " + '"' + id + '"';
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			ResultSet rs = prepStmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					String name = rsmd.getColumnName(i);
					car.put(name, rs.getString(i));
				}
			}
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();

		return car;
	}

	public int savePwd(String uid, byte[] salt, String pwd) {
		int ct = 0;
		try {
			String insertStatement = "INSERT INTO users VALUES(?,?,?,'','','','','','','','customer')";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(insertStatement);
			prepStmt.setString(1, uid);
			prepStmt.setBytes(2, salt);
			prepStmt.setString(3, pwd);
			ct = prepStmt.executeUpdate();
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return ct;
	}

	public int saveUserInfo(String uid, String firstName, String lastName, String email, String tel, String address,
			String country, String zip) {
		int ct = 0;
		try {
			String updateStatement = "update users set first_name = ?, last_name = ?, email = ?, tel = ?, address = ?, country = ?, zip = ? where uid = '"
					+ uid + "'";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(updateStatement);
			prepStmt.setString(1, firstName);
			prepStmt.setString(2, lastName);
			prepStmt.setString(3, email);
			prepStmt.setString(4, tel);
			prepStmt.setString(5, address);
			prepStmt.setString(6, country);
			prepStmt.setString(7, zip);
			ct = prepStmt.executeUpdate();
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return ct;
	}

	public Map<String, String> getUserInfo(String uid) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			String selectStatement = "select * from users where uid = '" + uid + "'";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			ResultSet rs = prepStmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					String name = rsmd.getColumnName(i);
					result.put(name, rs.getString(i));
				}
			}

			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return result;
	}

	public ArrayList<?> getSaltPwd(String uid) {
		ArrayList<Object> result = new ArrayList<Object>();
		try {
			String selectStatement = "select salt, pwd from users where uid = '" + uid + "'";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			ResultSet rs = prepStmt.executeQuery();
//			ResultSetMetaData rsmd = rs.getMetaData();
			if (rs.next() == false)
				return result;

			Blob blob = rs.getBlob(1);
			int blobLength = (int) blob.length();
			byte[] blobAsBytes = blob.getBytes(1, blobLength);
			blob.free();

			result.add(blobAsBytes);
			result.add(rs.getString(2));
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return result;
	}

	public int createOrder(String uid, String car_id, Timestamp order_time, String Dealer, String first_name,
			String last_name, String email, String tel, String address, String country, String zip) {
		int ct = 0;
		try {
			String selectStatement = "INSERT INTO orders VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			prepStmt.setString(1, uid);
			prepStmt.setString(2, car_id);
			prepStmt.setTimestamp(3, order_time);
			prepStmt.setString(4, Dealer);
			prepStmt.setString(5, first_name);
			prepStmt.setString(6, last_name);
			prepStmt.setString(7, email);
			prepStmt.setString(8, tel);
			prepStmt.setString(9, address);
			prepStmt.setString(10, country);
			prepStmt.setString(11, zip);
			prepStmt.setString(12, "initiated");
			prepStmt.setString(13, "");
			ct = prepStmt.executeUpdate();
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return ct;
	}

	public ArrayList<Map<String, String>> getUserOrders(String uid) {
		ArrayList<Map<String, String>> orders = new ArrayList<Map<String, String>>();
		Map<String, String> order = new HashMap<String, String>();

		try {
			String selectStatement = "select * from orders where uid = '" + uid + "' order by order_time desc";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			ResultSet rs = prepStmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					String name = rsmd.getColumnName(i);
					order.put(name, rs.getString(i));
				}
				orders.add(order);
				order = new HashMap<String, String>();
			}
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();

		return orders;
	}

	public ArrayList<Map<String, String>> getCustomersOrders(String dealer) {
		ArrayList<Map<String, String>> orders = new ArrayList<Map<String, String>>();
		Map<String, String> order = new HashMap<String, String>();

		try {
			String selectStatement = "select * from orders where Dealer = '" + dealer + "' order by order_time desc";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			ResultSet rs = prepStmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			while (rs.next()) {
				for (int i = 1; i <= columnCount; i++) {
					String name = rsmd.getColumnName(i);
					order.put(name, rs.getString(i));
				}
				orders.add(order);
				order = new HashMap<String, String>();
			}
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();

		return orders;
	}

	public int confirmOrder(String uid, String order_time) {
		int ct = 0;
		try {
			String updateStatement = "update orders set order_status = 'confirmed' where uid = ? and order_time = ?";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(updateStatement);
			prepStmt.setString(1, uid);
			prepStmt.setString(2, order_time);
			ct = prepStmt.executeUpdate();
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return ct;
	}

	public int cancelOrder(String uid, String order_time) {
		int ct = 0;
		try {
			String updateStatement = "update orders set order_status = 'canceled' where uid = ? and order_time = ?";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(updateStatement);
			prepStmt.setString(1, uid);
			prepStmt.setString(2, order_time);
			ct = prepStmt.executeUpdate();
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return ct;
	}

	public int payOrder(String uid, String order_time) {
		int ct = 0;
		try {
			String updateStatement = "update orders set order_status = 'paid' where uid = ? and order_time = ?";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(updateStatement);
			prepStmt.setString(1, uid);
			prepStmt.setString(2, order_time);
			ct = prepStmt.executeUpdate();
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return ct;
	}

	public int setOrderEDD(String uid, String order_time, String edd) {
		int ct = 0;
		try {
			String updateStatement = "update orders set order_status = 'delivering' where uid = ? and order_time = ?";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(updateStatement);
			prepStmt.setString(1, uid);
			prepStmt.setString(2, order_time);
			ct = prepStmt.executeUpdate();

			updateStatement = "update orders set edd = ? where uid = ? and order_time = ?";
			prepStmt = con.prepareStatement(updateStatement);
			prepStmt.setString(1, edd);
			prepStmt.setString(2, uid);
			prepStmt.setString(3, order_time);
			ct += prepStmt.executeUpdate();

			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return ct;
	}

	public int completeOrder(String uid, String order_time) {
		int ct = 0;
		try {
			String updateStatement = "update orders set order_status = 'completed' where uid = ? and order_time = ?";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(updateStatement);
			prepStmt.setString(1, uid);
			prepStmt.setString(2, order_time);
			ct = prepStmt.executeUpdate();
			prepStmt.close();
		} catch (SQLException ex) {
			System.out.println(ex);
		}

		releaseConnection();
		return ct;
	}

}
