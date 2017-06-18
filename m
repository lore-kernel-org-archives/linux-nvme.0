From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 12:27:32 +0300
Subject: [PATCH 2/3] nvme-pci: Add budget to __nvme_process_cq
In-Reply-To: <20170616070427.GB7672@lst.de>
References: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
 <1497548508-29447-3-git-send-email-sagi@grimberg.me>
 <20170616070427.GB7672@lst.de>
Message-ID: <025eee21-bcd3-c3b8-5d7a-a14b5dcfab51@grimberg.me>

>> Prepare for irq-poll logic
> 
> I don't think we should add this until we actually get the irq-poll
> code back on the plate.

Yea, good point...
