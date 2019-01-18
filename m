From: rajur@chelsio.com (Raju  Rangoju)
Date: Fri, 18 Jan 2019 07:37:54 +0000
Subject: [PATCH v3] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <3c2a416a-89c0-d63c-aedf-4f871dc26fc8@opengridcomputing.com>
References: <20190103173531.7987-1-rajur@chelsio.com>
 <b5f8ffb7-b912-60d1-95e3-0cb49899b771@grimberg.me>
 <3c2a416a-89c0-d63c-aedf-4f871dc26fc8@opengridcomputing.com>
Message-ID: <MWHPR1201MB0080D99508074185EB018406BC9C0@MWHPR1201MB0080.namprd12.prod.outlook.com>

Hi Christoph,

In case you missed, could you please pull this patch ?

-Raju

-----Original Message-----
From: Steve Wise <swise@opengridcomputing.com> 
Sent: 07 January 2019 21:29
To: Sagi Grimberg <sagi at grimberg.me>; Raju Rangoju <rajur at chelsio.com>; linux-nvme at lists.infradead.org
Cc: maxg at mellanox.com; stable at vger.kernel.org
Subject: Re: [PATCH v3] nvmet-rdma: fix null dereference under heavy load


On 1/3/2019 5:13 PM, Sagi Grimberg wrote:
> Wonder how the original fix got a tested-by...
>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

That was my bad.? But the testers said they couldn't reproduce the issue, so I assumed that meant it was fixed.? I guess they weren't stressing it enough.

Steve.
