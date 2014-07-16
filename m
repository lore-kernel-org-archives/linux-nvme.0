From: keith.busch@intel.com (Keith Busch)
Date: Wed, 16 Jul 2014 08:39:19 -0600 (MDT)
Subject: NVME User Installation
In-Reply-To: <8838223D960CB945AFF93D316204C6369D9F2F@CFWEX01.americas.cray.com>
References: <8838223D960CB945AFF93D316204C6369D9F2F@CFWEX01.americas.cray.com>
Message-ID: <alpine.LRH.2.03.1407160835170.4703@AMR>

On Fri, 11 Jul 2014, Ian Ziemba wrote:
> Hi,
>
> I am currently having trouble installing the nvme-user package on my system.
> Currently, I have an NVMe device up and running in my system. My current
> configuration is a Dell R720 running SLES 11 SP3 with a Linux kernel version
> of 3.0.76. In order to get my NVMe device to run, I had to use the
> nvme-compatibility driver. I would like to get the temperature reading off of
> my drive, but with my current setup, I cannot install the nvme-user package.
> Unfortunately, upgrading kernel versions is not an option.
>
> Any insight into how to install the nvme-user package on my system would be
> greatly appreciated.

Most likely you don't have the nvme driver's user-api header in your
include path. The compatibility driver has a copy at

  include/uapi/linux/nvme.h

If you know where your kernel headers are installed, you can just copy
it there and should be able compile the user tools after.
