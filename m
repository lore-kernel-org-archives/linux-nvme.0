From: keith.busch@intel.com (Keith Busch)
Date: Wed, 22 May 2019 16:49:55 -0600
Subject: [PATCH 9/9] nvme: Retrieve namespaces during list-subsys cmd
In-Reply-To: <1558543193-24752-10-git-send-email-maxg@mellanox.com>
References: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
 <1558543193-24752-10-git-send-email-maxg@mellanox.com>
Message-ID: <20190522224955.GC5857@localhost.localdomain>

On Wed, May 22, 2019@07:39:53PM +0300, Max Gurtovoy wrote:
> Add an association between subsystems/ctrls/namespaces using
> "nvme list-subsys" command. Now this command will show the following:
> 
> nvme-subsys4 - NQN=testsubsystem_0
> \
>  +- nvme4 rdma traddr=12.212.99.85 trsvcid=4420 live
>  \
>   +- nvme4n1
>   +- nvme4n2
>   +- nvme4n3
>  +- nvme5 rdma traddr=12.212.99.85 trsvcid=4420 live
>  \
>   +- nvme5n1
>   +- nvme5n2
>   +- nvme5n3
> 
> Instead of:
> ----------------
> nvme-subsys4 - NQN=testsubsystem_0
> \
>  +- nvme4 rdma traddr=12.212.99.85 trsvcid=4420
>  +- nvme5 rdma traddr=12.212.99.85 trsvcid=4420

This is a terrific start. Your output indicates you are not using
nvme native multipathing, though. Could you retry this command with
that enabled (I'll try it tomorrow as well)?
