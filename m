From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 6 Aug 2019 10:42:09 +0800
Subject: [PATCH 1/2] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
References: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
Message-ID: <d6ef0513-b271-6cb4-b1fb-aaed071cab91@mellanox.com>

The series looks good (sorry for not reviewing internally :))

please add to the v2:

connect example for the kernel commit message (rdma + tcp) and please 
show how the TOS influence on the traffic:

e.g. 80% to ctrl_1 and 20% to ctrl_2.



Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
