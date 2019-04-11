From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Apr 2019 00:51:24 +0900
Subject: [PATCH 0/2] nvme: pci: Fix queue_count parameter
Message-ID: <20190411155126.948-1-minwoo.im.dev@gmail.com>

The first patch will make it return an error if given value is larger
than number of possible cpus.  It has not been doing anything about it.

The second patch is just a nit for clean-up of local variable.  It does
not need to be initialized in this scope because kstrtoint() will return
an error if it fails without referring local variable after it.

Minwoo Im (2):
  nvme: pci: Return -EINVAL if given nr_queue larger than nr_cpu
  nvme: pci: Do not initialize local_var

 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1
