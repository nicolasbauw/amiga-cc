#include <proto/intuition.h>
#include <proto/dos.h>
#include <intuition/intuition.h>
int main() {
   struct Window *myWindow;
   struct NewWindow winlayout = {
      20, 20,
      280, 70,
      0,1, 
      IDCMP_CLOSEWINDOW,
      WFLG_SIZEGADGET | WFLG_DRAGBAR | WFLG_DEPTHGADGET |    WFLG_CLOSEGADGET | WFLG_ACTIVATE,
      NULL, NULL,
      "Compilation successful !",
      NULL,NULL,
      0,0,
      600,400,
      WBENCHSCREEN
   };
   myWindow = OpenWindow(&winlayout);
   Delay(200);
   if (myWindow) CloseWindow(myWindow);
   return(0);
   }

