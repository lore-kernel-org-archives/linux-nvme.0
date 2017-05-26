From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 26 May 2017 09:12:31 -0600
Subject: [GIT PULL] nvme updates for 4.12-rc3
In-Reply-To: <20170526140933.j6dctw6qdmvuseld@infradead.org>
References: <20170526140933.j6dctw6qdmvuseld@infradead.org>
Message-ID: <52550ccf-393c-6850-e46f-5c899bcb4298@kernel.dk>

On 05/26/2017 08:09 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> a couple of fixes for the next rc on the nvme front.  Various FC
> fixes from James, controller removal fixes from Ming (including a block
> layer patch), a APST related device quirk from Andy, a RDMA fix for
> small queue depth device from Marta, as well as fixes for the lack
> of metadata support in non-PCIe drivers and the printk logging format
> from me.

Pulled, thanks.

-- 
Jens Axboe
