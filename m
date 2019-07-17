From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 17 Jul 2019 20:42:58 +0900
Subject: [PATCH v2 1/3] nvme-pci: Pass the queue to SQ_SIZE/CQ_SIZE macros
In-Reply-To: <20190717004527.30363-1-benh@kernel.crashing.org>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
Message-ID: <20190717114258.GA10495@minwoo-desktop>

On 19-07-17 10:45:25, Benjamin Herrenschmidt wrote:
> This will make it easier to handle variable queue entry sizes
> later. No functional change.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
