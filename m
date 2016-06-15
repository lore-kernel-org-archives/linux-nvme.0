From: hch@lst.de (Christoph Hellwig)
Date: Wed, 15 Jun 2016 12:28:35 +0200
Subject: [PATCH] nvme-rdma: don't use IB-CM status code in reject path
In-Reply-To: <20160614175333.853CCE0753@smtp.ogc.us>
References: <20160614175333.853CCE0753@smtp.ogc.us>
Message-ID: <20160615102835.GA16828@lst.de>

On Sun, Jun 12, 2016@11:53:17PM -0700, Steve Wise wrote:
> Instead, check the private data length to determine if there
> is private data in the reject.
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>

Thanks Steve,

applied.
