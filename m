From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 12 May 2018 06:33:15 -0700
Subject: [PATCH v2] nvme: continue keep alive on error
In-Reply-To: <20180511232229.18929-1-jsmart2021@gmail.com>
References: <20180511232229.18929-1-jsmart2021@gmail.com>
Message-ID: <20180512133315.GA14317@infradead.org>

On Fri, May 11, 2018@04:22:29PM -0700, James Smart wrote:
> Currently, if the keep_alive command failed, an error message is
> generated and keep alive is stopped. This guarantees the target will
> eventually not see a keep_alive in a KATO window and fail.
> 
> The keep_alive command may complete in error in cases where the
> transport or lldd are temporarily out of resources. As such, the
> command should be retried rather than letting the controller die.
> 
> If the command completes in error, retry another one after a short
> delay. Track whether keep alive has had an error to reduce printing
> the error message to the first failure only.

This seems pretty much counter the definition of the keep alive.
What kinds of errors do you see when you'd want to retry?  How we
can we figute out we hit exactly that case instead of just wasting
our time retrying?
