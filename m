From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 29 Mar 2019 10:29:25 +0000
Subject: [PATCH 1/2] nvme: add per-device io and admin timeouts
In-Reply-To: <20190329094440.GA27315@lst.de>
References: <20190329093921.95710-1-mheyne@amazon.de>
 <20190329094440.GA27315@lst.de>
Message-ID: <b6fd1c99f0a718033ee44ba8ff233dacd7247f15.camel@infradead.org>

On Fri, 2019-03-29@10:44 +0100, Christoph Hellwig wrote:
> On Fri, Mar 29, 2019@09:39:20AM +0000, Maximilian Heyne wrote:
> > Some NVMe devices require specific io and admin timeouts that are
> > different from the default, for instance local vs. remote storage.
> > 
> > This patch adds per-device admin and io timeouts to the nvme_ctrl
> > structure and replaces all usages of the module parameters in the PCI
> > NVMe driver with the per-device timeouts.
> 
> I'm not all against a per-controller override, but if you controllers
> really _require_ a different timeout this is not the way to go.
> 
> Please talk to the nvme technical working group about exposing a
> default timeout in the controller as that is the only way to make
> these things work out of box.


Yeah, that's a good idea and would work well on top of these patches
when it eventually gets through the process.

In the meantime, people running Linux in certain environments are
having to hack their kernel to change the default timeout. Being able
to do it through sysfs is much saner.

Max, we should probably also implement this for at least the TCP back
end, which is going to want it for much the same reasons we do, and it
really does want to be tunable by the user there (and should probably
remain so in the general case even when we do improve the spec).


Note that this isn't strictly "required" but if your transport has a
SLA which permits outages of a certain period of time (for example
however long it takes a switch to restart), then having the NVMe
timeout exceed that value is kind of nice.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190329/9aaa884f/attachment.bin>
