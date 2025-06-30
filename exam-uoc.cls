%
% exam-uoc.cls
%
% author: Georgios Arampatzis (georgios.arampatzis@uoc.gr), 15.04.2024
%
% ---------------------------------------------------------------------
% The file `exam-uoc.cls' is free software; you can redistribute
% it and/or modify it under the terms of the GNU General Public
% License as published by the Free Software Foundation version 2
% of the license.
%
% This class file is distributed in the hope that it will be usefull,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
% General Public License for more details.
% ---------------------------------------------------------------------
%
%
% options: greek  loads the babel package automatically
%
% Example:
%
%   \documentclass[11pt]{exam-uoc}
%
%   \lectureheader{Prof.~A.~Einstein}{G.~Globi}{Relativity Theory I}
%   \setserie{1}
%   \header{Serie \serie}{April 1st, 1912}{April 15, 1912}
%
%   \begin{question}{$E=mc^2$?}\label{..}
%      Given ....
%      \begin{subquestion}\label{...}
%         Assume that ...
%         \begin{subsubquestion}
%            Prove that ...
%         \end{subquestion}
%         other bla bla
%         \begin{subquestion}
%            Yet another prove...
%         \end{subquestion}
%      \end{subquestion}
%     ...
%     \begin{subquestion}
%     ...
%     \end{subquestion}
%   ...
%   \end{question}
%   ...
%   \end{document}
%
% option a4wide saves a lot of paper!
%
\NeedsTeXFormat{LaTeX2e} \ProvidesClass{exam-uoc}[2025/06/30]

\RequirePackage{ifthen}
\RequirePackage{verbatim}
\RequirePackage{color}

\definecolor{gray}{rgb}{0.4,0.4,0.5}
\definecolor{black}{rgb}{0.0,0.0,0.0}

\ifx\pdfoutput\undefined
\relax
\else
\RequirePackage{thumbpdf}
\fi

\newboolean{language@set} \setboolean{language@set}{false}
\newboolean{@english} \setboolean{@english}{true}
\newboolean{@greek} \setboolean{@greek}{false}
\newboolean{ex@set} \setboolean{ex@set}{false}
\newboolean{sol@set} \setboolean{sol@set}{false}

% if the greek option is defined then load the babel package
% and set the default language to greek.
\DeclareOption{greek}{%
  \PassOptionsToPackage{greek}{babel} 
  \setboolean{language@set}{true}
  \setboolean{@greek}{true}
  \setboolean{@english}{false}
}
\DeclareOption{ex}{%
  \setboolean{ex@set}{true}
}
\DeclareOption{solution}{%
  \setboolean{sol@set}{true}
}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions
\LoadClass{article}
\ifthenelse{\boolean{language@set}}{% Load babel package
    \RequirePackage{babel}
}{}

% Load graphicx first with conditional options (before other packages that depend on it)
\ifx\pdfoutput\undefined
\RequirePackage[dvips]{graphicx}
\else
\RequirePackage[pdftex]{graphicx}
\fi

% Additional packages from common.tex
\RequirePackage{xparse} % for \DeclareDocumentCommand
\RequirePackage{parskip}
\RequirePackage{xcolor,colortbl}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{commath} % for differentials
\RequirePackage{bm} % for bold in math
\RequirePackage{bbm}
\RequirePackage[c]{esvect}% for vectors in math
\RequirePackage{upgreek}
\RequirePackage[capitalise]{cleveref}
\RequirePackage{import}
\RequirePackage{xifthen}
\RequirePackage{pdfpages}
\RequirePackage{transparent}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
\RequirePackage{float}
\RequirePackage{eurosym}
\RequirePackage{cancel}
\RequirePackage{geometry}

% Geometry settings
\geometry{
  a4paper,
  total={160mm,260mm},
  left=12mm,
  right=12mm,
  top=15mm,
}

% Language switching commands
\newcommand{\en}{\selectlanguage{english}}
\newcommand{\gr}{\selectlanguage{greek}}

% Math commands
\newcommand{\Real}{\mathbb{R}}
\newcommand{\Uniform}{\mathcal{U}}
\newcommand{\Normal}{\mathcal{N}}

\DeclareDocumentCommand{\Mean}{o o}
{%
  \IfNoValueTF{#2}{
    \IfNoValueTF{#1}{
        \mathbb{E}\,
    }{
        \mathbb{E}_{#1}
    }
  }
  {
    \mathbb{E}_{#1} \left[ #2 \right]
  }
}

\DeclareDocumentCommand{\Prob}{o o}
{%
  \IfNoValueTF{#2}{
    \IfNoValueTF{#1}{
        \mathbb{P}\,
    }{
        \mathbb{P}_{#1}
    }
  }
  {
    \mathbb{P}_{#1} \left( #2 \right)
  }
}

\DeclareDocumentCommand{\Var}{o o}
{%
  \IfNoValueTF{#2}{
    \IfNoValueTF{#1}{
        \mathbb{V}\,
    }{
        \mathbb{V}_{#1}
    }
  }
  {
    \mathbb{V}_{#1} \left[ #2 \right]
  }
}

% Figure commands
\newcommand{\incfig}[3][1]{%
    \def\svgwidth{#1\columnwidth}
    \import{#2}{#3.pdf_tex}
}

% nice way to put two pictures next to each other
\newcommand{\twofig}[6]{\begin{figure}
  \hfill
  \begin{minipage}[t]{.45\textwidth}
    \begin{center}  
      \includegraphics*[width=1.0\textwidth]{#1}
      \caption{#2}
      \label{fig:#3}
    \end{center}  \end{minipage}
  \hfill
  \begin{minipage}[t]{.45\textwidth}
    \begin{center}  
      \includegraphics*[width=1.0\textwidth]{#4}
      \caption{#5}
      \label{fig:#6}
    \end{center}
  \end{minipage}
  \hfill
\end{figure}}

% same as twofig but with only one caption and label
\newcommand{\twofigonecap}[4]{\begin{figure}
  \hfill
  \includegraphics*[width=0.45\textwidth]{#1}
  \hfill
  \includegraphics*[width=0.45\textwidth]{#2}
  \hfill
  \caption{#3}
  \label{fig:#4}
\end{figure}}

\newcommand{\refig}[1]{Fig.~\ref{fig:#1}}

% Set parindent to 0 (as in common.tex)
\setlength\parindent{0pt}

%
% define the words we use in this class file. Here you have to make
% changes if you are going to this file for a different language.
%\iflanguage{greek}{%
\ifthenelse{\boolean{@greek}}{% then translate
  \newcommand{\Question}{Ερώτηση}%
  }{% else English
  \newcommand{\Question}{Question}%
}

\ifthenelse{\boolean{@greek}}{% then translate
  \newcommand{\Information}{Πληροφορίες}%
  }{% else English
  \newcommand{\Information}{Information}%
}

\ifthenelse{\boolean{@greek}}{% then translate
  \newcommand{\Issued}{Έκδοση}%
  }{% else English
  \newcommand{\Issued}{Issued}%
}

\ifthenelse{\boolean{@greek}}{% then translate
  \newcommand{\Handin}{Παράδοση}%
  }{% else English
  \newcommand{\Handin}{Hand in (optional)}%
}
% define \ifex, \ifsol, \ifexsol
%
\newif\ifex\exfalse
\newif\ifsol\solfalse
\newif\ifexsol\exsolfalse
\ifthenelse{\boolean{sol@set}}{%
  \soltrue
  \ifthenelse{\boolean{ex@set}}{%
    \extrue\exsoltrue
  }{}%
}{%
  \extrue
}%
%
% global stuff: no parindent and parskip is set to 1ex
%
\parindent0cm
\parskip1.0ex plus 0.3ex minus 0.3ex
%
% \lectureheader{Prof}{Assistents}{title of the lecture}
%
% e.g: \lectureheader{Prof.~A.~Einstein}{R.~Theory, G.~Globbi}
%       {Relativity Theory}{Wintersemester Year}
%

\newcommand{\UOCheaderpath}{./}

\newcommand{\lectureheader}[4]{
  %
  \begin{minipage}{.25\textwidth}
    \ifx\pdfoutput\undefined
      \includegraphics[width=0.9\textwidth]{\UOCheaderpath/uoclogo.eps}
    \else
      \includegraphics[width=0.9\textwidth]{\UOCheaderpath/uoclogo.pdf}
    \fi
  \end{minipage}%
  \hspace{\fill}%
  \raisebox{-1mm}{%
    \begin{minipage}{0.63\textwidth}\flushright
        \textbf{\Large #3}\\#4
    \end{minipage}%
  }
  \par\hrule
  %
  \begin{minipage}[t]{0.5\textwidth}\textit{#1} \end{minipage} \hfill
  \begin{minipage}[t]{0.5\textwidth}\flushright \textit{#2}\end{minipage}
  \par
}


% \header{exercise title}{handed out}{due to}
%
% \header{Serie 1}{April 1st, 1912}{April 15, 1912}
\newcommand{\header}[2]{%
  \vspace{-0.5em}
  \begin{center}
    \textbf{\Large #1}\\
    {\normalsize #2} \\
  \end{center}\par%
  \vspace{0.5em}
}

%
% \serie returns the serie number.
%
\newcommand{\serie}{not defined yet}
\newcommand{\seriepoint}{}
%
% \setserie sets the serie number.
%
\newcommand{\setserie}[1]{%
  \renewcommand{\serie}{#1}%
}
%
% \setseriepoint sets the serie number . question number
\newcommand{\setseriepoint}[1]{%
  \setserie{#1}
  \renewcommand{\seriepoint}{#1.}%
}%
%
% \sig{signature}
%
% \sig{AE 15 Apr 12}
\newcommand{\sig}[1]{%
  \vfill
  \hfill\emph{\footnotesize #1}
}
%
%
% question, subquestion and subsubquestions counter
%
\newcounter{questionC}
\newcounter{subquestionC}[questionC]
\newcounter{subsubquestionC}[subquestionC]

% Point tracking counters
\newcounter{totalpoints}
\newcounter{questionpoints}[questionC]
\newcounter{tempsubqpoints}[questionC]

% Flag to track if question has explicit points
\newif\ifquestionhaspoints
\questionhaspointsfalse

% Command to get total points
\newcommand{\gettotalpoints}{\arabic{totalpoints}}
\newcommand{\getquestionpoints}{\arabic{questionpoints}}

% No longer needed - using optional parameter approach
%
%
% save old label values because we set them back in the environments
% described below.
%
\newlength{\labelwidthbak}\setlength{\labelwidthbak}{\labelwidth}
\newlength{\leftmarginbak}\setlength{\leftmarginbak}{\leftmargin}
\newlength{\itemindentbak}\setlength{\itemindentbak}{\itemindent}
\newlength{\labelsepbak}\setlength{\labelsepbak}{\labelsep}

%%%%%%%%%%%%%%%%%%%%%%%%%
%
% \begin{information} .... \end{information}
%
\newenvironment{information}{%
%  \stepcounter{questionC} % advance counter by one
%  \edef\@currentlabel{%
%    \arabic{questionC}}%
  \begin{list}{\textbf{\large \Information}}%
    {\labelwidth0pt \leftmargin0pt%
    \itemindent0pt \labelsep0pt}
    \item~\par%
    % restore old values
    \setlength{\labelwidth}{\labelwidthbak}%
    \setlength{\leftmargin}{\leftmarginbak}%
    \setlength{\itemindent}{\itemindentbak}%
    \setlength{\labelsep}{\labelsepbak}%
  }%
  {\end{list}}

%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% \begin{question} .... \end{question}
%
\NewDocumentEnvironment{question}{o m}{%
  \stepcounter{questionC} % advance counter by one
  \edef\@currentlabel{%
    \arabic{questionC}}%
  % Reset all flags and counters for this question
  \questionhaspointsfalse%
  \setcounter{questionpoints}{0}%
  \setcounter{tempsubqpoints}{0}%
  % Check if optional parameter (points) is provided
  \IfValueT{#1}{%
    \questionhaspointstrue%
    \addtocounter{totalpoints}{#1}%
    \addtocounter{questionpoints}{#1}%
  }%
  \vspace{20pt}
  \begin{list}{\textbf{\large \Question~\seriepoint\arabic{questionC}: #2\IfValueT{#1}{ [#1]}}}%
    {
    \ifsol\color{gray}\fi
    \labelwidth0pt \leftmargin0pt%
    \itemindent0pt \labelsep0pt}
    \item~\par%
    % restore old values
    \setlength{\labelwidth}{\labelwidthbak}%
    \setlength{\leftmargin}{\leftmarginbak}%
    \setlength{\itemindent}{\itemindentbak}%
    \setlength{\labelsep}{\labelsepbak}%
  }%
  {% End of question
    \ifquestionhaspoints
      % Question has explicit points, nothing to add
    \else
      \ifnum\value{tempsubqpoints}>0
        % Add points summary for questions without explicit points
        \vspace{0.5em}
        \hfill\textit{(\arabic{tempsubqpoints} points)}
      \fi
    \fi
    \end{list}%
  }
%
%
% \begin{subquestion}[points] ... \end{subquestion}
%
\newenvironment{subquestion}[1][]{%
  \stepcounter{subquestionC}
  \edef\@currentlabel{%
    \arabic{questionC}\alph{subquestionC}}%
  % Handle points if provided
  \ifx\relax#1\relax
    \def\subqpoints{}%
  \else
    \def\subqpoints{[#1]}%
    % Always track subquestion points in temporary counter
    \addtocounter{tempsubqpoints}{#1}%
    % Only add to totals if question doesn't have explicit points
    \ifquestionhaspoints
      % Question has points, subquestion points are just for display
    \else
      % Question has no points, count subquestion points
      \addtocounter{totalpoints}{#1}%
      \addtocounter{questionpoints}{#1}%
    \fi
  \fi
  \begin{list}{\alph{subquestionC}) \subqpoints}%
     {\settowidth{\labelwidth}{a) [99] } \labelsep0.5em \topsep0pt
      \setlength{\leftmargin}{\labelwidth}%
      \addtolength{\leftmargin}{\labelsep}%
     }
     \ifsol\color{gray}\fi
     \item
     % reset values
     \setlength{\labelwidth}{\labelwidthbak}%
     \setlength{\leftmargin}{\leftmarginbak}%
     \setlength{\itemindent}{\itemindentbak}%
     \setlength{\labelsep}{\labelsepbak}%
  }%
  {\end{list}}
%
%
% \begin{subsubquestion} ... \end{subsubquestion}
%
\newenvironment{subsubquestion}{%
  \stepcounter{subsubquestionC}
  \edef\@currentlabel{%
    \arabic{questionC}.\alph{subquestionC}.\roman{subsubquestionC}}%
  \begin{list}{\roman{subsubquestionC})}%
    {\settowidth{\labelwidth}{viii) }%
    \labelsep0.5em \topsep0pt%
    \setlength{\leftmargin}{\labelwidth}%
    \addtolength{\leftmargin}{\labelsep}%
    }%
    \ifsol\color{gray}\fi
    \item
    % reset list values
    \setlength{\labelwidth}{\labelwidthbak}%
    \setlength{\leftmargin}{\leftmarginbak}%
    \setlength{\itemindent}{\itemindentbak}%
    \setlength{\labelsep}{\labelsepbak}%
  }%
  {\end{list}}
%
%
% \begin{(ex|sol)} ... \end{(ex|sol)}
%
% \font\blackfont=cmb10 scaled 400
\newcommand\strip[1]{%
  % \leavevmode\xleaders\hbox{{\blackfont #1}}\hfill\strut%
  \leavevmode\xleaders\hbox{{#1}}\hfill\strut%
  \par\nobreak\medskip\nobreak%
}

\newenvironment{ex}{%
  \ifexsol\strip{QUESTION}\fi%
  \ifex\let\next\relax\else\let\next\comment\fi\next%
}{%
  \ifex\par\else\endcomment\fi%
}%
\newenvironment{solution}{%
  \ifsol\color{black}\par\fi%
  \ifexsol\strip{ANSWER}\fi%
  \ifsol\let\next\relax\else\let\next\goodbreak\fi\next%
  \ifsol\let\next\relax\else\let\next\comment\fi\next%
}{%
  \ifsol\par\else\endcomment\fi%
}%

%
% footnote without marker
%
\let\svthefootnote\thefootnote
\newcommand\freefootnote[1]{%
  \let\thefootnote\relax%
  \footnotetext{#1}%
  \let\thefootnote\svthefootnote%
}

