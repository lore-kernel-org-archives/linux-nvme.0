From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Aug 2016 12:15:40 -0400
Subject: Linux AER reporting
In-Reply-To: <CAG3=cOncMTcyALa=-i1jeA-z4pe22D9CrJ=Rxr2E8HWBsEMOPg@mail.gmail.com>
References: <CAG3=cOncMTcyALa=-i1jeA-z4pe22D9CrJ=Rxr2E8HWBsEMOPg@mail.gmail.com>
Message-ID: <20160822161540.GD28276@localhost.localdomain>

Hi Nisha,

The Linux NVMe driver didn't add AER support until commit:

| commit a0a3408ee614848c27b0d36c2fe490da3b387b8d
| Author: Keith Busch <keith.busch at intel.com>
| Date:   Mon Dec 7 15:30:31 2015 -0700
|
|   NVMe: Add pci error handlers


If you don't have the commit, AER's may cause problems for NVMe.
I think 4.4 was the first kernel release to include it.


On Mon, Aug 22, 2016@08:52:10AM -0700, Nisha Miller wrote:
> Hi all,
> 
> We have a PCIE SSD controller using NVME. This controller works on
> Windows and Linux. However, we are seeing a problem under Linux.
> 
> In the nvme Linux driver in function nvme_kthread() the CSTS register
> is read once a second to check for controller status failure. In our
> case we see that occasionally this register is read as 0xFFFFFFFF.
> Whenever this happens, the kernel just hangs. This seems to be PCIe
> read error and we are trying to gather further information. How does
> one use Linux AER with the nvme driver?
> 
> We are using Centos 7.2 with Kernel 3.19.8. PCIe AER has been enabled
> in the kernel and aerdriver.forceload=y is set in the command line.
> 
> TIA
> Nisha Miller
