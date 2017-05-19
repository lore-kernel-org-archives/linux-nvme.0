From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 May 2017 11:15:13 -0400
Subject: [PATCH 1/2] nvme: fix race between removing and reseting failure
In-Reply-To: <20170519125244.GB22585@ming.t460p>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-2-ming.lei@redhat.com>
 <20170518141307.GD28520@localhost.localdomain>
 <20170519125244.GB22585@ming.t460p>
Message-ID: <20170519151513.GB7850@localhost.localdomain>

On Fri, May 19, 2017@08:52:45PM +0800, Ming Lei wrote:
> But I still think it may be better to move nvme_kill_queues() into
> nvme_remove_dead_ctrl() as an improvement because during this small
> window page cache can be used up by write application, and no writeback
> can move on meantime.

Yes, I agree that's a better placement for it. I was just concerned
about the reasoning since it would also mean we're still stuck if an
IO timeout occurs while calling del_gendisk. So I'm okay with the patch
as-is, but I'll also look into my other concern.
