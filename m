From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Apr 2016 08:34:48 -0400
Subject: proper controller state machine and more common code
Message-ID: <1460982893-11315-1-git-send-email-hch@lst.de>

This series introduces a controller state machine based on code that Sagi
did for the Fabrics driver, and moves the namespace scanning and AER code
to nvme-core now that we have that state machine.
