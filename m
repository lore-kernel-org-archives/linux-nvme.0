From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 13 Mar 2014 15:20:45 -0400
Subject: problem in the development of nvme disk
In-Reply-To: <196070e8.d690.144bb7e553f.Coremail.liaohengquan1986@163.com>
References: <cover.1390897693.git.agordeev@redhat.com>
 <20140311150841.GA25564@dhcp-26-207.brq.redhat.com>
 <196070e8.d690.144bb7e553f.Coremail.liaohengquan1986@163.com>
Message-ID: <20140313192045.GD6091@linux.intel.com>

On Thu, Mar 13, 2014@08:50:22PM +0800, liaohengquan1986 wrote:
> Hi , guys,
> 
>                today, I get a problem in the development of NVMe disk. After insmod the NVMe driver(nvme.ko), I already found the
> 
> /dev/nvme0n1 block device, bus when I run " fdisk /dev/nvme0n1", the entire host server is broken down and reset. The host server's OS is Linux SUSE 11 sp3, . I want to know if it is the OS' bug, the system log is below, please help me, TKS.

Can you reproduce this with the mainline kernel, eg 3.13?
