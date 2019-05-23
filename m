From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 24 May 2019 00:11:43 +0900
Subject: [PATCH 9/9] nvme: Retrieve namespaces during list-subsys cmd
In-Reply-To: <1558602058-29434-10-git-send-email-maxg@mellanox.com>
References: <1558602058-29434-1-git-send-email-maxg@mellanox.com>
 <1558602058-29434-10-git-send-email-maxg@mellanox.com>
Message-ID: <20190523151141.GA27763@minwooim-desktop>

On 19-05-23 12:00:58, Max Gurtovoy wrote:
> Add an association between subsystems/ctrls/namespaces using
> "nvme list-subsys" command. Now this command will show the following:
> 
> nvme-subsys3 - NQN=nqn.2014.08.org.nvmexpress:80868086CVCQ5234001C400AGN INTEL SSDPEDMW400G4
> \
>  +- nvme0 pcie 0000:08:00.0 live
>  \
>   +- nvme3n1
> nvme-subsys4 - NQN=testsubsystem_0
> \
>  +- nvme4 rdma traddr=1.212.99.85 trsvcid=4420 live
>  \
>   +- nvme4c1n1
>   +- nvme4c1n2
>   +- nvme4c1n3
>  +- nvme5 rdma traddr=1.212.99.85 trsvcid=4420 live
>  \
>   +- nvme4c2n1
>   +- nvme4c2n2
>   +- nvme4c2n3
> 

Tested-by: Minwoo Im <minwoo.im.dev at gmail.com>

> The new json output is (partial):
> --------------------------
> {
>       "Name" : "nvme-subsys4",
>       "NQN" : "testsubsystem_0",
>       "Ctrls" : [
>         {
>           "Name" : "nvme4",
>           "Transport" : "rdma",
>           "Address" : "traddr=1.212.99.85 trsvcid=4420",
>           "State" : "live",
>           "Namespaces" : [
>             {
>               "Name" : "nvme4c1n1"
>             },
>             {
>               "Name" : "nvme4c1n2"
>             },
>             {
>               "Name" : "nvme4c1n3"
>             }
>           ]
>         },
>         {
>           "Name" : "nvme5",
>           "Transport" : "rdma",
>           "Address" : "traddr=1.212.99.85 trsvcid=4420",
>           "State" : "live",
>           "Namespaces" : [
>             {
>               "Name" : "nvme4c2n1"
>             },
>             {
>               "Name" : "nvme4c2n2"
>             },
>             {
>               "Name" : "nvme4c2n3"
>             }
>           ]
>         }
>       ]
> }
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
