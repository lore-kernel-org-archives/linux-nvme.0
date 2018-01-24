From: thomas.tai@oracle.com (Thomas Tai)
Date: Wed, 24 Jan 2018 15:23:09 -0500
Subject: [PATCH v2 0/1] nvme: Add fault injection feature
Message-ID: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>

Linux's fault injection framework provides a systematic way to support
error injection via debugfs in the /sys/kernel/debug directory. This
patch uses the framework to add error injection to NVMe driver. 

Change log since last version:
V1:
1. move error injection point into nvme_end_request()
2. Add expected result in the commit log

Thank you,
Thomas
