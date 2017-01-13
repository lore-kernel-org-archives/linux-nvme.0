From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 13 Jan 2017 22:38:18 +0200
Subject: [PATCH 3/6] nvme/pci: Start queues after tagset is updated
In-Reply-To: <1483569671-1462-4-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-4-git-send-email-keith.busch@intel.com>
Message-ID: <54faf39b-d632-0664-034a-e3c89bbabe5b@grimberg.me>


> We need to leave the block queues stopped if we're changing the tagset's
> number of queues.

Umm, Don't we need to fail these requests? What am I missing?
Won't these requests block until timeout expiration and will
trigger error recovery again?
