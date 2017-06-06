From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Jun 2017 14:58:29 +0300
Subject: [PATCH] nvme-pci: avoid 64-bit divisions in the HMB code
In-Reply-To: <20170606095411.22429-1-hch@lst.de>
References: <20170606095411.22429-1-hch@lst.de>
Message-ID: <e21c73eb-f4d9-784c-9ec6-321fa5b7ddd3@grimberg.me>

> [to be folded into "nvme-pci: implement host memory buffer support"]
> 
> Avoid 64-bit division by using shifts instead.  All involved sizez are
> powers of two.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
