From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 27 Jan 2015 20:39:18 -0500
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 (Keith Busch's message of "Wed, 28 Jan 2015 01:21:02 +0000 (UTC)")
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
Message-ID: <yq1zj93iszd.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith,

Keith> I can't register with the blk-integrity extentions until after
Keith> add_disk is completed because the disk's kobj needs to be
Keith> initialized before blk_integrity_register. The 'add_disk' itself
Keith> submits a lot of reads, though. Am I missing something, or how
Keith> could those succeed when the block device's required integrity
Keith> format hasn't been setup?

Protection is optional and enabled on a per-I/O basis. Even if the block
layer's auto protection is enabled it is normal to see a flutter of
unprotected reads while partitions are being scanned.

-- 
Martin K. Petersen	Oracle Linux Engineering
