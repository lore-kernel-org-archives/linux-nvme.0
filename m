From: keith.busch@gmail.com (Keith Busch)
Date: Wed, 22 May 2019 21:48:10 -0600
Subject: [PATCH 0/2] Reset timeout for paused hardware
In-Reply-To: <20190523032925.GA10601@ming.t460p>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190523032925.GA10601@ming.t460p>
Message-ID: <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>

On Wed, May 22, 2019, 9:29 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, May 22, 2019@11:48:10AM -0600, Keith Busch wrote:
> > Hardware may temporarily stop processing commands that have
> > been dispatched to it while activating new firmware. Some target
> > implementation's paused state time exceeds the default request expiry,
> > so any request dispatched before the driver could quiesce for the
> > hardware's paused state will time out, and handling this may interrupt
> > the firmware activation.
> >
> > This two-part series provides a way for drivers to reset dispatched
> > requests' timeout deadline, then uses this new mechanism from the nvme
> > driver's fw activation work.
>
> Just wondering why not freeze IO queues before updating FW?


Yeah, that's a good question. A FW update may have been initiated out
of band or from another host entirely. The driver can't count on
preparing for hardware pausing command processing before it's
happened, but we'll always find out asynchronously after it's too late
to freeze.
