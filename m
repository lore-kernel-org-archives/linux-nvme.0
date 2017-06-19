From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 11:00:34 +0300
Subject: [PATCH rfc 03/30] nvme-rdma: reuse configure/destroy admin queue
In-Reply-To: <20170619072004.GC13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-4-git-send-email-sagi@grimberg.me>
 <20170619072004.GC13168@lst.de>
Message-ID: <71fdef71-24a5-9514-e504-35e7c52b85bc@grimberg.me>


> static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)
> 
> Too long line..
> 
> Also what about moving the helpers into the right place in the
> previous patch that already re-indented most of this?

Sure.
