From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 4 May 2017 14:30:37 +0300
Subject: [PATCH 10/11] nvme: queue ns scanning and async request from
 nvme_wq
In-Reply-To: <20170504112122.GF9686@lst.de>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
 <1493893995-27063-11-git-send-email-sagi@grimberg.me>
 <20170504112122.GF9686@lst.de>
Message-ID: <45282022-d55b-77d3-a1d7-89e0985f6ee2@grimberg.me>


> Did you check that this won't create conflicts with other nvme
> actions (e.g. reset)?  I remember some issues in the past, but I'd
> have to look up the details.

I gave it some thought, due to the fact that we use a multi-threaded
workqueue I think there shouldn't be any problem.

I would have been taking the safe side if we had something like a
system_mem_reclaim_wq...
