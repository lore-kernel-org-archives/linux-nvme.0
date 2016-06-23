From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 Jun 2016 10:28:55 +0300
Subject: [PATCH 0/1] Fix for nvme-rdma host crash in nvmf-all.3
In-Reply-To: <cover.1466626499.git.swise@opengridcomputing.com>
References: <cover.1466626499.git.swise@opengridcomputing.com>
Message-ID: <576B8FB7.5000305@grimberg.me>


> This patch fixes a touch-after-free bug I discovered.  It is against
> nvmf-all.3 branch of git://git.infradead.org/nvme-fabrics.git.  The patch
> is kind of ugly, so any ideas on a cleaner solution are welcome.

Hey Steve, I don't see how this bug fixes the root-cause. Not exactly
sure we understand the root-cause. Is it possible that this is a chelsio
specific issue with send completion signaling (like we saw before)? Did
this happen with a non-chelsio device?
