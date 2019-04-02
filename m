From: jack@suse.cz (Jan Kara)
Date: Tue, 2 Apr 2019 11:20:44 +0200
Subject: [PATCH v3 3/7] block: add write-hint to stream-id conversion
In-Reply-To: <20190401050821.GQ23020@dastard>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075749epcas2p22b85cbdbb7ccb4f7f3ecf69b84f75dc9@epcas2p2.samsung.com>
 <1553846032-4451-4-git-send-email-joshi.k@samsung.com>
 <20190401050821.GQ23020@dastard>
Message-ID: <20190402092044.GE12133@quack2.suse.cz>

On Mon 01-04-19 16:08:21, Dave Chinner wrote:
> On Fri, Mar 29, 2019@01:23:48PM +0530, Kanchan Joshi wrote:
> > +		if(streamid > nr_streams)
> > +			streamid = 0;
> 
> So, basically, we'll compress all the kernel hints down to "no hint"
> if there are more user streams than the device supports?
> 
> Surely we should be reserving a stream for the kernel hints separate
> from the user and "none" streams when we have limited device streams
> available...

The question is what to do in a situation when the device has exactly as
many hints as we currently offer to userspace. Because currently either the
device has enough hints for all userspace hint values or we disable the
feature altogether. If we always mandated some hints are available for the
kernel, we'd have to regress some fuctionality currently available to
userspace. So I think that the option that the kernel won't get any hints
is the least painful solution. Later when people would like to extend hints
available to userspace, we could make sure kernel's batch of hints has
priority over these "extended userspace hints". 

								Honza
-- 
Jan Kara <jack at suse.com>
SUSE Labs, CR
