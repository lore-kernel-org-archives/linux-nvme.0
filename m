From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 20 May 2019 18:51:52 +0000
Subject: [PATCH] nvme: copy MTFA field from identify controller
References: <20190520174206.29464-1-keith.busch@intel.com>
Message-ID: <BYAPR04MB5749E41D46DA20B09A2C5BD186060@BYAPR04MB5749.namprd04.prod.outlook.com>

Indeed we don't set that.

root at mat ~/nvme (nvme-5.2-rc2)# grep -ir mtfa host/*.h
host/nvme.h:	u16 mtfa;
root at mat ~/nvme (nvme-5.2-rc2)# grep -ir mtfa host/*.c
host/core.c:	if (ctrl->mtfa)
host/core.c:				msecs_to_jiffies(ctrl->mtfa * 100);
root at mat ~/nvme (nvme-5.2-rc2)#

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 05/20/2019 10:47 AM, Keith Busch wrote:
> From: Laine Walker-Avina <laine.walker-avina at intel.com>
>
> We use the controller's reported maximum firmware activation time as our
> timeout before resetting a controller for a failed activation notice,
> but this value was never being read so we could only use the default
> timeout. Copy the Identify Controller MTFA field to the corresponding
> nvme_ctrl's mtfa field.
>
> Fixes: b6dccf7fae433 (?nvme: add support for FW activation without reset?).
> Signed-off-by: Laine Walker-Avina <laine.walker-avina at intel.com>
> [changelog, fix endian]
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7da80f375315..eb3fb561b165 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2557,6 +2557,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>
>   	ctrl->oacs = le16_to_cpu(id->oacs);
>   	ctrl->oncs = le16_to_cpu(id->oncs);
> +	ctrl->mtfa = le16_to_cpu(id->mtfa);
>   	ctrl->oaes = le32_to_cpu(id->oaes);
>   	atomic_set(&ctrl->abort_limit, id->acl + 1);
>   	ctrl->vwc = id->vwc;
>
