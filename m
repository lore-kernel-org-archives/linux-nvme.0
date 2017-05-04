From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 4 May 2017 15:02:15 +0300
Subject: [PATCH 10/11] nvme: queue ns scanning and async request from
 nvme_wq
In-Reply-To: <45282022-d55b-77d3-a1d7-89e0985f6ee2@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
 <1493893995-27063-11-git-send-email-sagi@grimberg.me>
 <20170504112122.GF9686@lst.de>
 <45282022-d55b-77d3-a1d7-89e0985f6ee2@grimberg.me>
Message-ID: <4f2d4571-13e1-3429-a8b5-73901507533b@grimberg.me>


>> Did you check that this won't create conflicts with other nvme
>> actions (e.g. reset)?

And yes, I did check controller resets and delete.
