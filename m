From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 6 Mar 2019 20:11:24 +0000
Subject: [PATCH] nvmet-file: clamp-down file namespace lba_shift
References: <20190305095548.14934-1-sagi@grimberg.me>
Message-ID: <SN6PR04MB4527C36DBCE293BDA6A7508786730@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/5/19 1:55 AM, Sagi Grimberg wrote:
> When the backing file is a tempfile for example, the inode i_blkbits
> can be 1M in size which causes problems for hosts to support as the
> disk block size.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> This issue was observed in I/O errors in the log running test nvme/009.
>
We are not doing any I/O in nvme/009 explicitly using dd/fio, is this 
due to internal commands we send as a part of connect and disconnect ?
Or test number is different ?

>   drivers/nvme/target/io-cmd-file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 517522305e5c..5008826cbd6a 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -49,7 +49,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>   		goto err;
>   
>   	ns->size = stat.size;
> -	ns->blksize_shift = file_inode(ns->file)->i_blkbits;
> +	ns->blksize_shift = min_t(u8, file_inode(ns->file)->i_blkbits, PAGE_SHIFT);
>   
>   	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
>   			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
> 
