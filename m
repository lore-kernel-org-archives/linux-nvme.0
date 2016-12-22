From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Dec 2016 22:41:15 -0800
Subject: Q: nvme_rdma and reconnect
In-Reply-To: <830460a5-ce31-b882-8f06-4a906763eb50@broadcom.com>
References: <20161207183947.128897-1-daniel.verkamp@intel.com>
 <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>
 <20161209182827.GA16834@lst.de>
 <7c17a439-5a28-f458-3af7-221d84607611@intel.com>
 <20161221102744.GA30308@lst.de>
 <830460a5-ce31-b882-8f06-4a906763eb50@broadcom.com>
Message-ID: <20161222064115.GA9581@infradead.org>

On Wed, Dec 21, 2016@04:56:41PM -0800, James Smart wrote:
> Sagi, Christoph,
> 
> Can you explain what the difference is between the "reset" path and the
> "error/reconnect" path is in the rdma driver.  From my point of view, it
> would seem both, relative to the fabric-side of the transport, are
> terminating the controller and reconnecting to a new controller to recover.
> So why wouldn't they be the same (single) reset flow ?

They should use the same flow.  A couple month ago I had a prototype
for that but never got it to work fully.
