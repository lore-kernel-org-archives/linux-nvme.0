From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 16 Jul 2015 21:44:40 -0400
Subject: [PATCH] NVMe: Reread partitions on metadata formats
In-Reply-To: <alpine.LNX.2.00.1507152142070.15930@localhost.lm.intel.com>
 (Keith Busch's message of "Wed, 15 Jul 2015 22:28:32 +0000 (UTC)")
References: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
 <55A559B5.2000303@fb.com>
 <CAA9_cmc2Kb=XRwPpOijT+T_1-qfPH-h7LeM0AGSP6ZOW72MjwQ@mail.gmail.com>
 <55A6D251.9050801@fb.com>
 <alpine.LNX.2.00.1507152142070.15930@localhost.lm.intel.com>
Message-ID: <yq17fpzo8vr.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> Here's a patch for that and the resulting nvme driver. It works
Keith> the same as today if registered after add_disk(), but safe to
Keith> call prior. If called prior, add_disk() handles the queue and
Keith> backing info settings for integrity, and adds the kobj.

This is going to blow up without blk integrity compiled in.

I'll take a stab at it tomorrow.

-- 
Martin K. Petersen	Oracle Linux Engineering
