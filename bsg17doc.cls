% !TEX encoding = UTF-8 Unicode
%-------------------------------------------------------
% Author: Stefan Thöni
% Email: stefan.thoeni@piratenpartei.de
%-------------------------------------------------------

\ProvidesPackage{bsg17doc}[2017/11/10 v0.1 (Stefan 'Exception' Thöni)]

\RequirePackage{xifthen}
\RequirePackage{scrbase}
\RequirePackage{tabularx}
\RequirePackage{xparse}
\RequirePackage{lastpage}
\RequirePackage{kantlipsum}
\RequirePackage[ngerman]{babel}
\RequirePackage{etoolbox}

\newbool{bsgweb}
\DeclareOption{web}{\booltrue{bsgweb}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

\LoadClass[11pt,a4paper]{scrartcl}

\setlength{\parindent}{0cm}
\widowpenalty10000
\clubpenalty10000
\tolerance9999
\emergencystretch3em

\RequirePackage{fontspec}
\RequirePackage{xltxtra}
\RequirePackage{xunicode}

\setromanfont[BoldFont=Source Sans Pro Bold]{Source Sans Pro}
\setsansfont[BoldFont=Source Sans Pro Bold]{Source Sans Pro}

\newenvironment{nscenter}
 {\parskip=0pt\par\nopagebreak\centering}
 {\par\noindent\ignorespacesafterend}
 
\newenvironment{nstabbing}
 {\setlength{\topsep}{0pt}%
  \setlength{\partopsep}{0pt}%
  \tabbing}
 {\endtabbing}

\newcommand{\datum}[1]{\newcommand{\thedatum}{#1}}
\newcommand{\entscheidung}[1]{\newcommand{\theentscheidung}{#1}}
\newcommand{\aktenzeichen}[1]{\newcommand{\theaktenzeichen}{#1}}
\newcommand{\antragsteller}[1]{\newcommand{\theantragsteller}{#1}}
\newcommand{\antragsgegner}[1]{\newcommand{\theantragsgegner}{#1}}
\newcommand{\havebeiladung}{false}
\newcommand{\beiladung}[1]{\renewcommand{\havebeiladung}{true}\newcommand{\thebeiladung}{#1}}

\RequirePackage[automark]{scrpage2}
\KOMAoptions{headinclude=true}
\KOMAoptions{footinclude=false}
\KOMAoptions{headlines=3}
\KOMAoptions{pagesize}
\recalctypearea
\clearscrheadfoot
\pagestyle{scrheadings}

\addtolength{\topmargin}{-2cm}
\addtolength{\textheight}{1.8cm}
\addtolength{\headheight}{1cm}
\addtolength{\oddsidemargin}{-1.5cm}
\addtolength{\textwidth}{3cm}

\newcommand{\lhead}{
	\raisebox{0em}{
		\begin{tabular}{l}
		\textbf{\theentscheidung} \\
		\textbf{\thedatum} \\
		\textbf{\theaktenzeichen} \\
		\end{tabular}
	}
}
\newcommand{\rhead}{
	\raisebox{0em}{
	    \scriptsize
		\begin{tabular}{l}
		Piratenpartei Deutschland \\
		Bundesschiedsgericht \\
		Plugstraße 9a \\
		10115 Berlin \\
		\end{tabular}
	}}
\newcommand{\rfoot}{-~\thepage~/~\pageref{LastPage}~-}

\lehead{\lhead}
\rehead{\rhead}
\lohead{\lhead}
\rohead{\rhead}
\chead{\includegraphics[height=2.1cm]{bsg.pdf}}
\refoot{\rfoot}
\rofoot{\rfoot}

\RequirePackage{titlesec}
\renewcommand{\thesection}{\Roman{section}.}
\renewcommand{\thesubsection}{\arabic{subsection}.}
\renewcommand{\thesubsubsection}{\alph{subsubsection}.}
\titlespacing*{\section}
{0pt}{0.15cm plus 0.05cm minus 0.02cm}{0.05cm plus 0.05cm minus 0.02cm}
\titlespacing*{\subsection}
{0pt}{0.1cm plus 0.05cm minus 0.02cm}{0.05cm plus 0.05cm minus 0.02cm}
\titlespacing*{\subsection}
{0pt}{0.05cm plus 0.05cm minus 0.02cm}{0.05cm plus 0.05cm minus 0.02cm}

\newcommand{\RichterTabelleHeader}{%
\small\centering\textcolor{white}{%
Das Bundesschiedsgericht der Piratenpartei Deutschland wird vertreten durch:%
}}%
\newcommand{\RichterTabelle}{%
\setlength{\tabcolsep}{0mm}%
\centering\textcolor{white}{%
\begin{tabular}{cccccc}%
\parbox[t]{32.0mm}{\centering Stefan\\Thöni\\[0.2em]\footnotesize{Vorsitzender~Richter}}&%
\parbox[t]{32.0mm}{\centering Michael\\Ebner\\[0.2em]\footnotesize{Richter}}&%
\parbox[t]{32.0mm}{\centering Georg\\v. Boroviczeny\\[0.2em]\footnotesize{Richter}}&%
\parbox[t]{32.0mm}{\centering Gregory\\Engels\\[0.2em]\footnotesize{Richter}}&%
\parbox[t]{32.0mm}{\centering Holger\\van Lengerich\\[0.2em]\footnotesize{Richter}}&%
\parbox[t]{32.0mm}{\centering Bertram\\Eckert\\[0.2em]\footnotesize{Richter}}%
\end{tabular}}}%

\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{eso-pic}
\definecolor{piraten}{rgb}{1,0.533,0}
\ifbool{bsgweb}{%
\newcommand\Background{%
\setlength{\unitlength}{1mm}
\put(-46.75,5.833){\includegraphics[width=172.541mm]{Signet.pdf}}
\put(0,0){\textcolor{piraten}{\rule{210mm}{28mm}}}
\put(0,22.6){\parbox[b]{\paperwidth}{\RichterTabelleHeader}}
\put(0,11){\parbox[b]{\paperwidth}{\RichterTabelle}}}
\AddToShipoutPicture{\Background}}

\RequirePackage{csquotes}

\RequirePackage{quotehelper}
\RequirePackage{quotegermanlaw}
\RequirePackage{quotesatzung}
\RequirePackage{quoteliterature}
