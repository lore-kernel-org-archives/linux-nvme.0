From: hch@lst.de (Christoph Hellwig)
Date: Wed,  5 Apr 2017 19:18:07 +0200
Subject: ->retries fixups V2
Message-ID: <20170405171812.19911-1-hch@lst.de>

This series fixes a few lose bits in terms of how nvme uses ->retries,
including fixing it for non-PCIe transports.  While at it I noticed that
nvme and scsi use the field in entirely different ways, and no other
driver uses it at all.  So I decided to move it into the nvme_request and
scsi_request structures instead.

Changes since V1:
 - better changelog for one patch
 - move the new retries field to the end of struct nvme_request
