From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 31 Dec 2018 23:58:28 -0800
Subject: [PATCH 0/2] two nvme-tcp small fixes
Message-ID: <20190101075830.27560-1-sagi@grimberg.me>

Left overs from when I had the nvme-tcp on top of centralized
reset/error-recovery flows. In essence, these shouldn't exist
in a transport driver.

Sagi Grimberg (2):
  nvme-tcp: remove dead code
  nvme-tcp: don't ask if controller is fabrics

 drivers/nvme/host/tcp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

-- 
2.17.1
