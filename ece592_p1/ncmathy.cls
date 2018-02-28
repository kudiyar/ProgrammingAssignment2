\ProvidesClass{ncmathy}[]
\NeedsTeXFormat{LaTeX2e}

%\DeclareOption{print}{\def\@cv@print{}}
%\DeclareOption*{%
%  \PassOptionsToClass{\CurrentOption}{article}%
%}
%\ProcessOptions\relax

\LoadClass{article}

\RequirePackage[utf8]{inputenc}

\RequirePackage[pdfusetitle]{hyperref} % for clickable toc
\hypersetup{
    colorlinks,
    citecolor=black,
    filecolor=black,
    linkcolor=black,
    urlcolor=blue
}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage[english]{babel}
\RequirePackage{cancel} % for diagonal strikethrough
%\renewcommand{\CancelColor}{red}
\RequirePackage [autostyle, english = american]{csquotes}
\RequirePackage{fancyhdr}
\RequirePackage{float}
\RequirePackage[margin=0.8in]{geometry}

\RequirePackage{graphicx}
\graphicspath{ {images/}{../images/} } % location of source images, available to subfiles and main file

\RequirePackage{mathtools,xparse}
\RequirePackage{multicol}
\RequirePackage{subfiles} % to modularize tex files
\RequirePackage{stackrel} % to add extra lower text field

\RequirePackage{wrapfig}

\numberwithin{equation}{section} % include sec. in eq. num.
\numberwithin{figure}{section} % include sec. in fig. num.

