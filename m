From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Mon, 16 Apr 2018 20:52:43 +0000
Subject: Disable Native NVMe Multipath Support
Message-ID: <DE927C68B458BE418D582EC97927A9287FEB6848@ORSMSX113.amr.corp.intel.com>

Hi everyone-

I'm doing some testing with the native NVMe multipath support in an NVMeoF environment.  In Ubuntu with kernel 4.15.15 it seems to be enabled by default and "just works" without taking any steps to set it up.  If I connect the same namespace from my target to my initiator using two different network paths it results in a single namespace on the initiator.  Then I can fail either network path and still run IO to the namespace.

I'd like to now set up dm-multipath for comparison.  It looks like I'll need to disable the native NVMe multipath support to do this, otherwise I can't connect the same namespace via two paths and have it show up on the initiator as two separate namespaces for dm-multipath to use.  Is there an quick and easy way to do disable the native NVMe multipath support, or is rebuilding the kernel with CONFIG_NVME_MULTIPATH=N the only option?

Thanks,
Joe
