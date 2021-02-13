clear all
clc
close all
%Ingreso de parametros para la simulacion:
Eb=10;              %Energia de bit
Rb=100;             %Tasa de bit

Es=1*Eb;            %Energia de simbolo -> 8-DPSK
Rs=Rb/1;            %Tasa de simbolo
CantSimb=12;        %Cantidad de simbolos influye brutalmente para obtener las curvas.
CantBit=CantSimb*1; %Cantidad de bits necesarios de simular para la cantidad de simbolos

Fp=10*Rb;           %Frecuencia de la portadora

Pot=Es*Rs;          %Potencia de cada uno de los simbolos

%-----------------------
EsNoTest=[1:25];    %Valores de Es/No para el bloque AWGN 
EsNo=[];
ErrorFinalSimbNOpt=[];
ErrorFinalBitNOpt=[];
ErrorFinalSimbOpt=[];
ErrorFinalBitOpt=[];
EbNo=[];
%-----------------------
for j=1:length(EsNoTest)
    EsNo=EsNoTest(j);
    EbNo(j)=EsNo - 10*log10(1); 
    sim('DBPSK_FormaEficiente')
    CantErrSOpt=0;
    CantErrSNOpt=0;
    ErrorTOpt=ErrOpt(1000/2:1000:length(ErrOpt)-(1000/2))'; %Producto de la integracion/retencion y reset me quedan picos que me confunden en las decisiones, diezmo la señal
    ErrorTNOpt=ErrNOpt(1000/2:1000:length(ErrOpt)-(1000/2))';
    
    for i=3:length(ErrorTOpt)
        if(ErrorTOpt(i) ~= 0)
            CantErrSOpt=CantErrSOpt+1;
        end
    end
    
    for i=3:length(ErrorTNOpt)
        if(ErrorTNOpt(i) ~= 0)
            CantErrSNOpt=CantErrSNOpt+1;
        end
    end

ErrorFinalSimbOpt(j)=CantErrSOpt/(CantSimb-2) %Cantidad de simbolos errados respecto a los totales PE
ErrorFinalBitOpt(j)=ErrorFinalSimbOpt(j)/1       %Cantidad de bit erroneos respecto a los bit de informacion PB
                                           %Se usa codificacion de Gray

ErrorFinalSimbNOpt(j)=CantErrSNOpt/(CantSimb-2);
ErrorFinalBitNOpt(j)=ErrorFinalSimbNOpt(j)/1;                                           
end     

ber = berawgn(EbNo,'dpsk',2);
semilogy(EbNo,ber)
hold on
semilogy(EbNo,ErrorFinalBitOpt)
xlabel('Eb/No (dB)')
ylabel('BER')
hold on
semilogy(EbNo,ErrorFinalBitNOpt)