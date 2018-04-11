From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 11 Apr 2018 19:17:13 +0300
Subject: [PATCH rfc 0/3] nvmet-rdma automatic port re-activation
In-Reply-To: <20180322190303.10951-1-sagi@grimberg.me>
References: <20180322190303.10951-1-sagi@grimberg.me>
Message-ID: <053ca9f3-2237-e270-82cd-d99d123bde1c@mellanox.com>

Hi Sagi,
Can we add it to the v4.17 cycle with the small fixes/updates needed ?

On 3/22/2018 9:02 PM, Sagi Grimberg wrote:
> When a RDMA device goes away we must destroy all it's associated
> RDMA resources. RDMa device resets also manifest as device removal
> events and a short while after they come back. We want to re-activate
> a port listener on this RDMA device when it comes back in to the system.
> 
> In order to make it happen, we save the RDMA device node_guid on a
> ULP listener representation (nvmet_rdma_port) and when a RDMA device
> comes into the system, we check if there is a listener port that needs
> to be re-activated.
> 
> In addition, reflect the port state to the sysadmin.
> 
> Israel Rukshin (2):
>    nvmet: Add fabrics ops to port
>    nvmet: Add port transport active flag
> 
> Sagi Grimberg (1):
>    nvmet-rdma: automatic listening port re-activation
> 
>   drivers/nvme/target/configfs.c |  10 ++
>   drivers/nvme/target/core.c     |  17 ++-
>   drivers/nvme/target/nvmet.h    |   3 +
>   drivers/nvme/target/rdma.c     | 231 +++++++++++++++++++++++++----------------
>   4 files changed, 169 insertions(+), 92 deletions(-)
> 
