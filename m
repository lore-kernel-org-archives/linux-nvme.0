From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 26 Jun 2018 15:27:25 +0300
Subject: [PATCH 1/1] nvme-rdma: fix WARN_ON condition during RDMA ctrl
 setup
In-Reply-To: <1530015365-30049-1-git-send-email-maxg@mellanox.com>
References: <1530015365-30049-1-git-send-email-maxg@mellanox.com>
Message-ID: <dbeadb2d-b227-d8c0-23e4-dafcf507913d@grimberg.me>


> We can only agree to fail moving to NVME_CTRL_LIVE while we're in
> NVME_CTRL_DELETING for existing controllers. In case we are in the
> initial creation of the controller we never should fail.

A. the change log is incorrect as we do fail, its about the warning
message.

B. What is this designed to warn against? did you actually see this? or
is it to warn if we happened to mess up?
