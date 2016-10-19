From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 19 Oct 2016 12:43:04 -0700
Subject: [PATCH 0/3] nvme-cli: fabric doc and tool fixes.
Message-ID: <1476906187-29183-1-git-send-email-james_p_freyensee@linux.intel.com>

This patchset tweaks discover/connect-all man pages according
to a previous thread, then last patch fixes the tool according
to the correct examples shown in the man pages.

Jay Freyensee (3):
  nvme-cli: follow-on discovery tweaks from thread
  nvme-cli: follow-on doc tweaks to nvme-connect-all
  nvme-cli: fix nvme-connect-all using hostnqn

 Documentation/nvme-connect-all.txt | 15 ++++++++-------
 Documentation/nvme-discover.txt    | 27 ++++++++++++++-------------
 fabrics.c                          |  6 ++++++
 3 files changed, 28 insertions(+), 20 deletions(-)

-- 
2.5.5
