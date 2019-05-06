From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 6 May 2019 16:29:12 +0000
Subject: [PATCH] nvme-trace: Add fabrics command opcode name
References: <20190505152201.23830-1-minwoo.im.dev@gmail.com>
Message-ID: <SN6PR04MB45270E164CBC599246428CE386300@SN6PR04MB4527.namprd04.prod.outlook.com>

Please do not mix admin and fabric commands.
On 05/05/2019 08:22 AM, Minwoo Im wrote:
> Opcode 0x7F is for fabrics commands.  We can also print it out
> "nvme_fabrics_command" instead of 0x7f in raw.
>
> Before this patch:
>    cmd=(0x7f cdw10=00 00 00 00 1f 00 00 00 98 3a 00 00 ......
>
> After this patch:
>    cmd=(nvme_fabrics_command cdw10=00 00 00 00 1f 00 00 00 98 3a 00 00 ....
>
> It would be nicer if trace can show which command in fabrics commands
> are now being excuted, but not for this time.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   drivers/nvme/host/trace.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index 97d3c77365b8..f91580bf2e2f 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -37,6 +37,7 @@
>   		nvme_admin_opcode_name(nvme_admin_directive_send),	\
>   		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
>   		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
> +		nvme_admin_opcode_name(nvme_fabrics_command),		\
>   		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
>   		nvme_admin_opcode_name(nvme_admin_security_send),	\
>   		nvme_admin_opcode_name(nvme_admin_security_recv),	\
>
