From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Sep 2016 12:05:02 -0700
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
In-Reply-To: <011101d21371$722909d0$567b1d70$@opengridcomputing.com>
References: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
 <011101d21371$722909d0$567b1d70$@opengridcomputing.com>
Message-ID: <b4e82aee-b899-e8d1-d579-73480873b75f@grimberg.me>


>> When we reconnect we can't really clear the
>> queue flags (DELETING flag in specific) because
>> we might end up trigerring a use-after-free condition
>> if we fail to establish the rdma connection.
>>
>> Fixes: e89ca58f9c90 ("nvme-rdma: add DELETING queue flag")
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>
> Tests good.
>
> Thanks Sagi!
>
> Tested-by: Steve Wise <swise at opengridcomputing.com>

Thanks Steve,

Jens, can you grab this last minute fix for rc8?

You can pull it from
git://git.infradead.org/nvme-fabrics.git nvmf-4.8-rc

Thanks
