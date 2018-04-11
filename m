From: keith.busch@intel.com (Keith Busch)
Date: Wed, 11 Apr 2018 07:45:30 -0600
Subject: 'modprobe nvme_core multipath=N' crashes in face of multipath
 fabric
In-Reply-To: <20180410204953.GA17979@redhat.com>
References: <20180410204953.GA17979@redhat.com>
Message-ID: <20180411134530.GC9238@localhost.localdomain>

On Tue, Apr 10, 2018@04:49:53PM -0400, Mike Snitzer wrote:
> This isn't new since the 4.17 merge or anything, I first noticed this
> issue existed while using a 4.16-rc4 kernel.
> 
> modprobe nvme_core multipath=N

Thanks for the notice.

There is definitely a bug here when CONFIG_NVME_MULTIPATH=y but nvme_core
multipath is disabled in the presence of shared namespaces. I think we'd
need each namespace to get a different "head" out of the subsystem in
this case, but it may take a moment for me to detangle this.
