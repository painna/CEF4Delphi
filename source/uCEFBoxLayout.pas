// ************************************************************************
// ***************************** CEF4Delphi *******************************
// ************************************************************************
//
// CEF4Delphi is based on DCEF3 which uses CEF to embed a chromium-based
// browser in Delphi applications.
//
// The original license of DCEF3 still applies to CEF4Delphi.
//
// For more information about CEF4Delphi visit :
//         https://www.briskbard.com/index.php?lang=en&pageid=cef
//
//        Copyright � 2023 Salvador Diaz Fau. All rights reserved.
//
// ************************************************************************
// ************ vvvv Original license and comments below vvvv *************
// ************************************************************************
(*
 *                       Delphi Chromium Embedded 3
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Unit owner : Henri Gourvest <hgourvest@gmail.com>
 * Web site   : http://www.progdigy.com
 * Repository : http://code.google.com/p/delphichromiumembedded/
 * Group      : http://groups.google.com/group/delphichromiumembedded
 *
 * Embarcadero Technologies, Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 *)

unit uCEFBoxLayout;

{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}
{$ENDIF}

{$I cef.inc}

{$IFNDEF TARGET_64BITS}{$ALIGN ON}{$ENDIF}
{$MINENUMSIZE 4}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, System.SysUtils,
  {$ELSE}
  Classes, SysUtils,
  {$ENDIF}
  uCEFBaseRefCounted, uCEFInterfaces, uCEFTypes, uCEFLayout;

type
  TCefBoxLayoutRef = class(TCefLayoutRef, ICefBoxLayout)
    protected
      procedure SetFlexForView(const view: ICefView; flex: Integer);
      procedure ClearFlexForView(const view: ICefView);

    public
      class function UnWrap(data: Pointer): ICefBoxLayout;
  end;

implementation

uses
  uCEFMiscFunctions;

procedure TCefBoxLayoutRef.SetFlexForView(const view: ICefView; flex: Integer);
begin
  PCefBoxLayout(FData)^.set_flex_for_view(PCefBoxLayout(FData),
                                          CefGetData(view),
                                          ord(flex));
end;

procedure TCefBoxLayoutRef.ClearFlexForView(const view: ICefView);
begin
  PCefBoxLayout(FData)^.clear_flex_for_view(PCefBoxLayout(FData),
                                            CefGetData(view));
end;

class function TCefBoxLayoutRef.UnWrap(data: Pointer): ICefBoxLayout;
begin
  if (data <> nil) then
    Result := Create(data) as ICefBoxLayout
   else
    Result := nil;
end;

end.

