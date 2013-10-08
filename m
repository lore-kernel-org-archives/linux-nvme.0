From: himanshu.madhani@qlogic.com (Himanshu Madhani)
Date: Tue, 8 Oct 2013 22:46:51 +0000
Subject: [PATCH RFC 63/77] qlcnic: Update MSI/MSI-X interrupts
 enablement code
In-Reply-To: <c92efbde96541d08f37510422c096d543bb01279.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <c92efbde96541d08f37510422c096d543bb01279.1380703263.git.agordeev@redhat.com>
Message-ID: <ADFE82A996F10145934E45547759F7638C923C26@avmb3.qlogic.org>

> -----Original Message-----
> From: Alexander Gordeev [mailto:agordeev at redhat.com]
> Sent: Wednesday, October 02, 2013 3:49 AM
> To: linux-kernel
> Cc: Alexander Gordeev; Bjorn Helgaas; Ralf Baechle; Michael Ellerman;
> Benjamin Herrenschmidt; Martin Schwidefsky; Ingo Molnar; Tejun Heo; Dan
> Williams; Andy King; Jon Mason; Matt Porter; linux-pci; linux-mips at linux-
> mips.org; linuxppc-dev at lists.ozlabs.org; linux390 at de.ibm.com; linux-
> s390 at vger.kernel.org; x86 at kernel.org; linux-ide at vger.kernel.org;
> iss_storagedev at hp.com; linux-nvme at lists.infradead.org; linux-
> rdma at vger.kernel.org; netdev; e1000-devel at lists.sourceforge.net; Dept-
> Eng Linux Driver; Solarflare linux maintainers; VMware, Inc.; linux-scsi
> Subject: [PATCH RFC 63/77] qlcnic: Update MSI/MSI-X interrupts enablement
> code
> 
> As result of recent re-design of the MSI/MSI-X interrupts enabling pattern
> this driver has to be updated to use the new technique to obtain a optimal
> number of MSI/MSI-X interrupts required.
> 
 "We will test this change for the driver and provide feedback."

> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>

Thanks,
Himanshu
