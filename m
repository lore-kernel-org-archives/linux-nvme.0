From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Thu, 28 Jul 2016 14:47:25 -0700
Subject: [PATCH v1] *** Discovery feature fix in nvme-cli ***
Message-ID: <1469742446-13416-1-git-send-email-james_p_freyensee@linux.intel.com>

Since the only way to do the discovery feature of NVMe-over-Fabrics
is through nvme-cli, I thought it will be appropriate to send
a patch to this email list (if nothing more than to inform and educate).

I'll push this to Keith Busch (the nvme-cli owner).

Changes since v0:
  changed short 'h' option to 'q'.

Jay Freyensee (1):
  nvme-cli: user-defined hostnqn option for discover

 fabrics.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.4.3
