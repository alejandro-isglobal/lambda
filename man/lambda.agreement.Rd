\name{lambda.agreement}
\alias{lambda.agreement}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Ageement measure lambda
}
\description{
Computes the agreement measure between two experiments across numerous conditions 
}
\usage{
lambda.agreement(means, sigmas, benchmark = "FALSE")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{means}{
a k-times-k matrix that encodes the cross-tabulation table of correlations (z-transformed) between experiment 1 in rows and experiment 2 in columns across k condition levels. 
}
  \item{sigmas}{
a k-times-k matrix that encodes the estandard error for the means.
}
  \item{benchmark}{
a logical (default FALSE) that computes the agreement measure for benchmarking experiment 2 (columns) against experiment 1 (rows).
}
}
\details{
Lambda is a generalization of Cohen'e kappa for studies that measure a population sample across a range of condition levels. The measure is computed from a cross-tabulation table of correlations between experitments across the range of conditions. The expected value that all diagonal terms are maxima in the rows and columns are maxima is fisrt computed. Lambda is then the fraction of the expected value over the number of conditions.  

The measure assumes that the means are estimates of normally distributed variables with the standard errors that are passed in the sigmas argument. 

}
\value{
 \item{estimate }{Estimate of lambda}
 \item{variance }{Variance of lambda}

}
\references{
Caceres, A and Gonzalez JR, An overall measure of agreement across numerous conditions: Reproducibility of co-expression networks across tissues, bioRxiv, DOI: 
}
\author{
A Caceres
}

\examples{



#simulate correlation network of ten variables (genes) on three conditions (tissues)
k<-10
#number of upper triangular elements in the correlation matrix is (k^2-k)/2 
tn <- (k^2-k)/2
net11 <- rnorm(tn)
net12 <- rnorm(tn)
net13 <- rnorm(tn)

#network in experiment 2 across theree conditions 
net21 <- net11 + rnorm(tn)
net22 <- net12 + rnorm(tn)
net23 <- net13 + rnorm(tn)

#correlation matrix between experients across conditions
cormat<-matrix(c(cor.test(net11,net21)$estimate,
cor.test(net11,net22)$estimate,
cor.test(net11,net23)$estimate,
cor.test(net12,net21)$estimate,
cor.test(net12,net22)$estimate,
cor.test(net12,net23)$estimate,
cor.test(net13,net21)$estimate,
cor.test(net13,net22)$estimate,
cor.test(net13,net23)$estimate), ncol=3)

#Fisher's Z transformation
zmat <- round(log((1 + cormat) / (1 - cormat)) / 2,2)
sigmaz <-  matrix(1/sqrt(length(net11) -3),ncol=3,nrow=3)

lambda <- lambda.agreement(zmat, sigmaz)
lambda



}
