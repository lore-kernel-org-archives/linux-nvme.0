From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 Jun 2016 17:22:37 +0200
Subject: automatic interrupt affinity for MSI/MSI-X capable devices V2
In-Reply-To: <b8cdfc80-fa77-b7cc-69b8-fb6037114087@sandisk.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <b8cdfc80-fa77-b7cc-69b8-fb6037114087@sandisk.com>
Message-ID: <20160616152237.GB13615@lst.de>

On Thu, Jun 16, 2016@11:45:55AM +0200, Bart Van Assche wrote:
> Is my interpretation correct that for an adapter that supports two 
> interrupts and on a system with eight CPU cores and no hyperthreading this 
> patch series will assign interrupt vector 0 to CPU 0 and interrupt vector 1 
> to CPU 1?

Yes - same as the existing blk-mq queue distribution.

> Are you aware that drivers like ib_srp assume that interrupts 
> have been spread evenly, that means assigning vector 0 to CPU 0 and vector 
> 1 to CPU 4?

which will make them run into a conflict with the current blk-mq
assignment.  That's exactly the point why we're trying to move things
to a core location so that everyone can use the same mapping.
