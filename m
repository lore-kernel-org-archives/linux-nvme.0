From: roland@purestorage.com (Roland Dreier)
Date: Tue, 5 Jun 2018 15:57:05 -0700
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180605044222.GA29384@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
 <20180605044222.GA29384@lst.de>
Message-ID: <CAL1RGDWvxcz7zAoEa-Ukhmsn=Vuj6O07X666BK+vJOdkA7qwNQ@mail.gmail.com>

> The sensible thing to do in nvme is to use different paths for
> different queues.  That is e.g. in the RDMA case use the HCA closer
> to a given CPU by default.  We might allow to override this for
> cases where the is a good reason, but what I really don't want is
> configurability for configurabilities sake.

That makes sense but I'm not sure it covers everything.  Probably the
most common way to do NVMe/RDMA will be with a single HCA that has
multiple ports, so there's no sensible CPU locality.  On the other
hand we want to keep both ports to the fabric busy.  Setting different
paths for different queues makes sense, but there may be
single-threaded applications that want a  different policy.

I'm not saying anything very profound, but we have to find the right
balance between too many and too few knobs.

 - R.
