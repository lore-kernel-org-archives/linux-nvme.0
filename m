From: vishal.l.verma@intel.com (Verma, Vishal L)
Date: Mon, 10 Nov 2014 19:33:54 +0000
Subject: [PATCH 01/11] block: nvme-scsi: Fix probable mask then right
 shift defects
In-Reply-To: <8cd08200f7cc1d1a7562d61f22a0758ec7ca182a.1414387334.git.joe@perches.com>
References: <cover.1414387334.git.joe@perches.com>
 <8cd08200f7cc1d1a7562d61f22a0758ec7ca182a.1414387334.git.joe@perches.com>
Message-ID: <1415648084.4373.2.camel@omniknight.lm.intel.com>

On Sun, 2014-10-26@22:24 -0700, Joe Perches wrote:
> Precedence of & and >> is not the same and is not left to right.
> shift has higher precedence and should be done after the mask.
> 
> Add parentheses around the mask.
> 
> Signed-off-by: Joe Perches <joe at perches.com>

Acked-by: Vishal Verma <vishal.l.verma at linux.intel.com>

> ---
>  drivers/block/nvme-scsi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
> index a4cd6d6..529ee54 100644
> --- a/drivers/block/nvme-scsi.c
> +++ b/drivers/block/nvme-scsi.c
> @@ -1972,8 +1972,8 @@ static inline void nvme_trans_get_io_cdb10(u8 *cmd,
>  {
>  	cdb_info->fua = GET_U8_FROM_CDB(cmd, IO_10_CDB_FUA_OFFSET) &
>  					IO_CDB_FUA_MASK;
> -	cdb_info->prot_info = GET_U8_FROM_CDB(cmd, IO_10_CDB_WP_OFFSET) &
> -					IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
> +	cdb_info->prot_info = (GET_U8_FROM_CDB(cmd, IO_10_CDB_WP_OFFSET) &
> +			       IO_CDB_WP_MASK) >> IO_CDB_WP_SHIFT;
>  	cdb_info->lba = GET_U32_FROM_CDB(cmd, IO_10_CDB_LBA_OFFSET);
>  	cdb_info->xfer_len = GET_U16_FROM_CDB(cmd, IO_10_CDB_TX_LEN_OFFSET);
>  }
> @@ -1983,8 +1983,8 @@ static inline void nvme_trans_get_io_cdb12(u8 *cmd,
>  {
>  	cdb_info->fua = GET_U8_FROM_CDB(cmd, IO_12_CDB_FUA_OFFSET) &
>  					IO_CDB_FUA_MASK;
> -	cdb_info->prot_info = GET_U8_FROM_CDB(cmd, IO_12_CDB_WP_OFFSET) &
> -					IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
> +	cdb_info->prot_info = (GET_U8_FROM_CDB(cmd, IO_12_CDB_WP_OFFSET) &
> +			       IO_CDB_WP_MASK) >> IO_CDB_WP_SHIFT;
>  	cdb_info->lba = GET_U32_FROM_CDB(cmd, IO_12_CDB_LBA_OFFSET);
>  	cdb_info->xfer_len = GET_U32_FROM_CDB(cmd, IO_12_CDB_TX_LEN_OFFSET);
>  }
> @@ -1994,8 +1994,8 @@ static inline void nvme_trans_get_io_cdb16(u8 *cmd,
>  {
>  	cdb_info->fua = GET_U8_FROM_CDB(cmd, IO_16_CDB_FUA_OFFSET) &
>  					IO_CDB_FUA_MASK;
> -	cdb_info->prot_info = GET_U8_FROM_CDB(cmd, IO_16_CDB_WP_OFFSET) &
> -					IO_CDB_WP_MASK >> IO_CDB_WP_SHIFT;
> +	cdb_info->prot_info = (GET_U8_FROM_CDB(cmd, IO_16_CDB_WP_OFFSET) &
> +			       IO_CDB_WP_MASK) >> IO_CDB_WP_SHIFT;
>  	cdb_info->lba = GET_U64_FROM_CDB(cmd, IO_16_CDB_LBA_OFFSET);
>  	cdb_info->xfer_len = GET_U32_FROM_CDB(cmd, IO_16_CDB_TX_LEN_OFFSET);
>  }
