From: sbates@raithlin.com (Stephen  Bates)
Date: Mon, 29 Oct 2018 15:37:46 +0000
Subject: [PATCH 2/2] nvme/multipath: Fix multipath disabled naming
 collisions
In-Reply-To: <20180426214956.3377-3-keith.busch@intel.com>
References: <20180426214956.3377-1-keith.busch@intel.com>
 <20180426214956.3377-3-keith.busch@intel.com>
Message-ID: <CAD4F464-15CC-44B9-9C72-B5F2BDFC5445@raithlin.com>

>    When CONFIG_NVME_MULTIPATH is set, but we're not using nvme to multipath,
>    namespaces with multiple paths were not creating unique names due to
>    reusing the same instance number from the namespace's head.
>    
>    This patch fixes this by falling back to the non-multipath naming method
>    when the parameter disabled using multipath.
    
Hi All

Andrew and I have been doing some testing on systems with quite a few NVMe controllers in them. Some of these have one namespace and some have multiple. We (by mistake) had CONFIG_NVME_MULTIPATH enabled in the .config and noticed some unusual naming in the sysfs tree. Basically the namespace names no longer align with the controller names. This leads to hilarity as we try to co-ordinate IO between the namespaces and try to work out what namespace is where in the system. For example on a QEMU system with six NVMe SSD models in it we get something like:

root at donard-qemu:~# ls -la /sys/bus/pci/devices/0000\:00\:04.0/nvme/nvme0/
total 0
drwxr-xr-x 4 root root    0 Oct 29 15:32 .
drwxr-xr-x 3 root root    0 Oct 29 15:32 ..
-r--r--r-- 1 root root 4096 Oct 29 15:32 address
-r--r--r-- 1 root root 4096 Oct 29 15:32 cntlid
-r--r--r-- 1 root root 4096 Oct 29 15:32 dev
lrwxrwxrwx 1 root root    0 Oct 29 15:32 device -> ../../../0000:00:04.0
-r--r--r-- 1 root root 4096 Oct 29 15:32 firmware_rev
-r--r--r-- 1 root root 4096 Oct 29 15:32 model
drwxr-xr-x 9 root root    0 Oct 29 15:32 nvme1n1
drwxr-xr-x 2 root root    0 Oct 29 15:32 power
--w------- 1 root root 4096 Oct 29 15:32 rescan_controller
--w------- 1 root root 4096 Oct 29 15:32 reset_controller
-r--r--r-- 1 root root 4096 Oct 29 15:32 serial
-r--r--r-- 1 root root 4096 Oct 29 15:32 state
-r--r--r-- 1 root root 4096 Oct 29 15:32 subsysnqn
lrwxrwxrwx 1 root root    0 Oct 29 15:32 subsystem -> ../../../../../class/nvme
-r--r--r-- 1 root root 4096 Oct 29 15:32 transport
-rw-r--r-- 1 root root 4096 Oct 29 15:32 uevent

Note how the /nvme/nvme0/ sysfs directory contains the nvme1n1 namespace. Is this expected? I am not that familiar with the multipath code so I'm not sure if this is a bug or not but it sure is confusing. Disabling CONFIG_NVME_MULTIPATH reverts to the legacy naming convention. This happens in all the 4.19, 4.18 and 4.17 kernels we tested. I've not tried the for-next tree.

Stephen

    
