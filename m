From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu,  2 May 2019 14:31:32 +0300
Subject: [PATCH 0/2] Few NVME fixes
Message-ID: <20190502113134.20835-1-mlevitsk@redhat.com>

Hi,

I am sending here two fixes for bugs I found during develpment of nvme-mdev
driver.
Patches are based on http://git.infradead.org/nvme.git nvme-5.2


Best regards,
	Maxim Levitsky


Maxim Levitsky (2):
  nvme/pci: init shadow doorbell after each reset
  nvme/pci: add known admin effects to augument admin effects log page

 drivers/nvme/host/core.c | 4 ++--
 drivers/nvme/host/pci.c  | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.17.2
