From: m@bjorling.me (Matias Bjorling)
Date: Wed, 10 Jun 2015 20:11:42 +0200
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <20150609074643.GA5707@infradead.org>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <20150609074643.GA5707@infradead.org>
Message-ID: <55787DDE.7020801@bjorling.me>

On 06/09/2015 09:46 AM, Christoph Hellwig wrote:
> Hi Matias,
> 
> I've been looking over this and I really think it needs a fundamental
> rearchitecture still.  The design of using a separate stacking
> block device and all kinds of private hooks does not look very
> maintainable.
> 
> Here is my counter suggestion:
> 
>  - the stacking block device goes away
>  - the nvm_target_type make_rq and prep_rq callbacks are combined
>    into one and called from the nvme/null_blk ->queue_rq method
>    early on to prepare the FTL state.  The drivers that are LightNVM
>    enabled reserve a pointer to it in their per request data, which
>    the unprep_rq callback is called on durign I/O completion.
> 

I agree with this, if it only was a common FTL that would be
implemented. This is maybe where we start, but what I really want to
enable is these two use-cases:

1. A get/put flash block API, that user-space applications can use.
That will enable application-driven FTLs. E.g. RocksDB can be integrated
tightly with the SSD. Allowing data placement and garbage collection to
be strictly controlled. Data placement will reduce the need for
over-provisioning, as data that age at the same time are placed in the
same flash block, and garbage collection can be scheduled to not
interfere with user requests. Together, it will remove I/O outliers
significantly.

2. Large drive arrays with global FTL. The stacking block device model
enables this. It allows an FTL to span multiple devices, and thus
perform data placement and garbage collection over tens to hundred of
devices. That'll greatly improve wear-leveling, as there is a much
higher probability of a fully inactive block with more flash.
Additionally, as the parallelism grows within the storage array, we can
slice and dice the devices using the get/put flash block API and enable
applications to get predictable performance, while using large arrays
that have a single address space.

If it too much for now to get upstream, I can live with (2) removed and
then I make the changes you proposed.

What do you think?

Thanks
-Matias
