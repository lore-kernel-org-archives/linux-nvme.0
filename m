From: hch@lst.de (Christoph Hellwig)
Date: Fri,  2 Dec 2016 19:31:00 +0100
Subject: detect and warn about ahci-remapped NVMe devices
Message-ID: <1480703463-17489-1-git-send-email-hch@lst.de>

Just a small band-aid to detect the AHCI-remapped NVMe devices
for now.  Hopefully we'll eventually get a fake PCIe root port
driver ala VMD for them.
