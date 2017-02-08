From: hch@lst.de (Christoph Hellwig)
Date: Wed,  8 Feb 2017 14:13:39 +0100
Subject: support for multi-range discard requests V2
Message-ID: <20170208131343.4003-1-hch@lst.de>

Hi all,

this series adds support for merging discontiguous discard bios into a
single request if the driver supports it.  This reduces the number of
discards sent to the device by about a factor of 5-6 for typical
workloads on NVMe, and for slower devices that use I/O scheduling
the number will probably be even bigger but I've not implemented
that support yet.

Changes since V1:
    - hardcoded max ranges for NVMe to 255
    - minor cleanups
