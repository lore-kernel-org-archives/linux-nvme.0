From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 7 Apr 2016 06:26:12 -0700
Subject: [PATCH] Avoid reset work on watchdog timer function during error
 recovery
In-Reply-To: <57065E3B.7070805@grimberg.me>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160407131131.GA2063@infradead.org>
 <57065E3B.7070805@grimberg.me>
Message-ID: <20160407132612.GA1054@infradead.org>

On Thu, Apr 07, 2016@04:18:51PM +0300, Sagi Grimberg wrote:
> Agreed, but nvme_should_reset() sounds like you are checking if a reset
> is needed,

But that's exaxtly what it does!  It reads CSTS to check for one of the
two bits in there indicating that we should initiate a reset, except for
various conditions why we think we better shouldn't reset at the
moment..
