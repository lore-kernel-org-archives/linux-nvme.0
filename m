From: solio.sarabia@intel.com (Solio Sarabia)
Date: Wed, 3 Apr 2019 21:37:32 -0700
Subject: linux-5.1-rc3: nvme hv_pci: request for interrupt failed
In-Reply-To: <PU1P153MB01691F731370D45D13C3615CBF500@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <FCE231C24CDC4243982F7030CC75E92F644C034C@FMSMSX102.amr.corp.intel.com>
 <PU1P153MB01691F731370D45D13C3615CBF500@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Message-ID: <20190404043732.GA18380@ssarabia-MOBL7.amr.corp.intel.com>

On Thu, Apr 04, 2019@02:42:56AM +0000, Dexuan Cui wrote:
> > From: Solio Sarabia <solio.sarabia at intel.com>
> > Sent: Wednesday, April 3, 2019 5:38 PM
> > To: linux-hyperv at vger.kernel.org; linux-nvme at lists.infradead.org
> > 
> > When two nvme devices are discrete-assigned [1] to a linuxvm on
> > hyper-v rs5 host, it fails to initialize both.  It worked a couple of
> > times and after some reboots it failed. `dmesg` shows:
> > 
> > [   14.099310] hv_pci 96a07283-8dac-417a-82c6-111eb8b9a4c0: Request for
> > interrupt failed: 0xc000009a
> > 
> > Thanks,
> > -Solio
> 
> 0xc000009a is STATUS_INSUFFICIENT_RESOURCES.
> 
> This is a known host resource leakage bug of the RS5 host. After the issue
> happens, rebooting the VM can not help, and rebooting the host may hang
> and we may have to power cycle the host by force.
> 
> The bug has been fixed in 19H1, which is in the Insider Preview phase, though:
> https://docs.microsoft.com/en-us/windows-insider/at-home/whats-new-wip-at-home-19h1
> https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewadvanced
> 
> The fix is being backported to RS5, but I don't have an ETA yet. 
> I'll try to get more info today and keep you updated.
> 
> Thanks,
> -- Dexuan

Great to know you're on top of things.  Guest hanged and had to reboot host;
in all cases guest was in consistent state upon reboot.

It's not a blocking issue at the moment, I can work on one device at a time.

Thanks,
-Solio
