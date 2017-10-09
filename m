From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 09 Oct 2017 23:52:26 +0200
Subject: Fwd: [Bug 196907] [Regression] New default s2idle does not work on
 Dell XPS 13 9360 with Ubuntu 16.04.3 LTS (Xenial Xerus)
Message-ID: <1636342.6qveo3Fvtu@aspire.rjw.lan>

Hi,

We are seeing a resume issue with a Hynix SSD (PC300 NVMe SK hynix 512GB)
with respect to suspend-to-idle (S3 resume works for the reporter,
interestingly enough).  It appears to be limited to Hynix and to that
specific SSD ATM.

Also it is reported to work in 4.11-rc1 and it already is failing in 4.13,
so it looks like something between the two broke it.

Any ideas of what that might be?

Or anything we should try/test to narrow it down?

Any help will be appreciated.

Thanks,
Rafael
-------------- next part --------------
An embedded message was scrubbed...
From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 196907] [Regression] New default s2idle does not work on Dell XPS 13 9360 with Ubuntu 16.04.3 LTS (Xenial Xerus)
Date: Mon, 09 Oct 2017 16:34:05 +0000
Size: 2348
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171009/c35e6dc1/attachment.mht>
