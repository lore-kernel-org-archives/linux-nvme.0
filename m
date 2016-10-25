From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Oct 2016 18:09:37 +0200
Subject: rework NVMe command passthrough
Message-ID: <1477411779-2993-1-git-send-email-hch@lst.de>

Hi all,

this series started out as part of my attempt to get rid of the SCSI
passthrough fields in struct request, but reviewing the NVMe FC patches
and subsequent discussion with James gave them additional priority.

This series introduce? a nvme nvme_request structure common to all
transports, which allows us to stop abusing the SCSI passthrough fields
in struct request, and also allows us to stop passing the full CQE
up to the callers of the request interface which is rather painful
for FC.
