From: parav@mellanox.com (Parav Pandit)
Date: Fri, 12 Jul 2019 09:39:40 +0000
Subject: regression: nvme rdma with bnxt_re0 broken
In-Reply-To: <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
Message-ID: <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>



> -----Original Message-----
> From: linux-rdma-owner at vger.kernel.org <linux-rdma-
> owner at vger.kernel.org> On Behalf Of Parav Pandit
> Sent: Friday, July 12, 2019 2:58 PM
> To: Selvin Xavier <selvin.xavier at broadcom.com>
> Cc: Yi Zhang <yi.zhang at redhat.com>; linux-nvme at lists.infradead.org; Daniel
> Jurgens <danielj at mellanox.com>; linux-rdma at vger.kernel.org; Devesh
> Sharma <devesh.sharma at broadcom.com>
> Subject: RE: regression: nvme rdma with bnxt_re0 broken
> 
> Hi Selvin,
> 
> > -----Original Message-----
> > From: Selvin Xavier <selvin.xavier at broadcom.com>
> > Sent: Friday, July 12, 2019 9:16 AM
> > To: Parav Pandit <parav at mellanox.com>
> > Cc: Yi Zhang <yi.zhang at redhat.com>; linux-nvme at lists.infradead.org;
> > Daniel Jurgens <danielj at mellanox.com>; linux-rdma at vger.kernel.org;
> > Devesh Sharma <devesh.sharma at broadcom.com>
> > Subject: Re: regression: nvme rdma with bnxt_re0 broken
> >
> > On Fri, Jul 12, 2019@8:19 AM Parav Pandit <parav@mellanox.com> wrote:
> > >
> > > Hi Yi Zhang,
> > >
> > > > -----Original Message-----
> > > > From: linux-rdma-owner at vger.kernel.org <linux-rdma-
> > > > owner at vger.kernel.org> On Behalf Of Yi Zhang
> > > > Sent: Friday, July 12, 2019 7:23 AM
> > > > To: Parav Pandit <parav at mellanox.com>;
> > > > linux-nvme at lists.infradead.org
> > > > Cc: Daniel Jurgens <danielj at mellanox.com>;
> > > > linux-rdma at vger.kernel.org; Devesh Sharma
> > > > <devesh.sharma at broadcom.com>; selvin.xavier at broadcom.com
> > > > Subject: Re: regression: nvme rdma with bnxt_re0 broken
> > > >
> > > > Hi Parav
> > > >
> > > > Here is the info, let me know if it's enough, thanks.
> > > >
> > > > [root at rdma-perf-07 ~]$ echo -n "module ib_core +p" >
> > > > /sys/kernel/debug/dynamic_debug/control
> > > > [root at rdma-perf-07 ~]$ ifdown bnxt_roce Device 'bnxt_roce'
> > > > successfully disconnected.
> > > > [root at rdma-perf-07 ~]$ ifup bnxt_roce Connection successfully
> > > > activated (D-Bus active path:
> > > > /org/freedesktop/NetworkManager/ActiveConnection/16)
> > > > [root at rdma-perf-07 ~]$ sh a.sh
> > > > DEV    PORT    INDEX    GID                    IPv4         VER DEV
> > > > ---    ----    -----    ---                    ------------ ---    ---
> > > > bnxt_re0    1    0    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > > > v1    bnxt_roce
> > > > bnxt_re0    1    1    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > > > v2    bnxt_roce
> > > > bnxt_re0    1    10    0000:0000:0000:0000:0000:ffff:ac1f:2bbb
> > > > 172.31.43.187     v1    bnxt_roce.43
> > > > bnxt_re0    1    11    0000:0000:0000:0000:0000:ffff:ac1f:2bbb
> > > > 172.31.43.187     v2    bnxt_roce.43
> > > > bnxt_re0    1    2    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > > > v1    bnxt_roce.45
> > > > bnxt_re0    1    3    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > > > v2    bnxt_roce.45
> > > > bnxt_re0    1    4    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > > > v1    bnxt_roce.43
> > > > bnxt_re0    1    5    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > > > v2    bnxt_roce.43
> > > > bnxt_re0    1    6    0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > > > 172.31.40.187     v1    bnxt_roce
> > > > bnxt_re0    1    7    0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > > > 172.31.40.187     v2    bnxt_roce
> > > > bnxt_re0    1    8    0000:0000:0000:0000:0000:ffff:ac1f:2dbb
> > > > 172.31.45.187     v1    bnxt_roce.45
> > > > bnxt_re0    1    9    0000:0000:0000:0000:0000:ffff:ac1f:2dbb
> > > > 172.31.45.187     v2    bnxt_roce.45
> > > > bnxt_re1    1    0    fe80:0000:0000:0000:020a:f7ff:fee3:6e33
> > > > v1    lom_2
> > > > bnxt_re1    1    1    fe80:0000:0000:0000:020a:f7ff:fee3:6e33
> > > > v2    lom_2
> > > > cxgb4_0    1    0    0007:433b:f5b0:0000:0000:0000:0000:0000         v1
> > > > cxgb4_0    2    0    0007:433b:f5b8:0000:0000:0000:0000:0000         v1
> > > > hfi1_0    1    0    fe80:0000:0000:0000:0011:7501:0109:6c60     v1
> > > > hfi1_0    1    1    fe80:0000:0000:0000:0006:6a00:0000:0005     v1
> > > > mlx5_0    1    0    fe80:0000:0000:0000:506b:4b03:00f3:8a38     v1
> > > > n_gids_found=19
> > > >
> > > > [root at rdma-perf-07 ~]$ dmesg | tail -15
> > > > [   19.744421] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib0.8002: link
> > > > becomes ready [   19.758371] IPv6: ADDRCONF(NETDEV_CHANGE):
> > > > mlx5_ib0.8004: link becomes ready [   20.010469] hfi1 0000:d8:00.0:
> hfi1_0:
> > > > Switching to NO_DMA_RTAIL [   20.440580] IPv6:
> > > > ADDRCONF(NETDEV_CHANGE): mlx5_ib0.8006: link becomes ready
> > > > [   21.098510] bnxt_en 0000:19:00.0 bnxt_roce: Too many traffic classes
> > > > requested: 8. Max supported is 2.
> > > > [   21.324341] bnxt_en 0000:19:00.0 bnxt_roce: Too many traffic classes
> > > > requested: 8. Max supported is 2.
> > > > [   22.058647] IPv6: ADDRCONF(NETDEV_CHANGE): hfi1_opa0: link
> > becomes
> > > > ready [  211.407329] _ib_cache_gid_del: can't delete gid
> > > > fe80:0000:0000:0000:020a:f7ff:fee3:6e32 error=-22 [  211.407334]
> > > > _ib_cache_gid_del: can't delete gid
> > > > fe80:0000:0000:0000:020a:f7ff:fee3:6e32 error=-22 [  211.425275]
> > > > infiniband
> > > > bnxt_re0: del_gid port=1 index=6 gid
> > > > 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > > > [  211.425280] infiniband bnxt_re0: free_gid_entry_locked port=1
> > > > index=6 gid 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > > > [  211.425292] infiniband bnxt_re0: del_gid port=1 index=7 gid
> > > > 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > > > [  211.425461] infiniband bnxt_re0: free_gid_entry_locked port=1
> > > > index=7 gid 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > > > [  225.474061] infiniband bnxt_re0: store_gid_entry port=1 index=6
> > > > gid 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > > > [  225.474075] infiniband bnxt_re0: store_gid_entry port=1 index=7
> > > > gid 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > > >
> > > >
> > > GID table looks fine.
> > >
> > The GID table has  fe80:0000:0000:0000:020a:f7ff:fee3:6e32 entry
> > repeated 6 times. 2 for each interface bnxt_roce, bnxt_roce.43 and
> > bnxt_roce.45. Is this expected to have same gid entries for vlan and
> > base interfaces? As you mentioned earlier, driver's assumption that
> > only 2 GID entries identical (one for RoCE v1 and one for RoCE
> > v2)   is breaking here.
> >
> Yes, this is correct behavior. Each vlan netdev interface is in different L2
> segment.
> Vlan netdev has this ipv6 link local address. Hence, it is added to the GID table.
> A given GID table entry is identified uniquely by GID+ndev+type(v1/v2).
> 
> Reviewing bnxt_qplib_add_sgid() does the comparison below.
> if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
> 
> This comparison looks incomplete which ignore netdev and type.
> But even with that, I would expect GID entry addition failure for vlans for ipv6
> link local entries.
> 
> But I am puzzled now, that , with above memcmp() check, how does both v1
> and v2 entries get added in your table and for vlans too?
> I expect add_gid() and core/cache.c add_roce_gid () to fail for the duplicate
> entry.
> But GID table that Yi Zhang dumped has these vlan entries.
> I am missing something.
> 
Ah, found it.
bnxt_re_add_gid() checks for -EALREADY and returns 0 to add_gid() callback.
Ok. so you just need to extend bnxt_qplib_add_sgid() for considering vlan too.
Let me see if I can share a patch in few minutes.

