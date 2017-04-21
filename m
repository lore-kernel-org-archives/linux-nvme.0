From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 10:49:58 +0200
Subject: sparse fixes for nvme/fc
Message-ID: <20170421085005.5945-1-hch@lst.de>

[sorry for the double post, the first series got the linux-nvme
 address wrong]

This fixes a couple ?parse warnings in the FC code, missing statics,
missing endianess annotations and incorrect byte swaps.
