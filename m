From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Oct 2016 01:58:08 +0300
Subject: [PATCH 2/2] nvme: Delete created IO queues on reset
In-Reply-To: <1475699566-5284-2-git-send-email-keith.busch@intel.com>
References: <1475699566-5284-1-git-send-email-keith.busch@intel.com>
 <1475699566-5284-2-git-send-email-keith.busch@intel.com>
Message-ID: <6768e355-6c6d-6b87-c1e0-3f6cbad4e8e5@grimberg.me>

> Commit c21377f8 (Suspend all queues before deletion) decrements the
> online queue count prior to our attempt to delete those IO queues, so
> the driver ended up not having the controller delete any. This patch
> uses the queue_count instead of online_queues.

A fixes tag would be useful here.

Other than that looks good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