% custom highlighting
\RequirePackage{xcolor}
\RequirePackage{soul}
\newcommand{\hlc}[2][yellow]{{%
    \colorlet{foo}{#1}%
    \sethlcolor{foo}\hl{#2}}%
}

%--------------------------------------------------------------------------
% Section Styling (depends on xcolor, calc)

\RequirePackage{calc}
% for horizontal line under sections
%\RequirePackage{titlesec} 
%\titleformat{\section}
%  {\normalfont\Large\bfseries}{\thesection}{1em}{}[{\titlerule[0.8pt]}]
\RequirePackage[explicit]{titlesec}

%Setting section title bg color
\definecolor{redbg}{RGB}{255, 234, 234}
%Setting subsection and subsubsection title color
\definecolor{Red}{RGB}{123, 25, 25}

\titleformat{\section}
  {\normalfont\LARGE\bfseries\color{Red}}
  {\thesection}
  {1em}
  %{\colorbox{redbg}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{\textcolor{Red}{\thesection\quad#1}}}}
  {#1}
	[{
  \setlength{\titlewidth}{\textwidth}
  \titlerule[1pt]
  }]

%Underlining ruler for subsections
\titleformat{\subsection}
  {\normalfont\Large\bfseries\color{Red}}
  {\thesubsection}
  {1em}
  {#1}
  [{
  \setlength{\titlewidth}{0.8\textwidth}
  \titlerule[0.6pt]
  \setlength{\titlewidth}{\textwidth}
  }]

% subsubsections  
\titleformat{\subsubsection} 
  {\normalfont\normalsize\bfseries\color{Red}}
  {\thesubsubsection}
  {1em}
  {#1}
  [{
  \setlength{\titlewidth}{\widthof{\thesubsubsection\quad{#1}}}
  \titlerule[0.3pt]
  \setlength{\titlewidth}{\textwidth}
  }]
  
\let\oldtitleline\titleline
\renewcommand{\titleline}{\oldtitleline*}
  
%--------------------------------------------------------------------------
 
% MATLAB
\RequirePackage[numbered,framed]{matlab-prettifier}
\RequirePackage{filecontents}
\RequirePackage[T1]{fontenc}
\let\ph\mlplaceholder % shorter macro
\lstMakeShortInline"

\lstset{
  style              = Matlab-editor,
  basicstyle         = \mlttfamily,
  escapechar         = ",
  mlshowsectionrules = true,
}

% c++ syntax highlighting (optional)
\newcommand{\cpp}{
	\lstset{language=C++,
                basicstyle=\ttfamily,
                keywordstyle=\color{blue}\ttfamily,
                stringstyle=\color{red}\ttfamily,
                commentstyle=\color{green}\ttfamily,
                morecomment=[l][\color{magenta}]{\#}
}}



%--------------------------------------------------------------------------
% no more packages, only commands

% pretty norm fences
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
\NewDocumentCommand{\normL}{ s O{} m }{%
  \IfBooleanTF{#1}{\norm*{#3}}{\norm[#2]{#3}}_{L_2(\Omega)}%
} 

% pretty inner products
\DeclarePairedDelimiterX{\inp}[2]{\langle}{\rangle}{#1 | #2}

\pagestyle{fancy}
\fancyhf{}

% plus or minus (pom) symbol
\newcommand{\pom}{\sbox0{$1$}\sbox2{$\scriptstyle\pm$}
  \raise\dimexpr(\ht0-\ht2)/2\relax\box2 }
\newcommand{\pinus}{\pom}
  
% noindent shorthand
\newcommand{\noi}{\noindent}

% set document to have no indent
\setlength\parindent{0pt}

% use highlighting to make in-line code
\newcommand{\code}[1]{\hlc[pink!20]{\texttt{#1}}}

% for vertical center in tables
\RequirePackage{makecell} % To keep spacing of text in tables
\setcellgapes{4pt} % parameter for the spacing
% some table formatting
\renewcommand\theadalign{cb}
\renewcommand\theadfont{\bfseries}
\renewcommand\theadgape{\Gape[4pt]}
\renewcommand\cellgape{\Gape[4pt]}

% for augmented matrices
% call like this: \begin{amatrix}{m-1}, m cols
\newenvironment{amatrix}[1]{%
  \left(\begin{array}{@{}*{#1}{c}|c@{}}
}{%
  \end{array}\right)
}

% skip to next column
\newcommand{\nextColumn}{\vfill\null \columnbreak}

% center title page on it's own page
\newcommand{\makeTitlePage}{
	\null  % Empty line
	\nointerlineskip  % No skip for prev line
	\vfill
	\let\snewpage \newpage
	\let\newpage \relax
	\maketitle
	\thispagestyle{empty} % remove page #
	\let \newpage \snewpage
	\vfill 
	\break % page break
}

% stylize title
\makeatletter
\renewcommand{\title}[1]{\renewcommand{\@title}{\color{\@titlecolor}#1}}
\newcommand{\@titlecolor}{Red}
\newcommand{\titlecolor}[1]{\renewcommand{\@titlecolor}{#1}}
\makeatother

% stylize header
\RequirePackage{etoolbox}
\makeatletter
\patchcmd{\f@nch@head}{\rlap}{\color{Red}\rlap}{}{}
\patchcmd{\headrule}{\hrule}{\color{Red}\hrule}{}{}
\patchcmd{\f@nch@foot}{\rlap}{\color{Red}\rlap}{}{}
\patchcmd{\footrule}{\hrule}{\color{Red}\hrule}{}{}
\makeatother

% number align* equations
\newcommand\numberthis{\addtocounter{equation}{1}\tag{\theequation}}

% type inverses faster
\newcommand{\inv}{^{-1}}

% shorthand for italics
\newcommand{\ital}[1]{\textit{{#1}}}

% gaussian elimination arrows
\newcommand{\gaussElimSmall}[1]{\quad\stackrel{\mathclap{{#1}}}{\rightarrow}\quad}
\newcommand{\gaussElim}[1]{\quad\quad\stackrel{\mathclap{{#1}}}{\rightarrow}\quad\quad}
\newcommand{\gaussElimBig}[1]{\quad\quad\quad\stackrel{\mathclap{{#1}}}{\rightarrow}\quad\quad\quad}

% colored strike-through for cancelling values in equations
\newcommand\hcancel[2][black]{\renewcommand\CancelColor{\color{#1}}\cancel{#2}}

% change toc title
\addto\captionsenglish{% Replace "english" with the language you use
  \renewcommand{\contentsname}%
    {Contents \footnotesize \textit{(Note that the entries are links.)}}
}