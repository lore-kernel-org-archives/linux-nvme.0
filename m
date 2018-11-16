From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Nov 2018 14:08:03 +0100
Subject: provide slaves/holders links for multipath devices
Message-ID: <20181116130805.16225-1-hch@lst.de>

Hi all,

a while ago Thadeu reported installer problems because nvme multipath
didn't provide slaves/holders links for the underlying devices.

This is because for one Tejun said the API shall not be used for new
users, but also because it currently hangs off the block_device
structure, which has a too short lifetime.

This series ignores Tejuns advice given that these links are the
defacto API for stacked block devices, moves the tracking to struct
hd_struct, and makes it work on NVMe multipath.
