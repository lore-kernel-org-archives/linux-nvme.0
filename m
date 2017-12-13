From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Dec 2017 08:35:10 -0700
Subject: [PATCH nvme-cli v2] nvme: Introduce new 'list-subsys' command
In-Reply-To: <20171213143417.19489-1-jthumshirn@suse.de>
References: <20171213143417.19489-1-jthumshirn@suse.de>
Message-ID: <20171213153510.GL11218@localhost.localdomain>

On Wed, Dec 13, 2017@03:34:17PM +0100, Johannes Thumshirn wrote:
> Introduce a 'nvme list-subsys' command to give basic information about
> connected NVMe subsystems.
> 
> Here's an example output of a host connected to two subsystems on the
> target with two paths to each subsystem:
> root at host# nvme list-subsys
> nvme-subsys0 - NQN=nvmf-test
> \
>  +- nvme0 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1
>  +- nvme1 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2
> nvme-subsys1 - NQN=nvmf-test2
> \
>  +- nvme2 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2
>  +- nvme3 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Thanks, this looks good to me! Applied.
