From: shiraz.saleem@intel.com (Shiraz Saleem)
Date: Wed, 23 Jan 2019 09:00:15 -0600
Subject: [PATCH] nvme-rdma: rework queue maps handling
In-Reply-To: <20190119005406.12855-1-sagi@grimberg.me>
References: <20190119005406.12855-1-sagi@grimberg.me>
Message-ID: <20190123150015.GA6596@ssaleem-MOBL4.amr.corp.intel.com>

On Fri, Jan 18, 2019@04:54:06PM -0800, Sagi Grimberg wrote:
> If the device supports less queues than provided (if the device has less
> completion vectors), we might hit a bug due to the fact that we ignore
> that in nvme_rdma_map_queues (we override the maps nr_queues with user
> opts).
> 
> Instead, keep track of how many default/read/poll queues we actually
> allocated (rather than asked by the user) and use that to assign our
> queue mappings.
> 
> Fixes: b65bb777ef22 (" nvme-rdma: support separate queue maps for read and write")
> Reported-by: Saleem, Shiraz <shiraz.saleem at intel.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

This patch fixes the reported problem on i40iw. Thanks!

Shiraz
