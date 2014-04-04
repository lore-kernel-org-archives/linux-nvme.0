From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Apr 2014 09:33:02 -0600 (MDT)
Subject: [PATCH] NVMe: Increase shutdown complete time
In-Reply-To: <90064137F935C142B4B98BA318BB81A301DA531F@GREEN-CLEX.greenliant.com>
References: <1396283044-31926-1-git-send-email-keith.busch@intel.com>
 <alpine.WNT.2.00.1403311256420.4656@DMCLERAN-MOBL.amr.corp.intel.com>
 <49158E750348AA499168FD41D8898360626A03D9@FMSMSX105.amr.corp.intel.com>
 <alpine.WNT.2.00.1403311755300.4656@DMCLERAN-MOBL.amr.corp.intel.com>
 <90064137F935C142B4B98BA318BB81A301DA530C@GREEN-CLEX.greenliant.com>
 <alpine.LRH.2.03.1404031709520.4731@AMR>
 <90064137F935C142B4B98BA318BB81A301DA531F@GREEN-CLEX.greenliant.com>
Message-ID: <alpine.LRH.2.03.1404040832460.4731@AMR>

On Thu, 3 Apr 2014, Yung-Chin Chen wrote:
> Thanks, Keith, for your prompt response. I do not know Linux driver that
> well. If you use MODULE_PARM_DESC(), how do I specify the parameter for
> bootable NVMe device?
>
> For example, RedHat 7.0 has built-in NVMe driver and supports bootable
> from an NVMe device. The driver is buil-in to the kernel, and is not a
> loadable module. Where can I specify the parameters for built-in driver?

Okay, I'm not overly familiar with RHEL7, but I believe the following
is the way. If the module is built in, we can specify module parameters
at the vmlinuz line from the boot loader. To make it permanent, you
can append:

   <module>.<module_param>=<value>

to the GRUB_CMDLINE_LINUX line in /etc/default/grub.  The proposed new
parameter would look like 'nvme.nvme_io_timeout=20' if you want a 20
second timeout. After you set it, save the file, then run:

   grub2-mkconfig --output=/boot/efi/EFI/redhat/grub.cfg

I assume you're efi booting since you mention booting from NVMe. If not
efi, the output would be in /boot/grub2/grub.cfg. The driver should then
use the new timeout value by default on each reboot after that.
