#ifndef PRINT_SAMPLES_H
#define PRINT_SAMPLES_H
#pragma once

//*****************************************************************************
//The width of page is 80 mm.
BOOL PrintInStandardMode80_203DPI( HANDLE g_hPort, int nPortType );
BOOL PrintInStandardMode80_300DPI( HANDLE g_hPort, int nPortType );

BOOL PrintInPageMode80_203DPI( HANDLE g_hPort, int nPortType );
BOOL PrintInPageMode80_300DPI( HANDLE g_hPort, int nPortType );

//*****************************************************************************
//The width of page is 56 mm.
BOOL PrintInStandardMode56_203DPI( HANDLE g_hPort, int nPortType );
BOOL PrintInStandardMode56_300DPI( HANDLE g_hPort, int nPortType );

BOOL PrintInPageMode56_203DPI( HANDLE g_hPort, int nPortType );
BOOL PrintInPageMode56_300DPI( HANDLE g_hPort, int nPortType );


//*****************************************************************************
//The width of page is 210 mm.

BOOL PrintInStandardMode210_203DPI( HANDLE g_hPort, int nPortType );
BOOL PrintInStandardMode210_300DPI( HANDLE g_hPort, int nPortType );

BOOL PrintInPageMode210_203DPI( HANDLE g_hPort, int nPortType );
BOOL PrintInPageMode210_300DPI( HANDLE g_hPort, int nPortType );

#endif