From: hare@suse.de (Hannes Reinecke)
Date: Mon, 30 Jul 2018 09:43:19 +0200
Subject: [PATCH V2 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <20180726041842.9668-2-chaitanya.kulkarni@wdc.com>
References: <20180726041842.9668-1-chaitanya.kulkarni@wdc.com>
 <20180726041842.9668-2-chaitanya.kulkarni@wdc.com>
Message-ID: <ef81592a-6c94-aef0-9405-95a5de9ad050@suse.de>

Hi Chaitanya,

some comments inline:

On 07/26/2018 06:18 AM, Chaitanya Kulkarni wrote:
> This patch adds a new command to retrieve the ANA Log page.
> We update identify ctrl/ns data structure to support this command.
> We also add ana based error codes and different identifiers to the
> linux/nvme.h header file in order to support this command.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>  linux/nvme.h   |  52 ++++++++++++++++++--
>  nvme-builtin.h |   1 +
>  nvme-ioctl.c   |   8 +++
>  nvme-ioctl.h   |   1 +
>  nvme-print.c   | 130 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  nvme-print.h   |   2 +
>  nvme.c         |  77 +++++++++++++++++++++++++++++
>  7 files changed, 266 insertions(+), 5 deletions(-)
> 
> diff --git a/linux/nvme.h b/linux/nvme.h
> index dc8ea89..50faaf0 100644
> --- a/linux/nvme.h
> +++ b/linux/nvme.h
> @@ -241,7 +241,12 @@ struct nvme_id_ctrl {
>  	__le32			hmminds;
>  	__le16			hmmaxd;
>  	__le16			nsetidmax;
> -	__u8			rsvd340[172];
> +	__u8			rsvd340[2];
> +	__u8			anatt;
> +	__u8			anacap;
> +	__le32			anagrpmax;
> +	__le32			nanagrpid;
> +	__u8			rsvd352[160];
>  	__u8			sqes;
>  	__u8			cqes;
>  	__le16			maxcmd;> @@ -257,7 +262,8 @@ struct nvme_id_ctrl {
>  	__le16			acwu;
>  	__u8			rsvd534[2];
>  	__le32			sgls;
> -	__u8			rsvd540[228];
> +	__u8			mnan;
> +	__u8			rsvd544[224];
>  	char			subnqn[256];
>  	__u8			rsvd1024[768];
>  	__le32			ioccsz;
This is wrong; 'mnan' is a 32-bit integer.
(Hence the next field is called 'rsvd544', as it starts at offset 544...)

> @@ -317,7 +323,9 @@ struct nvme_id_ns {
>  	__le16			nabspf;
>  	__le16			noiob;
>  	__u8			nvmcap[16];
> -	__u8			rsvd64[36];
> +	__u8			rsvd64[28];
> +	__le32			anagrpid;
> +	__u8			rsvd95[4];
>  	__le16			nvmsetid;
>  	__le16			endgid;
>  	__u8			nguid[16];
The 'reserved' space starts at offset 96, so the field should be named
'rsvd96'.

[ .. ]
> @@ -881,6 +916,7 @@ enum {
>  	NVME_LOG_TELEMETRY_HOST = 0x07,
>  	NVME_LOG_TELEMETRY_CTRL = 0x08,
>  	NVME_LOG_ENDURANCE_GROUP = 0x09,
> +	NVME_LOG_ANA		= 0x0c,
>  	NVME_LOG_DISC		= 0x70,
>  	NVME_LOG_RESERVATION	= 0x80,
>  	NVME_LOG_SANITIZE	= 0x81,
> @@ -892,6 +928,7 @@ enum {
>  enum {
>  	NVME_NO_LOG_LSP       = 0x0,
>  	NVME_NO_LOG_LPO       = 0x0,
> +	NVME_LOG_ANA_RGO      = 0x1,
>  	NVME_TELEM_LSP_CREATE = 0x1,
>  };
>  
Shouldn't this rather be named

NVME_ANA_LSP_RGO

for consistency?

> @@ -1040,7 +1077,7 @@ struct nvme_get_log_page_command {
>  	__u64			rsvd2[2];
>  	union nvme_data_ptr	dptr;
>  	__u8			lid;
> -	__u8			rsvd10;
> +	__u8			lsp;
>  	__le16			numdl;
>  	__le16			numdu;
>  	__u16			rsvd11;
[ .. ]
> diff --git a/nvme-print.c b/nvme-print.c
> index daf2929..89a7075 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
[ .. ]
> @@ -924,6 +942,10 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
>  	printf("hmminds   : %d\n", le32_to_cpu(ctrl->hmminds));
>  	printf("hmmaxd    : %d\n", le16_to_cpu(ctrl->hmmaxd));
>  	printf("nsetidmax : %d\n", le16_to_cpu(ctrl->nsetidmax));
> +	printf("anatt     : %d\n", ctrl->anatt);
> +	printf("anacap    : %d\n", ctrl->anacap);
> +	printf("anagrpmax : %d\n", ctrl->anagrpmax);
> +	printf("nanagrpid : %d\n", le32_to_cpu(ctrl->nanagrpid));
>  	printf("sqes      : %#x\n", ctrl->sqes);
>  	if (human)
>  		show_nvme_id_ctrl_sqes(ctrl->sqes);
'anacap' is a bitfield, each bit of which has a distinct meaning.
Hence we should implement a 'human' decoding here, too.

> @@ -951,6 +973,7 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
>  		show_nvme_id_ctrl_nvscc(ctrl->nvscc);
>  	printf("acwu      : %d\n", le16_to_cpu(ctrl->acwu));
>  	printf("sgls      : %x\n", le32_to_cpu(ctrl->sgls));
> +	printf("mnan      : %d\n", ctrl->mnan);
>  	if (human)
>  		show_nvme_id_ctrl_sgls(ctrl->sgls);
>  	printf("subnqn    : %-.*s\n", (int)sizeof(ctrl->subnqn), ctrl->subnqn);
'mnan' should be called with le32_to_cpu().
And 'cmic' decoding is missing.

Wouldn't it be more sensible to drop these things, and include them in a
different patch?
With that this patch would just be dealing with the actual ANA Log page
implementation, and the other patch would be centered around ANA
enablement for the nvme cli in general.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
