From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 31 Oct 2016 06:59:35 -0700
Subject: [PATCH v5 14/14] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <540193784.5466628.1477921998345.JavaMail.zimbra@redhat.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <fe057bf0-6ede-fc9e-9a53-9d790c9782c2@sandisk.com>
 <540193784.5466628.1477921998345.JavaMail.zimbra@redhat.com>
Message-ID: <c8c503bf-4fcb-5e1d-487a-53277bc1c300@sandisk.com>

On 10/31/2016 06:53 AM, Laurence Oberman wrote:
> Ran multiple read/write buffered and directio tests via RDMA/SRP and mlx5 (100Gbit) with max_sectors_kb set to 1024, 2048, 4096 and 8196
> Ran multiple read/write buffered and directio tests via RDMA/SRP and mlx4 (56Gbit)  with max_sectors_kb set to 1024, 2048, 4096 and 8196
> Reset the SRP hosts multiple times with multipath set to no_path_retry queue
> Ran basic NVME read/write testing with no hot plug disconnects on multiple block sizes
>
> All tests passed.
>
> For the series:
> Tested-by: Laurence Oberman <loberman at redhat.com>

Hello Laurence,

Thanks for having tested this version of this patch series again so quickly!

Bart.
