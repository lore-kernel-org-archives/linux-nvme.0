From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Oct 2018 00:59:07 +0200
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <0bd80d4b-3ae8-a9e2-c19b-5531fbfac8b3@suse.de>
References: <20180927230557.29444-1-hch@lst.de>
 <0bd80d4b-3ae8-a9e2-c19b-5531fbfac8b3@suse.de>
Message-ID: <20180930225907.GA20144@lst.de>

On Sat, Sep 29, 2018@02:09:15PM +0200, Hannes Reinecke wrote:
> Actually I would love to have some statistic or debug info showing the
> NUMA locality mapping somewhere. Otherwise the admin might have a hard
> time figuring out what's going on here, plus debugging any I/O routing
> issues will be tricky.

You already see the node of the devices in sysfs, so what else do you
think of?
