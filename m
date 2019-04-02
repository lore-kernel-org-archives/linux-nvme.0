From: david@fromorbit.com (Dave Chinner)
Date: Wed, 3 Apr 2019 07:35:08 +1100
Subject: [PATCH v3 3/7] block: add write-hint to stream-id conversion
In-Reply-To: <20190402092044.GE12133@quack2.suse.cz>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075749epcas2p22b85cbdbb7ccb4f7f3ecf69b84f75dc9@epcas2p2.samsung.com>
 <1553846032-4451-4-git-send-email-joshi.k@samsung.com>
 <20190401050821.GQ23020@dastard>
 <20190402092044.GE12133@quack2.suse.cz>
Message-ID: <20190402203508.GT26298@dastard>

On Tue, Apr 02, 2019@11:20:44AM +0200, Jan Kara wrote:
> On Mon 01-04-19 16:08:21, Dave Chinner wrote:
> > On Fri, Mar 29, 2019@01:23:48PM +0530, Kanchan Joshi wrote:
> > > +		if(streamid > nr_streams)
> > > +			streamid = 0;
> > 
> > So, basically, we'll compress all the kernel hints down to "no hint"
> > if there are more user streams than the device supports?
> > 
> > Surely we should be reserving a stream for the kernel hints separate
> > from the user and "none" streams when we have limited device streams
> > available...
> 
> The question is what to do in a situation when the device has exactly as
> many hints as we currently offer to userspace.

Then do what we do now for that case. For every other case, the
kernel should have reserved space and not get intermingled with
userspace hints.

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
