From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 13 May 2019 15:24:59 +0000
Subject: [PATCH v3 2/7] devcoredump: fix typo in comment
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <SN6PR04MB452707FD4C32EE927D80294F860F0@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.


On 05/12/2019 08:55 AM, Akinobu Mita wrote:
> s/dev_coredumpmsg/dev_coredumpsg/
>
> Cc: Johannes Berg <johannes at sipsolutions.net>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> Cc: Kenneth Heitke <kenneth.heitke at intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
> * v3
> - No change since v2
>
>   drivers/base/devcoredump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index 3c960a6..e42d0b5 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -314,7 +314,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   EXPORT_SYMBOL_GPL(dev_coredumpm);
>
>   /**
> - * dev_coredumpmsg - create device coredump that uses scatterlist as data
> + * dev_coredumpsg - create device coredump that uses scatterlist as data
>    * parameter
>    * @dev: the struct device for the crashed device
>    * @table: the dump data
>
