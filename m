From: yi.zhang@redhat.com (Yi Zhang)
Date: Thu, 11 Jul 2019 05:47:13 -0400 (EDT)
Subject: regression: nvme rdma with bnxt_re0 broken
In-Reply-To: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
Message-ID: <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>

Hello

'nvme connect' failed when use bnxt_re0 on latest upstream build[1], by bisecting I found it was introduced from v5.2.0-rc1 with [2], it works after I revert it.
Let me know if you need more info, thanks.

[1]
[root at rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420 -n testnqn
Failed to write to /dev/nvme-fabrics: Bad address

[root at rdma-perf-07 ~]$ dmesg
[  476.320742] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x4b9]=0x15 status 0x5
[  476.327103] infiniband bnxt_re0: Failed to allocate HW AH
[  476.332525] nvme nvme2: rdma_connect failed (-14).
[  476.343552] nvme nvme2: rdma connection establishment failed (-14)

[root at rdma-perf-07 ~]$ lspci  | grep -i Broadcom
01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720 2-port Gigabit Ethernet PCIe
01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720 2-port Gigabit Ethernet PCIe
18:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury] (rev 02)
19:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
19:00.1 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)


[2]
commit 823b23da71132b80d9f41ab667c68b112455f3b6
Author: Parav Pandit <parav at mellanox.com>
Date:   Wed Apr 10 11:23:03 2019 +0300

    IB/core: Allow vlan link local address based RoCE GIDs
    
    IPv6 link local address for a VLAN netdevice has nothing to do with its
    resemblance with the default GID, because VLAN link local GID is in
    different layer 2 domain.
    
    Now that RoCE MAD packet processing and route resolution consider the
    right GID index, there is no need for an unnecessary check which prevents
    the addition of vlan based IPv6 link local GIDs.
    
    Signed-off-by: Parav Pandit <parav at mellanox.com>
    Reviewed-by: Daniel Jurgens <danielj at mellanox.com>
    Signed-off-by: Leon Romanovsky <leonro at mellanox.com>
    Signed-off-by: Jason Gunthorpe <jgg at mellanox.com>



Best Regards,
  Yi Zhang
