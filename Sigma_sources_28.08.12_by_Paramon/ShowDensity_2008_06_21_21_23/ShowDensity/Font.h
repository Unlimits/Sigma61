#ifndef __FONT_GL__
#define __FONT_GL__

#include "Camera.h"

namespace DensityVisualisation
{
	//�����, � ���. �������� ����� �������� ����� � OpenGL
	class Font
	{
		GLuint nFontList;
	public:
		//�����������
		Font()
		{
			nFontList = 0;
		}
		//����������
		~Font()
		{
			nFontList = 0;
		}

		//����������� ���������� �������
		void Destroy()
		{
			glDeleteLists(nFontList,256);
		}

		//������������� ������
		void Init(HDC& dc,int SizeX,int SizeY)
		{
			LOGFONT logfont;
		
			logfont.lfHeight = SizeY;        
			logfont.lfWidth = SizeX;
			logfont.lfEscapement = 0;
			logfont.lfOrientation = 0;
			logfont.lfWeight = FW_NORMAL;
			logfont.lfItalic = FALSE;
			logfont.lfUnderline = FALSE;
			logfont.lfStrikeOut = FALSE;
			logfont.lfCharSet = RUSSIAN_CHARSET;
			logfont.lfOutPrecision = OUT_DEFAULT_PRECIS;
			logfont.lfClipPrecision = CLIP_DEFAULT_PRECIS;
			logfont.lfQuality = PROOF_QUALITY;
			logfont.lfPitchAndFamily = DEFAULT_PITCH || FF_ROMAN;
			strcpy(logfont.lfFaceName,"Verdana");
	
			HFONT hOldFont,hFont = CreateFontIndirect(&logfont);
			if(hOldFont = (HFONT)SelectObject (dc, hFont))
			{
				nFontList = glGenLists(256);
				wglUseFontBitmaps(dc, 0, 256, nFontList);
				SelectObject(dc,hOldFont);
			}
			DeleteObject(hFont);
		}

		//�������������� OpenGL � ������ ������
		void BeginRendering(int Width,int Height)
		{
			glDisable(GL_DEPTH_TEST);
			glPushAttrib(GL_LIST_BIT);
			glMatrixMode(GL_PROJECTION);
			glPushMatrix();
			glLoadIdentity();
			glOrtho(0.0f,Width,Height,0.0f,-1.0f,1.0f);
			glMatrixMode(GL_MODELVIEW);
			glListBase(nFontList);
		}
		
		//��������� ����� ������
		void EndRendering()
		{
			glMatrixMode(GL_PROJECTION);
			glPopMatrix();
			glMatrixMode(GL_MODELVIEW);
			glPopAttrib(); 
			glEnable(GL_DEPTH_TEST);
		}


		//������� ����� � �������� �����������
		void Draw(GLfloat x,GLfloat y,char* pStr,Vector3D Color)
		{
			if(pStr==NULL)
				return;

			glColor3fv(Color);
			glRasterPos2f(x,y);
			glCallLists((int)strlen(pStr),GL_UNSIGNED_BYTE,pStr);	
		}

		//������� ����� � �������� ����������� � 3D
		void Draw(Vector3D Pos,char* pStr,Vector3D Color)
		{
			if(pStr==NULL)
				return;

			glColor3fv(Color);
			glRasterPos3fv(Pos);
			glCallLists((int)strlen(pStr),GL_UNSIGNED_BYTE,pStr);	
		}

		//�������������� OpenGL � ������ ������ � 3D
		void BeginRenderingIn3D()
		{
			glPushAttrib(GL_LIST_BIT);
			glListBase(nFontList);
		}

		//��������� ����� ������ � 3D
		void EndRenderingIn3D()
		{
			glPopAttrib(); 
		}


	};

}

#endif
