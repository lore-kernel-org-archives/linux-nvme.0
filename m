From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Dec 2017 15:13:58 +0100
Subject: [PATCH 6/6] nvme: remove .init_request callback
In-Reply-To: <20171212110232.12495-7-ming.lei@redhat.com>
References: <20171212110232.12495-1-ming.lei@redhat.com>
 <20171212110232.12495-7-ming.lei@redhat.com>
Message-ID: <20171212141358.GB7849@lst.de>

On Tue, Dec 12, 2017@07:02:32PM +0800, Ming Lei wrote:
> It may cause race by setting 'nvmeq' in nvme_init_request()
> because .init_request is called inside switching io scheduler, which
> may happen when the NVMe device is being resetted and its nvme queues
> are being freed and created. We don't have any sync between the two
> pathes.
> 
> This patch removes the .init_request callback and sets the nvmeq runtime,
> and fixes the following bug:

If ->init_request doesn't work for NVMe it won't work for any other
driver either, so we need to remove it entirely if we can't fix it.

I'd much rather try to fix it first, though.
