From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 11:51:30 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <CAL1RGDWvxcz7zAoEa-Ukhmsn=Vuj6O07X666BK+vJOdkA7qwNQ@mail.gmail.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
 <20180605044222.GA29384@lst.de>
 <CAL1RGDWvxcz7zAoEa-Ukhmsn=Vuj6O07X666BK+vJOdkA7qwNQ@mail.gmail.com>
Message-ID: <20180606095130.GA10485@lst.de>

On Tue, Jun 05, 2018@03:57:05PM -0700, Roland Dreier wrote:
> That makes sense but I'm not sure it covers everything.  Probably the
> most common way to do NVMe/RDMA will be with a single HCA that has
> multiple ports, so there's no sensible CPU locality.  On the other
> hand we want to keep both ports to the fabric busy.  Setting different
> paths for different queues makes sense, but there may be
> single-threaded applications that want a  different policy.
> 
> I'm not saying anything very profound, but we have to find the right
> balance between too many and too few knobs.

Agreed.  And the philosophy here is to start with a as few knobs
as possible and work from there based on actual use cases.
Single threaded applications will run into issues with general
blk-mq philosophy, so to work around that we'll need to dig deeper
and allow borrowing of other cpu queues if we want to cater for that.
