From: keith.busch@intel.com (Keith Busch)
Date: Thu, 23 Jun 2016 11:29:03 -0600
Subject: [PATCH 0/3] Namespace iteration fixes
Message-ID: <1466702946-13065-1-git-send-email-keith.busch@intel.com>

Patch 1/3 cleanly applies to linux-block/for-linus and for-next. The
other two only apply to for-next.

The first fixes a bug introduced in 4.7 and hoping this can be applied
to 4.7. It's version 2 of this patch. The reset of the series is targeted
to 4.8. 

The second patch fixes issues where buffered writers block removal
from proceeding.

The third locks the namespace mutex when searching for invalid
namespaces. While it doesn't appear necessary in the existing paths that
use it, it makes this function safe for potential future use.

Keith Busch (3):
  nvme: Remove RCU namespace protection
  nvme: Kill detached namespaces prior to removal
  nvme: Put invalid namespaces on removal list

 drivers/nvme/host/core.c | 112 ++++++++++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 45 deletions(-)

-- 
2.7.2
