From: sathya.m@samsung.com (Sathyavathi M)
Date: Fri, 12 Jun 2015 09:01:09 +0000 (GMT)
Subject: Fwd: Fwd: Re: PCIe error handling patch
Message-ID: <1470799126.939801434099669048.JavaMail.weblogic@epmlwas06d>

Keith,

I was able to test the PCIe error handling patch on IBM power pc machine.
The patch works for me without the delay mention in the NVMe: PCI error handling code patch.
If an EEH is triggered the system recovers and resume back any ios.
So I would request you to pull the EEH patch without the delay.

Regards,
Sathya 

------- Original Message -------
Sender : Sathyavathi M<sathya.m at samsung.com> Lead Engineer/SRI-Bangalore-SSD Solutions/Samsung Electronics
Date : Apr 20, 2015 18:31 (GMT+09:00)
Title : Fwd: Re: PCIe error handling patch

Keith,

Im unable to inject the error with the patch.
I used the same spec file mentioned in the patch 
  AER
  BUS 9 DEV 0 FN 0
  UNCOR_STATUS MALF_TLP
  HEADER_LOG 0 1 2 3

I m getting an error saying "AER service is not initialized"

Regards,
sathya
------- Original Message -------
Sender : Keith Busch
Date : Mar 25, 2015 23:58 (GMT+09:00)
Title : Re: PCIe error handling patch

On Wed, 25 Mar 2015, sathyavathi wrote:
> I came across the below patch regarding PCI error handling,
> http://lists.infradead.org/pipermail/linux-nvme/2014-July/001073.html
> Any specific reason for not including this patch in the NVMe driver.

I have no idea if it even works correctly in a real scenario. Does this
test out okay for you?


Regards,
Sathya

Regards,
Sathya
