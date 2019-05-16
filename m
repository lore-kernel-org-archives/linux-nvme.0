From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 17 May 2019 02:23:48 +0900
Subject: [PATCH 0/2] nvme-cli: fix disconnect-all for pcie tp
Message-ID: <20190516172350.11864-1-minwoo.im.dev@gmail.com>

The first patch fixes that it tries to delete_controller even it's a
controller with PCIe transport type.  If so, the rest of the controller
with fabrics type might not be disconnected properly.

The second one is just a trivial clean-up patch.

Minwoo Im (2):
  nvme-cli: don't try to disconnect for ctrl with pcie transport
  nvme-cli: remove unnecessary initialize of local var

 fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.21.0
