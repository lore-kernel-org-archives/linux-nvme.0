From: keith.busch@intel.com (Keith Busch)
Date: Thu, 4 Jan 2018 16:47:27 -0700
Subject: [PATCH 0/5] Failover criteria unification
In-Reply-To: <20180104233627.GA16051@redhat.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104233627.GA16051@redhat.com>
Message-ID: <20180104234727.GA15654@localhost.localdomain>

On Thu, Jan 04, 2018@06:36:27PM -0500, Mike Snitzer wrote:
> Right, I dropped that patch since it'd have only resulted in conflicts
> come merge time.  As such, this series can easily go through the nvme
> tree to Jens.

It looks like you can also touch up dm to allow it to multipath nvme
even if CONFIG_NVME_MULTIPATH is set. It may be useful since native NVMe
doesn't multipath namespaces across subsystems, and some crack smoking
people want to create something that requires that.
