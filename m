From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 22 Dec 2016 04:50:23 -0800
Subject: Q: nvme_rdma and reconnect
In-Reply-To: <0dcc2dab-378e-aae0-742d-a688928249a1@suse.de>
References: <20161207183947.128897-1-daniel.verkamp@intel.com>
 <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>
 <20161209182827.GA16834@lst.de>
 <7c17a439-5a28-f458-3af7-221d84607611@intel.com>
 <20161221102744.GA30308@lst.de>
 <830460a5-ce31-b882-8f06-4a906763eb50@broadcom.com>
 <20161222064115.GA9581@infradead.org>
 <9576f8bf-e2df-d00f-edb6-8f17ae188980@grimberg.me>
 <0dcc2dab-378e-aae0-742d-a688928249a1@suse.de>
Message-ID: <20161222125023.GA19717@infradead.org>

On Thu, Dec 22, 2016@01:46:10PM +0100, Hannes Reinecke wrote:
> And keeping in mind that the reset path will be a killer for any prospective
> multipath scenario; if you need to remove the device to reset you are
> guaranteed to _never_ get it back under memory pressure.

No one talked about removing the device, just shutting down the
instance of the controller.  We need a clean slate to reconnect as all
our RDMA QPs are toast once an error happens by design of IB Verbs.
