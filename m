From: loberman@redhat.com (Laurence Oberman)
Date: Mon, 05 Feb 2018 10:44:32 -0500
Subject: Regression: Connect-X5 doesn't connect with NVME-of
In-Reply-To: <7941ee6c-bf13-093c-e5c2-9ed93889405d@grimberg.me>
References: <66a5332c-01ee-7a39-8224-189fa52a7298@deltatee.com>
 <e6cdfbe7-762c-c70c-be5f-397bdb08ee80@mellanox.com>
 <0d629a68-a1fa-7297-e371-5abbc2dd5fe7@grimberg.me>
 <dbda15f0-f678-9fab-dffe-5e8d2ae24ae1@mellanox.com>
 <7941ee6c-bf13-093c-e5c2-9ed93889405d@grimberg.me>
Message-ID: <1517845472.11655.3.camel@redhat.com>

On Mon, 2018-02-05@16:18 +0200, Sagi Grimberg wrote:
> > Hi Sagi/Logan,
> > 
> > I've repro it with v4.14.1 (not happens on each connect).
> > Sagi's proposal below fix the issue of the "Failed to write to?
> > /dev/nvme-fabrics: Invalid cross-device link".
> > 
> > Sagi can you push (with my Tested-by: Max Gurtovoy <maxg at mellanox.c
> > om>?
> > and Reviewed-by: Max Gurtovoy <maxg at mellanox.com>) it or I will ?
> 
> Thanks, I'll send it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" 
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at??http://vger.kernel.org/majordomo-info.html

This missed me because all my NVME is still using CX3 (mlx4)
I will move the NVME devices into the setup with mlx5 so next time I
will catch this sort of issue with the testing.
Currently the mlx5 is only testing ISER and SRP.

Thanks
Laurence 
