function HybridCalculatorApp()
    fig = uifigure('Name','Hybrid Calculator','Position',[20 20 1280 640],'Color',[0.75 0.95 0.85]);

    % ================= CALCULATOR =================
    calc = uipanel(fig,'Title','SCIENTIFIC CALCULATOR','Position',[10 10 400 610],'BackgroundColor',[0.72 0.92 0.97],'FontWeight','bold','FontSize',12);
    uilabel(calc,'Text','Mode:','Position',[10 545 50 22],'FontWeight','bold');
    degBtn = uibutton(calc,'Text','Deg','Position',[65 545 60 24],'BackgroundColor',[0.5 1 0.5]);
    radBtn = uibutton(calc,'Text','Rad','Position',[135 545 60 24],'BackgroundColor',[0.2 0.2 0.2],'FontColor','white','FontWeight','bold');
    uilabel(calc,'Text','Ans:','Position',[215 545 35 22],'FontWeight','bold');
    ansLabel = uilabel(calc,'Text','0','Position',[255 545 135 22],'BackgroundColor','black','FontColor','white','HorizontalAlignment','right');
    % Current Input label REMOVED - sirf display box hai
    dispLabel = uilabel(calc,'Text','','Position',[10 518 380 20],'BackgroundColor',[0.35 0.35 0.35],'FontColor','white','HorizontalAlignment','right');

    expr=""; isDeg=true; ansVal=0;
    degBtn.ButtonPushedFcn=@(s,e) setMode(true); radBtn.ButtonPushedFcn=@(s,e) setMode(false);
    function setMode(d), isDeg=d; if d, degBtn.BackgroundColor=[0.5 1 0.5]; radBtn.BackgroundColor=[0.2 0.2 0.2]; else, degBtn.BackgroundColor=[0.95 0.9 0.85]; radBtn.BackgroundColor=[0.5 1 0.5]; end; end

    btns={'AC','BACK','(',' )','%','7','8','9','/','sin','4','5','6','*','cos','1','2','3','+','tan','0','.','=','-','pi','sin-1','cos-1','tan-1','e^x','10^x','x^y','x^2','x^3','log','ln','1/x','sqrt','cbrt','n!','^'};
    for i=1:40
        r=floor((i-1)/5); c=mod(i-1,5); x=10+c*76; y=465-r*50;
        b=uibutton(calc,'Text',btns{i},'Position',[x y 70 44],'FontSize',11,'FontWeight','bold','BackgroundColor',[0.1 0.1 0.1],'FontColor','white');
        if strcmp(btns{i},'AC'), b.BackgroundColor=[1 0.15 0.15]; end
        if strcmp(btns{i},'BACK'), b.BackgroundColor=[1 0.5 0]; end
        if ismember(btns{i},{'(',' )','%','sin','cos','tan','pi'}), b.BackgroundColor=[0.55 0.3 0.85]; end
        if ismember(btns{i},{'/','*','+','-'}), b.BackgroundColor=[1 0.85 0.2]; b.FontColor='black'; end
        if strcmp(btns{i},'='), b.BackgroundColor=[0.25 0.9 0.25]; end
        if ismember(btns{i},{'sin-1','cos-1','tan-1','e^x','10^x','x^y','x^2','x^3','log','ln','1/x','sqrt','cbrt','n!','^'}), b.BackgroundColor=[0 0.45 0.85]; end
        txt = btns{i};
        b.ButtonPushedFcn=@(s,e) calcPush(txt);
    end
    ansBtn=uibutton(calc,'Text','Ans','Position',[85 60 300 44],'FontSize',13,'FontWeight','bold','BackgroundColor',[0.25 0.9 0.25],'FontColor','white');
    ansBtn.ButtonPushedFcn=@(s,e) calcPush('Ans');
    nBtn=uibutton(calc,'Text','n!','Position',[10 60 70 44],'FontSize',11,'FontWeight','bold','BackgroundColor',[0 0.45 0.85],'FontColor','white');
    nBtn.ButtonPushedFcn=@(s,e) calcPush('n!');

    function calcPush(t)
        if strcmp(t,'sin'), expr=expr+"sin("; dispLabel.Text=expr; return; end
        if strcmp(t,'cos'), expr=expr+"cos("; dispLabel.Text=expr; return; end
        if strcmp(t,'tan'), expr=expr+"tan("; dispLabel.Text=expr; return; end
        if strcmp(t,'sin-1'), expr=expr+"asin("; dispLabel.Text=expr; return; end
        if strcmp(t,'cos-1'), expr=expr+"acos("; dispLabel.Text=expr; return; end
        if strcmp(t,'tan-1'), expr=expr+"atan("; dispLabel.Text=expr; return; end
        if strcmp(t,'AC'), expr=""; dispLabel.Text=""; ansLabel.Text="0";
        elseif strcmp(t,'BACK'), if strlength(expr)>0, expr=extractBefore(expr,strlength(expr)); end; dispLabel.Text=expr;
        elseif strcmp(t,'=')
            nOpen=count(expr,"(")-count(expr,")");
            if nOpen>0
                dispLabel.Text="Error"; expr="";
                return;
            end
            try
                res=evalExpr(expr); ansVal=res; ansLabel.Text=num2str(res,'%g'); dispLabel.Text=num2str(res,'%g'); expr=num2str(res,'%g');
            catch
                dispLabel.Text="Error"; expr="";
            end
        elseif strcmp(t,'Ans'), expr=expr+num2str(ansVal); dispLabel.Text=expr;
        elseif strcmp(t,'n!'), expr=expr+"factorial("; dispLabel.Text=expr;
        elseif strcmp(t,'1/x'), expr=expr+"1/("; dispLabel.Text=expr;
        elseif strcmp(t,'x^y'), expr=expr+"^"; dispLabel.Text=expr;
        elseif strcmp(t,'x^2'), expr=expr+"^2"; dispLabel.Text=expr;
        elseif strcmp(t,'x^3'), expr=expr+"^3"; dispLabel.Text=expr;
        elseif strcmp(t,'e^x'), expr=expr+"exp("; dispLabel.Text=expr;
        elseif strcmp(t,'10^x'), expr=expr+"10^("; dispLabel.Text=expr;
        elseif strcmp(t,'sqrt'), expr=expr+"sqrt("; dispLabel.Text=expr;
        elseif strcmp(t,'cbrt'), expr=expr+"^(1/3)"; dispLabel.Text=expr;
        elseif strcmp(t,'log'), expr=expr+"log10("; dispLabel.Text=expr;
        elseif strcmp(t,'ln'), expr=expr+"log("; dispLabel.Text=expr;
        elseif strcmp(t,'%'), expr=expr+"/100"; dispLabel.Text=expr;
        elseif strcmp(t,'^'), expr=expr+"^"; dispLabel.Text=expr;
        elseif strcmp(t,'pi'), expr=expr+"pi"; dispLabel.Text=expr;
        else, expr=expr+t; dispLabel.Text=expr; end
    end
    function r=evalExpr(e)
        if isDeg, e=strrep(e,"sin(","sind("); e=strrep(e,"cos(","cosd("); e=strrep(e,"tan(","tand("); e=strrep(e,"asin(","asind("); e=strrep(e,"acos(","acosd("); e=strrep(e,"atan(","atand("); end
        r=eval(e);
    end

    % ================= SIGNAL GENERATOR =================
    sig=uipanel(fig,'Title','SIGNAL GENERATOR AND PROCESSOR','Position',[420 10 850 610],'BackgroundColor',[0.75 0.95 0.85],'FontWeight','bold','FontSize',12);
    p1=uipanel(sig,'Title','Signal 1 [y1(t)]','Position',[10 410 265 170],'BackgroundColor',[0.35 0.75 1],'FontWeight','bold','ForegroundColor','white');
    uilabel(p1,'Text','Amplitude(A1):','Position',[10 125 110 22],'FontColor','white','FontWeight','bold'); a1E=uieditfield(p1,'numeric','Value',1,'Position',[125 125 130 22],'BackgroundColor','black','FontColor','white');
    uilabel(p1,'Text','Frequency(F1):','Position',[10 95 110 22],'FontColor','white','FontWeight','bold'); f1E=uieditfield(p1,'numeric','Value',1,'Position',[125 95 130 22],'BackgroundColor','black','FontColor','white');
    uilabel(p1,'Text','Type:','Position',[10 65 50 22],'FontColor','white','FontWeight','bold'); t1D=uidropdown(p1,'Items',{'Sine','Cosine','Square','Triangle','Sawtooth'},'Position',[70 65 185 22],'Value','Sine');
    p2=uipanel(sig,'Title','Signal 2 [y2(t)]','Position',[285 410 265 170],'BackgroundColor',[1 0.55 0.3],'FontWeight','bold','ForegroundColor','white');
    uilabel(p2,'Text','Amplitude(A2):','Position',[10 125 110 22],'FontColor','white','FontWeight','bold'); a2E=uieditfield(p2,'numeric','Value',1,'Position',[125 125 130 22],'BackgroundColor','black','FontColor','white');
    uilabel(p2,'Text','Frequency(F2):','Position',[10 95 110 22],'FontColor','white','FontWeight','bold'); f2E=uieditfield(p2,'numeric','Value',1,'Position',[125 95 130 22],'BackgroundColor','black','FontColor','white');
    uilabel(p2,'Text','Type:','Position',[10 65 50 22],'FontColor','white','FontWeight','bold'); t2D=uidropdown(p2,'Items',{'Sine','Cosine','Square','Triangle','Sawtooth'},'Position',[70 65 185 22],'Value','Cosine');
    p3=uipanel(sig,'Title','Operations','Position',[560 410 280 170],'BackgroundColor',[1 0.3 0.85],'FontWeight','bold','ForegroundColor','white');
    genBtn=uibutton(p3,'Text','Generate Signals','Position',[10 125 260 28],'BackgroundColor',[0 1 0],'FontWeight','bold');
    og=uibuttongroup(p3,'Position',[10 55 260 60],'BackgroundColor',[1 0.3 0.85]);
    rAdd=uiradiobutton(og,'Text','Add (y1 + y2)','Position',[10 35 120 22],'Value',true,'FontColor','white');
    rSub=uiradiobutton(og,'Text','Sub (y1 - y2)','Position',[135 35 120 22],'FontColor','white');
    rMul=uiradiobutton(og,'Text','Mul (y1 x y2)','Position',[10 10 120 22],'FontColor','white');
    rDiv=uiradiobutton(og,'Text','Div (y1 / y2)','Position',[135 10 120 22],'FontColor','white');
    clearBtn=uibutton(p3,'Text','Clear Plots','Position',[10 15 260 28],'BackgroundColor',[1 0.1 0.2],'FontColor','white','FontWeight','bold');
    eqP=uipanel(sig,'Title','Equations Display','Position',[10 10 265 390],'BackgroundColor',[1 1 0.65],'FontWeight','bold');
    eqBox=uitextarea(eqP,'Position',[8 8 249 365],'Value',{'y1(t) = 1*sin(2*pi*1*t)','','y2(t) = 1*cos(2*pi*1*t)','','Operation: y1 + y2','','Result Equation:','y(t) = 1*sin(2*pi*1*t) + 1*cos(2*pi*1*t)'},'BackgroundColor',[1 1 1],'FontColor',[0 0 0],'FontSize',11,'FontWeight','bold','Editable','off');
    ax=uiaxes(sig,'Position',[285 10 555 390]); ax.Color=[1 1 1]; ax.XColor=[0 0 0]; ax.YColor=[0 0 0]; ax.GridColor=[0.7 0.7 0.7]; ax.XGrid='on'; ax.YGrid='on'; ax.Box='on';
    title(ax,'Signal Processing','Color',[0 0 0],'FontWeight','bold'); xlabel(ax,'Time (s)','Color',[0 0 0]); ylabel(ax,'Amplitude','Color',[0 0 0]);
    genBtn.ButtonPushedFcn=@(s,e) plotAll(); clearBtn.ButtonPushedFcn=@(s,e) clearPlot();
    function clearPlot(), cla(ax); title(ax,'Signal Processing','Color',[0 0 0],'FontWeight','bold'); xlabel(ax,'Time (s)','Color',[0 0 0]); ylabel(ax,'Amplitude','Color',[0 0 0]); eqBox.Value={'Cleared'}; end
    function y=makeSig(A,F,typ,t), switch typ, case 'Sine', y=A*sin(2*pi*F*t); case 'Cosine', y=A*cos(2*pi*F*t); case 'Square', y=A*square(2*pi*F*t); case 'Triangle', y=A*sawtooth(2*pi*F*t,0.5); case 'Sawtooth', y=A*sawtooth(2*pi*F*t); end; end
    function fn=getFn(typ)
        switch typ, case 'Sine', fn='sin'; case 'Cosine', fn='cos'; case 'Square', fn='square'; case 'Triangle', fn='tri'; case 'Sawtooth', fn='sawtooth'; end
    end
    function plotAll()
        t=0:0.001:2; y1=makeSig(a1E.Value,f1E.Value,t1D.Value,t); y2=makeSig(a2E.Value,f2E.Value,t2D.Value,t);
        if rAdd.Value, yr=y1+y2; op='y1 + y2'; opSym='+'; elseif rSub.Value, yr=y1-y2; op='y1 - y2'; opSym='-'; elseif rMul.Value, yr=y1.*y2; op='y1 * y2'; opSym='*'; else, yr=y1./(y2+0.001); op='y1 / y2'; opSym='/'; end
        plot(ax,t,y1,'Color',[0 0.5 1],'LineWidth',1.8,'DisplayName','y1(t)'); hold(ax,'on'); plot(ax,t,y2,'Color',[1 0.4 0],'LineWidth',1.8,'DisplayName','y2(t)'); plot(ax,t,yr,'Color',[0 0.7 0],'LineWidth',2.6,'DisplayName',['Result: ' op]); hold(ax,'off');
        title(ax,['Signal Processing: ' op],'Color',[0 0 0],'FontWeight','bold','FontSize',12); xlabel(ax,'Time (s)','Color',[0 0 0],'FontSize',11,'FontWeight','bold'); ylabel(ax,'Amplitude (V)','Color',[0 0 0],'FontSize',11,'FontWeight','bold'); legend(ax,'show','TextColor',[0 0 0],'Color',[1 1 1],'Location','northeast'); grid(ax,'on');
        y1Str = [num2str(a1E.Value,'%g') '*' getFn(t1D.Value) '(2*pi*' num2str(f1E.Value,'%g') '*t)'];
        y2Str = [num2str(a2E.Value,'%g') '*' getFn(t2D.Value) '(2*pi*' num2str(f2E.Value,'%g') '*t)'];
        if strcmp(opSym,'*') || strcmp(opSym,'/')
            resStr = ['y(t) = (' y1Str ') ' opSym ' (' y2Str ')'];
        else
            resStr = ['y(t) = ' y1Str ' ' opSym ' ' y2Str];
        end
        eqBox.Value={['y1(t) = ' y1Str],'',['y2(t) = ' y2Str],'',['Operation: ' op],'','Result Equation:',resStr};
    end
    plotAll();
end