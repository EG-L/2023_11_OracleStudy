package com.sist.main;
import com.sist.DAO.*;
import java.util.*;
public class MovieMain {
	public static void main(String[] args) {
		MovieDAO dao = new MovieDAO();
		String menu = "======= 메뉴 =======\n"
				     + "1. 제목으로 검색\n"
				     + "2. 장르으로 검색\n"
				     + "3. 출연으로 검색\n";
		System.out.print(menu);
		Scanner sc = new Scanner(System.in);
		System.out.print("메뉴 선택 :");
		int num = sc.nextInt();
		String s = "";
		if(num == 1) {
			s = "title";
		}
		else if(num == 2) {
			s = "genre";
		}
		else if(num == 3) {
			s = "actor";
		}
		System.out.print("검색어 입력 :");
		String fd = sc.next();
		//오라클에서 데이터를 찾아 온다.
		int count = dao.movieFindCount(s, fd);
		if(count==0) {
			System.out.println("검색된 결과가 없습니다.");
		}else {
			System.out.printf("검색 결과 : %d 건",count);
			System.out.println();
			ArrayList<MovieVO> list = dao.movieFindData(s, fd);
			for(MovieVO vo:list) {
				System.out.println(vo.getTitle()+" "+vo.getActor()+" "+vo.getGenre());
			}
		}
	}
}
