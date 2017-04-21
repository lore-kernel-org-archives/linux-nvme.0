From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 21 Apr 2017 16:19:21 -0700
Subject: [PATCH 0/3] nvme: APST improvements (for 4.12, perhaps)
Message-ID: <cover.1492816561.git.luto@kernel.org>

Hi all-

These are APST improvements for 4.12 or so.  The first one fixes a
buggy comment.  The second makes debugging easier.  The third makes
it possible to force APST on despite quirks.

Andy Lutomirski (3):
  nvme: Fix APST comment
  nvme: Display raw APST configuration via DYNAMIC_DEBUG
  nvme: Add nvme_core.force_apst to ignore the NO_APST quirk

 drivers/nvme/host/core.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

-- 
2.9.3
