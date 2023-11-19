package com.sist.main;
import java.util.*;
import com.sist.dao.*;
public class MainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MovieDAO dao = new MovieDAO();
		Scanner sc = new Scanner(System.in);
		int total = dao.movieTotalPage();
		System.out.println("페이지 입력(1~"+total+"):");
		int page = sc.nextInt();
		ArrayList<MovieVO> list = dao.movieListData(page);
		for(MovieVO vo:list) {
			System.out.println(vo.getMno()+"."+vo.getTitle());
		}

	}

}
