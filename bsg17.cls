% !TEX encoding = UTF-8 Unicode
%-------------------------------------------------------
% Author: Stefan Thöni
% Email: stefan.thoeni@piratenpartei.de
%-------------------------------------------------------

\ProvidesPackage{bsg17}[2017/11/10 v0.1 (Stefan 'Exception' Thöni)]

\RequirePackage{xifthen}
\RequirePackage{scrbase}
\RequirePackage{tabularx}
\RequirePackage{xparse}
\RequirePackage{lastpage}
\RequirePackage{kantlipsum}
\RequirePackage[ngerman]{babel}
\RequirePackage{etoolbox}

\newbool{bsganonym}
\newbool{bsgweb}
\DeclareOption{anonym}{\booltrue{bsganonym}}
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

\newcommand{\Anonym}[1]{%
\ifbool{bsganonym}{ \textcolor{piraten}{\rule[0.25mm]{6.472mm}{2mm}} }{#1}%
}

\newcommand{\AnonymLang}[1]{%
\ifbool{bsganonym}{ \textcolor{piraten}{\rule[0.25mm]{15mm}{2mm}} }{#1}%
}

\newcommand{\Pseudonym}[2]{%
\ifbool{bsganonym}{ \textcolor{piraten}{%
\rule[0.25mm]{3.236mm}{2mm}~\textbf{#2}~\rule[0.25mm]{3.236mm}{2mm}%
} }{#1}%
}

\newenvironment{nscenter}
 {\parskip=0pt\par\nopagebreak\centering}
 {\par\noindent\ignorespacesafterend}
 
\newenvironment{nstabbing}
 {\setlength{\topsep}{0pt}%
  \setlength{\partopsep}{0pt}%
  \tabbing}
 {\endtabbing}

\newcommand{\abstand}{\vspace{0.2cm}}

\DeclareDocumentCommand{\partei}{ m m m m m g }{%
\abstand
\IfNoValueTF{#6}{%
\begin{nstabbing}
\ifthenelse{\equal{#1}{}}{}{#1 }\=\ifthenelse{\equal{#2}{}}{}{#2 }\textbf{#3},\\
\>#4,\`#5,
\end{nstabbing}
}{%
\begin{nstabbing}
\ifthenelse{\equal{#1}{}}{}{#1 }\=\ifthenelse{\equal{#2}{}}{}{\Anonym{#2} }\textbf{\Pseudonym{#3}{#6}},\\
\>\AnonymLang{#4},\`#5,
\end{nstabbing}
}}

\DeclareDocumentCommand{\vertretung}{ m m m m g }{%
\IfNoValueTF{#5}{%
\begin{nstabbing}
\hspace{4.5cm}\=\kill
\ifthenelse{\equal{#1}{}}{}{#1: }\> \ifthenelse{\equal{#2}{}}{}{#2 }#3, \\
\> #4,
\end{nstabbing}
}{%
\begin{nstabbing}
\hspace{4.5cm}\=\kill
\ifthenelse{\equal{#1}{}}{}{#1: }\> \ifthenelse{\equal{#2}{}}{}{\Anonym{#2} }\Pseudonym{#3}{#5}, \\
\> \AnonymLang{#4},
\end{nstabbing}
}}

\newcommand{\aktenzeichen}[1]{\newcommand{\theaktenzeichen}{#1}}
\newcommand{\antragsteller}[1]{\newcommand{\theantragsteller}{#1}}
\newcommand{\antragsgegner}[1]{\newcommand{\theantragsgegner}{#1}}
\newcommand{\havebeiladung}{false}
\newcommand{\beiladung}[1]{\renewcommand{\havebeiladung}{true}\newcommand{\thebeiladung}{#1}}

\newcommand{\wegen}[2]{%
\newcommand{\thewegen}%
{\abstand\noindent\begin{tabular}{@{}p{.05\textwidth}p{.925\textwidth}@{}}
wegen: & \textbf{#1} \\
\ifthenelse{\equal{#2}{}}{}{& hier: #2 \\}
\end{tabular} \\
}
}

\newcommand{\senat}{\newcommand{\thegericht}{das Bundesschiedsgericht}}
\newcommand{\kammer}[1]{\newcommand{\thegericht}{das Bundesschiedsgericht, #1.~Kammer}}
\newcommand{\verhandlung}[1]{\newcommand{\thewie}{%
\newcommand{\thedatum}{#1}%
aufgrund der fernmündlichen Verhandlung vom #1}}
\newcommand{\verhandlungRL}[1]{\newcommand{\thewie}{%
\newcommand{\thedatum}{#1}%
aufgrund der mündlichen Verhandlung vom #1}}
\newcommand{\schriftlich}[1]{\newcommand{\thewie}{%
\newcommand{\thedatum}{#1}%
aufgrund der schriftlichen Vorträge in Beratung am #1}}
\newcommand{\umlauf}[1]{\newcommand{\thewie}{%
\newcommand{\thedatum}{#1}%
aufgrund der schriftlichen Vorträge im Umlauf am #1}}

\newcommand{\richterformat}{durch}
\DeclareDocumentCommand{\richter}{ m m g g }{%
\ifthenelse{\equal{#4}{durch}}{%
#1\>#2\IfNoValueF{#3}{ als #3}%
}{%
#2
}}
\DeclareDocumentCommand{\ST}{ g }{\richter{den Vorsitzenden Richter}{Stefan Thöni}{#1}{\richterformat}}
\DeclareDocumentCommand{\HvL}{ g }{\richter{den Richter}{Holger van Lengerich}{#1}{\richterformat}}
\DeclareDocumentCommand{\GvB}{ g }{\richter{den Richter}{Georg von Boroviczeny}{#1}{\richterformat}}
\DeclareDocumentCommand{\ME}{ g }{\richter{den Richter}{Michael Ebner}{#1}{\richterformat}}
\DeclareDocumentCommand{\GE}{ g }{\richter{den Richter}{Gregory Engels}{#1}{\richterformat}}
\DeclareDocumentCommand{\MG}{ g }{\richter{den Richter}{Melano Gärtner}{#1}{\richterformat}}
\DeclareDocumentCommand{\MP}{ g }{\richter{den Ersatzrichter}{Mirko Pauli}{#1}{\richterformat}}
\DeclareDocumentCommand{\besetzung}{ m m g g g g }{%
\newcommand{\thebesetzung}{%
durch
\begin{nstabbing}
\hspace{5.5cm}\=\kill
#1\IfNoValueTF{#3}{ und}{,}\\
#2\IfNoValueF{#3}{\IfNoValueTF{#4}{ und}{,}}\\
\IfNoValueF{#3}{#3\IfNoValueF{#4}{\IfNoValueTF{#5}{ und}{,}}\\}
\IfNoValueF{#4}{#4\IfNoValueF{#5}{\IfNoValueTF{#6}{ und}{,}}\\}
\IfNoValueF{#5}{#5\IfNoValueF{#6}{ und}\\}
\IfNoValueF{#6}{#6\\}
\end{nstabbing}}
\newcommand{\thesignatures}{%
\setlength{\tabcolsep}{0mm}%
{\centering%
\newcommand{\sigwidth}{\IfNoValueTF{#6}{\IfNoValueTF{#5}{\IfNoValueTF{#4}{\IfNoValueTF{#3}{84.0mm}{56.0mm}}{42.0mm}}{33.0mm}}{28.0mm}}
\begin{tabular}{cccccc}%
\IfNoValueF{#1}{\parbox[t]{\sigwidth}{\centering #1}}\IfNoValueF{#2}{&}%
\IfNoValueF{#2}{\parbox[t]{\sigwidth}{\centering #2}}\IfNoValueF{#3}{&}%
\IfNoValueF{#3}{\parbox[t]{\sigwidth}{\centering #3}}\IfNoValueF{#4}{&}%
\IfNoValueF{#4}{\parbox[t]{\sigwidth}{\centering #4}}\IfNoValueF{#5}{&}%
\IfNoValueF{#5}{\parbox[t]{\sigwidth}{\centering #5}}\IfNoValueF{#6}{&}%
\IfNoValueF{#6}{\parbox[t]{\sigwidth}{\centering #6}}%
\end{tabular}}%
}}

\newcommand{\rechtsbehelf}{%
\section*{Rechtsmittel}
Gegen Entscheidungen des Bundesschiedsgerichtes sind innerparteilich keine Rechtsmittel möglich. Gegebenenfalls können die ordentlichen Gerichte angerufen werden.
}
\newcommand{\footer}{%
\renewcommand{\richterformat}{sig}
\vspace{0.3cm}
\thesignatures
\vfill
\rechtsbehelf
}

\DeclareDocumentCommand\titem{ m }{\item{\textbf{#1}}}
\DeclareDocumentCommand\tenor{ m }{%
\newcommand{\thetenor}{%
\vspace{-0.4cm}
\theformel
\vspace{-0.2cm}
\begin{enumerate}
\setlength{\itemsep}{0cm}
#1
\end{enumerate}}}

\newcommand{\klageurteil}{
\newcommand{\theentscheidung}{Urteil}
\newcommand{\theformel}{für Recht erkannt:}
\begin{center}
\textbf{\textsc{\Huge Urteil}}
\end{center}
\abstand
\begin{nscenter}
In dem schiedsgerichtlichen Verfahren \\
\end{nscenter}
\theantragsteller
\abstand\abstand
\begin{nscenter}
g~e~g~e~n
\end{nscenter}
\theantragsgegner
\ifthenelse{\equal{\havebeiladung}{false}}{}{%
\abstand\abstand
\begin{nscenter}
sowie
\end{nscenter}
\thebeiladung
}
\abstand
\thewegen \abstand \\
hat \thegericht,\abstand \\
\thewie, \abstand \\
\thebesetzung
\abstand
\thetenor
\setlength{\parskip}{0.25cm}
}

\newcommand{\berufungsurteil}{
\newcommand{\theentscheidung}{Urteil}
\newcommand{\theformel}{für Recht erkannt:}
\begin{center}
\textbf{\textsc{\Huge Urteil}}
\end{center}
\abstand
\begin{nscenter}
In dem schiedsgerichtlichen Berufungsverfahren \\
\end{nscenter}
\theantragsteller
\abstand\abstand
\begin{nscenter}
g~e~g~e~n
\end{nscenter}
\theantragsgegner
\ifthenelse{\equal{\havebeiladung}{false}}{}{%
\abstand\abstand
\begin{nscenter}
sowie
\end{nscenter}
\thebeiladung
}
\abstand
\thewegen \abstand \\
hat \thegericht,\abstand \\
\thewie, \abstand \\
\thebesetzung
\abstand
\thetenor
\setlength{\parskip}{0.25cm}
}


\newcommand{\beschluss}{
\newcommand{\theentscheidung}{Beschluss}
\newcommand{\theformel}{beschlossen:}
\begin{center}
\textbf{\textsc{\Huge Beschluss}}
\end{center}
\abstand
\begin{nscenter}
In dem schiedsgerichtlichen Verfahren \\
\end{nscenter}
\theantragsteller
\abstand\abstand
\begin{nscenter}
g~e~g~e~n
\end{nscenter}
\theantragsgegner
\ifthenelse{\equal{\havebeiladung}{false}}{}{%
\abstand\abstand
\begin{nscenter}
sowie
\end{nscenter}
\thebeiladung
}
\thewegen \abstand \\
hat \thegericht,\abstand \\
\thewie, \abstand \\
\thebesetzung
\abstand
\thetenor
\setlength{\parskip}{0.25cm}
}


\newcommand{\einseitigerbeschluss}{
\newcommand{\theentscheidung}{Beschluss}
\newcommand{\theformel}{beschlossen:}
\begin{center}
\textbf{\textsc{\Huge Beschluss}}
\end{center}
\abstand
\begin{nscenter}
In dem schiedsgerichtlichen Verfahren \\
\end{nscenter}
\theantragsteller
\abstand
\thewegen \abstand
hat \thegericht,\abstand \\
\thewie, \abstand \\
\thebesetzung
\abstand
\thetenor
\setlength{\parskip}{0.25cm}
}



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
		Pflugstraße 9a \\
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
\begin{tabular}{ccccccc}%
\parbox[t]{27.0mm}{\centering Stefan\\Thöni\\[0.2em]\footnotesize{Vorsitzender~Richter}}&%
\parbox[t]{27.0mm}{\centering Michael\\Ebner\\[0.2em]\footnotesize{Richter}}&%
\parbox[t]{27.0mm}{\centering Georg\\v. Boroviczeny\\[0.2em]\footnotesize{Richter}}&%
\parbox[t]{27.0mm}{\centering Gregory\\Engels\\[0.2em]\footnotesize{Richter}}&%
\parbox[t]{27.0mm}{\centering Holger\\van Lengerich\\[0.2em]\footnotesize{Richter}}%
\parbox[t]{27.0mm}{\centering Melano\\Gärtner\\[0.2em]\footnotesize{Richter}}%
\parbox[t]{27.0mm}{\centering Mirko\\Pauli\\[0.2em]\footnotesize{Ersatzrichter}}%
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
