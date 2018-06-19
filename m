From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Tue, 19 Jun 2018 09:41:16 -0700
Subject: [PATCH] nvme-cli: Printing the additional feature in OAES in
 Identify Ctrl
In-Reply-To: <20180619163401.4803-1-revanth.rajashekar@intel.com>
References: <20180619163401.4803-1-revanth.rajashekar@intel.com>
Message-ID: <382b965c-c0d0-231c-11c1-33ee50a098df@intel.com>

On 06/19/2018 09:34 AM, Revanth Rajashekar wrote:
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
> ---
>  nvme-print.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/nvme-print.c b/nvme-print.c
> index 8699d6c..8deda5d 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -94,12 +94,15 @@ static void show_nvme_id_ctrl_cmic(__u8 cmic)
>  static void show_nvme_id_ctrl_oaes(__le32 ctrl_oaes)
>  {
>  	__u32 oaes = le32_to_cpu(ctrl_oaes);
> -	__u32 rsvd0 = (oaes & 0xFFFFFE00) >> 9;
> +	__u32 rsvd0 = (oaes & 0xFFFFFC00) >> 10;
> +	__U32 fan  = (oaes & 0x200) >> 9;

This is probably meant to be __u32 rather than __U32.

>  	__u32 nace = (oaes & 0x100) >> 8;
>  	__u32 rsvd1 = oaes & 0xFF;
>  
>  	if (rsvd0)
>  		printf(" [31:9] : %#x\tReserved\n", rsvd0);
> +	printf("[9:9] : %#x\t Firmware Activation Notices Event %sSupported\n",
> +		fan, fan ? "" : "Not ");
>  	printf("  [8:8] : %#x\tNamespace Attribute Changed Event %sSupported\n",
>  		nace, nace ? "" : "Not ");
>  	if (rsvd1)
> 
