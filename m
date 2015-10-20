From: cmartin@altera.com (Chris Martin)
Date: Tue, 20 Oct 2015 14:38:57 +0000
Subject: Help with NVMe Driver on Altera SoCs
In-Reply-To: <20151020141744.GA18345@localhost.localdomain>
References: <20B8CF9DC7757148B9D6420301E14D590AE5E744@SJ-ITEXCH02.altera.priv.altera.com>
 <20151020141744.GA18345@localhost.localdomain>
Message-ID: <20B8CF9DC7757148B9D6420301E14D590AE5E79D@SJ-ITEXCH02.altera.priv.altera.com>


>Yes, this says that there were no memory resources available to assign to BAR0, which is the controller registers.
>If the driver is unable to remap the controller registers, it won't be able to drive it. It returns -ENOMEM since the error is a memory resource.

Thanks, Keith.  I'll work on adjusting the hardware and see what we can do in the PCIe driver.  Thanks! --Chris

________________________________

Confidentiality Notice.
This message may contain information that is confidential or otherwise protected from disclosure. If you are not the intended recipient, you are hereby notified that any use, disclosure, dissemination, distribution, or copying of this message, or any attachments, is strictly prohibited. If you have received this message in error, please advise the sender by reply e-mail, and delete the message and any attachments. Thank you.
