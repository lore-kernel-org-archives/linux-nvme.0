From: keith.busch@intel.com (Keith Busch)
Date: Wed, 1 Nov 2017 09:49:51 -0600
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <20171101154232.GA25317@infradead.org>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
 <20171028064508.GA20977@infradead.org>
 <ac29e201-7d60-d698-d6a3-9b4c0307c91f@kernel.dk>
 <20171101154232.GA25317@infradead.org>
Message-ID: <20171101154951.GK17245@localhost.localdomain>

On Wed, Nov 01, 2017@08:42:32AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 30, 2017@08:30:04AM -0600, Jens Axboe wrote:
> > On 10/28/2017 12:45 AM, Christoph Hellwig wrote:
> > > And what about sanitize?  I guess instead of looking at opcodes directly
> > > we'd better look at the indications in the Commands Supported and Effects
> > > log.  That's what the Windows driver does, btw.
> > 
> > Isn't that exactly what Keith's patch did?
> 
> Ooops I had missed his patch was a completely different approach.

I'll send it out in a new thread. I have fix the command effects log
page memory leak, anyway.
