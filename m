From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Mar 2019 10:44:40 +0100
Subject: [PATCH 1/2] nvme: add per-device io and admin timeouts
In-Reply-To: <20190329093921.95710-1-mheyne@amazon.de>
References: <20190329093921.95710-1-mheyne@amazon.de>
Message-ID: <20190329094440.GA27315@lst.de>

On Fri, Mar 29, 2019@09:39:20AM +0000, Maximilian Heyne wrote:
> Some NVMe devices require specific io and admin timeouts that are
> different from the default, for instance local vs. remote storage.
> 
> This patch adds per-device admin and io timeouts to the nvme_ctrl
> structure and replaces all usages of the module parameters in the PCI
> NVMe driver with the per-device timeouts.

I'm not all against a per-controller override, but if you controllers
really _require_ a different timeout this is not the way to go.

Please talk to the nvme technical working group about exposing a
default timeout in the controller as that is the only way to make
these things work out of box.
