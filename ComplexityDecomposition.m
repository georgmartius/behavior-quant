(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



GetFiles[dir_String,pattern_] :=
Module[{pwd,fs},
pwd= Directory[];
SetDirectory[dir];
fs= FileNames[pattern];
SetDirectory[pwd];
 Map[dir<># & , fs]
]


CalcImgSize[pagefraction_]:=460pagefraction;


(*creates m colors from "indexed" schemes n *)
Colors[n_Integer,m_Integer]:=Table[ColorData[n][x],{x,1,m}]


ColorsFromScheme[n_Integer,scheme_String]:=Table[ColorData[scheme][x],{x,0,1,1/(n-1)}]


SetOptions[Plot,LabelStyle->Directive[FontFamily->Times,FontSize->10],PlotStyle->Thick,PlotTheme->None];
SetOptions[ListPlot3D,LabelStyle->Directive[FontFamily->Times,FontSize->10],PlotTheme->None];


SetOptions[ListLogLinearPlot,LabelStyle->Directive[FontFamily->Times,FontSize->10],PlotTheme->None];


Options[ListLinePlot2p5D]=Options[ListLinePlot];


ListLinePlot2p5D[dat_,opts:OptionsPattern[ListLinePlot2p5D]]:=Module[{range,colorscaling,colors,coloring,opts4plot},
range={Min[dat[[All,3]]],Max[dat[[All,3]]]};
colorscaling=RescalingTransform[{range}];
colors=OptionValue[ColorFunction]/.{Automatic->ColorData["Rainbow"]};
coloring[x_]=colors[First[colorscaling[{x}]]];
opts4plot = FilterRules[{opts},Options[Graphics]];
Graphics[Flatten[{OptionValue[PlotStyle]/.Automatic->{},Map[Line[#[[All,{1,2}]],VertexColors->coloring/@#[[All,3]]]&,Partition[dat,2,1]]}],Axes->True,AspectRatio->1/GoldenRatio,opts4plot]
]


Zip[l1_List,l2_List]:=Thread[List[l1,l2]]
Zip3[l1_List,l2_List,l3_List]:=Thread[List[l1,l2,l3]]
Zip4[l1_List,l2_List,l3_List, l4_List]:=Thread[List[l1,l2,l3,l4]]
(*ZipS but uses shortest common list*)
ZipS[l1_List,l2_List]:=Module[{mlen},
mlen=Min[Length[l1],Length[l2]];
Thread[List[Take[l1,mlen],Take[l2,mlen]]]]


EveryXAvg[data_List, x_Integer] := Module[{parts},
parts = Partition[data,x];
Map[ReplacePart[#,0->Plus]/x&,parts]
]


EveryXFun[data_List, x_Integer,fun_] := Module[{parts},
parts = Partition[data,x];
Map[fun[#]&,parts]
]


EveryXIndex[data_List, x_Integer] := Module[{},
Table[x,{x,x/2,Length[data],x}]
]


EveryXAvgSliding[data_List, x_Integer,n_Integer] := Module[{parts},
parts = Partition[data,x,n];
Map[ReplacePart[#,0->Plus]/x&,parts]
]


MapNth[f_,x_,n_]:= ReplacePart[x, n ->f[ x[[n]] ]]


MapTimeSeries[fun_, dat_]:=Map[MapNth[fun,#,2]&,dat];


DefaultMissing[maybeMissing_,default_]:=If[maybeMissing[[0]]===Missing,default,maybeMissing];


SumList[m_]:=ReplacePart[Flatten[m],0->Plus];
ProdList[m_]:=ReplacePart[Flatten[m],0->Times];


MaxWithPosition[list_]:=Block[{m=Max[list]},{m,First[FirstPosition[list,m]]}];


SelectRange[dat_,range_]:=Module[{int},int=Interval[range];
Select[dat,IntervalMemberQ[int,#[[1]]]&&(And@@NumberQ/@#)&]];


StyleLabel[x_,size_:10]:=Style[x ,size,Bold,FontFamily->"Times New Roman"];
StyleAxisLabel[x_,size_:12]:=Style[x ,size,FontFamily->"Times New Roman"];


RoundNumbersInExp[exp_,val_: 0.01]:=exp/.{t:_?NumberQ:>Round[t,val]};


Eps=StyleAxisLabel[\[Epsilon]];
EEm=StyleAxisLabel["\!\(\*SubsuperscriptBox[\(E\), \(m\), \((2)\)]\)"];
PIm=StyleAxisLabel["\!\(\*SubscriptBox[\(PI\), \(m\)]\)"];
D2m=StyleAxisLabel["\!\(\*SubsuperscriptBox[\(D\), \(m\), \((2)\)]\)"];
h2m=StyleAxisLabel["\!\(\*SubsuperscriptBox[\(h\), \(m\), \((2)\)]\)"];
H2m=StyleAxisLabel["\!\(\*SubsuperscriptBox[\(H\), \(m\), \((2)\)]\)"];
CCm=StyleAxisLabel["\!\(\*SubsuperscriptBox[\(Cc\), \(m\), \((2)\)]\)"];


LoadTiseanFile[file_String,print_: False]:=
Module[{dat,series,blocks},
dat = Import[file,"Table"];
blocks = DeleteCases[Split[dat,And[#1!={},#2!={}]&],{{}}];
series =Map[DeleteCases[#,Except[{_Real,_Real}]]&,blocks];
If[print==True,Print[ dat[[1]]]];
If[print==True,Print["Read " <>ToString[Length[series]]<> " blocks with "
	<> ToString[Length[series[[1]]]]<>" datasets"]];
series
]


(*This function does not make sense because the data in each column does not have the same length *)
MergeTisean[dat_]:=Module[{firstcol},
firstcol=dat[[All,All,1]];
Assert[And @@Map[First[firstcol] == #&,firstcol],"The first column must be identical" ];
{dat[[1,All,1]]} ~Join~dat[[All,All,2]]
]


LoadTiseanLyapFile[file_String,print_: False]:=
Module[{dat,series},
dat = Import[file,"Table"];
series =dat; (*Map[DeleteCases[#,Except[{_Integer,___}]]&,dat];*)
If[print==True,Print[ dat[[1]]]];
If[print==True,Print["Read " <>ToString[Length[series]]<> " with "
	<> ToString[Length[series[[1]]]]<>" columns"]];
series
]


ChangeExtension[name_,ending_]:=StringReplace[name,RegularExpression["\\.[^.]*$"]->ending]


ZipWith[f_Function,l1_List,l2_List]:=Map[f @@ #&,ZipS[l1,l2]];


DiffSeries[pair_]:=ZipWith[Function[{a,b},{a[[1]],b[[2]]-a[[2]]}],pair[[1]],pair[[2]]]


LogDerivativeSeries[xylists_,k_]:=Module[{n},
n=Max[k,3];
n=If[EvenQ[n],n+1,n];
Map[Function[{x,l},{x,Mean[Map[(#[[2,2]]-#[[1,2]])/(Log[#[[2,1]]]-Log[#[[1,1]]])&,Partition[l,2,1]]]}]@@#&,Zip[xylists[[All,1]],Partition[xylists,n,1,{-Round[(n+1)/2],Round[(n+1)/2]},{}]]]
]


ExcessEntropySum[deltaHs_,n_Integer,i_Integer]:=Module[{ls},
{deltaHs[[1,i,1]],
If[And@@Map[Length[#]>=i&,deltaHs[[1;;n]]],
Sum[k deltaHs[[k,i,2]],{k,1,n}],
Undefined
]}
]


ExcessEntropies[deltaHs_]:=Table[Table[ExcessEntropySum[deltaHs,n,i],{i,1,Length[deltaHs[[1]]]}],{n,1,Length[deltaHs]}];


DiffDimSchreiber[Ds_,d_]:=Table[Table[{Ds[[m,i,1]],(Ds[[m,i,2]]-Ds[[d,i,2]])/(m-d)},{i,1,Min[Length[Ds[[m]]],Length[Ds[[d]]]]}],{m,d+1,Length[Ds]}];


DerivativeDiffPast2[l_List]:=(#[[2]]-#[[1]])&/@Partition[Prepend[l,l[[1]]],2,1]


CutWhenWigly[list_List,thresh_]:=Module[{diff2},diff2=DerivativeDiffPast2[DerivativeDiffPast2[list[[All,2]]]];
TakeWhile[Zip[diff2,list],Abs[#[[1]]]<thresh&][[All,2]]]


Options[TiseanD2PlotsAndData]={ColorPalette->"Rainbow",EpsRange->All,Thresh->Infinity, ShowEntropy->False,ShowCSum->False,CleanDeltaH->False}~Join~Options[ListLogLinearPlot]; 
ColorPalette::usage="Palette to be used (default:Rainbow)";
Thresh::usage="maximum of 2nd derivative, before it is but";
ShowEntropy::usage="Show plot for block entropies";
ShowCSum::usage="Show plot for correlation sum";
CleanDeltaH::usage="Fit the wigling parts of deltaH";
EpsRange::usage="Restrict epsilon range";


TiseanD2PlotsAndData::usage="Extracts data from tisean output, calculates Excess Entropy etc and generates plots. Returns {plots,data}.
Provide any of the tisean output files (e.g. the .d2) and the spatial embedding dimension (d in the paper)";


SelectRange[dat_,range_]:=Module[{int},int=Interval[range];
Select[dat,IntervalMemberQ[int,#[[1]]]&&(And@@NumberQ/@#)&]];


TiseanD2PlotsAndData[filename_,dim_,opts:OptionsPattern[TiseanD2PlotsAndData]]:=Module[{files,epsRange,d2,h2,c2,indices,H,h,deltaH,deltaHorig,en,den,len,core, core2, opts4plot,thresh,colors,data},
files=Map[ChangeExtension[filename,#]&,{".d2",".h2",".c2"}];
epsRange=OptionValue[EpsRange];
d2=LoadTiseanFile[files[[1]],True];
h2=LoadTiseanFile[files[[2]],False];
c2=LoadTiseanFile[files[[3]],False];
If[Not[epsRange===All],
d2=SelectRange[#,epsRange]&/@d2;h2=SelectRange[#,epsRange]&/@h2;c2=SelectRange[#,epsRange]&/@c2;
];
len=Length[d2];
indices=Table[(x)*dim,{x,1,Length[c2]/dim}];
H=Map[Map[{#[[1]],-Log[#[[2]]]}&,#]&,c2[[indices]]];
h=Prepend[Map[DiffSeries,Partition[H,2,1]],H[[1]]];
deltaHorig=Map[DiffSeries,Reverse /@Partition[h,2,1]];
deltaH=If[OptionValue[CleanDeltaH],Map[FitEndOfRange[#,Max[0,#]&]&,deltaHorig], deltaHorig];
en=Table[n H[[n-1]] - (n-1) H[[n]],{n,2,Length[H]}];
(* en=ExcessEntropies[deltaH]; *) (* The same as above*)
den=Map[Map[MapNth[-#&,#,2]&,LogDerivativeSeries[#,5]]&,en];
thresh = OptionValue[Thresh];
opts4plot = FilterRules[{opts},Options[ListLogLinearPlot]];
colors=ColorsFromScheme[len,OptionValue[ColorPalette]];
data={"D"->d2,"h"->h,"E"->en,"DE"->den,"deltaH"->deltaH,"H"->H};
{{ListLogLinearPlot[CutWhenWigly[#,thresh]&/@d2, opts4plot, Joined->True,ImageSize->350,GridLines->{None,Automatic},GridLinesStyle->Directive[Gray,Dashed],PlotLabel->files[[1]] ,PlotStyle->colors,AxesLabel->{Eps,D2m}],
If[Length[h]>0,ListLogLinearPlot[CutWhenWigly[#,thresh]&/@h, opts4plot,Joined->True,ImageSize->350,PlotLabel->"entropy rate " ,AxesLabel->{Eps,h2m},PlotStyle->Prepend[colors,Darker[Gray]]],Null],
If[Length[en]>0,ListLogLinearPlot[CutWhenWigly[#,thresh]&/@en, opts4plot,Joined->True,PlotRange->All,
ImageSize->350,PlotLabel->"excess entropy",AxesLabel->{Eps,EEm},PlotStyle->Drop[colors,1]],Null],
If[Length[den]>0,ListLogLinearPlot[CutWhenWigly[#,thresh]&/@den, opts4plot,Joined->True,PlotRange->{All,{0,Automatic}},ImageSize->350,
GridLines->{None,Automatic},GridLinesStyle->Directive[Gray,Dashed],
PlotLabel->"Dim of excess entropy",PlotStyle->colors],Null],
If[Length[deltaH]>0,ListLogLinearPlot[deltaH, opts4plot,Joined->True,PlotRange->All,ImageSize->350,PlotLabel->"\!\(\*SubsuperscriptBox[\(\[Delta]h\), \(m\), \((2)\)]\)",PlotStyle->colors,AxesLabel->{Eps,"\!\(\*SubsuperscriptBox[\(\[Delta]h\), \(m\), \((2)\)]\)"}],Null],
If[OptionValue[ShowCSum],
If[Length[c2]>0,ListLogLinearPlot[c2, opts4plot,Joined->True,PlotRange->All,ImageSize->350,PlotLabel->"\!\(\*SubsuperscriptBox[\(c\), \(m\), \((2)\)]\)",PlotStyle->colors],Null],
If[Length[deltaH]>0 && OptionValue[CleanDeltaH],ListLogLinearPlot[deltaHorig, opts4plot,Joined->True,PlotRange->All,ImageSize->350,PlotLabel->"\!\(\*SubsuperscriptBox[\(\[Delta]h\), \(m\), \((2)\)]\)- original",PlotStyle->colors],Null]
],
If[Length[H]>0 && OptionValue[ShowEntropy],ListLogLinearPlot[H, opts4plot,Joined->True,PlotRange->All,ImageSize->350,PlotLabel->"Entropies",AxesLabel->{Eps,H2m},PlotStyle->colors],Null]
},
data}
]


FitEndOfRange[dat_,func_:Identity]:=Module[{end,pos,fit,rangestart,model},
pos=First[FirstPosition[dat,_?((Not[NumberQ[#[[2]]]])&),{Length[dat]},{1},Heads->False]];
end=First[dat[[Max[1,pos-30]]]];
fit=NonLinearFitWithAutoCutOff[dat,c111-d111 Log[x],{c111,d111},x,0.0001,{0.0,end}];
rangestart=fit[[2,1]];
model=fit[[1]];
Map[If[#[[1]]<=rangestart,{#[[1]],func[model[#[[1]]]]},#]&,dat]
]


TiseanPlotDiffDim[filename_,fromdim_,todim_,opts:OptionsPattern[TiseanPlotAllMultiDim]]:=Module[{files,d2,diffDs,len, opts4plot,thresh,colors},
files=Map[ChangeExtension[filename,#]&,{".d2",".h2",".c2"}];
d2=LoadTiseanFile[files[[1]],True];len=Length[d2];
diffDs=Table[{d,DiffDimSchreiber[d2,d]},{d,fromdim,todim}];
test=diffDs;
thresh = OptionValue[Thresh];
opts4plot = FilterRules[{opts},Options[ListLogLinearPlot]];
colors=ColorsFromScheme[len,OptionValue[ColorPalette]];
Prepend[
Map[ListLogLinearPlot[#[[2]], opts4plot, Joined->True,ImageSize->350,GridLines->{None,Automatic},GridLinesStyle->Directive[Gray,Dashed],PlotLabel->files[[1]] ,PlotStyle->Drop[colors,#[[1]]],AxesLabel->{Eps,(Subscript[D, m]-Subscript[D, #[[1]]])/(m-#[[1]])}]&,
diffDs],
ListLogLinearPlot[CutWhenWigly[#,thresh]&/@d2, opts4plot, Joined->True,ImageSize->350,GridLines->{None,Automatic},GridLinesStyle->Directive[Gray,Dashed],PlotLabel->files[[1]] ,PlotStyle->colors,AxesLabel->{Eps,D2m}]]
]


Needs["PlotLegends`"]


TiseanLegend[num_Integer,with0_:True,scheme_String:"Rainbow"]:=Module[{colors},
colors=ColorsFromScheme[num,scheme];
If[with0,PrependTo[colors,Darker[Gray]]];
Graphics[Legend[MapIndexed[{Graphics[{#1,Thick, Line[{{0,0},{1,0}}]}],If[Mod[#2[[1]],2]==1,If[with0,#2[[1]]-1,#2[[1]]],""]}&,colors],LegendLabel->m,LegendTextSpace->1.5, LegendSpacing->0,LegendShadow->None,LegendBackground->Opacity[0],LegendLabelSpace->2,LegendBorder->None,ShadowBackground ->Opacity[0]],ImageSize->20]
]


TiseanLegendNew[num_Integer,with0_:True,scheme_String:"Rainbow"]:=Module[{colors},
colors=ColorsFromScheme[num,scheme];
If[with0,PrependTo[colors,Darker[Gray]]];LineLegend[colors,MapIndexed[If[Mod[#2[[1]],2]==1,If[with0,#2[[1]]-1,#2[[1]]],""]&,colors],LegendLabel->m,LegendLayout->{"Column",1}]]


LogDerivativeSeries[Table[{Exp[x],x^2},{x,1,6}],3]


LogLinFitFun=NonlinearModelFit[#,c-d Log[x],{c,d},x]&;
ConstFitFun=LinearModelFit[#,0,x]&;


(*FitQualityCriterion[model_]:=Variance[model["FitResiduals"]];*)
(*FitQualityCriterion[model_]:=model["EstimatedVariance"];*)
FitQualityCriterion[model_]:=Total[model["FitResiduals"]^2];
(*FitQualityCriterion[model_]:=Mean[model["FitResiduals"]]+StandardDeviation[model["FitResiduals"]];*)
(*FitQualityCriterion[model_]:=Max[ReplacePart[model["ParameterConfidenceIntervals"],{{1,0},{2,0}}\[Rule]Subtract]];*)

FindAllFits[data_,fitfun_,minPoints_,quantile_:0.25]:=Module[{cleaned,shortfits,fiterrors,thresh,goodintervals},
(*joined = SortBy[Select[If[Head[data[[1,1]]]===List,Flatten[data,1],data],(And@@NumberQ/@#)&],First];*)
cleaned=Select[data,(And@@NumberQ/@#)&];
shortfits=FitShortRegions[cleaned,fitfun,minPoints];
     fiterrors=Map[FitQualityCriterion, shortfits[[All,1]]];
thresh=Quantile[fiterrors,quantile]+0.1StandardDeviation[fiterrors];
goodintervals=Select[Zip[shortfits,fiterrors],#[[2]]<thresh&][[All,1,2]];
SelectInvervals[Select[Map[FindMaxFitRegion[cleaned,fitfun,2*thresh,#,minPoints]&,goodintervals[[All,1]]],Length[#]>0&]]
]


FitShortRegions[data_,fitfun_,size_:10]:=Module[{len,low,up,fits,range,fitter,criterion},
len=Length[data];
(*first check upwards*)
fitter=Function[{range},
fitfun[data[[range[[1]];;range[[2]]]]] 
];
fits=Map[{fitter[#],#}&,Table[{i,i+size},{i,1,len-size,1}]]
(*fits=Map[fitter,Flatten[Table[{i,j},{i,1,len-size,1},{j,i+size,len,1}],1]]*)
]


FindMaxFitRegion[data_,fitfun_,maxVariance_,index_,minPoints_:6,bothsides_:False]:=Module[{len,low,up,fits,range,fitter,criterion},
len=Length[data];
low=Max[index,1];
up=Min[index+minPoints ,len];
(*first check upwards*)
fitter=Function[{range},
{fitfun[data[[range[[1]];;range[[2]]]]],range} 
];
criterion=Function[{fit},FitQualityCriterion[First[fit]]< maxVariance];
fits=MapWhile[fitter,criterion,Table[{low,i},{i,up,len,1}]];
If[Length[fits]==0,{},
range=Last[fits][[2]];
If[bothsides,
up=range[[2]];
fits=MapWhile[fitter,criterion,Table[{i,up},{i,low,1,-1}]];
If[Length[fits]==0,{},
range=Last[fits][[2]];
{Last[fits][[1]],Sort[data[[range,1]]],range}
]
,{Last[fits][[1]],Sort[data[[range,1]]],range}
]
]
]


MapWhile[fun_,crit_,list_List]:=Module[{result, pred,n,len,next},
len=Length[list];
pred=True;
result={};
n=1;
While[pred && n<=len,
next=fun[list[[n]]];
pred=crit[next];
If[pred,AppendTo[result,next]];
n++;
];
result
]


MapWhile[#^2&,#<36&,{}]
MapWhile[#^2&,#<36&,{1,2}]
MapWhile[#^2&,#<36&,{1,2,3,4,5,6}]


IntervalLen[Interval[]]:=0;
IntervalLen[in_Interval]:=Max[in]-Min[in];
IntervalEmpty[in_Interval]:=((in)===(Interval[]));
SelectInvervals[fits_]:=Module[{withInt,n},
withInt=Map[MapNth[Interval,#,3]&,fits];
n=1;
While[n<Length[withInt],
If[IntervalLen[IntervalIntersection[withInt[[n,3]],withInt[[n+1,3]]]]/(Min[IntervalLen[withInt[[n,3]]],IntervalLen[withInt[[n+1,3]]]])<0.3,
n++,
withInt = If[IntervalLen[withInt[[n,3]]]<IntervalLen[withInt[[n+1,3]]],Delete[withInt,n],Delete[withInt,n+1]];
];
];
withInt
]


IntervalAndDataTagged[dat_,fits_]:=
Module[{intervals,tagged},
intervals=fits[[All,3]];
tagged=Map[Function[{idx},{idx,Flatten[Position[Map[IntervalMemberQ[#,idx]&,intervals],True]]}],Range[1,Length[dat]]];

Map[Function[{idx,matches},If[Length[matches]<1,{dat[[idx]],0},{{dat[[idx,1]],Mean[Map[#[[1]][dat[[idx,1]]]&,fits[[matches]]]]},1}]]@@#&,tagged]
]


If[Length[MaximalBy]==0,
MaximalBy[{},f_]:={};
MaximalBy[exp_,f_]:=Block[{m=Map[f,exp]},exp[[Position[m,Max[m]][[1]]]]]];


GetLongestSubsequence[list_,crit_]:=MaximalBy[Table[{x+1,LengthWhile[Drop[list,x],crit]},{x,0,Length[list]-1}],Last];


FitWithAutoCutOff[data_,fitfun_,maxVariance_,initRange_: Null]:=Module[{joined,lm,range,resid,varparams,var,ri,newdat,n},range=initRange;
joined = SortBy[If[Head[data[[1,1]]]===List,Flatten[data,1],data],First];
range=If[initRange===Null,range={Min[joined[[All,1]]],Max[joined[[All,1]]]},initRange];
newdat=SelectRange[joined,range];
lm=fitfun [newdat];
varparams=lm["EstimatedVariance"];
n=1;
While[varparams>maxVariance&&n<20,
(*Print[{range,lm["EstimatedVariance"]}];*)
resid=lm["StudentizedResiduals"];
var=1.5StandardDeviation[resid];
ri=First[GetLongestSubsequence[resid,(Abs[#]<=var&)]];
range=Sort[newdat[[{ri[[1]],ri[[1]]+ri[[2]]-1},1]]];
newdat=SelectRange[newdat,range];
lm=fitfun [newdat];
varparams=lm["EstimatedVariance"];
n++;];
{lm,range,n}]


NonLinearFitWithAutoCutOff[data_,form_,params_,vars_,maxVariance_,initRange_:Null]:=
Module[{fitfun},
fitfun=NonlinearModelFit[#,form,params,vars]&;
FitWithAutoCutOff[data,fitfun,maxVariance,initRange]
]
LinearFitWithAutoCutOff[data_,form_,vars_,maxVariance_,initRange_:Null]:=
Module[{fitfun},
fitfun=LinearModelFit[#,form,vars]&;
FitWithAutoCutOff[data,fitfun,maxVariance,initRange]
]


fittedLineStyle=Directive[Black,Opacity[.3],Dotted,AbsoluteThickness[.5]];


Options[PlotFitInLog]={ShowLabel->True,LabelSize->10,LabelAngle->0, BasePlotRatio->1,LimiterSize->Tiny,ExtendFit->1, LabelPosition->{Automatic,-0.4},FitLineStyle->fittedLineStyle};
ShowLabel::usage="Show label at fit (default: True)";
LabelAngle::usage="Angle at which label is put, Use Automatic and BasePlotRatio to get automatically rotated labels";
LabelSize::usage="font size of label";
LimiterSize::usage="Size of limiters, (e.g. Small)";
ExtendFit::usage="extend the fit by this many orders of magnitude above and below range";
LabelPosition::usage="position of label along the fit {horizontally, vertically}, default: {middle,-0.4}";
BasePlotRatio::usage="coordinate system ratio of base plot(the stuff is embedded into)";
FitLineStyle::usage="line style of fit";


GetPlotCoordinateRatio[plot_]:=Block[{aopt=Quiet[AbsoluteOptions[plot]]},
(AspectRatio/.aopt)*(Divide@@Map[-Subtract@@#&,PlotRange/.aopt])];


PlotFitInLog[fit_,opts:OptionsPattern[PlotFitInLog]]:=Module[{lm,range,rangeMean,mi,ma,logMeanRange,extend,lpos,arrowHead,baseplot,angle},lm=fit[[1]];
range=Clip[#,{10^-8,10^8}]& /@fit[[2]];
mi=range[[1]];
ma=range[[2]];
extend = OptionValue[ExtendFit];
arrowHead=Graphics[{Opacity[.4],Line[{{-1,1/2},{0,0},{-1,-1/2},{-1,1/2}}]}];
Assert[Length[OptionValue[LabelPosition]]>=2];
lpos = First[OptionValue[LabelPosition]];
If[lpos===Automatic,lpos=Exp[Mean[Log[range]]]];
angle[lm_,p_]:=If[OptionValue[LabelAngle]===Automatic ,ArcTan[(lm[p]-lm[p+0.0001])/(Log[p]-Log[p+0.0001])*OptionValue[BasePlotRatio]],OptionValue[LabelAngle] Degree];
{LogLinearPlot[lm[x],{x,Exp[Log[mi]-extend],Exp[Log[ma]+extend]},PlotStyle->fittedLineStyle],
{(*Line[{{Log[mi],lm[mi]-limiterlen},{Log[mi],lm[mi]+limiterlen}}],Line[{{Log[ma],lm[ma]-limiterlen},{Log[ma],lm[ma]+limiterlen}}],*)
{Transparent,Arrowheads[{{OptionValue[LimiterSize],1,{arrowHead,1}}}],Arrow[{{Log[mi*0.9],lm[mi*0.9]},{Log[mi],lm[mi]}}],Arrow[{{Log[ma*1.1],lm[ma*1.1]},{Log[ma],lm[ma]}}]},
If[OptionValue[ShowLabel],Inset[Rotate[StyleLabel[RoundNumbersInExp[lm[\[Epsilon]],0.01],OptionValue[LabelSize]],angle[lm,lpos]],{Log[lpos],lm[lpos]},{0,OptionValue[LabelPosition][[2]]}],{}]}}]


Options[CalcEEDecompostion]={ConstThresh->0.01, RemoveNegative->False,UseLargerRangePlateaus->True}; 
ConstThresh::usage="Threshold under which a line is considered constant (straight) (for detection of plateaus on larger scales)";
RemoveNegative::usage="Remove negative values of \[Delta]h";
UseLargerRangePlateaus::usage="Use values of deltaH's from larger range to add to memory complexity (and substract from middle)"


CalcEEDecompostion[slice_List,assignedMRange_,opts:OptionsPattern[CalcEEDecompostion]]:=Module[{numNoFits,containsIndeterminates,numExtrapolation,numNegative,maxM,numMDropped,sliceClean,
lowerM,upperM,determinism,isDeterministic,fromLargerRange},
containsIndeterminates=Count[slice,Indeterminate,{3}]>0;
numNoFits=Count[slice[[All,2]],False];
maxM=Length[slice];
numMDropped=Count[slice,{{_,Indeterminate,__},__}];
numNegative=Count[slice,{{x_,y_,__},__}/;y<-0.001];
numExtrapolation=Count[slice[[All,3]],True];
sliceClean=slice/.{Indeterminate->0};
sliceClean=If[OptionValue[RemoveNegative],Map[Function[{x},If[x[[1,2]]<0,ReplacePart[x,{1,2}->0],x]],sliceClean],sliceClean];
{lowerM,upperM,determinism,isDeterministic}=assignedMRange;
fromLargerRange = If[OptionValue[UseLargerRangePlateaus],Total[Table[m sliceClean[[Max[m,1],4]],{m,lowerM,upperM}]],0];
{sliceClean[[1,1,1]],
ExcessEntropySumPart[sliceClean,1,Max[0,lowerM-1]]+ fromLargerRange,
ExcessEntropySumPart[sliceClean,lowerM,upperM] - fromLargerRange,
ExcessEntropySumPart[sliceClean,upperM+1],
ExcessEntropySumPart[slice[[All,{1},{1,4}]],1,-1],
{"lowerM"->lowerM,
"upperM"->upperM,
"stochasticity"->1-determinism,
"isDeterministic"->isDeterministic,
"numMDropped"->numMDropped,
"numNoFits"->numNoFits,
"indet"->containsIndeterminates,
"extrapol"->numExtrapolation,
"negative"->numNegative,
"fromLargerRange"->fromLargerRange}
}
]


Options[DataWithFitsAndDerivativesTagged]={NumPointForDerivative->5,ReplaceEndByFits->False};
ReplaceEndByFits::usage="use to extapolate data at the end by the fits, (everything after the last fit is replaced by it)";
NumPointForDerivative::usage="number of points used to calculate numerical derivative at each point (default 5)";
DataWithFitsAndDerivativesTagged[dat_,fits_,opts:OptionsPattern[DataWithFitsAndDerivativesTagged]]:=
Module[{intervals,tagged,derivatives,getIncline,posLastFit,lastFitIdx},
derivatives=LogDerivativeSeries[dat,OptionValue[NumPointForDerivative]];
intervals=fits[[All,3]];
getIncline[fit_,p_]:=(fit[p]-fit[p+0.0001])/(Log[p]-Log[p+0.0001]);
tagged=Map[Function[{idx},{idx,Flatten[Position[Map[IntervalMemberQ[#,idx]&,intervals],True]]}],Range[1,Length[dat]]];
posLastFit=Length[tagged];
If[OptionValue[ReplaceEndByFits],(* replace everything after last fit by the fit*)
posLastFit=Length[tagged]-First[DefaultMissing[FirstPosition[Reverse[tagged],{_,{_Integer}}],{1}]]+1;
lastFitIdx=tagged[[posLastFit,2]];
tagged=ReplacePart[tagged,Table[{i,2}->lastFitIdx,{i,posLastFit+1,Length[tagged]}]];
];
Map[Function[{idx,matches},
If[Length[matches]<1,
{{dat[[idx,1]],dat[[idx,2]],derivatives[[idx,2]],dat[[idx,2]]},False,False},
{{dat[[idx,1]],Mean[Map[#[dat[[idx,1]]]&,fits[[matches,1]]]],
Mean[Map[getIncline[#,dat[[idx,1]]]&,fits[[matches,1]]]],
dat[[idx,2]]},
idx<=posLastFit,idx>posLastFit}]]@@#&,tagged]
]


Options[DecomposeAndPlotExcessEntropy]={DeltaHFlatThreshold->0.05,DeterminismThreshold->0.5,YPlotRangeMax->Automatic,XTicks->Automatic,FactorForQualityScales->Automatic,
DimLabelsEvery->Automatic,MaxDimScale->Automatic,ShowRawExcessEntropy->True,
ShowMDropped->True,ShowSceptical->False,ShowQualStochastic->True,ShowNumNoFits->True,ShowNegative->False,
ShowLegend->True
}~Join~Options[CalcEEDecompostion]~Join~Options[ListLogLinearPlot]~Join~Options[DataWithFitsAndDerivativesTagged]; 
DeltaHFlatThreshold::usage="derivative under which deltaH is considered flat. (0.05)";
DeterminismThreshold::usage="if the sum of eps-dependend \[Delta]H is larger than this threshold it is considered to be deterministic (0.5)";
ShowRawExcessEntropy::usage="Show also the raw excess entropy without the fits";
YPlotRangeMax::usage="maximal Y-PlotRange used also for rescaling right axis";
XTicks::usage="Explicit ticks specs for x axis";
FactorForQualityScales::usage="size of quality scales w.r.t. the dim scale (Automatic)";
MaxDimScale::usage="scale of dimension axis (for m's)";
DimLabelsEvery::usage="labeled ticks every so often in dimension scale";
ShowMDropped::usage="Show number m dropped";
ShowSceptical::usage="whether sum contains mssing data (also in MDropped)";
ShowQualStochastic::usage="Show quality of determinstic/ amount of stochasticity";
ShowNegative::usage="Show indicate whether there are negatives";
ShowNumNoFits::usage="Show number of m's where we have no fit";
ShowLegend::usage="show a legend or not"; 


DecomposeAndPlotExcessEntropy[dat_,fits_,opts:OptionsPattern[DecomposeAndPlotExcessEntropy]]:=Module[{datandfits,merged,straights,maxM,allderivs,mRangeDet,mergedFitsDerivStraights,decomp,
cState,cMiddle,cMem,cSM,cAll,ee,opts4plot, plt,
optsForDatReplacement,aux,lowerM,upperM,stochasticity,maxDimScale,factorQual,numNoFits,sceptical,numMDropped,detOrStoc,negative,extrapol,maxQual,datarange,plotrange,rescale,rescaleQual,mLabelsEvery,axeslabel,rightaxis,rightoffset,rescaleQualDat,QualityQuants,colors,plotstyle,legend
},
datandfits=Zip[dat,fits];
optsForDatReplacement=FilterRules[{opts},Options[DataWithFitsAndDerivativesTagged]];
merged=Map[DataWithFitsAndDerivativesTagged [#[[1]],#[[2]],optsForDatReplacement]&,datandfits];
straights=Map[GetPlateauOnLargerScaleWithoutDip[#[[1]],#[[2]],OptionValue[DeltaHFlatThreshold]]&,datandfits];
allderivs = -Transpose[merged][[All,All,1,3]]; (*all derivative (negated, because we are intersted in D of const - D log(eps)*)
(*range of m's for eps-dependent part and stochasticity, {{Subsuperscript[m, lower, *],Subsuperscript[m, upper, *],stochasticity,isDeterministic (True/False)},...}*)
mRangeDet=AssignMRangeToStochasticRanges[Map[GetEpsDepMAndDeterminism[#,OptionValue[DeltaHFlatThreshold]]&,allderivs],
OptionValue[DeterminismThreshold],10]; 
(*{curves} with curve={{{x,y,dy/dx},True|False,prevStraight},{...}}*)
mergedFitsDerivStraights=Map[Function[{m,s},Map[Append[#[[1]],#[[2]]]&,Zip[m,s]]]@@#&,Zip[merged,straights]];
decomp=SortBy[Map[CalcEEDecompostion[#[[1]],#[[2]],FilterRules[{opts},Options[CalcEEDecompostion]]]&,Zip[Transpose[mergedFitsDerivStraights],mRangeDet]],First];
cState=decomp[[All,{1,2}]];
cMiddle = decomp[[All,{1,3}]];
cMem=decomp[[All,{1,4}]];
cSM =CombineTimeSeries[Plus,cMem,cState]; (*mem + state*)
cAll=CombineTimeSeries[Plus,cSM,cMiddle]; (*plus middle term*)
ee=decomp[[All,{1,5}]]; (*raw excess entropy*)
maxM=Length[dat];
aux=decomp[[All,{1,6}]];
upperM=MapTimeSeries["upperM"/.#&,aux];
lowerM=MapTimeSeries["lowerM"/.#&,aux];
numNoFits=MapTimeSeries[("numNoFits"/.#)/maxM&,aux];
sceptical=MapTimeSeries[If["indet"/.#,1,0]&,aux];
numMDropped=MapTimeSeries[("numMDropped"/.#)/maxM&,aux];
extrapol=MapTimeSeries[("extrapol"/.#)/maxM&,aux];
stochasticity=MapTimeSeries["stochasticity"/.#&,aux];
detOrStoc=MapTimeSeries[If["isDeterministic"/.#,Missing[],1]&,aux];
(*negative=MapTimeSeries[If[("negative"/.#)>0,1,0]&,aux];*)
negative=MapTimeSeries[("negative"/.#)/maxM&,aux];
QualityQuants=Cases[
{If[OptionValue[ReplaceEndByFits],{extrapol,"% extrap.",Directive[Gray],ShowMDropped},{numMDropped,"% dropped",Directive[Gray],ShowMDropped}],
{sceptical,"sceptical",Directive[Gray],ShowSceptical},{numNoFits,"% no fits",Directive[Cyan],ShowNumNoFits},{negative,"% negative",Directive[Lighter[Red]],ShowNegative},
{stochasticity,"stochastic",Directive[Green],ShowQualStochastic}
},{_,_,_,v_}/; OptionValue[v]];
maxQual=Length[QualityQuants];
maxDimScale=If[OptionValue[MaxDimScale]===Automatic,Max[upperM[[All,2]]],OptionValue[MaxDimScale]] ;
mLabelsEvery= If[OptionValue[DimLabelsEvery]===Automatic,Ceiling[maxDimScale/2],OptionValue[DimLabelsEvery]] ;
factorQual= If[OptionValue[FactorForQualityScales]===Automatic,Ceiling[maxDimScale/5],OptionValue[FactorForQualityScales]] ;
datarange=maxDimScale +(factorQual*2) maxQual;
plotrange=If[OptionValue[YPlotRangeMax]===Automatic,Max[cAll[[All,2]]]*1.2,OptionValue[YPlotRangeMax]];
rightoffset=plotrange/2;
rescale[x_]:=(x) (plotrange-rightoffset)/datarange+rightoffset;
rescaleQual[x_,i_]:=(factorQual x+maxDimScale+factorQual .5+(factorQual*2)i-1) (plotrange-rightoffset)/datarange+rightoffset;
rescaleQualDat[data_,i_]:=MapTimeSeries[rescaleQual[#,i]&,data];
rightaxis=Table[{rescale[v],If[Mod[v,mLabelsEvery]==0,ToString[v],""]},{v,0,maxDimScale,1}]~Join~
Flatten[MapIndexed[Function[{x,i},{{rescaleQual[0,First[i]],""},{rescaleQual[1,First[i]],x[[2]]}}],QualityQuants],1];opts4plot = FilterRules[{opts},Options[ListLogLinearPlot]];
(*colors={ColorData[1,2],ColorData[1,1],ColorData[1,3],ColorData[1,4]};*)
colors={Blue,Darker[Red],Orange,ColorData[1,4]};
plotstyle=Flatten[{{colors[[1]],Directive[Dashed,colors[[2]]],colors[[3]]},
If[OptionValue[ShowRawExcessEntropy],{Directive[Darker[ColorData[1,3]]]},{}],
{Directive[colors[[4]],Dotted],Directive[colors[[4]],DotDashed]},QualityQuants[[All,3]],{None}},1];
plt=ListLogLinearPlot[Flatten[{{cMem,cSM,cAll},If[OptionValue[ShowRawExcessEntropy],{ee},{}],
{MapTimeSeries[rescale,lowerM],MapTimeSeries[rescale,upperM]},
MapIndexed[Function[{x,i},MapTimeSeries[rescaleQual[#,First[i]]&,First[x]]],QualityQuants],
{MapTimeSeries[rescaleQual[#,maxQual]&,detOrStoc]}
},
1],
opts4plot,PlotRange->{Automatic,{Automatic,rescaleQual[1,maxQual]}},FrameLabel->{None,EEm},
Prolog->Inset[Style[\[Epsilon],12,FontFamily->"Times New Roman"],ImageScaled[{.85,.05}]],PlotRangeClipping->False,
PlotStyle->plotstyle,
Filling->Flatten[{{1->0,2->{1},3->{{2},Directive[Opacity[.3],RGBColor[1,0.9,0]]},6->{{5},Directive[Opacity[.1],colors[[3]]]}},
Table[If[OptionValue[ShowRawExcessEntropy],6,5]+i->rescaleQual[0,i],{i,1,maxQual}],
{If[OptionValue[ShowRawExcessEntropy],6,5]+maxQual+1->{0,Directive[Opacity[.05],Black]}}},
1],
Joined->True,
Frame->{{True,True},{True,False}},
FrameTicks->{{Automatic,rightaxis},{OptionValue[XTicks],None}},
FrameTicksStyle->{{Automatic,Directive[6]},{Automatic,Automatic}},
Axes->{False,False},
GridLines->{None,{rescale[0]}~Join~Table[rescaleQual[1,x],{x,1,maxQual}]},GridLinesStyle->Directive[LightGray,Dashed],PlotLegends->If[OptionValue[ShowLegend],LineLegend[Flatten[{{"memory","core\n(state+mem)","excess Ent.\ndecomp"},If[OptionValue[ShowRawExcessEntropy],{"excess Ent.\n raw"},{}],{"\!\(\*SubscriptBox[\(m\), \(l\)]\)","\!\(\*SubscriptBox[\(m\), \(u\)]\)"}},1]],None]
];
legend=LineLegend[plotstyle,Flatten[{{"memory ","core (state+mem) ","excess Ent. decomp "},If[OptionValue[ShowRawExcessEntropy],{"excess Ent. raw "},{}],{"\!\(\*SubscriptBox[\(m\), \(l\)]\) ","\!\(\*SubscriptBox[\(m\), \(u\)]\) "}},1],LegendLayout->{"Row",1}];
{plt,decomp,{"legend"->legend,"straights"->straights}}
]


Options[FitDeltaHs]={MinFitLength->10,FitQualityQuantile->0.25,ShowFitLines->{}}~Join~Options[PlotFitInLog];
MinFitLength::usage="minimal length if fits in number of data points";
FitQualityQuantile::usage="quantile under which are considered good (w.r.t to all possible fits)";
ShowFitLines::usage="selector for fitline to plot";

FitDeltaHs[plots_,tiseandat_,opts:OptionsPattern[FitDeltaHs]]:=Module[{dat,plt,fits,ratio,opts4labels},
dat = "deltaH"/.tiseandat;
plt=plots[[5]];
fits=Map[FindAllFits[#,LogLinFitFun,OptionValue[MinFitLength],OptionValue[FitQualityQuantile]]&,dat];
If[OptionValue[ShowLabel],
ratio=GetPlotCoordinateRatio[plt];
opts4labels ={LabelAngle->Automatic,BasePlotRatio->ratio} ~Join~FilterRules[{opts},Options[PlotFitInLog]];
,	
opts4labels =FilterRules[{opts},Options[PlotFitInLog]];
];
{dat,fits,Show[plt,Map[PlotFitInLog[#][[1]]&,Flatten[fits,1][[OptionValue[ShowFitLines]]]],PlotLabel->None,Epilog->Map[PlotFitInLog[#,opts4labels][[2]]&,Flatten[fits,1]]]
}
]


GetPlateauOnLargerScaleWithoutDip[dat_,fits_, flatThresh_:0.01]:=Module[{getFit,getIncline},
getIncline[fit_,p_]:=(fit[p]-fit[p+0.0001])/(Log[p]-Log[p+0.0001]);
getFit[x_]:=First[FirstPosition[fits[[All,2]],int_List/;IntervalMemberQ[Interval[int],x],{0},2]];
Drop[FoldList[Function[{last,x},Block[{match=getFit[x[[1]]]},
If[match==0 || -getIncline[fits[[match,1]],x[[1]]]>=flatThresh,Max[0,Min[last,x[[2]]],0],
Max[0,fits[[match,1]][x[[1]]]]]
]
],0,dat/.Indeterminate->0],1]
]


ExcessEntropySumPart[deltaHslice_,start_Integer,end_Integer:-1]:=Module[{ls,minm,maxm},
minm=Max[start,1];
maxm=Min[Length[deltaHslice],If[end< 0,Length[deltaHslice],end]];
Sum[k (deltaHslice[[k,1,2]]),{k,minm,maxm}]
]


CombineTimeSeries[fun_,s1_List,s2_List]:=Block[{f=Function[{vs1,vs2},{vs1[[1]],fun[vs1[[2]],vs2[[2]]]}]},Map[Function[{vs1,vs2},{vs1[[1]],fun[vs1[[2]],vs2[[2]]]}]@@#&,Zip[s1,s2]]];


CombineTimeSeries[Plus,{{1,1},{2,4}},{{1,4},{2,0}}]


If[Length[FirstPosition]==0,
FirstPosition[expr_,pattern_,default_:Missing["NotFound"],levelspec_:Infinity]:= Replace[Position[expr,pattern,levelspec],{{}:> default, l_:> First[l]}]
];


GetEpsDepMAndDeterminism[derivatives_,flatThreshold_]:=Module[{maxd,posmaxd,below,above,lowerM,upperM,sum},
{maxd,posmaxd}=MaxWithPosition[derivatives];
below=Reverse[derivatives[[1;;posmaxd-1]]];
above=derivatives[[posmaxd+1;;]];
lowerM=posmaxd-(First[FirstPosition[below,x_/;x<flatThreshold,{Length[below]+1}]]-1);
upperM=posmaxd+(First[FirstPosition[above,x_/;x<flatThreshold,{Length[above]+1}]]-1);
{lowerM,upperM,Total[derivatives[[lowerM;;upperM]]]}
]


{GetEpsDepMAndDeterminism[{0,1,0,0},0.1]=={2,2,1},
GetEpsDepMAndDeterminism[{0,0,0,1},0.1]=={4,4,1},
GetEpsDepMAndDeterminism[{0,0.1,0.2,0},0.1]=={2,3,0.3},
GetEpsDepMAndDeterminism[{0.4,0.6,0,0},0.1]=={1,2,1},
GetEpsDepMAndDeterminism[{0.2,0.4,0.2,0.2},0.1]=={1,4,1}}


MovingAverageHalf[list_,r_]:=Map[Mean,Partition[list,r,1,{-1,-1},0]]
AssignMRangeToStochasticRanges[mRangeAndStochasticity_,detThreshold_,averaging_]:=Module[{mrangeWithAvgs},
mrangeWithAvgs=Zip[mRangeAndStochasticity,Zip[MovingAverageHalf[mRangeAndStochasticity[[All,1]],averaging],MovingAverageHalf[mRangeAndStochasticity[[All,2]],averaging]]];
Drop[FoldList[Function[{acc,ms},Block[{lastrange=acc[[1]]},
If[ms[[1,3]]<detThreshold,{lastrange,lastrange~Join~{ms[[1,3]],False}},
{Round[ms[[2]]],Append[ms[[1]],True]}
]]],{{0,0},{}},mrangeWithAvgs]
,1][[All,2]]
]


GetAvgDecomp[eeDecomp_List,int_Interval]:=Module[{relevant},
relevant=Select[eeDecomp,IntervalMemberQ[int,#[[1]]]&];
{"state"->PlusMinus[Mean[relevant[[All,2]]] ,StandardDeviation[relevant[[All,2]]]],
"memory"->PlusMinus[Mean[relevant[[All,4]]], StandardDeviation[relevant[[All,4]]]],
"state+memory"->PlusMinus[Mean[relevant[[All,2]]]+Mean[relevant[[All,4]]], StandardDeviation[relevant[[All,2]]]+ StandardDeviation[relevant[[All,4]]]]
}
]


Options[AvgDecompInPlot]={LabelSize->8};
AvgDecompInPlot[decomp_,int_Interval,posstate_:-1,posmem_:-1,opts:OptionsPattern[AvgDecompInPlot]]:=Module[{mi,ma,lpos,state,memory,statemem,max},
mi=Min[int];
ma=Max[int];
lpos=Exp[Mean[Log[int[[1]]]]];
state="state"/.decomp;
memory="memory"/.decomp;
statemem="state+memory"/.decomp;
max=statemem[[1]]+3(statemem[[2]]);
{{Darker[Gray],Line[{{Log[mi],0},{Log[mi],max}}],Line[{{Log[ma],0},{Log[ma],max}}]},
If[memory[[1]]>0,Inset[StyleLabel[RoundNumbersInExp[memory,0.01],OptionValue[LabelSize]],{Log[lpos],memory[[1]]-2posmem*memory[[2]]},{0,posmem}],{}],
If[state[[1]]>0,Inset[StyleLabel[RoundNumbersInExp[state,0.01],OptionValue[LabelSize]],{Log[lpos],statemem[[1]]-2posstate*statemem[[2]]},{0,posstate}],{}]
}
]


Needs["ErrorBarPlots`"]


EtaScale::usage="Factor for eta";
Options[PlotMIScan]={EtaScale->1/2}~Join~Options[ListLogLinearPlot]; 


PlotMIScan[d_,title_String,opts:OptionsPattern[PlotMIScan]]:=Module[{len,dataraw,data,pl,error,ep,opts4plot},
dataraw=GatherBy[d,First][[All,All,{3,4,5}]];
data=Map[MapAt[OptionValue[EtaScale]#&,#,1]&,dataraw,{2}];
len = Length [data];
opts4plot= FilterRules[{opts},Options[ListLogLinearPlot]];
pl=ListLogLinearPlot[Map[Sort,data[[All,All,{1,2}]]],opts4plot,Joined->True,PlotStyle->ColorsFromScheme[len,"Rainbow"],PlotTheme->None,PlotLabel->ToString[len] <> ":..." <>StringTake[title,-Min[30,StringLength[title]]],ImageSize->350,PlotRange->{Automatic,{0,All}},AxesLabel->{StyleAxisLabel[OptionValue[EtaScale]\[Eta]],PIm}];
error = Map[{{Log[#[[1]]],#[[2]]},ErrorBar[{#[[3]]-#[[2]],0}]}&,data,{2}];
ep=ErrorListPlot[error,PlotStyle->ColorsFromScheme[len,"Rainbow"],PlotTheme->None];
Show[pl,ep]
]
