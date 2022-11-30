unit UFormsUtils;

interface

uses
  Vcl.Forms;

type
  TformUtils = class

  private

  public

    class procedure SetarFormPrincipal(NewMainForm: TForm);

  end;

implementation

class procedure TformUtils.SetarFormPrincipal(NewMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NewMainForm;
end;

end.
