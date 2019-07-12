From: parav@mellanox.com (Parav Pandit)
Date: Fri, 12 Jul 2019 12:52:24 +0000
Subject: regression: nvme rdma with bnxt_re0 broken
In-Reply-To: <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
Message-ID: <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>



> -----Original Message-----
> From: Yi Zhang <yi.zhang at redhat.com>
> Sent: Friday, July 12, 2019 5:11 PM
> To: Parav Pandit <parav at mellanox.com>; Selvin Xavier
> <selvin.xavier at broadcom.com>
> Cc: Daniel Jurgens <danielj at mellanox.com>; linux-rdma at vger.kernel.org;
> Devesh Sharma <devesh.sharma at broadcom.com>; linux-
> nvme at lists.infradead.org
> Subject: Re: regression: nvme rdma with bnxt_re0 broken
> 
> Hi Parav
> The nvme connect still failed[1], I've paste all the dmesg log to[2], pls check it.
> 
> 
> [1]
> [root at rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420 -n
> testnqn
> Failed to write to /dev/nvme-fabrics: Connection reset by peer
> [2]
> https://pastebin.com/ipvak0Sp
> 

I think vlan_id is not initialized to 0xffff due to which ipv4 entry addition also failed with my patch.
This is probably solves it. Not sure. I am not much familiar with it.

Selvin,
Can you please take a look?
