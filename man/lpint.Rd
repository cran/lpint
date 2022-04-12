\name{lpint}
\alias{lpint}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Martingale estimating equation local polynomial estimator of counting
  process intensity function and its derivatives 
%%  ~~function to do ... ~~
}
\description{
  This local polynomial estimator is based on a biased martingale
  estimating equation. 
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
lpint(jmptimes, jmpsizes = rep(1, length(jmptimes)),
      Y = rep(1,length(jmptimes)), bw = NULL,
      adjust = 1, Tau = max(1, jmptimes), p = nu + 1,
      nu = 0, K = function(x) 3/4 * (1 - x^2) * (x <= 1 & x >= -1),
      n = 101, bw.only=FALSE)
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
  \item{Tau}{a numric constant >0 giving the censoring time (when
    observation of the counting process is terminated)
    %%     ~~Describe \code{Tau} here~~
  }
  \item{p}{the degree of the local polynomial used in constructing the
    estimator. Default to 1 plus the degree of the derivative to be
    estimated
    %%     ~~.Describe \code{p} here~~
  }
  \item{nu}{the degree of the derivative of the intensity function to be
    estimated. Default to 0 for estimation of the intensity itself.
    %%     ~~Describe \code{nu} here~~
  }
  \item{K}{the kernel function 
    %%     ~~Describe \code{K} here~~
  }
  \item{n}{the number of evenly spaced time points to evaluate the
    estimator at
    %%     ~~Describe \code{n} here~~
  }
  \item{bw.only}{TRUE or FALSE according as if the rule of thumb
    bandwidth is the only required output or not}
}
% \details{
% %%  ~~ If necessary, more details than the description above ~~
% }
\value{
  either a list containing
  \item{x}{the vector of times at which the estimator is evaluated}
  \item{y}{the vector giving the values of the estimator at times given
    in \code{x}}
  \item{se}{the vector giving the standard errors of the estimates given
    in \code{y}} 
  \item{bw}{the bandwidth actually used in defining the estimator equal
    the automatically calculated or supplied multiplied by
    \code{adjust}}
  or a numeric constant equal to the rule of thumb bandwidth estimate
}
\references{
  Chen, F., Yip, P.S.F., & Lam, K.F. (2011) On the Local Polynomial
  Estimators of the Counting Process Intensity Function and its
  Derivatives. Scandinavian Journal of Statistics 38(4): 631 -
  649. http://dx.doi.org/10.1111/j.1467-9469.2011.00733.x

%% ~put references to the literature/web site here ~
}
\author{
  Feng Chen <feng.chen@unsw.edu.au.>
%%  ~~who you are~~
}
% \note{
% %%  ~~further notes~~
% }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{lplikint}}
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
intest <- lpint(jtms,Tau=censor)
##plot and compare
plot(intest,xlab="time",ylab="intensity",type="l",lty=1)
curve(int,add=TRUE,lty=2)

## Example estimating the hazard function from right censored data:
## First simulate the (not directly observable) life times and censoring
## times:
lt <- rweibull(500,2.5,3); ct <- rlnorm(500,1,0.5)
## Now the censored times and censorship indicators delta (the
## observables): 
ot <- pmin(lt,ct); dlt <- as.numeric(lt <= ct);
## Estimate the hazard rate based on the censored observations:
jtms <- sort(ot[dlt==1]);
Y <- sapply(jtms,function(x)sum(ot>=x));
haz.est <- lpint(jtms,Y=Y);
## plot the estimated hazard function:
matplot(haz.est$x,
        pmax(haz.est$y+outer(haz.est$se,c(-1,0,1)*qnorm(0.975)),0),
        type="l",lty=c(2,1,2),
        xlab="t",ylab="h(t)",
        col=1);
## add the truth:
haz <- function(x)dweibull(x,2.5,3)/pweibull(x,2.5,3,lower.tail=FALSE)
curve(haz, add=TRUE,col=2)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{smooth }
\keyword{survival }% __ONLY ONE__ keyword per line
