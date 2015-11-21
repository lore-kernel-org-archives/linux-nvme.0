From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:34:10 +0100
Subject: [PATCH 02/47] block: fix blk_abort_request for blk-mq drivers
In-Reply-To: <x49oaeob9ei.fsf@segfault.boston.devel.redhat.com>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-3-git-send-email-hch@lst.de>
 <x49oaeob9ei.fsf@segfault.boston.devel.redhat.com>
Message-ID: <20151121073410.GA23894@lst.de>

On Fri, Nov 20, 2015@05:20:21PM -0500, Jeff Moyer wrote:
> > We only added the request to the request list for the !blk-mq case,
> > so we should only delete it in that case as well.
> 
> I think I'd rather see the conditional moved into blk_delete_timer.
> Breaking the balance of add/delete seems ugly to me.  I had expected to
> see a later patch make use of the list, but nothing does.  So, this is
> just a cleanup (as opposed to a preparatory patch), yes ?

It was needed in an earlier version of the series.  Note that it's still
needed e.g. for libsas.
