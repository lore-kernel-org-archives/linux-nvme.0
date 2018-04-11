From: snitzer@redhat.com (Mike Snitzer)
Date: Wed, 11 Apr 2018 10:17:21 -0400
Subject: 'modprobe nvme_core multipath=N' crashes in face of multipath
 fabric
In-Reply-To: <20180411134530.GC9238@localhost.localdomain>
References: <20180410204953.GA17979@redhat.com>
 <20180411134530.GC9238@localhost.localdomain>
Message-ID: <20180411141720.GB22124@redhat.com>

On Wed, Apr 11 2018 at  9:45am -0400,
Keith Busch <keith.busch@intel.com> wrote:

> On Tue, Apr 10, 2018@04:49:53PM -0400, Mike Snitzer wrote:
> > This isn't new since the 4.17 merge or anything, I first noticed this
> > issue existed while using a 4.16-rc4 kernel.
> > 
> > modprobe nvme_core multipath=N
> 
> Thanks for the notice.
> 
> There is definitely a bug here when CONFIG_NVME_MULTIPATH=y but nvme_core
> multipath is disabled in the presence of shared namespaces. I think we'd
> need each namespace to get a different "head" out of the subsystem in
> this case, but it may take a moment for me to detangle this.

No problem, it certainly isn't something I could tackle any quicker ;)

Thanks for looking to resolve this though.
