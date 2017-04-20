From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 20 Apr 2017 15:25:54 +0000
Subject: [PATCH 12/23] dm mpath: don't check for req->errors
In-Reply-To: <20170420140316.6546-13-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-13-hch@lst.de>
Message-ID: <1492701953.2642.3.camel@sandisk.com>

On Thu, 2017-04-20@16:03 +0200, Christoph Hellwig wrote:
> We'll get all proper errors reported through ->end_io and ->errors will
> go away soon.

Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
