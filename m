From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 15 Dec 2017 14:49:37 -0700
Subject: [GIT PULLL] nvme fixes for Linux 4.15
In-Reply-To: <20171215164828.ztoycqf5wettwkkg@infradead.org>
References: <20171215164828.ztoycqf5wettwkkg@infradead.org>
Message-ID: <d0bb89eb-a660-2d09-9662-3c4b6d409958@kernel.dk>

On 12/15/2017 09:48 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below are a couple important one or two liners fixes for Linux 4.15:
> 
> 
> The following changes since commit fcf38cdf332a81b20a59e3ebaea81f6b316bbe0c:
> 
>   kyber: fix another domain token wait queue hang (2017-12-06 12:33:07 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.15
> 
> for you to fetch changes up to 654b4a4acd8b52a4272114b95896e9a10d382cde:
> 
>   nvme: setup streams after initializing namespace head (2017-12-15 15:18:07 +0100)
> 
> ----------------------------------------------------------------
> David Disseldorp (1):
>       nvme: set discard_alignment to zero
> 
> James Smart (1):
>       nvme-fc: remove double put reference if admin connect fails
> 
> Keith Busch (2):
>       nvme: check hw sectors before setting chunk sectors
>       nvme: setup streams after initializing namespace head
> 
> Ming Lei (1):
>       nvme: call blk_integrity_unregister after queue is cleaned up

Thanks, looks fine, pulled for 4.15.

-- 
Jens Axboe
