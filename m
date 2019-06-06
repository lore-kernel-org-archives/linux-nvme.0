From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jun 2019 08:34:17 +0200
Subject: [PATCH] nvme: introduce nvme_is_fabrics to check fabrics cmd
In-Reply-To: <20190606053014.27240-1-minwoo.im.dev@gmail.com>
References: <20190606053014.27240-1-minwoo.im.dev@gmail.com>
Message-ID: <20190606063417.GA27033@lst.de>

On Thu, Jun 06, 2019@02:30:14PM +0900, Minwoo Im wrote:
> This patch introduces a nvme_is_fabrics() inline function to check
> whether or not the given command structure is for fabrics.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
