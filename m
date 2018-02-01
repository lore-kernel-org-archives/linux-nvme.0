From: thomas.tai@oracle.com (Thomas Tai)
Date: Thu,  1 Feb 2018 18:10:57 -0500
Subject: [PATCH v3 0/2] nvme: Add fault injection feature
Message-ID: <1517526659-3450-1-git-send-email-thomas.tai@oracle.com>

Linux's fault injection framework provides a systematic way to support
error injection via debugfs in the /sys/kernel/debug directory. This
patch uses the framework to add error injection to NVMe driver. 

Change log since last version:
V2:
- add user changable status and no_retry debugfs attribute
- add document to show how to use nvme fault injection

V1:
- move error injection point into nvme_end_request()
- Add expected result in the commit log

Thank you,
Thomas
