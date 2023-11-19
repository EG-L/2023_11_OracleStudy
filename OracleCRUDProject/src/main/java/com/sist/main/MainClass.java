package com.sist.main;

import java.io.FileReader;

import com.sist.dao.StudentDAO;

public class MainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		FileReader fr = null;
		try {
			fr = new FileReader("C:\\javaDev\\test1.txt");
			StudentDAO dao = new StudentDAO();
			StringBuffer sb = new StringBuffer();
			int i = 0;
			while((i=fr.read())!=-1) {
				sb.append((char)i);
			}
//			System.out.println(sb.toString());
			String[] data = sb.toString().split("\n");
			sb = new StringBuffer();
			String a = "";
			for(String dd:data) {
				String[] dt = dd.split("\\|");
				if(!(dt[1].equals(a))) {
					a = dt[1];
//					sb.append(dd+"\n");
					dao.stdInsert(dt[2], Integer.parseInt(dt[0]), dt[1]);
//					System.out.println(String.valueOf(Integer.parseInt(dt[2])).length());
				}
			}
//			System.out.println(sb.toString());
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

}
