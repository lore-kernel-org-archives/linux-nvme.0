From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 4 Jan 2018 19:07:44 -0500
Subject: [PATCH 0/5] Failover criteria unification
In-Reply-To: <20180104234727.GA15654@localhost.localdomain>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104233627.GA16051@redhat.com>
 <20180104234727.GA15654@localhost.localdomain>
Message-ID: <20180105000744.GG16051@redhat.com>

On Thu, Jan 04 2018 at  6:47pm -0500,
Keith Busch <keith.busch@intel.com> wrote:

> On Thu, Jan 04, 2018@06:36:27PM -0500, Mike Snitzer wrote:
> > Right, I dropped that patch since it'd have only resulted in conflicts
> > come merge time.  As such, this series can easily go through the nvme
> > tree to Jens.
> 
> It looks like you can also touch up dm to allow it to multipath nvme
> even if CONFIG_NVME_MULTIPATH is set. It may be useful since native NVMe
> doesn't multipath namespaces across subsystems, and some crack smoking
> people want to create something that requires that.

I had a "CONFIG_NVME_MULITIPATH=Y" typo in the dm-mpath.c commit that
added the CONFIG_NVME_MULTIPATH mutual exclussion in dm-4.16; so I
just dropped it via rebase.

So now the underlying nvme devices (already multipath'd by NVMe) should
be discoverable by multipathd.  Who am I to judge crack smokers?
