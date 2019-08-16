From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 16 Aug 2019 15:11:27 +0200
Subject: [GIT PULL] Power management fixes for v5.3-rc5
Message-ID: <CAJZ5v0j4ezEuK1dk0J3wwjSuudzjhKWTXzJL=EkE1QG39HKRiw@mail.gmail.com>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.3-rc5

with top-most commit a3ee2477c45f73184a64d9c6cf97855a52732dc6

 Merge branch 'pm-cpufreq'

on top of commit d45331b00ddb179e291766617259261c112db872

 Linux 5.3-rc4

to receive power management fixes for 5.3-rc5.

These add a check to avoid recent suspend-to-idle power regression on
systems with NVMe drives where the PCIe ASPM policy is "performance"
(or when the kernel is built without ASPM support), fix an issue
related to frequency limits in the schedutil cpufreq governor and fix a
mistake related to the PM QoS usage in the cpufreq core introduced
recently.

Specifics:

 - Disable NVMe power optimization related to suspend-to-idle added
   recently on systems where PCIe ASPM is not able to put PCIe links
   into low-power states to prevent excess power from being drawn by
   the system while suspended (Rafael Wysocki).

 - Make the schedutil cpufreq governor handle frequency limits changes
   properly in all cases (Viresh Kumar).

 - Prevent the cpufreq core from treating positive values returned
   by dev_pm_qos_update_request() as errors (Viresh Kumar).

Thanks!


---------------

Rafael J. Wysocki (2):
      PCI/ASPM: Add pcie_aspm_enabled()
      nvme-pci: Allow PCI bus-level PM to be used if ASPM is disabled

Viresh Kumar (2):
      cpufreq: dev_pm_qos_update_request() can return 1 on success
      cpufreq: schedutil: Don't skip freq update when limits change

---------------

 drivers/cpufreq/cpufreq.c        |  2 +-
 drivers/nvme/host/pci.c          | 13 ++++++++++---
 drivers/pci/pcie/aspm.c          | 20 ++++++++++++++++++++
 include/linux/pci.h              |  2 ++
 kernel/sched/cpufreq_schedutil.c | 14 ++++++++++----
 5 files changed, 43 insertions(+), 8 deletions(-)
