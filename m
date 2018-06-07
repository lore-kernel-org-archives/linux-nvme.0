From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:55:37 +0200
Subject: [PATCH 05/10] nvme: add ANA support
In-Reply-To: <20180607130559.GA13101@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-6-hch@lst.de>
 <56eca832-5b3c-9ba8-c953-924f3fb7609f@grimberg.me>
 <20180607130559.GA13101@lst.de>
Message-ID: <20180607135537.GA3882@lst.de>

On Thu, Jun 07, 2018@03:05:59PM +0200, Christoph Hellwig wrote:
> It makes sense, except that we it would take a lot of effort to figure
> out what namespace actually changed due to the group indirection.
> 
> What we can do more easily is to only kick it off again on live
> namespaces, so I'll look into that.

The requeue_work will skip before incrementing the retry counter,
so this is not actually an issue.  It might still be nice to
avoid a whole lot of work for the case where there is no live
path, so maybe we can do something about it.
