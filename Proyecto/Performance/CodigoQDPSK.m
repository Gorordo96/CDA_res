%Ingreso de parametros para la simulacion:
Eb=EbPerf;             %Energia de bit
Rb=RbPerf;             %Tasa de bit

Es=2*Eb;              %Energia de simbolo -> 8-DPSK
Rs=Rb/2;              %Tasa de simbolo
CantSimb=CantSimbPerf;%Cantidad de simbolos influye brutalmente para obtener las curvas.
CantBit=CantSimb*2;   %Cantidad de bits necesarios de simular para la cantidad de simbolos

Fp=10*Rb;             %Frecuencia de la portadora

Pot=Es*Rs;            %Potencia de cada uno de los simbolos

Fs=FsPerf;            %Frecuencia de muestreo para observar señales en el canal de comunicaciones (Salida Modulador)

%-----------------------
EsNoTest=EsNoTestPerf + 10*log10(2);    %Valores de Es/No para el bloque AWGN 
EsNo=[];
ErrorFinalSimb=[];
ErrorFinalBit=[];
EbNo=[];
%-----------------------
fprintf("---\t --- \t QDPSK \t --- \t --- \n")
for j=1:length(EsNoTest)
    fprintf("Simulacion DQPSK N: %i / %i \n",j,length(EsNoTest))
    EsNo=EsNoTest(j);
    EbNo(j)=EsNo - 10*log10(2); 
    sim('QDPSK');
    CantErrS=0;
    ErrorT=Err';
    for i=3:length(ErrorT)
        if(ErrorT(i) ~= 0)
            CantErrS=CantErrS+1;
        end
    end

ErrorFinalSimb(j)=CantErrS/(CantSimb-2); %Cantidad de simbolos errados respecto a los totales PE
ErrorFinalBit(j)=ErrorFinalSimb(j)/2   ;       %Cantidad de bit erroneos respecto a los bit de informacion PB
                                           %Se usa codificacion de Gray

end     
fprintf("---\t --- \t Termino QDPSK \t --- \t --- \n")
%ber = berawgn(EbNo,'dpsk',4);
%semilogy(EbNo,ber)
%hold on
%semilogy(EbNo,ErrorFinalBit)
%xlabel('Eb/No (dB)')
%ylabel('BER')