From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Jan 2018 10:58:51 +0100
Subject: [PATCH 0/5] Failover criteria unification
In-Reply-To: <20180104234727.GA15654@localhost.localdomain>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104233627.GA16051@redhat.com>
 <20180104234727.GA15654@localhost.localdomain>
Message-ID: <20180108095851.GF4673@lst.de>

On Thu, Jan 04, 2018@04:47:27PM -0700, Keith Busch wrote:
> It looks like you can also touch up dm to allow it to multipath nvme
> even if CONFIG_NVME_MULTIPATH is set. It may be useful since native NVMe
> doesn't multipath namespaces across subsystems, and some crack smoking
> people want to create something that requires that.

Right now that is simply not allowed by the spec.  If Dave comes up
with a palatable way to retrofit that into the spec we'll support it.
