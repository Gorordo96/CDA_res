warning('off','all')
EbPerf=10;
RbPerf=100;
FsPerf=100000;
CantSimbPerf=2002;
EsNoTestPerf=[1:0.5:14];
%Ejecucion de simulink
BDPSK
%Variables BDPSK
PerfDBPSKEbNo=EbNo;
PerfDBPSKOpt=ErrorFinalBitOpt;
PerfDBPSKNOpt=ErrorFinalBitNOpt;
CodigoQDPSK
%Variables QDPSK
PerfQDPSKEbNo=EbNo;
PerfQDPSK=ErrorFinalBit;
%Variables 8DPSK
Codigo8DPSK
Perf8DPSKEbNo=EbNo;
Perf8DPSK=ErrorFinalBit;
figure()
%Graficas teoricas
berDBPSK = berawgn(PerfDBPSKEbNo,'dpsk',2);
semilogy(PerfDBPSKEbNo,berDBPSK)
hold on
berDQPSK = berawgn(PerfQDPSKEbNo,'dpsk',4);
semilogy(PerfQDPSKEbNo,berDQPSK)
hold on
ber8DPSK = berawgn(Perf8DPSKEbNo,'dpsk',8);
semilogy(Perf8DPSKEbNo,ber8DPSK)
legend('BDPSK','QDPSK','8DPSK')
%Graficas obtenidas mediante simulacion
figure()
semilogy(PerfDBPSKEbNo,PerfDBPSKOpt)
hold on
semilogy(PerfDBPSKEbNo,PerfDBPSKNOpt)
hold on
semilogy(PerfQDPSKEbNo,PerfQDPSK)
hold on 
semilogy(Perf8DPSKEbNo,Perf8DPSK)
legend('BDPSKef','BDPSKnef','QDPSK','8DPSK')
warning('on','all')
