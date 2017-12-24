From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Dec 2017 10:55:57 +0200
Subject: [PATCH 4.15-rc 2/3] nvme-core/loop/rdma: Host delete_work and
 reset_work on system workqueues
In-Reply-To: <6e87270a-ee67-4b93-e2c3-b977400f9e79@broadcom.com>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-3-sagi@grimberg.me>
 <6e87270a-ee67-4b93-e2c3-b977400f9e79@broadcom.com>
Message-ID: <bd62742a-aea3-e310-9d81-53eb215dd443@grimberg.me>


> Any particular reason you didn't do similar mods for the fc transport ?

AFAICT, fc never flushes the nvme_wq.
