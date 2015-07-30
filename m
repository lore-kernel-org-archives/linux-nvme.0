From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 30 Jul 2015 18:02:38 -0400
Subject: [PATCHv2] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <1438285118-24146-1-git-send-email-keith.busch@intel.com> (Keith
 Busch's message of "Thu, 30 Jul 2015 13:38:38 -0600")
References: <1438285118-24146-1-git-send-email-keith.busch@intel.com>
Message-ID: <yq1d1z9l2wx.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Maybe virt_boundary_mask to make it symmetric with seg_boundary_mask?

Otherwise it looks OK.

-- 
Martin K. Petersen	Oracle Linux Engineering
