From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Thu, 28 Jul 2016 13:03:19 -0700
Subject: [PATCH] *** Discovery feature fix in nvme-cli ***
Message-ID: <1469736200-6618-1-git-send-email-james_p_freyensee@linux.intel.com>

Since the only way to do the discovery feature of NVMe-over-Fabrics
is through nvme-cli, I thought it will be appropriate to send
a patch to this email list (if nothing more than to inform and educate).

I'll push this to Keith Busch (the nvme-cli owner).

Jay Freyensee (1):
  nvme-cli: user-defined hostnqn option for discover

 fabrics.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.4.3