> Yi Zhang,
> Instead of last 15 lines of dmesg, can you please share the whole dmsg log
> which should be enabled before creating vlans.
> using
> echo -n "module ib_core +p" /sys/kernel/debug/dynamic_debug/control
> 
> Selvin,
> Additionally, driver shouldn't be looking at the duplicate entries. core already
> does it.
> You might only want to do for v1/v2 case as bnxt driver has some dependency
> with it.
> Can you please fix this part?
> 
> > > > On 7/12/19 12:18 AM, Parav Pandit wrote:
> > > > > Sagi,
> > > > >
> > > > > This is better one to cc to linux-rdma.
> > > > >
> > > > > + Devesh, Selvin.
> > > > >
> > > > >> -----Original Message-----
> > > > >> From: Parav Pandit
> > > > >> Sent: Thursday, July 11, 2019 6:25 PM
> > > > >> To: Yi Zhang <yi.zhang at redhat.com>;
> > > > >> linux-nvme at lists.infradead.org
> > > > >> Cc: Daniel Jurgens <danielj at mellanox.com>
> > > > >> Subject: RE: regression: nvme rdma with bnxt_re0 broken
> > > > >>
> > > > >> Hi Yi Zhang,
> > > > >>
> > > > >>> -----Original Message-----
> > > > >>> From: Yi Zhang <yi.zhang at redhat.com>
> > > > >>> Sent: Thursday, July 11, 2019 3:17 PM
> > > > >>> To: linux-nvme at lists.infradead.org
> > > > >>> Cc: Daniel Jurgens <danielj at mellanox.com>; Parav Pandit
> > > > >>> <parav at mellanox.com>
> > > > >>> Subject: regression: nvme rdma with bnxt_re0 broken
> > > > >>>
> > > > >>> Hello
> > > > >>>
> > > > >>> 'nvme connect' failed when use bnxt_re0 on latest upstream
> > > > >>> build[1], by bisecting I found it was introduced from
> > > > >>> v5.2.0-rc1 with [2], it works after I revert it.
> > > > >>> Let me know if you need more info, thanks.
> > > > >>>
> > > > >>> [1]
> > > > >>> [root at rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125
> > > > >>> -s
> > > > >>> 4420 -n testnqn Failed to write to /dev/nvme-fabrics: Bad
> > > > >>> address
> > > > >>>
> > > > >>> [root at rdma-perf-07 ~]$ dmesg
> > > > >>> [  476.320742] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x4b9]=0x15
> > > > >>> status 0x5
> > >
> > > Devesh, Selvin,
> > >
> > > What does this error mean?
> > > bnxt_qplib_create_ah() is failing.
> > >
> > We are passing a wrong index for the GID to FW because of the
> > assumption mentioned earlier.
> > FW is failing command due to this.
> >
> > > > >>> [ 476.327103] infiniband bnxt_re0: Failed to allocate HW AH [
> > > > >>> 476.332525] nvme nvme2: rdma_connect failed (-14).
> > > > >>> [  476.343552] nvme nvme2: rdma connection establishment
> > > > >>> failed
> > > > >>> (-14)
> > > > >>>
> > > > >>> [root at rdma-perf-07 ~]$ lspci  | grep -i Broadcom
> > > > >>> 01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries
> > > > >>> NetXtreme
> > > > >>> BCM5720 2-port Gigabit Ethernet PCIe
> > > > >>> 01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries
> > > > >>> NetXtreme
> > > > >>> BCM5720 2-port Gigabit Ethernet PCIe
> > > > >>> 18:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3
> > > > >>> 3008 [Fury] (rev
> > > > >>> 02)
> > > > >>> 19:00.0 Ethernet controller: Broadcom Inc. and subsidiaries
> > > > >>> BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> > > > >>> 19:00.1 Ethernet controller: Broadcom Inc. and subsidiaries
> > > > >>> BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> > > > >>>
> > > > >>>
> > > > >>> [2]
> > > > >>> commit 823b23da71132b80d9f41ab667c68b112455f3b6
> > > > >>> Author: Parav Pandit <parav at mellanox.com>
> > > > >>> Date:   Wed Apr 10 11:23:03 2019 +0300
> > > > >>>
> > > > >>>      IB/core: Allow vlan link local address based RoCE GIDs
> > > > >>>
> > > > >>>      IPv6 link local address for a VLAN netdevice has nothing
> > > > >>> to do with
> > its
> > > > >>>      resemblance with the default GID, because VLAN link local GID is
> in
> > > > >>>      different layer 2 domain.
> > > > >>>
> > > > >>>      Now that RoCE MAD packet processing and route resolution
> > > > >>> consider
> > > > the
> > > > >>>      right GID index, there is no need for an unnecessary
> > > > >>> check which
> > > > prevents
> > > > >>>      the addition of vlan based IPv6 link local GIDs.
> > > > >>>
> > > > >>>      Signed-off-by: Parav Pandit <parav at mellanox.com>
> > > > >>>      Reviewed-by: Daniel Jurgens <danielj at mellanox.com>
> > > > >>>      Signed-off-by: Leon Romanovsky <leonro at mellanox.com>
> > > > >>>      Signed-off-by: Jason Gunthorpe <jgg at mellanox.com>
> > > > >>>
> > > > >>>
> > > > >>>
> > > > >>> Best Regards,
> > > > >>>    Yi Zhang
> > > > >>>
> > > > >> I need some more information from you to debug this issue as I
> > > > >> don?t have the hw.
> > > > >> The highlighted patch added support for IPv6 link local address
> > > > >> for vlan. I am unsure how this can affect IPv4 AH creation for
> > > > >> which there is
> > > > failure.
> > > > >>
> > > > >> 1. Before you assign the IP address to the netdevice, Please
> > > > >> do, echo -n "module ib_core +p" >
> > > > >> /sys/kernel/debug/dynamic_debug/control
> > > > >>
> > > > >> Please share below output before doing nvme connect.
> > > > >> 2. Output of script [1]
> > > > >> $ show_gids script
> > > > >> If getting this script is problematic, share the output of,
> > > > >>
> > > > >> $ cat /sys/class/infiniband/bnxt_re0/ports/1/gids/*
> > > > >> $ cat /sys/class/infiniband/bnxt_re0/ports/1/gid_attrs/ndevs/*
> > > > >> $ ip link show
> > > > >> $ip addr show
> > > > >> $ dmesg
> > > > >>
> > > > >> [1]
> > > > >> https://community.mellanox.com/s/article/understanding-show-gid
> > > > >> s- script#jive_content_id_The_Script
> > > > >>
> > > > >> I suspect that driver's assumption about GID indices might have
> > > > >> gone wrong here in drivers/infiniband/hw/bnxt_re/ib_verbs.c.
> > > > >> Lets see about results to confirm that.
> > > > > _______________________________________________
> > > > > Linux-nvme mailing list
> > > > > Linux-nvme at lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-nvme
