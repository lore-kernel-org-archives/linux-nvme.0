From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Oct 2017 01:56:53 -0700
Subject: [PATCH v4] nvmet: synchronize sqhd update
In-Reply-To: <20171018213359.3587-1-jsmart2021@gmail.com>
References: <20171018213359.3587-1-jsmart2021@gmail.com>
Message-ID: <20171019085653.GA2622@infradead.org>

On Wed, Oct 18, 2017@02:33:59PM -0700, James Smart wrote:
> In testing target io in read write mix, we did indeed get into cases
> where sqhd didn't update properly and slowly missed enough updates to
> shutdown the queue.
> 
> Protect the updating sqhd by using cmpxchg
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Applied to nvme-4.14 with a small changelog fixup.
