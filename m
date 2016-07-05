From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Tue, 05 Jul 2016 15:10:06 -0300
Subject: WARN_ON hit on __blk_mq_run_hw_queue followed by an Oops
In-Reply-To: <577B6F0C.4010506@jp.fujitsu.com> (Masayoshi Mizuma's message of
 "Tue, 5 Jul 2016 17:25:48 +0900")
References: <87wplqij40.fsf@linux.vnet.ibm.com>
 <577B6F0C.4010506@jp.fujitsu.com>
Message-ID: <87r3b85535.fsf@linux.vnet.ibm.com>

Masayoshi Mizuma <m.mizuma at jp.fujitsu.com> writes:

> Is this WARN_ON still appear in 4.7-rc6 ?
> If so, the following patch may fix this problem.
>
> http://lists.infradead.org/pipermail/linux-nvme/2016-July/005303.html

Hi,

I experimented with this patch before and I still could see the issue.

The warning is not the only symptom anymore, as we also may reach a
deadlock while waiting for queues to freeze in the
blk_mq_queue_reinit_notify path. This may or may not be related.

Things are a little confusing yet, but I'm debugging it and made a good
progress on avoiding the warning.  I'll submit a patch soon.

Thanks,

-- 
Gabriel Krisman Bertazi
