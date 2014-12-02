From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Dec 2014 00:08:17 +0000 (UTC)
Subject: NVMe driver within hypervisors
In-Reply-To: <1417473163.6910.10.camel@espiritosanto.int.convergent.io>
References: <53cea8aa3891427498928f77e6b9dc46@hioexcmbx06-prd.hq.netapp.com>
 <alpine.LNX.2.00.1412011504440.4225@localhost.lm.intel.com>
 <1417473163.6910.10.camel@espiritosanto.int.convergent.io>
Message-ID: <alpine.LNX.2.00.1412012345220.4225@localhost.lm.intel.com>

On Mon, 1 Dec 2014, Daniel Stodden wrote:
> On Mon, 2014-12-01@15:07 +0000, Keith Busch wrote:
>> Correct me if I'm wrong, but doesn't Xen derive device driver support
>> from its "dom-0"? Just use an nvme-capable Linux guest there and you've
>> enabled Xen to support nvme, yeah?
>
> Correct. Backends in dom0 eventually translate guest I/O to bios issued
> to a kernel blockdev. Such as an NVMe one, typically implemented by a
> normal Linux driver.

I get asked about Xen support a lot, but my experience is limited so I've
only been guessing when I say it ought to work just fine. No one ever
takes it to the next level as far as I know. I'm not sure what people
are waiting for (a commercial offering perhaps?), so I'll give it a shot.

It's pretty darn easy actually (YMMV). I'm starting with an old debian,
spare parts from the lab, and an old nvme driver. The h/w I found is
pretty weak, so I can't actually do anything interesting with it except
show that xen and nvme have worked since forever ago.

I'll post stuff on this public list so I can point people to it next
time someone asks "when will xen run nvme?" :)

Here's what I'm starting with:

   # cat /etc/debian_version
   7.7

   # uname -a
   Linux debian 3.2.0-4-amd64 #1 SMP Debian 3.2.63-2+deb7u1 x86_64 GNU/Linux

Install Xen:

   # apt-get install xen-linux-system

Edit /etc/default/grub by adding the following line:

   GRUB_CMDLINE_XEN_DEFAULT="dom0_mem=1024M,max:1500M no-real-mode e820-verbose"

Edit /etc/xen/xend-config.sxp to configure the toolstack to match by changing the following settings:

   (dom0-min-mem 1024)
   (enable-dom0-ballooning no)

Update grub:

   # update-grub

After reboot, make sure to select "Xen 4.1-amd64" boot option.

Verify it's running under Xen:

   # xm list
   Name                                        ID   Mem VCPUs      State   Time(s)
   Domain-0                                     0   1024     4     r-----     12.5

   # xm info
   host                   : debian
   release                : 3.2.0-4-amd64
   version                : #1 SMP Debian 3.2.63-2+deb7u1
   machine                : x86_64
   nr_cpus                : 4
   nr_nodes               : 1
   cores_per_socket       : 2
   threads_per_core       : 2
   cpu_mhz                : 3691
   hw_caps                : bfebfbff:2c100800:00000000:00007f40:71dafbbf:00000000:00000021:0000272b
   virt_caps              : hvm
   total_memory           : 1949
   free_memory            : 1409
   free_cpus              : 0
   xen_major              : 4
   xen_minor              : 1
   xen_extra              : .4
   xen_caps               : xen-3.0-x86_64 xen-3.0-x86_32p hvm-3.0-x86_32 hvm-3.0-x86_32p hvm-3.0-x86_64
   xen_scheduler          : credit
   xen_pagesize           : 4096
   platform_params        : virt_start=0xffff800000000000
   xen_changeset          : unavailable
   xen_commandline        : placeholder dom0_mem=1024M,max:2048M no-real-mode e820-verbose
   cc_compiler            : gcc version 4.7.2 (Debian 4.7.2-5)
   cc_compile_by          : ultrotter
   cc_compile_domain      : debian.org
   cc_compile_date        : Mon Sep 29 16:42:20 EEST 2014
   xend_config_format     : 4

'git' a capable nvme driver for this kernel, make and load it:

   # apt-get install linux-headers-3.2.0-4-amd64
   # git clone git://git.infradead.org/users/kbusch/nvme-compatibility.git
   # cd nvme-compatibility && make nvme && insmod ./drivers/block/nvme.ko

Check that it found my device:

   # cat /proc/partitions
   major minor  #blocks  name

      8        0  293036184 sda
      8        1     498688 sda1
      8        2  288442368 sda2
      8        3    4093952 sda3
    254        0  781412184 nvme0n1

Let's see what's attached to dom0:

   # xm block-list 0

Nothing. Let's attach the raw nvme device:

   # xm block-attach 0 phy:/dev/nvme0n1 xvda w 0

Now let's check:

   # cat /proc/partitions
   major minor  #blocks  name

      8        0  293036184 sda
      8        1     498688 sda1
      8        2  288442368 sda2
      8        3    4093952 sda3
    254        0  781412184 nvme0n1
    202        0  781412184 xvda

   # xm block-list 0
   Vdev  BE handle state evt-ch ring-ref BE-path
   51712  0    0     4      40     8     /local/domain/0/backend/vbd/0/51712

Looks like Xen and NVMe have worked for years! Hardly worth a mention
on nvmexpress.org, though; they don't announce for a particular linux
distro, so I don't see why xen would get special treatment.
