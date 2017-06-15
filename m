From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 20:41:45 +0300
Subject: [PATCH 0/3] refactor nvme-pci cq processing
Message-ID: <1497548508-29447-1-git-send-email-sagi@grimberg.me>

Some preps for my non-selective polling patches that got
left out. I should revisit those soon.

Sagi Grimberg (3):
  nvme-pci: Split __nvme_process_cq to poll and handle
  nvme-pci: Add budget to __nvme_process_cq
  nvme-pci: open-code polling logic in nvme_poll

 drivers/nvme/host/pci.c | 136 ++++++++++++++++++++++++++++++------------------
 1 file changed, 84 insertions(+), 52 deletions(-)

-- 
2.7.4
