From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 17:28:06 +0300
Subject: [PATCH v2 0/4] refactor nvme-pci cq processing
Message-ID: <1497796090-14808-1-git-send-email-sagi@grimberg.me>

Some preps for my non-selective polling patches that got
left out. I should revisit those soon.

Changes from v1:
- separated patch #1 into:
  - introduce nvme_ring_cq_doorbell
  - factor out cqe handling
  - factor out the cqe read mechanics
- dropped the budget patch
- got rid of __nvme_process_cq

Sagi Grimberg (4):
  nvme-pci: Introduce nvme_ring_cq_doorbell
  nvme-pci: factor out cqe handling into a dedicated routine
  nvme-pci: factor out the cqe reading mechanics from __nvme_process_cq
  nvme-pci: open-code polling logic in nvme_poll

 drivers/nvme/host/pci.c | 130 ++++++++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 54 deletions(-)

-- 
2.7.4
