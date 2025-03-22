clear ;
clc;

Tobj=25;
responsivity=54;
lato=0.7;
superfice=(lato*10^-3)^2;
gain=151;
slope=0.6;

Vcc=3.3;

par=3;

delta=5;
for Rp=67000:1:70000
    for R= 10000:1:12000
        min=5;
        max=0;
        for t=5:1:14
            Tsens=15+t*5;
            if par==1
                Vres=Vcc*Rdec(R)/(Rdec(R)+((res(t)*Rdec(Rp))/(res(t)+Rdec(Rp))));
            elseif par==0
                Vres=Vcc*Rdec(R)/(Rdec(R)+res(t));
            elseif par==2
                Vres=Vcc*R/(R+res(t));
            elseif par==3
                Vres=Vcc*R/(R+((res(t)*Rp)/(res(t)+Rp)));
            end
            P=5.67*10^-8*((Tobj+273.15)^4-(Tsens+273.15)^4);
            Vsens=P*responsivity*superfice*slope;
            Vout=Vsens*gain+Vres;
            if Vout>max
                max=Vout;
            end
            if Vout<min
                min=Vout;
            end
        end
        if max-min<delta && max-min>0
            delta=max-min;
            if par==0||par==1
                fprintf("delta: %f Rlow:%f (%d) Rp:%f (%d) V:%f\n",delta,Rdec(R),R,Rdec(Rp),Rp,Vcc);
            elseif par==2||par==3
                fprintf("delta: %f Rlow:%f Rp:%f V:%f\n",delta,R,Rp,Vcc);
            end
        end
    end
end


function out=Rdec(i)
mantissa=mod(i,100);
esp=idivide(int32(i),int32(100));
out=double((mantissa/10)*10^esp);
end


function out=res(i)
if i==0
    out=157200.0;
elseif i==1
    out=125000.0;
elseif i==2
    out=100000.0;
elseif i==3
    out=80500.0;
elseif i==4
    out=65200.0;
elseif i==5
    out=53200.0;
elseif i==6
    out=43600.0;
elseif i==7
    out=35900.0;
elseif i==8
    out=29700.0;
elseif i==9
    out=24700.0;
elseif i==10
    out=20700.0;
elseif i==11
    out=17300.0;
elseif i==12
    out=14600.0;
elseif i==13
    out=12400.0;
elseif i==14
    out=10500.0;
elseif i==15
    out=9000.0;
end

end