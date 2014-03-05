%
% bsg2tex
%
% LaTeX-Vorlage für Schiedsgerichtsbeschlüsse und -urteile
% CC-BY Markus Gerstel
%
% For great justice!
%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{bsg2tex}[2013/06/25 v0.93 Schiedsgerichtsbeschluesse und -urteile]
\newcommand\bsgtotexversion{v0.93}

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

\usepackage{xspace}

\setlength{\unitlength}{1mm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Anonymisierfunktion

\newcommand{\Anonym}[1]{%
\ifbool{bsganonym}{\xspace\textcolor{piraten}{\rule[0.25mm]{6.472mm}{2mm}}\xspace}{#1}%
}

\newcommand{\Pseudonym}[2]{%
\ifbool{bsganonym}{\textcolor{piraten}{%
\rule[0.25mm]{3.236mm}{2mm}~\textbf{#2}~\rule[0.25mm]{3.236mm}{2mm}%
}}{#1}%
}

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

\clubpenalty = 1000 
\widowpenalty = 1000 
\displaywidowpenalty = 1000

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
\suspendcutout
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

\resumecutout
}

\AddToShipoutPicture{\Background}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  LaTeX3-Magie um Textblock rechts oben freizustellen,
%  adaptiert von
%  http://tex.stackexchange.com/questions/36848/non-rectangular-page-geometry
%
%  funktioniert leider nicht zuverlässig. Wird in einer späteren Version entfernt.

\usepackage[excludeor]{everyhook}
\usepackage{expl3,xparse}
\ExplSyntaxOn
  \int_new:N \l_cutout_active                    % Zum deaktivieren in bestimmten Bereichen
  \dim_new:N \l_cutout_height_dim
  \dim_new:N \l_cutout_width_dim
  \dim_new:N \l_cutout_hsize_dim
  \dim_new:N \l_cutout_fudge_dim
  \int_new:N \l_cutout_short_lines_this_page_int % Zeilen am Seitenanfang beschneiden
  \int_new:N \l_cutout_total_lines_int           % Insgesamt Zeilen auf dieser Seite
  \int_new:N \l_cutout_short_lines_next_page_int % Zeilen am folgenden Seitenanfang beschneiden
  \NewDocumentCommand{\suspendcutout}{} { \int_set_eq:NN \l_cutout_active \c_zero }
  \NewDocumentCommand{\resumecutout}{}  { \int_set_eq:NN \l_cutout_active \c_one  }
  \NewDocumentCommand{\cutouttop}{mm}
    {
      \dim_set:Nn \l_cutout_height_dim { #1 }
      \dim_set:Nn \l_cutout_width_dim { #2 }
      \dim_set:Nn \l_cutout_fudge_dim { 2.4pt }  % Geheimnisvoller Fudge-Factor. #dontask
      \int_set_eq:NN \l_cutout_active \c_one
%      \exp_args:No \tex_everypar:D \cutout_everypar:
      \PushPostHook{par}{\cutout_everypar}
    }
  \NewDocumentCommand{\cutout_everypar}{}
%  \cs_new_protected:Npn \cutout_everypar:
  {
    \int_compare:nNnT \l_cutout_active > \c_zero
    {
      \dim_set:Nn \l_cutout_hsize_dim
        { \tex_hsize:D - \l_cutout_width_dim }

      \int_set_eq:NN \l_cutout_short_lines_this_page_int \c_zero
      \int_compare:nNnF \tex_pagetotal:D > \l_cutout_height_dim
        {
          \int_set:Nn \l_cutout_short_lines_this_page_int
            {
              \int_div_truncate:nn
                { \l_cutout_height_dim - \tex_pagetotal:D } %- \tex_pagetotal:D 
                { \tex_baselineskip:D }
            }
          \int_set:Nn \l_cutout_short_lines_this_page_int
            { \int_eval:w \l_cutout_short_lines_this_page_int + \c_one \int_eval_end: }
        }

      \int_set:Nn \l_cutout_total_lines_int
        {
              \int_div_truncate:nn
                { \tex_pagegoal:D - \tex_pagetotal:D  + \l_cutout_fudge_dim }
                { \tex_baselineskip:D }
        }
      \int_compare:nNnF \l_cutout_total_lines_int > \c_zero
        { \int_set_eq:NN \l_cutout_total_lines_int \c_zero }

%      \the\l_cutout_total_lines_int, \the\tex_pagetotal:D, 
% page_goal: 582,28563
% baselineskip: 13,6
% pagetotal: 527,80023
      \int_set:Nn \l_cutout_short_lines_next_page_int
        {
          \int_div_truncate:nn
            { \l_cutout_height_dim }
            { \tex_baselineskip:D }
        }
      \int_set:Nn \l_cutout_short_lines_next_page_int
        { \int_eval:w \l_cutout_short_lines_next_page_int + \c_one \int_eval_end: }

      \tex_parshape:D
        = \int_eval:w \l_cutout_total_lines_int + \l_cutout_short_lines_next_page_int + \c_one \int_eval_end:
          \prg_replicate:nn \l_cutout_short_lines_this_page_int
            { \c_zero_dim \l_cutout_hsize_dim }
          \prg_replicate:nn { \l_cutout_total_lines_int - \l_cutout_short_lines_this_page_int }
            { \c_zero_dim \tex_hsize:D }
          \prg_replicate:nn \l_cutout_short_lines_next_page_int
            { \c_zero_dim \l_cutout_hsize_dim }
        \c_zero_dim \tex_hsize:D
    }
  }
\ExplSyntaxOff

%\cutouttop{17.5mm}{50mm}

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