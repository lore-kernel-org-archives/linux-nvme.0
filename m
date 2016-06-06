From: hch@lst.de (Christoph Hellwig)
Date: Mon,  6 Jun 2016 23:20:42 +0200
Subject: general preparation for NVMe over Fabrics support
Message-ID: <1465248052-17811-1-git-send-email-hch@lst.de>

This patch set adds some needed preparations for the upcoming NVMe over
Fabrics support.

Contains:
- Allow transfer size limitations for NVMe transports
- Add the get_log_page command definition required by the NVMe target
- more helpers in core code that can be used by various transports
- add some missing constants and identify attributes
