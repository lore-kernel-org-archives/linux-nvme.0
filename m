From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Wed, 17 Oct 2012 21:38:32 +0000
Subject: IRQ allocation in nvme driver
Message-ID: <E821E2F372F08945977BD15EAE588D61084671CE@SACMBXIP02.sdcorp.global.sandisk.com>

Hi Matthew,

The nvme driver allocates MSIX vector 0 for admin queue, but it also allocates the same vector 0 for IO queue 0. Is this a bug, since any completion on the admin queue after MSIX IRQ allocation will generate an interrupt for IO queue 0?

We have changed our code to avoid this by allocating n+1 MSIX vectors and IO queue 0 using MSIX vector 1. If this fix is needed, we can send our patch.

Thanks,
Chayan


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
