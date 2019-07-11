From: parav@mellanox.com (Parav Pandit)
Date: Thu, 11 Jul 2019 16:18:45 +0000
Subject: regression: nvme rdma with bnxt_re0 broken
In-Reply-To: <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
Message-ID: <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>

Sagi,

This is better one to cc to linux-rdma.

+ Devesh, Selvin.

> -----Original Message-----
> From: Parav Pandit
> Sent: Thursday, July 11, 2019 6:25 PM
> To: Yi Zhang <yi.zhang at redhat.com>; linux-nvme at lists.infradead.org
> Cc: Daniel Jurgens <danielj at mellanox.com>
> Subject: RE: regression: nvme rdma with bnxt_re0 broken
> 
> Hi Yi Zhang,
> 
> > -----Original Message-----
> > From: Yi Zhang <yi.zhang at redhat.com>
> > Sent: Thursday, July 11, 2019 3:17 PM
> > To: linux-nvme at lists.infradead.org
> > Cc: Daniel Jurgens <danielj at mellanox.com>; Parav Pandit
> > <parav at mellanox.com>
> > Subject: regression: nvme rdma with bnxt_re0 broken
> >
> > Hello
> >
> > 'nvme connect' failed when use bnxt_re0 on latest upstream build[1],
> > by bisecting I found it was introduced from v5.2.0-rc1 with [2], it
> > works after I revert it.
> > Let me know if you need more info, thanks.
> >
> > [1]
> > [root at rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420
> > -n testnqn Failed to write to /dev/nvme-fabrics: Bad address
> >
> > [root at rdma-perf-07 ~]$ dmesg
> > [  476.320742] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x4b9]=0x15 status
> > 0x5 [ 476.327103] infiniband bnxt_re0: Failed to allocate HW AH [
> > 476.332525] nvme nvme2: rdma_connect failed (-14).
> > [  476.343552] nvme nvme2: rdma connection establishment failed (-14)
> >
> > [root at rdma-perf-07 ~]$ lspci  | grep -i Broadcom
> > 01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> > BCM5720 2-port Gigabit Ethernet PCIe
> > 01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> > BCM5720 2-port Gigabit Ethernet PCIe
> > 18:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury]
> > (rev
> > 02)
> > 19:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412
> > NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> > 19:00.1 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412
> > NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> >
> >
> > [2]
> > commit 823b23da71132b80d9f41ab667c68b112455f3b6
> > Author: Parav Pandit <parav at mellanox.com>
> > Date:   Wed Apr 10 11:23:03 2019 +0300
> >
> >     IB/core: Allow vlan link local address based RoCE GIDs
> >
> >     IPv6 link local address for a VLAN netdevice has nothing to do with its
> >     resemblance with the default GID, because VLAN link local GID is in
> >     different layer 2 domain.
> >
> >     Now that RoCE MAD packet processing and route resolution consider the
> >     right GID index, there is no need for an unnecessary check which prevents
> >     the addition of vlan based IPv6 link local GIDs.
> >
> >     Signed-off-by: Parav Pandit <parav at mellanox.com>
> >     Reviewed-by: Daniel Jurgens <danielj at mellanox.com>
> >     Signed-off-by: Leon Romanovsky <leonro at mellanox.com>
> >     Signed-off-by: Jason Gunthorpe <jgg at mellanox.com>
> >
> >
> >
> > Best Regards,
> >   Yi Zhang
> >
> 
> I need some more information from you to debug this issue as I don?t have the
> hw.
> The highlighted patch added support for IPv6 link local address for vlan. I am
> unsure how this can affect IPv4 AH creation for which there is failure.
> 
> 1. Before you assign the IP address to the netdevice, Please do, echo -n
> "module ib_core +p" > /sys/kernel/debug/dynamic_debug/control
> 
> Please share below output before doing nvme connect.
> 2. Output of script [1]
> $ show_gids script
> If getting this script is problematic, share the output of,
> 
> $ cat /sys/class/infiniband/bnxt_re0/ports/1/gids/*
> $ cat /sys/class/infiniband/bnxt_re0/ports/1/gid_attrs/ndevs/*
> $ ip link show
> $ip addr show
> $ dmesg
> 
> [1] https://community.mellanox.com/s/article/understanding-show-gids-
> script#jive_content_id_The_Script
> 
> I suspect that driver's assumption about GID indices might have gone wrong
> here in drivers/infiniband/hw/bnxt_re/ib_verbs.c.
> Lets see about results to confirm that.
