From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 31 May 2018 14:17:57 -0400
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180531163311.GA30954@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com> <20180531163311.GA30954@lst.de>
Message-ID: <20180531181757.GB11848@redhat.com>

On Thu, May 31 2018 at 12:33pm -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, May 30, 2018@06:02:06PM -0400, Mike Snitzer wrote:
> > Because once nvme_core.multipath=N is set: native NVMe multipath is then
> > not accessible from the same host.  The goal of this patchset is to give
> > users choice.  But not limit them to _only_ using dm-multipath if they
> > just have some legacy needs.
> 
> Choise by itself really isn't an argument.  We need a really good
> use case for all the complexity, and so far none has been presented.

OK, but its choice that is governed by higher level requirements that _I_
personally don't have.  They are large datacenter deployments like
Hannes eluded to [1] where there is heavy automation and/or layered
products that are developed around dm-multipath (via libraries to access
multipath-tools provided info, etc).

So trying to pin me down on _why_ users elect to make this choice (or
that there is such annoying inertia behind their choice) really isn't
fair TBH.  They exist.  Please just accept that.

Now another hypothetical usecase I thought of today, that really drives
home _why_ it useful to have this fine-grained 'mpath_personality'
flexibility is: admin containers.  (not saying people or companies
currently, or plan to, do this but they very easily could...):
1) container A is tasked with managing some dedicated NVMe technology
   that absolutely needs native NVMe multipath.
2) container B is tasked with offering some canned layered product that
   was developed ontop of dm-multipath with its own multipath-tools
   oriented APIs, etc. And it is to manage some other NVMe technology on
   the same host as container A.

So, containers with conflicting requirements running on the same host.

Now you can say: sorry don't do that.  But that really isn't a valid
counter.

Point is it really is meaningful to offer this 'mpath_personality'
switch.  I'm obviously hopeful for it to not be heavily used BUT not
providing the ability for native NVMe multipath and dm-multipath to
coexist on the same Linux host really isn't viable in the near-term.

Mike

[1] https://lkml.org/lkml/2018/5/29/95
