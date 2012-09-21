\name{lplikint}
\alias{lplikint}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Maximum partial likelihood local polynomial estimator of counting
  process intensity function and its derivatives 
%%  ~~function to do ... ~~
}
\description{
  The local polynomial estimator is based on the (localized) partial
  likelihood 
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
lplikint(jmptimes, jmpsizes = rep(1, length(jmptimes)), Y = rep(1, length(jmptimes)), K = function(x) 3/4 * (1 - x^2) * (x <= 1 & x >= -1), bw, adjust = 1, nu = 0, p = 1, Tau = 1, n = 101, tseq = seq(from = 0, to = Tau, length = n), tol = 1e-05, maxit = 100, us = 10, gd = 5)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{jmptimes}{a numeric vector giving the jump times of the counting process
    %%     ~~Describe \code{jmptimes} here~~
  }
  \item{jmpsizes}{a numeric vector giving the jump sizes at each jump
    time. Need to be of the same length as jmptimes
    %%     ~~Describe \code{jmpsizes} here~~
  }
  \item{Y}{a numeric vector giving the value of the exposure process
    (or size of the risk set) at each jump times. Need to be of the same
    length as jmptimes
    %%     ~~Describe \code{Y} here~~
  }
  \item{K}{the kernel function 
    %%     ~~Describe \code{K} here~~
  }
  \item{bw}{a numeric constant specifying the bandwidth used in the
    estimator. If left unspecified the automatic bandwidth selector will
    be used to calculate one. 
    %%     ~~Describe \code{bw} here~~
  }
  \item{adjust}{a positive constant giving the adjust factor to be
    multiplied to the default bandwith parameter or the supplied
    bandwith
    %%     ~~Describe \code{adjust} here~~
  }
  \item{nu}{the degree of the derivative of the intensity function to be
    estimated. Default to 0 for estimation of the intensity itself.
    %%     ~~Describe \code{nu} here~~
  }
  \item{p}{the degree of the local polynomial used in constructing the
    estimator. Default to 1 plus the degree of the derivative to be
    estimated
    %%     ~~.Describe \code{p} here~~
  }
  \item{Tau}{a numric constant >0 giving the censoring time (when
    observation of the counting process is terminated)
    %%     ~~Describe \code{Tau} here~~
  }
  \item{n}{the number of evenly spaced time points to evaluate the
    estimator at. Not used when \code{tseq} is provided.
    %%     ~~Describe \code{n} here~~
  }
  \item{tseq}{the time sequence at which to evaluate the estimator
    %%     ~~Describe \code{tseq} here~~
  }
  \item{tol}{the parameter error tolerance used to stop the iterations
    in optimizing the local likelihood
    %%     ~~Describe \code{tol} here~~
  }
  \item{maxit}{maximum number of iterations allowed in the optimization
    used in a single estimation point
    %%     ~~Describe \code{maxit} here~~
  }
  \item{us}{a numeric constants used together with
    \code{gd} to grid search for a decent start value in solving the
    local score equation. The starting value is 0 except on its first
    dimension, which was chosen so that the starting value is the
    minimizer of the L^1 norm of the score function among the values:
    average intensity X \code{us^(-gd:gd)} 
    %%     ~~Describe \code{us} here~~
  }
  \item{gd}{a numeric constant used together with \code{us} to search
    for a decent start value in solving the local score equation
    %%     ~~Describe \code{gd} here~~
  }
}
\details{
  The estimator is based on solving the local score equation using the
  Newton-Raphson method and extract the appropriate dimension.
  %%  ~~ If necessary, more details than the description above ~~
}
\value{
  a list containing
  \item{x}{the vector of times at which the estimator is evaluated}
  \item{y}{the vector giving the values of the estimator at times given
    in \code{x}}
  \item{se}{the vector giving the standard errors of the estimates given
    in \code{y}} 
  \item{bw}{the bandwidth actually used in defining the estimator equal
    the automatically calculated or supplied multiplied by \code{adjust}}
  \item{fun}{the intensity (or derivative) estimator as a function of
    the estimation point, which can be called to evaluate the estimator
    at points not included in \code{tseq}
    %%  ~Describe the value returned
    %%  If it is a LIST, use
    %%  \item{comp1 }{Description of 'comp1'}
    %%  \item{comp2 }{Description of 'comp2'}
    %% ...
  }
}
\references{
  Chen, F. (2011) Maximum local partial likelihood estimators for the
  counting process intensity function and its derivatives. Statistica
  Sinica 21(1): 107
  -128. http://www3.stat.sinica.edu.tw/statistica/j21n1/J21N14/J21N14.html 
}
\author{
  Feng Chen <feng.chen@unsw.edu.au.>
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{lpint}}
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##simulate a Poisson process on [0,1] with given intensity
int <- function(x)100*(1+0.5*cos(2*pi*x))
censor <- 1
set.seed(2)
N <- rpois(1,150*censor);
jtms <- runif(N,0,censor);
jtms <- jtms[as.logical(mapply(rbinom,n=1,size=1,prob=int(jtms)/150))];

##estimate the intensity
intest <- lplikint(jtms,bw=0.15,Tau=censor)
#plot and compare
plot(intest,xlab="time",ylab="intensity",type="l",lty=1)
curve(int,add=TRUE,lty=2)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{smooth }
\keyword{survival }% __ONLY ONE__ keyword per line
