From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Dec 2017 17:30:35 +0200
Subject: [PATCH] Revert "nvme: allow controller RESETTING to RECONNECTING
 transition"
In-Reply-To: <20171207143450.7005-1-nitzanc@mellanox.com>
References: <20171207143450.7005-1-nitzanc@mellanox.com>
Message-ID: <3af89c7d-5faa-b0ea-9ab3-4531599b24d4@grimberg.me>

This breaks fc so NAK...

You need to fix rdma to make sure reconnect and err works
are flushed before moving forward (I think it does but might
need to move earlier.
