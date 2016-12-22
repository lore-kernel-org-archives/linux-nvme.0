From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 22 Dec 2016 04:10:19 -0800
Subject: Q: nvme_rdma and reconnect
In-Reply-To: <9576f8bf-e2df-d00f-edb6-8f17ae188980@grimberg.me>
References: <20161207183947.128897-1-daniel.verkamp@intel.com>
 <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>
 <20161209182827.GA16834@lst.de>
 <7c17a439-5a28-f458-3af7-221d84607611@intel.com>
 <20161221102744.GA30308@lst.de>
 <830460a5-ce31-b882-8f06-4a906763eb50@broadcom.com>
 <20161222064115.GA9581@infradead.org>
 <9576f8bf-e2df-d00f-edb6-8f17ae188980@grimberg.me>
Message-ID: <20161222121019.GA22558@infradead.org>

On Thu, Dec 22, 2016@02:08:44PM +0200, Sagi Grimberg wrote:
> We can go via the same flow and condition on the state for the
> differences, but I'm not sure its easier to understand than two
> distinct routines (although that share a lot of code).

FYI, my attempt back then was to have a shutdown and a connect
method that these two path call, with the hope of folding the initial
connect and final shutdown into it as well, similar to how the PCI
code work.
