%
% bsg2tex
%
% LaTeX-Vorlage für Schiedsgerichtsbeschlüsse und -urteile
% CC-BY Markus Gerstel
%
% For great justice!
%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{bsg2tex}[2014/08/28 v0.98 Schiedsgerichtsbeschluesse und -urteile]
\newcommand\bsgtotexversion{v0.98}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Präambel (wegen der Rechtssicherheit)

\usepackage{etoolbox}
\newbool{bsganonym}\newbool{bsgvordruck}\newbool{bsgbriefpapier}

% Es gibt aktuell drei gültige Optionen für die bsg2tex Klasse:
%
%   - anonym     Anonymisiert/pseudonymisiert vorhandene Namen
%
%   - print      Entfernt Hintergrundelemente zum Ausdruck auf (vorgedrucktes) Briefpapier
%
%   - invprint   Nur Hintergrundelemente. Zur Produktion von (vorgedrucktem) Briefpapier.
%                In diesem Fall sollte natürlich kein Text im eigentlichen Dokument stehen.
%                Da LaTeX keine leeren Dokumente schreiben mag, wird
%                  \begin{document}
%                  \textcolor{white}{\rule{0mm}{0mm}}
%                  \end{document}
%                als Dokumenteninhalt empfohlen. (Weißes Quadrat mit Kantenlänge 0)

\DeclareOption{anonym}{\booltrue{bsganonym}}
\DeclareOption{print}{\booltrue{bsgvordruck}\boolfalse{bsgbriefpapier}}
\DeclareOption{invprint}{\boolfalse{bsgvordruck}\booltrue{bsgbriefpapier}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper]{article}

\usepackage[latin1]{inputenc}
\usepackage[ngerman]{babel}
\setlength{\unitlength}{1mm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Anonymisierfunktion

\newcommand{\Anonym}[1]{%
\ifbool{bsganonym}{ \textcolor{piraten}{\rule[0.25mm]{6.472mm}{2mm}} }{#1}%
}

\newcommand{\Pseudonym}[2]{%
\ifbool{bsganonym}{ \textcolor{piraten}{%
\rule[0.25mm]{3.236mm}{2mm}~\textbf{#2}~\rule[0.25mm]{3.236mm}{2mm}%
} }{#1}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Zitatmakro
%

\newcommand{\Zitat}[1]{\textit{{\glqq}#1{\grqq}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Verschlusssachemakro:
%
%  \Verschlusssache{Text} bricht in der anonymisierten Fassung
%  das Dokument mit dem Kommentar 'Text' ab.

\newcommand{\Verschlusssache}[1]{%
\ifbool{bsganonym}{\vspace{10mm}\begin{center}\textit{#1}\end{center}\end{document}}{}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Mehrfach §§-Zeichen:
%

\newcommand{\SSS}{\S\kern-0.4\S}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Font
%

\usepackage[default]{sourcesanspro}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Farben
%

\usepackage{xcolor}
\definecolor{piraten}{rgb}{1,0.533,0}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Seitenlayout
%
%  Textbereich und Ränder
%

\setlength{\textwidth}{161mm}
\setlength{\oddsidemargin}{-4.4mm}
\setlength{\evensidemargin}{-0.08in}

\setlength{\topmargin}{0.0mm}
\setlength{\headheight}{18mm}
\setlength{\headsep}{19.6mm}
\setlength{\textheight}{200mm}

%
%  Absatzeinzug und -abstand
%

\setlength{\parindent}{0cm}
\parskip=0.65\baselineskip

%
%  Automatische Seitenzahl deaktivieren
%

\pagestyle{empty}

%
%  Keine Hurenkinder und Schusterjungen
%

\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=1000

%
%  Gliederung
%

\usepackage{titlesec}
\renewcommand{\thesection}{\Roman{section}} 
\renewcommand{\thesubsection}{\arabic{subsection}}
\renewcommand{\thesubsubsection}{\alph{subsubsection}}

\titlespacing{\section}{0pt}{*1}{*0.5}
\titleformat{\section}
{\normalfont\large\bfseries}{\thesection.}{1em}{}
\titlespacing{\subsection}{0pt}{*0.2}{-\parskip}
\titleformat{\subsection}
{\normalfont\bfseries}{\thesubsection.}{1em}{}
\titlespacing{\subsubsection}{0pt}{*0}{-\parskip}
\titleformat{\subsubsection}
{\normalfont\bfseries}{\thesubsubsection.}{1em}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Standardseitenelemente setzen
%   - Piratenparteilogo
%   - Signet im Hintergrund
%   - Überschrift (nur auf 1. Seite)
%   - Textblock oben rechts
%   - Footer
%

\RequirePackage{graphicx}
\RequirePackage{eso-pic}
\RequirePackage{lastpage}

\newcommand\Background{%
\setlength{\unitlength}{1mm}

%
% Signet im Hintergrund
%
\ifbool{bsgvordruck}{}{
\put(-46.75,5.833){\includegraphics[width=172.541mm]{Signet.pdf}}
}

%
% Logo oben rechts
%
\ifbool{bsgvordruck}{}{
\put(121.91,261.937){\includegraphics[width=63.34mm]{Logo.pdf}}
}

% Freigestellter Block oben rechts (für Debuggingzwecke)
%\put(131.88,255.5){\textcolor{piraten}{\rule[-32mm]{72.67mm}{39mm}}}
%\put(144.55,258.5){\textcolor{white}{\rule[-32mm]{60mm}{36mm}}}

%
% Seitentitel oben links
%
\ifbool{bsgbriefpapier}{}{
\put(20, 237.5){
\ifnum\thepage=1
{\textbf{\LARGE\Titel}}
\else
\fi
}
}

%
% Anschrift oben rechts
%
\ifbool{bsgbriefpapier}{}{
\put(144.55,258.5){\Header}
}

%
% Seitenzahl
%
\ifbool{bsgbriefpapier}{}{
\put(186,37.25){--~\thepage~/~\pageref*{LastPage}~--}
}

%
% Orangener Block am Seitenende
%
\ifbool{bsgvordruck}{}{
\put(0,0){\textcolor{piraten}{\rule{210mm}{28mm}}}
}

%
% Im Block: Headerzeile
%
\ifbool{bsgvordruck}{}{
\put(0,22.6){\parbox[b]{\paperwidth}{\RichterTabelleHeader}}
}

%
% Im Block: Richtertabelle
%
\ifbool{bsgvordruck}{}{
\put(0,11){\parbox[b]{\paperwidth}{\RichterTabelle}}
}

}

\AddToShipoutPicture{\Background}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% \usepackage[excludeor]{everyhook}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  PDF-Links und weitere Einstellungen

\usepackage{hyperref}
\hypersetup{
%hidelinks,
%pdffitwindow=false,     % window fit to page when opened
%pdfstartview={FitH},    % fits the width of the page to the window
 pdfpagemode=UseThumbs,
 pdfpagelayout=SinglePage,
 pdfcreator={BSG2Tex \bsgtotexversion, M. Gerstel}, % Ey! CC-BY, ja?
%colorlinks=true,
%linkcolor=gold,
 linkbordercolor={0.90 0.75 0.54},
%citebordercolor={0.60 0.81 0.92},
 urlbordercolor={1.00 0.53 0.00},
 breaklinks=true,
% Infos zu den möglichen Einstellungen:
% http://mirror.switch.ch/ftp/mirror/tex/macros/latex/contrib/hyperref/doc/manual.html
% http://en.wikibooks.org/wiki/LaTeX/Hyperlinks#cite_note-3
}
\urlstyle{sf}

%
% You know what you doing!
%
