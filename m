From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Sep 2016 20:38:52 -0700
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
In-Reply-To: <013901d2137b$8f329e10$ad97da30$@opengridcomputing.com>
References: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
 <20160920200803.GA839@lst.de>
 <013901d2137b$8f329e10$ad97da30$@opengridcomputing.com>
Message-ID: <a46d0da7-0695-3745-1bc9-8faf4383fa19@grimberg.me>


>> On Tue, Sep 20, 2016@11:57:28AM -0700, Sagi Grimberg wrote:
>>> When we reconnect we can't really clear the
>>> queue flags (DELETING flag in specific) because
>>> we might end up trigerring a use-after-free condition
>>> if we fail to establish the rdma connection.
>>
>> Can you add a comment explaining this to the assignment?  Looking
>> at the patch it looks like black magic to be, and that's even
>> after reading the above changelog..
>
> Maybe this changelog?
>
>     nvme-rdma: only clear queue flags after successful connect
>
>     Otherwise, nvme_rdma_stop_and_clear_queue() will incorrectly
>     try to stop/free rdma qps/cm_ids that are already freed.

I can modify the change log, Christoph do you still want a
comment in the code?
