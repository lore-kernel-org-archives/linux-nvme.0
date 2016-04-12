From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 12 Apr 2016 12:01:45 -0700
Subject: [PATCH] Avoid reset work on watchdog timer function during error
 recovery
In-Reply-To: <570684B6.4060404@linux.vnet.ibm.com>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160407131131.GA2063@infradead.org>
 <20160407142449.GA9586@localhost.localdomain>
 <57067FE5.7060002@linux.vnet.ibm.com>
 <20160407154600.GB9586@localhost.localdomain>
 <570684B6.4060404@linux.vnet.ibm.com>
Message-ID: <20160412190145.GD32482@infradead.org>

On Thu, Apr 07, 2016@01:03:02PM -0300, Guilherme G. Piccoli wrote:
> On 04/07/2016 12:46 PM, Keith Busch wrote:
> >On Thu, Apr 07, 2016@12:42:29PM -0300, Guilherme G. Piccoli wrote:
> >>Great! What name should/can I choose for the function?
> >
> >I liked Christoph's 'nvme_should_reset' suggestion.
> >
> 
> Ok, cool. I'll use this name.

Did you manage to get around resending it?
