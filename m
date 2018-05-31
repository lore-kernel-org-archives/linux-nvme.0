From: hch@lst.de (Christoph Hellwig)
Date: Thu, 31 May 2018 18:34:40 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180531123738.GA10552@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com>
 <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
 <20180531123738.GA10552@redhat.com>
Message-ID: <20180531163440.GB30954@lst.de>

On Thu, May 31, 2018@08:37:39AM -0400, Mike Snitzer wrote:
> I saw your reply to the 1/3 patch.. I do agree it is broken for not
> checking if any handles are active.  But that is easily fixed no?

Doing a switch at runtime simply is a really bad idea.  If for some
reason we end up with a good per-controller switch it would have
to be something set at probe time, and to get it on a controller
you'd need to reset it first.
