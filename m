From: joshi.k@samsung.com (kanchan)
Date: Wed, 3 Apr 2019 20:17:32 +0530
Subject: [PATCH v3 3/7] block: add write-hint to stream-id conversion
In-Reply-To: <20190403093610.GE8836@quack2.suse.cz>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075749epcas2p22b85cbdbb7ccb4f7f3ecf69b84f75dc9@epcas2p2.samsung.com>
 <1553846032-4451-4-git-send-email-joshi.k@samsung.com>
 <20190401050821.GQ23020@dastard> <20190402092044.GE12133@quack2.suse.cz>
 <20190402203508.GT26298@dastard> <20190403093610.GE8836@quack2.suse.cz>
Message-ID: <11cf01d4ea2c$32666920$97333b60$@samsung.com>

> Then do what we do now for that case. For every other case, the kernel 
> should have reserved space and not get intermingled with userspace 
> hints.

I hope this means that we're fine with the current conversion approach. 
As you would have noticed, current approach does not disable stream feature
based on dearth of streams.
It either exposes 8 streams (if device has equal or more than 8 streams) or
N streams (if N is less than 8). 
For less than 8 streams case, user-space hints get priority over
kernel-space hints. But at any point of time, there is no intermingling.


Thanks,
Kanchan

-----Original Message-----
From: Jan Kara [mailto:jack@suse.cz] 
Sent: Wednesday, April 03, 2019 3:06 PM
To: Dave Chinner <david at fromorbit.com>
Cc: Jan Kara <jack at suse.cz>; Kanchan Joshi <joshi.k at samsung.com>;
linux-kernel at vger.kernel.org; linux-block at vger.kernel.org;
linux-nvme at lists.infradead.org; linux-fsdevel at vger.kernel.org;
linux-ext4 at vger.kernel.org; axboe at fb.com; prakash.v at samsung.com;
anshul at samsung.com; joshiiitr at gmail.com
Subject: Re: [PATCH v3 3/7] block: add write-hint to stream-id conversion

On Wed 03-04-19 07:35:08, Dave Chinner wrote:
> On Tue, Apr 02, 2019@11:20:44AM +0200, Jan Kara wrote:
> > On Mon 01-04-19 16:08:21, Dave Chinner wrote:
> > > On Fri, Mar 29, 2019@01:23:48PM +0530, Kanchan Joshi wrote:
> > > > +		if(streamid > nr_streams)
> > > > +			streamid = 0;
> > > 
> > > So, basically, we'll compress all the kernel hints down to "no hint"
> > > if there are more user streams than the device supports?
> > > 
> > > Surely we should be reserving a stream for the kernel hints 
> > > separate from the user and "none" streams when we have limited 
> > > device streams available...
> > 
> > The question is what to do in a situation when the device has 
> > exactly as many hints as we currently offer to userspace.
> 
> Then do what we do now for that case. For every other case, the kernel 
> should have reserved space and not get intermingled with userspace 
> hints.

Yup, we are on the same page then.

								Honza
--
Jan Kara <jack at suse.com>
SUSE Labs, CR
