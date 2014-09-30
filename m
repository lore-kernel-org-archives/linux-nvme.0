From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Tue, 30 Sep 2014 19:32:18 +0100
Subject: CQ Doorbells can be touched after queue deleted
Message-ID: <542AF732.3060706@ranbarg.com>

Hi All,
I've encountered an interesting issue with the driver as in v3.17-rc7.
The NVMe specification defines writing to CQ doorbells for non-existent
queues as "undefined", so it is probably not a good idea to do this.
I'm aware of at least one drive that gets very upset if you try.

The case I hit was where there is I/O running to the drive, but the
drive is being reset in the kthread due to not responding to abort requests.
When an I/O request came in, nvme_process_cq was called from
nvme_make_request, but the queue no longer exists as it has been torn
down by the reset.
During nvme_process_cq, the doorbell is updated, which upsets the drive.

This is a bit of a corner case, but it has happened.
We probably need to skip the doorbell update if the queue has been deleted.
