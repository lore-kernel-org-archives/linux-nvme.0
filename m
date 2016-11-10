From: hch@lst.de (Christoph Hellwig)
Date: Thu, 10 Nov 2016 07:32:32 -0800
Subject: rework NVMe command passthrough V2
Message-ID: <1478791954-30152-1-git-send-email-hch@lst.de>

Hi all,

this series started out as part of my attempt to get rid of the SCSI
passthrough fields in struct request, but reviewing the NVMe FC patches
and subsequent discussion with James gave them additional priority.

This series introduces a nvme_request structure common to all transports,
which allows us to stop abusing the SCSI passthrough fields in struct
request, and also allows us to stop passing the full CQE up to the
callers of the request interface which is rather painful for FC.

Changes since V1:
 - fix AER completions
