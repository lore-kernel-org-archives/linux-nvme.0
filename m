From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 8 Apr 2018 14:04:22 +0300
Subject: [PATCH 1/2] nvme-rdma: Fix race between queue timeout and error
 recovery
In-Reply-To: <20180405085527.GD2286@lst.de>
References: <1522595994-21092-1-git-send-email-israelr@mellanox.com>
 <20180405085527.GD2286@lst.de>
Message-ID: <58e5c294-a716-26bf-9099-c9e9d5cf204c@grimberg.me>


> Please send an introduction cover letter explaining what issue you've
> triggered and your overall design.

The commit log is actually wrong... We don't complete the request in two
places, the issue is that we need to make sure to unmap user buffer
before completing the request in case of a timeout. I sent this patch
to a bug report on the list and this is what it is designed to do.

Given that we already simply schedule error recovery, we will fail it
there, after we drain the queue pair, so the choice is to reset the
timer for it in the timeout callout.

We could alternatively invalidate the rkey in the timeout callout, but
that won't work with the unsafe rkey mode.
