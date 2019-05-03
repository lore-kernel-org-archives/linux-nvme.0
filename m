From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 3 May 2019 05:29:02 -0700
Subject: [PATCH v2 06/10] nvme/core: add mdev interfaces
In-Reply-To: <20190502114801.23116-7-mlevitsk@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190502114801.23116-7-mlevitsk@redhat.com>
Message-ID: <20190503122902.GA5081@infradead.org>

On Thu, May 02, 2019@02:47:57PM +0300, Maxim Levitsky wrote:
> If the mdev device driver also sets the
> NVME_F_MDEV_DMA_SUPPORTED, the mdev core will
> dma map all the guest memory into the nvme device,
> so that nvme device driver can use dma addresses as passed
> from the mdev core driver

We really need a proper block layer interface for that so that
uring or the nvme target can use pre-mapping as well.
