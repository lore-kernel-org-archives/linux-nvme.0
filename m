From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed,  7 Aug 2019 17:51:18 +1000
Subject: [PATCH v4 0/4] nvme-pci: Support for Apple 201+ (T2 chip) 
Message-ID: <20190807075122.6247-1-benh@kernel.crashing.org>

This series combines the original series and an updated version of the
shared tags patch, and is rebased on nvme-5.4.

This adds support for the controller found in recent Apple machines
which is basically a SW emulated NVME controller in the T2 chip.

The original reverse engineering work was done by
Paul Pawlowski <paul at mrarm.io>.
