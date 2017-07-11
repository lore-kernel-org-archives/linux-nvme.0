From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Tue, 11 Jul 2017 14:25:00 +0530
Subject: [PATCH 00/13]mpt3sas driver NVMe support:
Message-ID: <1499763313-7214-1-git-send-email-suganath-prabu.subramani@broadcom.com>

Ventura Series controller are Tri-mode. The controller and
firmware are capable of supporting NVMe devices and
PCIe switches to be connected with the controller. This
patch set adds driver level support for NVMe devices and
PCIe switches.

Suganath Prabu S (13):
  mpt3sas: Add nvme device support in slave alloc, target alloc and
    probe
  mpt3sas: SGL to PRP Translation for I/Os to NVMe  devices
  mpt3sas: Added support for nvme encapsulated request message.
  mpt3sas: Handle NVMe PCIe device related events generated            
    from firmware.
  mpt3sas: Set NVMe device queue depth as 128
  mpt3sas: API 's to support NVMe drive addition to SML
  mpt3sas: API's to remove nvme drive from sml
  mpt3sas: scan and add nvme device after controller reset
  mpt3as: Add-Task-management-debug-info-for-NVMe-drives.
  mpt3sas: NVMe drive support for BTDHMAPPING ioctl command and log
    info
  mpt3sas: Fix nvme drives checking for tlr.
  mpt3sas: Update MPI Header
  mpt3sas: Update mpt3sas driver version.

 drivers/scsi/mpt3sas/mpi/mpi2.h          |   43 +-
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h     |  647 ++++++++++-
 drivers/scsi/mpt3sas/mpi/mpi2_init.h     |   11 +-
 drivers/scsi/mpt3sas/mpi/mpi2_ioc.h      |  331 ++++++-
 drivers/scsi/mpt3sas/mpi/mpi2_pci.h      |  142 +++
 drivers/scsi/mpt3sas/mpi/mpi2_tool.h     |   14 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c      |  709 +++++++++++-
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  176 +++-
 drivers/scsi/mpt3sas/mpt3sas_config.c    |  100 ++
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       |  170 +++-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 1871 ++++++++++++++++++++++++++++--
 drivers/scsi/mpt3sas/mpt3sas_warpdrive.c |    2 +-
 12 files changed, 4081 insertions(+), 135 deletions(-)
 create mode 100644 drivers/scsi/mpt3sas/mpi/mpi2_pci.h

Thanks,
Suganath Prabu S
