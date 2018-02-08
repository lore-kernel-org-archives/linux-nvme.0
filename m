From: thomas.tai@oracle.com (Thomas Tai)
Date: Thu,  8 Feb 2018 13:38:28 -0500
Subject: [PATCH v4 0/2] nvme: Add fault injection feature
Message-ID: <1518115110-15930-1-git-send-email-thomas.tai@oracle.com>

Linux's fault injection framework provides a systematic way to support
error injection via debugfs in the /sys/kernel/debug directory. This
patch uses the framework to add error injection to NVMe driver. 

Change log since last version:
from v3 to v4:
- correct documentation to cover status code can be changed
  via debugfs
- add Reviewed-by: Keith Busch <keith.busch at intel.com>

from v1 to V2:
- add user changable status and no_retry debugfs attribute
- add document to show how to use nvme fault injection

from v0 to V1:
- move error injection point into nvme_end_request()
- Add expected result in the commit log

Thank you,
Thomas
