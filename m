From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 17 Dec 2018 05:56:31 -0700
Subject: [PATCH 2/2] nvme-pci: don't share queue maps
In-Reply-To: <20181217111627.22635-2-hch@lst.de>
References: <20181217111627.22635-1-hch@lst.de>
 <20181217111627.22635-2-hch@lst.de>
Message-ID: <158707fb-7fb4-ac6f-a118-dd9892f3da36@kernel.dk>

On 12/17/18 4:16 AM, Christoph Hellwig wrote:
> Now that the block layer checks if a queue map has any queues inside
> it there is no more reason to duplicate the maps for the non-default
> types.

Applied, thanks.

-- 
Jens Axboe
