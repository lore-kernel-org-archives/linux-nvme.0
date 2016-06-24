From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 01:17:26 -0700
Subject: [PATCH 2/2] [RFC] nvme: enable asynchronous events notification
 by default
In-Reply-To: <20160620202135.GG12936@localhost.localdomain>
References: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1466184075-10471-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <57679355.6000303@gmail.com> <576821E9.2060009@linux.vnet.ibm.com>
 <20160620202135.GG12936@localhost.localdomain>
Message-ID: <20160624081726.GA13596@infradead.org>

On Mon, Jun 20, 2016@04:21:35PM -0400, Keith Busch wrote:
> Instead of simply logging a message, is there something better we can do
> to notify a user of an async event result? The event should be masked
> by the controller until the appropriate log page is read, and I don't
> think scanning the kernel logs is how such a program wants to find out
> which page to read.

Yes, I'm not too excited about handling the AERs in kernel space,
having a userspace daemon to listen for them would generally be more
useful.

The only exception is the namespace changed AER that we already handle.
But while we're at it: why do we make use of the changed namespace
list log page in this case instead of doing a full recan.
