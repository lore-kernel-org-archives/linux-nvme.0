From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 Feb 2017 16:25:31 +0200
Subject: [PATCH 1/2] nvme-loop: retrieve iod from the cqe command_id
In-Reply-To: <20170228140921.GA20317@lst.de>
References: <1488214820-3578-1-git-send-email-sagi@grimberg.me>
 <20170228140921.GA20317@lst.de>
Message-ID: <794b3587-d8fc-2941-e336-e64e75c3512e@grimberg.me>


>> useful to validate that the we didn't mess up
>> the command_id.
>
> But also less efficient, so I don't really see a good reason for it.

Less efficient? I highly doubt this will ever make any noticeable
difference...

I changed that because the blk-mq scheduler facilities broke nvmf and
it took me a while to figure out why loop doesn't break like rdma, but
I really don't see why we do something different from all other
transports, especially since its main usage is testing...

I can drop it if you insist against it but I sorta disagree with
you.
