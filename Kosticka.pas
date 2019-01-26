unit Kosticka;

interface

uses Vcl.ExtCtrls;

type
  TKosticka = Class(TObject)
    private
      kosticka : TImage;
    public
      constructor Create(kost : TImage);
      function getKosticka : TImage;
  End;
  TKostickaEnum = (TRUBKA, CTVEREC, LKO, ZKO, TKO);

implementation

constructor TKosticka.Create(kost: TImage);
begin
  self.kosticka := kost;
end;

function TKosticka.getKosticka;
begin
  result := kosticka;
end;

end.
