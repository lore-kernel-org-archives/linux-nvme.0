From: m.mizuma@jp.fujitsu.com (Masayoshi Mizuma)
Date: Fri, 8 Jul 2016 08:51:46 +0900
Subject: WARN_ON hit on __blk_mq_run_hw_queue followed by an Oops
In-Reply-To: <87r3b85535.fsf@linux.vnet.ibm.com>
References: <87wplqij40.fsf@linux.vnet.ibm.com>	<577B6F0C.4010506@jp.fujitsu.com>
 <87r3b85535.fsf@linux.vnet.ibm.com>
Message-ID: <577EEB12.7010202@jp.fujitsu.com>

 
On Tue, 5 Jul 2016 15:10:06 -0300 Gabriel Krisman Bertazi wrote:
> Masayoshi Mizuma <m.mizuma at jp.fujitsu.com> writes:
> 
>> Is this WARN_ON still appear in 4.7-rc6 ?
>> If so, the following patch may fix this problem.
>>
>> http://lists.infradead.org/pipermail/linux-nvme/2016-July/005303.html
> 
> Hi,
> 
> I experimented with this patch before and I still could see the issue.
> 
> The warning is not the only symptom anymore, as we also may reach a
> deadlock while waiting for queues to freeze in the
> blk_mq_queue_reinit_notify path. This may or may not be related.

I understand. Thanks.

> 
> Things are a little confusing yet, but I'm debugging it and made a good
> progress on avoiding the warning.  I'll submit a patch soon.

That's good news :-)

- Masayoshi Mizuma

> 
> Thanks,
> 
