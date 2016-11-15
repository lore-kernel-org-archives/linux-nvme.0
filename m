From: hch@lst.de (Christoph Hellwig)
Date: Tue, 15 Nov 2016 19:52:07 +0100
Subject: [PATCH 0/5] ahci: nvme remap support
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20161115185207.GB5854@lst.de>

As it's been a few weeks since this initial posting:  What's the
status of either getting the magic chipset handshake mode published
to take the chipset out of this degraded mode, or implementing a bridge
driver like VMD?

It seems devices supporting this "slow down the devices and make life
hell for the OS" mode are getting more common, so we'll have to do
something about it.
