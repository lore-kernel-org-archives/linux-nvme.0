From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 27 May 2016 00:34:14 -0700
Subject: [PATCHv2] NVMe: Sync reset and scan work
In-Reply-To: <1464102370-11283-1-git-send-email-keith.busch@intel.com>
References: <1464102370-11283-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160527073414.GA950@infradead.org>

As mentioned before I like this a lot, but not that I looked into
porting this over to Fabrics I have a few more nitpicks..

 - we really should go through nvme_reset_ctrl and thus the
   nvme_reset_ctrl for all places that schedule a reset
 - past that the transitions should be tightened so that we
   can only transition from SCHED_RESET to RESETTING, and the
   check for NVME_CTRL_RESETTING in the beginning of nvme_reset_work
   can go away.
 - isn't the flushing of the scan work better done from the
   reset work so that we don't block the caller?
