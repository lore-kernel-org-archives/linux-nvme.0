From: parav@mellanox.com (Parav Pandit)
Date: Fri, 12 Jul 2019 09:49:42 +0000
Subject: regression: nvme rdma with bnxt_re0 broken
In-Reply-To: <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
Message-ID: <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>


> > Hi Selvin,
> >
> > > -----Original Message-----
> > > From: Selvin Xavier <selvin.xavier at broadcom.com>
> > > Sent: Friday, July 12, 2019 9:16 AM
> > > To: Parav Pandit <parav at mellanox.com>
> > > Cc: Yi Zhang <yi.zhang at redhat.com>; linux-nvme at lists.infradead.org;
> > > Daniel Jurgens <danielj at mellanox.com>; linux-rdma at vger.kernel.org;
> > > Devesh Sharma <devesh.sharma at broadcom.com>
> > > Subject: Re: regression: nvme rdma with bnxt_re0 broken
> > >
> > > On Fri, Jul 12, 2019 at 8:19 AM Parav Pandit <parav at mellanox.com>
> wrote:
> > > >
> > > > GID table looks fine.
> > > >
> > > The GID table has  fe80:0000:0000:0000:020a:f7ff:fee3:6e32 entry
> > > repeated 6 times. 2 for each interface bnxt_roce, bnxt_roce.43 and
> > > bnxt_roce.45. Is this expected to have same gid entries for vlan and
> > > base interfaces? As you mentioned earlier, driver's assumption that
> > > only 2 GID entries identical (one for RoCE v1 and one for RoCE
> > > v2)   is breaking here.
> > >
> > Yes, this is correct behavior. Each vlan netdev interface is in
> > different L2 segment.
> > Vlan netdev has this ipv6 link local address. Hence, it is added to the GID
> table.
> > A given GID table entry is identified uniquely by GID+ndev+type(v1/v2).
> >
> > Reviewing bnxt_qplib_add_sgid() does the comparison below.
> > if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
> >
> > This comparison looks incomplete which ignore netdev and type.
> > But even with that, I would expect GID entry addition failure for
> > vlans for ipv6 link local entries.
> >
> > But I am puzzled now, that , with above memcmp() check, how does both
> > v1 and v2 entries get added in your table and for vlans too?
> > I expect add_gid() and core/cache.c add_roce_gid () to fail for the
> > duplicate entry.
> > But GID table that Yi Zhang dumped has these vlan entries.
> > I am missing something.
> >
> Ah, found it.
> bnxt_re_add_gid() checks for -EALREADY and returns 0 to add_gid() callback.
> Ok. so you just need to extend bnxt_qplib_add_sgid() for considering vlan too.
> Let me see if I can share a patch in few minutes.
> 
> > Yi Zhang,
> > Instead of last 15 lines of dmesg, can you please share the whole dmsg
> > log which should be enabled before creating vlans.
> > using
> > echo -n "module ib_core +p" /sys/kernel/debug/dynamic_debug/control
> >
> > Selvin,
> > Additionally, driver shouldn't be looking at the duplicate entries.
> > core already does it.
> > You might only want to do for v1/v2 case as bnxt driver has some
> > dependency with it.
> > Can you please fix this part?
> >

How about below fix?
