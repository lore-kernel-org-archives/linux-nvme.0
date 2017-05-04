From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 4 May 2017 14:20:19 +0300
Subject: [PATCH 00/11] a few useful nvme fixes and cleanups
In-Reply-To: <20170504111127.GA9301@lst.de>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
 <20170504111127.GA9301@lst.de>
Message-ID: <18acd434-17dd-158c-121d-cc26a9d70426@grimberg.me>


>> Some patches I've been sitting on for that past two weeks.
>
> What's your target for these?  A few look like 4.12 material for
> sure, but some look like material for the next merge window.

Nothing here is 4.12 material I think.

Only patch 10/11 fixes a real bug if I'm not wrong. Note that I've
triggered it only with loop which before patch 9/11 didn't even use a
WQ_MEM_RECLAIM workqueue, but once I converted it to use that, it
easily triggered the warning which I think can easily happen if the pci
driver happens to call nvme_uninit_ctrl when a ns scan is running
(system_wq is not WQ_MEM_RECLAIM).
