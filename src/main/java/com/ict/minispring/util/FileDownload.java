package com.ict.minispring.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * IE 8.0�ΰ�� ȭ�ϴٿ�ε� ��û�� 2ȸ�ǽ�
 * (������ ��Ȯ�� �𸣰����� ȭ�ϴٿ�ε� ���̾Ʒαװ� ������鼭 �ٽ� ȣ���ϴ°� ����.)
 * ù��° ��û�ΰ�� �ѱ����ڵ��� ����� �̷����µ�
 * �ι�°�� �ѱ��� ������
 * �׷��� ù��°���� �����س��� �װ��� ����Ѵ�.
 */

@WebServlet("/FileDownload.do")
public class FileDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request.setCharacterEncoding("utf-8");
		String dir = request.getParameter("dir");
		String fullpath = getServletContext().getRealPath(dir);
		String filename = "";
		filename = request.getParameter("filename");
		String fullpathname = String.format("%s/%s", fullpath,filename);
		//System.out.println(fullpathname);
		File file = new File(fullpathname);
		byte [] b = new byte[1024*1024*4];
		
		 // ����� ������ Ÿ�� ������
        String strAgent = request.getHeader("User-Agent");
        String userCharset = request.getCharacterEncoding();
        if(userCharset==null)userCharset="utf-8";
        
        //System.out.println("filename:"+filename+"\nagent:"+strAgent+"\ncharset:"+userCharset);
        //System.out.println("----------------------------------------------------------------");
        String value = "";
        // IE �� ���
        if (strAgent.indexOf("MSIE") > -1) 
        {
            // IE 5.5 �� ���
            if (strAgent.indexOf("MSIE 5.5") > -1) 
            {
                value = "filename=" + filename ;
            }
            // �׹ۿ�
            else if (strAgent.indexOf("MSIE 7.0") > -1) 
            {
                if ( userCharset.equalsIgnoreCase("UTF-8") ) 
                {
                	filename = URLEncoder.encode(filename,userCharset);
                	filename = filename.replaceAll("\\+", " ");
                    value = "attachment; filename=\"" + filename + "\"";

                }    
                else 
                {
                    value = "attachment; filename=" + new String(filename.getBytes(userCharset), "ISO-8859-1");
                   
                }
            }
            else{
            	//IE 8.0�̻󿡼��� 2ȸ ȣ���..
            	if ( userCharset.equalsIgnoreCase("UTF-8") ) 
                {
                	filename = URLEncoder.encode(filename,"utf-8");
                	filename = filename.replaceAll("\\+", " ");
                    value = "attachment; filename=\"" + filename + "\"";
            		
                }    
                else 
                {
                    value = "attachment; filename=" + new String(filename.getBytes(userCharset), "ISO-8859-1");
                   
                }
            }
            
            
        }else if(strAgent.indexOf("Firefox") > -1){
        	//Firefox : ���鹮�����Ĵ� �νľȵ�...
        	value = "attachment; filename=" + new String(filename.getBytes(), "ISO-8859-1");
        }
       else {
            // IE �� ������ ������
            value = "attachment; filename=" + new String(filename.getBytes(), "ISO-8859-1");
        }
        
   
        response.setContentType("Pragma: no-cache"); 

		//���� �����Ͱ� stream ó���ǵ��� : �������� ���ڼ��� : 8859_1
		response.setContentType("application/octet-stream;charset=8859_1;");
		//��� ȭ�Ͽ� ���ϰ� �ٿ�ε� ��ȭ���ڰ� ������ ����
		//Content-Disposition : attachment
		response.setHeader("Content-Disposition", value);
		//����Ÿ���� binary(����ȭ��)
		response.setHeader("Content-Transfer-Encoding", "binary;");
		if(file.isFile())
		{
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			int i=0;
			try
			{
				while((i=bis.read(b))!=-1)
				{
					bos.write(b,0,i);
				}
			}catch(Exception e){
				//e.printStackTrace();
			}finally {
				if(bos!=null)bos.close();
				if(bis!=null)bis.close();
				
			}
		}
	}
	
}
