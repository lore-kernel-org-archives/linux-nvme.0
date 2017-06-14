From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Jun 2017 08:35:35 +0200
Subject: remove long broken SCSI to NVMe translations
Message-ID: <20170614063537.1044-1-hch@lst.de>

TEST UNIT READY wa broken for a year and a half, and FORMAT UNIT and
WRITE BUFFER for two years.  Instead of fixing them up remove them - no
one should be sending SCSI commands to non-scsi devices anyway.
