From: jsmart2021@gmail.com (James Smart)
Date: Thu, 4 May 2017 16:17:29 -0700
Subject: [RFC 0/7] nvme_fc: add dev_loss_tmo support
In-Reply-To: <20170504210726.GA31395@infradead.org>
References: <20170504180737.5472-1-jsmart2021@gmail.com>
 <38787b57-5778-5e26-5fd0-0159568e9c6b@gmail.com>
 <20170504210726.GA31395@infradead.org>
Message-ID: <456d4b53-57e3-af99-b544-7d595f7006f8@gmail.com>

On 5/4/2017 2:07 PM, Christoph Hellwig wrote:
> On Thu, May 04, 2017@12:24:34PM -0700, James Smart wrote:
>> But, in the future, FC-NVME will support retransmission. Meaning we would
>> not immediately delete the existing association and terminate all i/o.
>> Therefore, it would be preferred if the association stays active at the
>> target at least as long as our connectivity window (if possible), and i/o
>> resumes, perhaps with retransmission to recover from errors that occurred
>> during the loss of connectivity.
>
> This is not the model the NVMe over Fabrics spec assumes.  If you want
> this model please take it to the NVMe working group first, which so far
> is left pretty much in the dark of a lot of these weird NVMe details
> anyway.
>

controller resets (CC.NE=0) would always fully reset. if the controller 
isn't reset, then the rest is simply in the retransmission model for the 
transport.

Regardless.. please ignore the KATO statements and provide feedback on 
how you think dev_loss_tmo from the transport should contend vs the 
connect option ctlr_loss_tmo.

-- james
