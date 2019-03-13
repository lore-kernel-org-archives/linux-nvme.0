From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:54:53 +0100
Subject: [PATCHBOMB] nvme fixes for 5.1
Message-ID: <20190313175510.20725-1-hch@lst.de>

Hi Jens,

git.infradead.org seems to have some hickups at the moment, so
this bunch of nvme fixes will come in form of a patchbomb instead.

Most important is quirking Write Zeroes on qemu, as the implementation
there is buggy and could lead to ext4 data corruption.  Except for
that we have various other fixes all over the place.
