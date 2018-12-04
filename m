From: keith.busch@intel.com (Keith Busch)
Date: Tue, 4 Dec 2018 08:46:00 -0700
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
Message-ID: <20181204154559.GJ14775@localhost.localdomain>

On Mon, Dec 03, 2018@05:33:06PM -0800, Sagi Grimberg wrote:
> >>
> > Yes, I'm very much in favour of this, too.
> > We always have this IMO slightly weird notion of stopping the queue, set 
> > some error flags in the driver, then _restarting_ the queue, just so 
> > that the driver then sees the error flag and terminates the requests.
> > Which I always found quite counter-intuitive.
> 
> What about requests that come in after the iteration runs? how are those
> terminated?

If we've reached a dead state, I think you'd want to start a queue freeze
before running the terminating iterator.
