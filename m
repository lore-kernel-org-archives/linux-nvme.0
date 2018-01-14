From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 18:47:05 +0200
Subject: [PATCH 1/1] nvme-rdma: fix possible list_del corruption while
 freeing ctrl
In-Reply-To: <1515947767-7701-1-git-send-email-maxg@mellanox.com>
References: <1515947767-7701-1-git-send-email-maxg@mellanox.com>
Message-ID: <862de718-adb0-c61c-b758-09381a0c5d42@grimberg.me>


> In case of concurrent calls to nvme_rdma_free_ctrl will occur,
> we may end up with a wrong and non-protected check for list emptiness.
> For current implementation, this is only for good practice.

.free_ctrl is called from a single call-site serialized by a refcount
so we don't have concurrent access by design, so I'm not sure I
understand why this makes sense.
