From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 18:33:05 +0000 (UTC)
Subject: [PATCH] NVMe: avoid kmalloc/kfree for smaller IO
In-Reply-To: <CANvN+end4BQMAeBZKggbA8k+gjQzKj2xYx+=hovbTvmK_GH4Ug@mail.gmail.com>
References: <20150122043805.GA12546@kernel.dk>
 <alpine.LNX.2.00.1501221702170.15481@localhost.lm.intel.com>
 <CANvN+end4BQMAeBZKggbA8k+gjQzKj2xYx+=hovbTvmK_GH4Ug@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1501221823430.15481@localhost.lm.intel.com>

On Thu, 22 Jan 2015, Andrey Kuzmin wrote:
> On Jan 22, 2015 8:27 PM, "Keith Busch" <keith.busch@intel.com> wrote:
> > On Wed, 21 Jan 2015, Jens Axboe wrote:
> >>
> >> Currently we allocate an nvme_iod for each IO, which holds the
> >> sg list, prps, and other IO related info. Set a threshold of
> >> 2 pages and/or 8KB of data, below which we can just embed this
> >> in the per-command pdu in blk-mq. For any IO at or below
> >> NVME_INT_PAGES and NVME_INT_BYTES, we save a kmalloc and kfree.
> >>
> >> For higher IOPS, this saves up to 1% of CPU time.
> >>
> >> Signed-off-by: Jens Axboe <axboe at fb.com>
> >>
> >> ----
> >
> >
> >> +/*
> >> + * Max size of iod being embedded in the request payload
> >> + */
> >> +#define NVME_INT_PAGES? ? ? ? ?2
> >> +#define NVME_INT_BYTES? ? ? ? ?(NVME_INT_PAGES * PAGE_CACHE_SIZE)
> >
> >
> > I think the above needs to use what the device thinks a page size, right? If
> > there's a mismatched host-device page size, nvme_setup_prps could end up
> > accessing a non-existent prp list.
> >
> 
> AFAIR, per spec NVMe device operates in system page size terms.

That's the ideal situation, but the device and system don't always have
the same capabilities. Pretty much every nvme controller supports 4k,
and for many, that's all they understand. Some archs use 8k pages, so
we have to split a system page into two logical pages when setting up
the PRPs. The alternative is to not work at all, but the sales people
didn't like that idea.
