From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 05 May 2015 13:41:40 -0600
Subject: RFC: struct request cleanups
In-Reply-To: <1429303042-12078-1-git-send-email-hch@lst.de>
References: <1429303042-12078-1-git-send-email-hch@lst.de>
Message-ID: <55491CF4.6060903@kernel.dk>

On 04/17/2015 02:37 PM, Christoph Hellwig wrote:
> The first 5 patches move the magic IDE request types into the old IDE
> driver to keep the core block code clean of them.  Those are basically
> ready to merge, just like the 6th one which is a cleanup on it's own.
>
> The real RFC is the last one which allocates the block_pc specific
> data separately in the callers instead of bloating every struct
> request with it.  I always hated what we did, but with the upcoming
> split of nvme into transports and command sets we'll need a NVME
> equivalent of BLOCK_PC, and as NVMe was designed by crackmonkeys
> dreaming of an ATA controller the "command block" for NVME is even
> bigger than what we have to deal with in SCSI.
>
> Note that the old IDE driver doesn't compile with the last patch
> yet as there are major nightmares to sort out, and BLOCK_PC passthrough
> with dm-multipath doesn't work yet either.  If I get some general
> concensus on the approach I'll fix those of course.

These are nice improvements, it'd be great to get rid of embeeding the 
command block. I have applied 1-6 for 4.2.

-- 
Jens Axboe
