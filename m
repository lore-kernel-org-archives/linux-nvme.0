From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 27 Jul 2017 13:28:20 -0400
Subject: [PATCH 2/2] nvme: Provide option to disable ASPT feature
In-Reply-To: <1501174721-8253-2-git-send-email-keith.busch@intel.com>
References: <1501174721-8253-1-git-send-email-keith.busch@intel.com>
 <1501174721-8253-2-git-send-email-keith.busch@intel.com>
Message-ID: <5DFAE162-66C5-4860-8330-8B5F34517E60@amacapital.net>



> On Jul 27, 2017,@12:58 PM, Keith Busch <keith.busch@intel.com> wrote:
> 
> Similar to PCIe's APSM, the NVMe driver needs the ability to not use APST
> feature so that users have a way to prevent this feature from making their
> machines unusable. This patch makes that possible via module parameter
> "apst_off".

Isn't this redundant with default_ps_max_latency=0?

> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Cc: Andy Lutomirski <luto at amacapital.net>
> ---
> drivers/nvme/host/core.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b150702..834913b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -64,6 +64,10 @@ static bool force_apst;
> module_param(force_apst, bool, 0644);
> MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
> 
> +static bool apst_off;
> +module_param(apst_off, bool, 0644);
> +MODULE_PARM_DESC(apst_off, "Disable APST driver support");
> +
> static bool streams;
> module_param(streams, bool, 0644);
> MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
> @@ -1542,7 +1546,7 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
>     * If APST isn't supported or if we haven't been initialized yet,
>     * then don't do anything.
>     */
> -    if (!ctrl->apsta)
> +    if (!ctrl->apsta || apst_off)
>        return 0;
> 
>    if (ctrl->npss > 31) {
> -- 
> 2.5.5
> 
