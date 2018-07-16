From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 16 Jul 2018 09:34:43 -0500
Subject: nvme-rdma and rdma comp vector affinity problem
In-Reply-To: <b1728f78-f546-552f-6296-8c7e22d52599@mellanox.com>
References: <bf6b909e-b3b9-cc77-2837-c65302f7c22c@opengridcomputing.com>
 <984d4c8e-16b9-d459-e4b9-bf1703b4c226@opengridcomputing.com>
 <b1728f78-f546-552f-6296-8c7e22d52599@mellanox.com>
Message-ID: <97f83ec3-c6a2-8b18-fff1-4bc052a267b1@opengridcomputing.com>



On 7/15/2018 2:58 AM, Max Gurtovoy wrote:
> Hi Steve,
> I didn't go throw the implementation of cxgb4, but did you implement
> the needed callback or you calling the blk mapping function (fallback
> to blk_mq_map_queues) ?
>
> Regards,
> -Max.
>

Hey Max.? I implemented ib_get_vector_affinity() support for cxgb4.??
Also, If I change mlx5 to use the same cpus for each vector, I see the
same error for nvme-rdma over mlx5.?

Steve.
