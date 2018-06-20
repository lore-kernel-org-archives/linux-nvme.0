From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Jun 2018 10:21:21 +0200
Subject: [PATCH V4] nvmet: add buffered I/O support for file backed ns
In-Reply-To: <20180620040141.9553-1-chaitanya.kulkarni@wdc.com>
References: <20180620040141.9553-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180620082121.GA3033@lst.de>

> +		ns->file_wq = alloc_workqueue("nvmet-file",
> +				WQ_UNBOUND_MAX_ACTIVE | WQ_MEM_RECLAIM, 0);

The WQ_UNBOUND_MAX_ACTIVE here looks bogus, as far as I can tell it
isn't a flag for alloc_workqueue but needs to be passed as the last
argument.

I've removed it for now, and applied the patch with a few minor cleanups
to the nvme-4.19 branch.
