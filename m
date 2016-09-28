From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 28 Sep 2016 16:49:40 -0700
Subject: [PATCH 0/4] .txt input files for discover man pages
Message-ID: <1475106584-14961-1-git-send-email-james_p_freyensee@linux.intel.com>

This marks the start of documenting the NVMe over Fabrics commands
in the nvme-cli tool that was greatly lacking.

Jay Freyensee (4):
  nvme-cli: Documentation for nvme-discover
  nvme-cli: Tweak discover summary to match docs
  nvme-cli: Add nvme-connect.txt shell for fill in
  nvme-cli: Add discover connect cmds to main list

 Documentation/cmds-main.txt     |   6 ++
 Documentation/nvme-connect.txt  |  89 ++++++++++++++++++++++++++++
 Documentation/nvme-discover.txt | 125 ++++++++++++++++++++++++++++++++++++++++
 nvme.c                          |   2 +-
 4 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/nvme-connect.txt
 create mode 100644 Documentation/nvme-discover.txt

-- 
2.7.4
