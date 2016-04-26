From: hch@lst.de (Christoph Hellwig)
Date: Tue, 26 Apr 2016 13:51:55 +0200
Subject: proper controller state machine and more common code V2
Message-ID: <1461671520-4758-1-git-send-email-hch@lst.de>

This series introduces a controller state machine based on code that Sagi
did for the Fabrics driver, and moves the namespace scanning and AER code
to nvme-core now that we have that state machine.

Changes since V1:
 - renamed the finished_scan method to post_scan
