From: keith.busch@intel.com (Keith Busch)
Date: Thu, 7 Apr 2016 15:46:01 +0000
Subject: [PATCH] Avoid reset work on watchdog timer function during
 error recovery
In-Reply-To: <57067FE5.7060002@linux.vnet.ibm.com>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160407131131.GA2063@infradead.org>
 <20160407142449.GA9586@localhost.localdomain>
 <57067FE5.7060002@linux.vnet.ibm.com>
Message-ID: <20160407154600.GB9586@localhost.localdomain>

On Thu, Apr 07, 2016@12:42:29PM -0300, Guilherme G. Piccoli wrote:
> Great! What name should/can I choose for the function?

I liked Christoph's 'nvme_should_reset' suggestion.
