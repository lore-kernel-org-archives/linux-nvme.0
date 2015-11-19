From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Nov 2015 22:20:12 +0000
Subject: [PATCH] nvme: allow queues the chance to quiesce after
 freezing them
In-Reply-To: <20151119215311.GA19302@infradead.org>
References: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>
 <20151119214156.GA22690@localhost.localdomain>
 <20151119215311.GA19302@infradead.org>
Message-ID: <20151119222012.GB22690@localhost.localdomain>

On Thu, Nov 19, 2015@01:53:11PM -0800, Christoph Hellwig wrote:
> This looks reasonable.  I ran into stray ->q_db derference a lot during
> reset testing, but after my abort and reset rewrites ([1] for th latest
> version) I couldn't reproduce it any more. 
> 
> [1]
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-req.8

There's good stuff in this tree. I've been using it most of this week
to study the reset handling and still have a concern here.

I mentioned ending IO in the reset handler in a previous review, and I can
create memory and data corruption with well timed delays (or badly timed,
depending on your perspective). We can't end IO while the controller
owns it. Even though the timeout handler often means the controller is
not going to return the command anyway, ending it releases memory the
controller may still access.

I don't see how we can disable the controller to forcefully end commands
with merged probe and reset work, and thinking these need to be kept
separate. Timeouts are done in a workqueue now, so can we do controller
shutdown inline with the timeout handler?
