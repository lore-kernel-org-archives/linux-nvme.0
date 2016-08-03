From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 Aug 2016 13:37:00 +0300
Subject: [PATCH] nvmet-rdma: Don't use the inline buffer in order to avoid
 allocation for small reads
In-Reply-To: <20160803094941.GA11821@lst.de>
References: <1470040599-7294-1-git-send-email-sagi@grimberg.me>
 <20160802125042.GB13235@lst.de>
 <157675f0-0576-1cc9-1f99-c0944185e3c5@grimberg.me>
 <20160802161526.GA14964@obsidianresearch.com> <20160803094941.GA11821@lst.de>
Message-ID: <6b40dd46-a334-09b6-f359-b7a0f2ee0d9d@grimberg.me>


>>> that is currently being sent (its a rare race condition, but
>>> theoretically possible). The reason is that we repost the inline data
>>> buffer for receive before we post the send request. We used to have
>>
>> ?? The same buffer is posted at the same time for send and recv? That
>> is never OK, SRQ or not.
>
> We will never POST it for a SEND, but it would be used as the target
> of RDMA READ / WRITE operations.

Jason's comment still holds.
