From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 1 Aug 2016 04:18:59 -0700
Subject: [PATCH v2] nvme-cli: user-defined hostnqn option for discover
In-Reply-To: <1469824719-7378-2-git-send-email-james_p_freyensee@linux.intel.com>
References: <1469824719-7378-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1469824719-7378-2-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20160801111859.GA28246@infradead.org>

On Fri, Jul 29, 2016@01:38:39PM -0700, Jay Freyensee wrote:
> The nvme-cli will always use the default hostnqn
> in /dev/nvme-fabrics  for the discovery query, even though
> both the NVMe Target and NVMe Host rdma implementations allow
> user-defined hostnqn naming.
> 
> For example, this is the current, somewhat broken behavior if you
> used your own hostnqn provision naming on the NVMe kernel target:

Maybe -n or -N would be a good choice for the short option flag?

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>

Any chance you could also send a patch that reads /etc/nvme/hostnqn
for a default hostnqn so that we can have a persistent one?
