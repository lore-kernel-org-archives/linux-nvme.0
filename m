From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Thu, 7 Apr 2016 13:03:02 -0300
Subject: [PATCH] Avoid reset work on watchdog timer function during error
 recovery
In-Reply-To: <20160407154600.GB9586@localhost.localdomain>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160407131131.GA2063@infradead.org>
 <20160407142449.GA9586@localhost.localdomain>
 <57067FE5.7060002@linux.vnet.ibm.com>
 <20160407154600.GB9586@localhost.localdomain>
Message-ID: <570684B6.4060404@linux.vnet.ibm.com>

On 04/07/2016 12:46 PM, Keith Busch wrote:
> On Thu, Apr 07, 2016@12:42:29PM -0300, Guilherme G. Piccoli wrote:
>> Great! What name should/can I choose for the function?
>
> I liked Christoph's 'nvme_should_reset' suggestion.
>

Ok, cool. I'll use this name.

Thanks,


Guilherme
