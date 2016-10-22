From: hch@lst.de (Christoph Hellwig)
Date: Sat, 22 Oct 2016 08:50:38 +0200
Subject: [PATCH 0/5] ahci: nvme remap support
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20161022065038.GA8547@lst.de>

On Fri, Oct 21, 2016@05:25:21PM -0700, Dan Williams wrote:
> Some Intel ahci implementations have the capability to expose another
> pci-express device's memory resources through an ahci memory bar.  Add
> the enabling to detect these configurations and register the resources
> for the nvme driver to consume. Otherwise, the nvme device is
> effectively hidden from the kernel for this configuration.

Honestly I think this is just too ugly to live. I think people getting
tricked by Intel into buying this piece of junk will just have to live
with AHCI mode.
