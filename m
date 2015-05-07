From: hch@lst.de (Christoph Hellwig)
Date: Thu,  7 May 2015 09:38:12 +0200
Subject: fix queue_lock usage in blk-mq and nvme
Message-ID: <1430984294-25859-1-git-send-email-hch@lst.de>

Historically we always take queue_lock with irqs disabled.  Blk-mq doesn't really
use the queue_lock much, but when it does it needs to follow this rules to make
lockdep happy.

The first patch removes a queue_lock usage instead of fixing things properly,
and the second is a bad-aid for nvme.  In the long run I'd prefer to remove
other users of the queue_lock from blk-mq and blk-mq based driver entirely,
but that will require a bit more work.
