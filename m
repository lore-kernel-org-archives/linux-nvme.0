From: keith.busch@intel.com (Keith Busch)
Date: Fri, 12 Jun 2015 14:06:28 +0000 (UTC)
Subject: Fwd: Fwd: Re: PCIe error handling patch
In-Reply-To: <1470799126.939801434099669048.JavaMail.weblogic@epmlwas06d>
References: <1470799126.939801434099669048.JavaMail.weblogic@epmlwas06d>
Message-ID: <alpine.LNX.2.00.1506121400410.15930@localhost.lm.intel.com>

On Fri, 12 Jun 2015, Sathyavathi M wrote:
> I was able to test the PCIe error handling patch on IBM power pc machine.
> The patch works for me without the delay mention in the NVMe: PCI error handling code patch.
> If an EEH is triggered the system recovers and resume back any ios.
> So I would request you to pull the EEH patch without the delay.

Hi Sathya,

You're saying the same AER patch, plus removing the msleep, tests
successfully with EEH h/w? If so, that's great! I'll have it merged up
to the latest kernel to test on other platforms, then we can resubmit
the patch.

Thanks,
Keith
