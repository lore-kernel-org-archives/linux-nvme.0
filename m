From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 3 Aug 2018 10:54:11 -0600
Subject: How /dev/nvme numbers are allocated/mapped to BDF
In-Reply-To: <097442158bb64b9cbf07cc6e6c25ef1a@ausx13mps321.AMER.DELL.COM>
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
 <20180803071820.GA22003@infradead.org>
 <20180803144025.GA4381@localhost.localdomain>
 <097442158bb64b9cbf07cc6e6c25ef1a@ausx13mps321.AMER.DELL.COM>
Message-ID: <20180803165411.GA4551@localhost.localdomain>

On Fri, Aug 03, 2018@04:16:16PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> Thanks. I'm fairly convinced I have that patch. I can see by-path links 
> for Intel drives, but not the Samasungs.
> 
> [root at g-prime mrnuke]# ls /dev/disk/by-path/ |grep nvme
> pci-0000:3f:00.0-nvme-1
> pci-0000:3f:00.0-nvme-1-part1
> pci-0000:b1:00.0-nvme-1
> pci-0000:b1:00.0-nvme-1-part1
> 
> [root at g-prime mrnuke]# lspci |grep NVM
> 3f:00.0 Non-Volatile memory controller: Intel Corporation Express Flash  NVMe P4500
> 40:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe  SSD Controller 172Xa/172Xb (rev 01)
> b1:00.0 Non-Volatile memory controller: Intel Corporation Express Flash  NVMe P4600
> b2:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe  SSD Controller 172Xa/172Xb (rev 01)
> 
> 
> [root at g-prime mrnuke]# nvme list
> Node             SN                    Model                                    Namespace  Usage                      Format           FW Rev
> ---------------- --------------------  ---------------------------------------- ---------  -------------------------- ---------------- --------
> /dev/nvme0n1     PHLF7363029G1P0GGN   Dell Express Flash NVMe P4500  1.0TB SFF  1           1.00  TB /   1.00  TB     512   B +  0 B   QDV1DP12
> /dev/nvme1n1     PHLE7260008Z3P2EGN   Dell Express Flash NVMe P4600  3.2TB SFF  1           3.20  TB /   3.20  TB     512   B +  0 B   QDV1DP12
> /dev/nvme2n1           S39YNX0HB00195 Dell Express Flash PM1725a 800GB  SFF     1           800.17  GB / 800.17  GB   512   B +  0 B   1.0.4
> /dev/nvme3n1           S39YNX0HB00293 Dell Express Flash PM1725a 800GB  SFF     1           800.17  GB / 800.17  GB   512   B +  0 B   1.0.4

The sammy drives do not have compliant serial number. Spec requires
strings are left justified, padding spaces to the right.

Not that it should matter to the by-path symlinks...

Could you attach output from:

  udevadm test -a -p $(udevadm info -q path -n /dev/nvme2n1)
