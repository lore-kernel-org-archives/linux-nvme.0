From: kamalax.subbiah@intel.com (Subbiah, KamalaX)
Date: Thu, 20 Jul 2017 13:43:44 +0000
Subject: Support for nvme format/fw-download/fw-activate/set-feature in
 NVMeOF host
In-Reply-To: <20170718142345.GF1496@localhost.localdomain>
References: <06DD61BCF94D6D48AEF1059E41772BF32B668682@BGSMSX108.gar.corp.intel.com>
 <20170718142345.GF1496@localhost.localdomain>
Message-ID: <06DD61BCF94D6D48AEF1059E41772BF32B66DD54@BGSMSX108.gar.corp.intel.com>

Is there any plan to implement those commands?


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Tuesday, July 18, 2017 7:54 PM
To: Subbiah, KamalaX <kamalax.subbiah at intel.com>
Cc: Lakenani, RaviX <ravix.lakenani at intel.com>; Mariappan, Thenil KannanX <thenil.kannanx.mariappan at intel.com>; linux-nvme at lists.infradead.org
Subject: Re: Support for nvme format/fw-download/fw-activate/set-feature in NVMeOF host

On Tue, Jul 18, 2017@12:13:52PM +0000, Subbiah, KamalaX wrote:
> Hi,
> 
> Both NVMeOF host? and NVMeOF target server is configured with RHEL OS v7.3 and upstream kernel v4.10.4.
> NIC card (both target and host) - Mellanox Technologies MT27710 Family [ConnectX-4??? Lx], driver: mlx5_core, version: 3.0-1, firmware v14.14.1100.
> 1. Powered on the NVMeOF target server with single drive.
> 2. NVMe OF Target and Host? is configured and loaded with all nvme modules and mlx5 drivers.
> 3. Discovered the device with 'nvme discover -t rdma -a 1.1.1.1 -s 4440' in host.
> 4. Connected to the target with 'nvme connect -n subsystemName -t rdma -a 1.1.1.1 -s 4440' in host.
> 5.Verify drive discovery??? <ls /dev/nvme*> in host.
> 
> The following nvme commands are giving error in host:
> nvme format
> nvme fw-download
> nvme fw-activate
> nvme set-feature for temperature threshold.
> 
> Is there any support for these commands in NVMeOF host?

The host is just reporting the status it got from the target. None of those commands are supported in the target.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
