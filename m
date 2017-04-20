From: keith.busch@intel.com (Keith Busch)
Date: Thu, 20 Apr 2017 10:20:44 -0400
Subject: [PATCH] nvme/pci: Poll CQ on timeout
In-Reply-To: <20170420085609.GA6217@linux-x5ow.site>
References: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
 <20170228141017.GC20317@lst.de>
 <20170228160056.GA15639@localhost.localdomain>
 <6c0cacb0-ab91-6270-8bae-dbd18a8dbd0e@fb.com>
 <20170420085609.GA6217@linux-x5ow.site>
Message-ID: <20170420142044.GB21311@localhost.localdomain>

On Thu, Apr 20, 2017@10:56:09AM +0200, Johannes Thumshirn wrote:
> On Tue, Feb 28, 2017@10:44:21AM -0700, Jens Axboe wrote:
> > IMHO that can go at a later time, if we do remove polling for
> > specific entries. For now it's fine.
> > 
> > And I do think this is a nice addition - it's free, and it provides
> > us extra info for debugging an issue. That's a big deal, especially
> > if it's a user report.
> 
> JFYI, we did have I/O timeout issues on one of our internal systems.
> Keith suggested to give this patch a shot and indeed it cought missed IRQs,
> which after being polled at least didn't result in filesystem errors.
> 
> So if you want you can have my:
> Tested-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

Thanks, I forgot about this one, but still think it's a good idea.
Applied it to for-next.
