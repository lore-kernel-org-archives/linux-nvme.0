From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 16:24:50 +0100
Subject: fix discard and write zeroes configureation for multipath devices
Message-ID: <20190312152453.9550-1-hch@lst.de>

Hi all,

this series is based on earlier patches from Sagi and fixes up
nvme_update_disk_info so that we properly configure discard and
write zeroes for the multipath device node.
