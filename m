From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Feb 2018 16:18:42 +0200
Subject: Regression: Connect-X5 doesn't connect with NVME-of
In-Reply-To: <dbda15f0-f678-9fab-dffe-5e8d2ae24ae1@mellanox.com>
References: <66a5332c-01ee-7a39-8224-189fa52a7298@deltatee.com>
 <e6cdfbe7-762c-c70c-be5f-397bdb08ee80@mellanox.com>
 <0d629a68-a1fa-7297-e371-5abbc2dd5fe7@grimberg.me>
 <dbda15f0-f678-9fab-dffe-5e8d2ae24ae1@mellanox.com>
Message-ID: <7941ee6c-bf13-093c-e5c2-9ed93889405d@grimberg.me>


> Hi Sagi/Logan,
> 
> I've repro it with v4.14.1 (not happens on each connect).
> Sagi's proposal below fix the issue of the "Failed to write to 
> /dev/nvme-fabrics: Invalid cross-device link".
> 
> Sagi can you push (with my Tested-by: Max Gurtovoy <maxg at mellanox.com> 
> and Reviewed-by: Max Gurtovoy <maxg at mellanox.com>) it or I will ?

Thanks, I'll send it.
