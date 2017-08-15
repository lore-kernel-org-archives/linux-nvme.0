From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 15 Aug 2017 12:08:47 +0300
Subject: [PATCH 1/1] nvme-rdma: Use unlikely macro in the fast path
In-Reply-To: <1502713766-10055-1-git-send-email-maxg@mellanox.com>
References: <1502713766-10055-1-git-send-email-maxg@mellanox.com>
Message-ID: <407fda2c-b54d-a4a6-7504-a7fc51a416f5@grimberg.me>

> This patch slightly improves performance (mainly for small block sizes).

This looks fine,

Looks fine,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

Since you mentioned it, can you quantify what that bought us?
