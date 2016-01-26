From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 26 Jan 2016 08:29:39 -0500
Subject: dm-multipath low performance with blk-mq
In-Reply-To: <20160125233717.GQ24960@octiron.msp.redhat.com>
References: <569E11EA.8000305@dev.mellanox.co.il>
 <20160119224512.GA10515@redhat.com>
 <20160125214016.GA10060@redhat.com>
 <20160125233717.GQ24960@octiron.msp.redhat.com>
Message-ID: <20160126132939.GA23967@redhat.com>

On Mon, Jan 25 2016 at  6:37pm -0500,
Benjamin Marzinski <bmarzins@redhat.com> wrote:

> On Mon, Jan 25, 2016@04:40:16PM -0500, Mike Snitzer wrote:
> > On Tue, Jan 19 2016 at  5:45P -0500,
> > Mike Snitzer <snitzer@redhat.com> wrote:
> 
> I don't think this is going to help __multipath_map() without some
> configuration changes.  Now that we're running on already merged
> requests instead of bios, the m->repeat_count is almost always set to 1,
> so we call the path_selector every time, which means that we'll always
> need the write lock. Bumping up the number of IOs we send before calling
> the path selector again will give this patch a change to do some good
> here.
> 
> To do that you need to set:
> 
> 	rr_min_io_rq <something_bigger_than_one>
> 
> in the defaults section of /etc/multipath.conf and then reload the
> multipathd service.
> 
> The patch should hopefully help in multipath_busy() regardless of the
> the rr_min_io_rq setting.

This patch, while generic, is meant to help the blk-mq case.  A blk-mq
request_queue doesn't have an elevator so the requests will not have
seen merging.

But yes, implied in the patch is the requirement to increase
m->repeat_count via multipathd's rr_min_io_rq (I'll backfill a proper
header once it is tested).

Thanks,
Mike
