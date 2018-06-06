From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 11:50:29 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <4203e888-df87-efd6-f61a-24b43fb710e2@grimberg.me>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
 <20180605044222.GA29384@lst.de>
 <4203e888-df87-efd6-f61a-24b43fb710e2@grimberg.me>
Message-ID: <20180606095029.GA10439@lst.de>

On Wed, Jun 06, 2018@12:32:21PM +0300, Sagi Grimberg wrote:
> Huh? different paths == different controllers so this sentence can't
> be right... you mean that a path selector will select a controller
> based on the home node of the local rdma device connecting to it and
> the running cpu right?

Think of a system with say 8 cpu cores.  Say we have two optimized
paths.

There is no point in going round robin or service time over the
two paths for each logic pre-cpu queue.  Instead we should always
got to path A for a given cpu queue or path B to reduce selection
overhead and cache footprint.
