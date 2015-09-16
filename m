From: sathya.m@samsung.com (Sathyavathi M)
Date: Wed, 16 Sep 2015 10:03:35 +0000 (GMT)
Subject: Fwd: Fwd: Fwd: Re: Fwd: Fwd: Re: PCIe error handling patch
Message-ID: <1107870359.1155791442397814537.JavaMail.weblogic@ep2mlwas06d>

Hi Keith,

Can you merge the below patch to latest kernels.
http://lists.infradead.org/pipermail/linux-nvme/2015-June/001949.html


Regards,
Sathya
------- Original Message -------
Sender : Keith Busch
Date : Jun 12, 2015 23:06 (GMT+09:00)
Title : Re: Fwd: Fwd: Re: PCIe error handling patch

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
