From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 13 Mar 2019 12:06:16 -0600
Subject: [PATCHBOMB] nvme fixes for 5.1
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <ea9bce39-20aa-d8ba-4f0c-8fbd05839d0f@kernel.dk>

On 3/13/19 11:54 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> git.infradead.org seems to have some hickups at the moment, so
> this bunch of nvme fixes will come in form of a patchbomb instead.
> 
> Most important is quirking Write Zeroes on qemu, as the implementation
> there is buggy and could lead to ext4 data corruption.  Except for
> that we have various other fixes all over the place.

Applied, thanks.

-- 
Jens Axboe
