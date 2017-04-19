From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 19 Apr 2017 21:02:33 +0000
Subject: [PATCH 01/23] pd: don't check blk_execute_rq return value.
In-Reply-To: <20170419192708.22098-2-hch@lst.de>
References: <20170419192708.22098-1-hch@lst.de>
 <20170419192708.22098-2-hch@lst.de>
Message-ID: <1492635752.2543.16.camel@sandisk.com>

On Wed, 2017-04-19@21:26 +0200, Christoph Hellwig wrote:
> The driver never sets req->errors, so blk_execute_rq will always return 0.

Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
