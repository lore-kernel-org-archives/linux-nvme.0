From: hch@lst.de (Christoph Hellwig)
Date: Tue, 5 Jun 2018 06:42:23 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
Message-ID: <20180605044222.GA29384@lst.de>

On Mon, Jun 04, 2018@02:58:49PM -0700, Roland Dreier wrote:
> We plan to implement all the fancy NVMe standards like ANA, but it
> seems that there is still a requirement to let the host side choose
> policies about how to use paths (round-robin vs least queue depth for
> example).  Even in the modern SCSI world with VPD pages and ALUA,
> there are still knobs that are needed.  Maybe NVMe will be different
> and we can find defaults that work in all cases but I have to admit
> I'm skeptical...

The sensible thing to do in nvme is to use different paths for
different queues.  That is e.g. in the RDMA case use the HCA closer
to a given CPU by default.  We might allow to override this for
cases where the is a good reason, but what I really don't want is
configurability for configurabilities sake.
