From: keith.busch@intel.com (Keith Busch)
Date: Mon, 14 Aug 2017 15:17:45 -0400
Subject: [PATCH] nvme-cli/fabrics: Add ctrl-loss-tmo param to connect cmd
In-Reply-To: <1502639104-27315-1-git-send-email-maxg@mellanox.com>
References: <1502639104-27315-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170814191745.GG7233@localhost.localdomain>

On Sun, Aug 13, 2017@06:45:04PM +0300, Max Gurtovoy wrote:
> From: Nitzan Carmi <nitzanc at mellanox.com>
> 
> Added 'ctrl-loss-tmo' to 'connect' command so users can specify the
> controller lost timeout period.
> 
> usage examples:
> nvme connect --ctrl-loss-tmo=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
> nvme connect -l 0 -t rdma -a 10.0.1.1 -n test_nvme
> 
> Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

Looks good, applied.
