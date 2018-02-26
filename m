From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 26 Feb 2018 13:55:39 +0100
Subject: [PATCH v2 0/1] nvme: extend log page implementation
Message-ID: <20180226125540.9513-1-mb@lightnvm.io>

This patch introduces support for get log page offset and extends
the number of dwords to be 32 bits.

Changes from v1:

 - Suggestion from Johannes that paratheses around (size / 4) - 1 can
   be removed.
 - Make nvme_get_log_ext() static. Expose when the function is used by
   lightnvm.
 - Make sure to use unsigned long long when shifting a u64 with a
   constant.

Matias Bj?rling (1):
  nvme: implement log page low/high offset and dwords

 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

-- 
2.11.0
