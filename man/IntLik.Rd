\name{IntLik}
\Rdversion{1.0}
\alias{ILik}
\title{
Numerical Integration for Integrated Likelihood
}
\description{
This function calculates the integrated likelihood numerically. Given the Likelihood function and the prior function, this function integrates out the nuisance parameters by Metropolis-Hastings (MCMC) Algorithm.
}


\usage{
ILik(L, prior, start, psiseq, psidim = 1, proposal = "Normal", iternum = 1000)
}
\arguments{
  \item{L}{
Likelihood function with two arguments, defined in form of L(psi,lambda), where psi is the parameter interested in and lambda is the nuisance parameter. psi and lambda can be scalar or vector.
}
  \item{prior}{
Prior function for lambda, in form of prior(lambda,psi), which can depend on psi.
}
  \item{start}{
Starting value of lambda to search for the MLE of lambda given certain psi. 
}
  \item{psiseq}{
The sequence of psi for which the integrated likelihood will be evaluated at.
}
  \item{psidim}{
The dimemsion of psi. If default value is 1.
}
  \item{proposal}{
The proposal distribution used in MCMC procedure,with two options: "Normal" and "Gamma". For lambda which can take any value, then proposal distribution can be set as "Normal". For lambda which can only take positive value, e.g. variances, then the proposal distribution should be set as "Gamma". The default value is "Normal".
}
  \item{iternum}{
The number of iteration in the MCMC procedure.
}
}
\value{
This function return a vector of estimated Integrated Likelihood evaluated at the given psi sequence.
}

\references{
 Chib, S. and Jeliazkov, I. (2001) Marginal likelihood from the Metropolis-Hastings Output. Journal of the American Statistical Association. 96, 270-281

 Severini, T.A. (2007) Integrated likelihood functions for non-Bayesian inference. Biometrika. 94 529-542
}

\author{
Zhenyu Zhao
\email{zhenyuzhao2014@u.northwestern.edu} 
}


\examples{
##Integrated Likelihood for Ratio of Normal Mean (Example 2 in Severini 2007)
##Generating Data
n=10
u1=4
u2=1/5
x=rnorm(1,u1,sqrt(1/n))
y=rnorm(1,u2,sqrt(1/n))

##Calculate MLE for the start value
psi_hat=x/y
lambda_hat=(x*psi_hat+y)/(psi_hat^2+1)

#Define prior function
prior=function(lambda,psi){
dnorm((psi^2+1)*lambda/(psi*psi_hat+1),mean=0,sd=1)*(psi^2+1)/(psi*psi_hat+1)
}


#Define Likelihood
L=function(psi,lambda){
L=n/2/pi*exp(-n/2*((x-psi*lambda)^2+(y-lambda)^2))
L
}

#Estimate the Integrated Likelihood evaluated at a sequence of psi 
ILik(L,prior, start=lambda_hat, seq(psi_hat-10,psi_hat+10,1), 1, "Normal")

}


\keyword{ distribution }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
