From: nisha.miller420@gmail.com (Nisha Miller)
Date: Mon, 22 Aug 2016 08:52:10 -0700
Subject: Linux AER reporting
Message-ID: <CAG3=cOncMTcyALa=-i1jeA-z4pe22D9CrJ=Rxr2E8HWBsEMOPg@mail.gmail.com>

Hi all,

We have a PCIE SSD controller using NVME. This controller works on
Windows and Linux. However, we are seeing a problem under Linux.

In the nvme Linux driver in function nvme_kthread() the CSTS register
is read once a second to check for controller status failure. In our
case we see that occasionally this register is read as 0xFFFFFFFF.
Whenever this happens, the kernel just hangs. This seems to be PCIe
read error and we are trying to gather further information. How does
one use Linux AER with the nvme driver?

We are using Centos 7.2 with Kernel 3.19.8. PCIe AER has been enabled
in the kernel and aerdriver.forceload=y is set in the command line.

TIA
Nisha Miller
