From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Thu, 08 Mar 2018 11:03:42 -0800
Subject: [pci PATCH v4 2/4] virtio_pci: Add support for unmanaged SR-IOV on
 virtio_pci devices
In-Reply-To: <20180308185507.5433.98830.stgit@localhost.localdomain>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
Message-ID: <20180308190236.5433.64788.stgit@localhost.localdomain>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Hardware-realized virtio_pci devices can implement SR-IOV, so this
patch enables its use. The device in question is an upcoming Intel
NIC that implements both a virtio_net PF and virtio_net VFs. These
are hardware realizations of what has been up to now been a software
interface.

The device in question has the following 4-part PCI IDs:

PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe

The patch currently needs no check for device ID, because the callback
will never be made for devices that do not assert the capability or
when run on a platform incapable of SR-IOV.

One reason for this patch is because the hardware requires the
vendor ID of a VF to be the same as the vendor ID of the PF that
created it. So it seemed logical to simply have a fully-functioning
virtio_net PF create the VFs. This patch makes that possible.

Signed-off-by: Mark Rustad <mark.d.rustad at intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck at intel.com>
---

v4: Dropped call to pci_disable_sriov in virtio_pci_remove function

 drivers/virtio/virtio_pci_common.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 48d4d1cf1cb6..27ab090163b4 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -596,6 +596,9 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm	= &virtio_pci_pm_ops,
 #endif
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = pci_sriov_configure_unmanaged,
+#endif
 };
 
 module_pci_driver(virtio_pci_driver);
