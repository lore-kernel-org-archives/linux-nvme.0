From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Tue, 14 Aug 2018 10:34:52 +0200
Subject: memleak on hot unplug
Message-ID: <7516FE0D-1C04-4110-98C4-77810BC63A9A@javigon.com>

While reviewing Hannes' sysfs patches on top of Christoph's nvme-4.19, I
came across a leak when hot unplugging the controller. The leak seems to
be introduced by nvme_init_ctrl:dev_pm_qos_update_user_latency_tolerance()

A quick check shows that neither dev_pm_qos_expose_latency_tolerance()
nor dev_pm_qos_hide_latency_tolerance() are being called in
nvme_init_identify().

I don't know this part enough to come up with a fix, but I hop it is
enough info for you.

Javier

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180814/f6268bef/attachment.sig>
