From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 4 May 2017 14:07:26 -0700
Subject: [RFC 0/7] nvme_fc: add dev_loss_tmo support
In-Reply-To: <38787b57-5778-5e26-5fd0-0159568e9c6b@gmail.com>
References: <20170504180737.5472-1-jsmart2021@gmail.com>
 <38787b57-5778-5e26-5fd0-0159568e9c6b@gmail.com>
Message-ID: <20170504210726.GA31395@infradead.org>

On Thu, May 04, 2017@12:24:34PM -0700, James Smart wrote:
> But, in the future, FC-NVME will support retransmission. Meaning we would
> not immediately delete the existing association and terminate all i/o.
> Therefore, it would be preferred if the association stays active at the
> target at least as long as our connectivity window (if possible), and i/o
> resumes, perhaps with retransmission to recover from errors that occurred
> during the loss of connectivity.

This is not the model the NVMe over Fabrics spec assumes.  If you want
this model please take it to the NVMe working group first, which so far
is left pretty much in the dark of a lot of these weird NVMe details
anyway.
