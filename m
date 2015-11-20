From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Nov 2015 02:50:22 -0800
Subject: nvme lightnvm comments
Message-ID: <20151120105022.GA22131@infradead.org>

Hi Matias,

two small comments on the NVME lighnvm support:

 1) please don't claim the existing Qemu NVMe PCI ID for lightnvm
    support.  We might need the actual vendor specific data for
    qemu purposes.  Please allocate a different PCI ID for a qemu
    emulated lightnvm nvme device
 2) please build the lightnvm.o object conditionally in the makefile

Thanks!
