From: mikey@neuling.org (Michael Neuling)
Date: Tue, 20 Mar 2018 11:22:42 +1100
Subject: [PATCH] nvme-pci: Fix NULL ptr deref in EEH code
Message-ID: <20180320002242.10416-1-mikey@neuling.org>

On powerpc on boot we can take an EEH event which results in this oops.

cpu 0x23: Vector: 300 (Data Access) at [c000000ff50f3800]
pc: c0080000089a0eb0: nvme_error_detected+0x4c/0x90 [nvme]
lr: c000000000026564: eeh_report_error+0xe0/0x110
sp: c000000ff50f3a80
msr: 9000000000009033
dar: 400
dsisr: 40000000
current = 0xc000000ff507c000
paca = 0xc00000000fdc9d80 softe: 0 irq_happened: 0x01
pid = 782, comm = eehd
Linux version 4.15.6-openpower1 (smc at smc-desktop) (gcc version 6.4.0 (Buildroot 2017.11.2-00008-g4b6188e)) #2 SM P Tue Feb 27 12:33:27 PST 2018
enter ? for help
[c000000ff50f3af0] c000000000026564 eeh_report_error+0xe0/0x110
[c000000ff50f3b30] c000000000025520 eeh_pe_dev_traverse+0xc0/0xdc
[c000000ff50f3bc0] c000000000026bd0 eeh_handle_normal_event+0x184/0x4c4
[c000000ff50f3c70] c000000000026ff4 eeh_handle_event+0x30/0x288
[c000000ff50f3d10] c00000000002758c eeh_event_handler+0x124/0x170
[c000000ff50f3dc0] c00000000008fed0 kthread+0x14c/0x154
[c000000ff50f3e30] c00000000000b594 ret_from_kernel_thread+0x5c/0xc8

This fixes the NULL ptr deref.

Signed-off-by: Michael Neuling <mikey at neuling.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b6f43b738f..404b346e3c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2626,6 +2626,9 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
+	if (!dev)
+		return PCI_ERS_RESULT_NEED_RESET;
+
 	/*
 	 * A frozen channel requires a reset. When detected, this method will
 	 * shutdown the controller to quiesce. The controller will be restarted
-- 
2.14.1
