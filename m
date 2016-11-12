From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 12 Nov 2016 22:58:16 +0200
Subject: [GIT PULL] nvme fabrics patches for the next round of 4.9 rc
In-Reply-To: <56b11145-78ed-aead-2096-e14747d692fc@kernel.dk>
References: <1478678520-26697-1-git-send-email-sagi@grimberg.me>
 <950ac71c-1854-017e-a497-bba97138fa98@kernel.dk>
 <044901d23ba4$a6c59e50$f450daf0$@opengridcomputing.com>
 <56b11145-78ed-aead-2096-e14747d692fc@kernel.dk>
Message-ID: <572146a8-6cd2-e284-fdd8-89c4e84024cd@grimberg.me>


>>> On 11/09/2016 01:02 AM, Sagi Grimberg wrote:
>>>> Hey Jens,
>>>>
>>>> Mostly some stability fixes for fabrics:
>>>> - some memleaks, correctness and verbosity fixes from Bart
>>>> - fix command delivery during queue reconnect from Christoph
>>>> - nvme rdma reconnect vs io race fix from Christoph and steve
>>>> - nvme rdma queue cleanup on connection failure fix from Steve
>>>> - nvme rdma target error flow and queue teardown fixes
>>>> - nvme rdma queue size fix from Samuel
>>>> - nvmet namespace rcu race fix from Sasha
>>>>
>>>> please pull from:
>>>>
>>>>   git://git.infradead.org/nvme-fabrics.git nvmf-4.9-rc
>>>
>>> I'm scanning the list for anything that might NOT be appropriate this
>>> late in the cycle, and I see a few:
>>>
>>>      nvme/scsi: Remove set-but-not-used variables
>>>      nvme-fabrics: Adjust source code indentation
>>>      nvme-rdma: remove redundant define
>>>
>>> I can pull this in for 4.10 without hesistation, but I don't want to
>>> send a pull request for a fairly new feature with 3 of the commits being
>>> cleanups for -rc5.
>>>
>>> Let me know what you want to do.
>>
>> It would be great to get the kato/reconnect fixes in 4.9...
>
> Sagi? I'm sending patches for -rc5 tomorrow. Let's get this batch split
> in a 4.9 and 4.10 chunk.

Hi Jens,

Sorry for the late reply, I've updated nvmf-4.9-rc to contain
only the fixes. I'll start nvmf-4.10 next week.

The diffstats:
----------------------------------------------------------------
Bart Van Assche (4):
       nvmet-rdma: Fix REJ status code
       nvme-fabrics: Fix memory leaks in nvmf_parse_options()
       nvme-fabrics: Fix a memory leak in an nvmf_create_ctrl() error path
       nvmet-rdma: Fix possible NULL deref when handling rdma cm events

Christoph Hellwig (1):
       nvme-rdma: reject non-connect commands before the queue is live

Sagi Grimberg (3):
       nvmet: Don't queue fatal error work if csts.cfs is set
       nvmet-rdma: don't forget to delete a queue from the list of 
connection failed
       nvmet-rdma: drain the queue-pair just before freeing it

Samuel Jones (1):
       nvme-rdma: force queue size to respect controller capability

Solganik Alexander (1):
       nvmet: Fix possible infinite loop triggered on hot namespace removal

Steve Wise (1):
       nvme-rdma: stop and free io queues on connect failure


Thanks,
Sagi.
