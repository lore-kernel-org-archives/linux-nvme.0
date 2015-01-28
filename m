From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Jan 2015 15:11:09 +0000 (UTC)
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <yq1zj93iszd.fsf@sermon.lab.mkp.net>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 <yq1zj93iszd.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>

On Tue, 27 Jan 2015, Martin K. Petersen wrote:
>>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:
> Keith,
>
> Keith> I can't register with the blk-integrity extentions until after
> Keith> add_disk is completed because the disk's kobj needs to be
> Keith> initialized before blk_integrity_register. The 'add_disk' itself
> Keith> submits a lot of reads, though. Am I missing something, or how
> Keith> could those succeed when the block device's required integrity
> Keith> format hasn't been setup?
>
> Protection is optional and enabled on a per-I/O basis. Even if the block
> layer's auto protection is enabled it is normal to see a flutter of
> unprotected reads while partitions are being scanned.

Thanks for the info. NVMe doesn't appear to allow disabling metadata
per-io except for a subset of formats. If that's correct, this driver
would have to provide a valid protection buffer for all IO. Checking
with committee comrades for clarification.
