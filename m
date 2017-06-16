From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 09:04:09 +0200
Subject: [PATCH 1/3] nvme-pci: Split __nvme_process_cq to poll and handle
In-Reply-To: <1497548508-29447-2-git-send-email-sagi@grimberg.me>
References: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
 <1497548508-29447-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170616070408.GA7672@lst.de>

I like this split, but I think the patch as-is is not easily
verifyable.  Can you break it out by splitting out one helper
at a time, e.g.

 patch 1: introduce nvme_ring_cq_doorbell
 patch 2: introduce nvme_handle_cqe
 patch 3: introduce nvme_read_cqe

Also there seems ot be no reason in the this patch to change the
__nvme_process_cq and nvme_process_cq return values.
