From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 14 Sep 2018 03:03:08 -0700
Subject: [PATCH V2] nvme-core: add async event trace helper
In-Reply-To: <BYAPR04MB4502ED2C1C2691C07DF7485D861B0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180829221922.23539-1-chaitanya.kulkarni@wdc.com>
 <20180911071952.GA8988@infradead.org>
 <BYAPR04MB4502ED2C1C2691C07DF7485D861B0@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <20180914100308.GA8892@infradead.org>

On Wed, Sep 12, 2018@05:51:23AM +0000, Chaitanya Kulkarni wrote:
>         switch ((result & 0xff00) >> 8) {
>         case NVME_AER_NOTICE_NS_CHANGED:
> +               trace_nvme_async_event(ctrl, (result & 0xff00) >> 8);
>                 set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
>                 nvme_queue_scan(ctrl);
>                 break;
>         case NVME_AER_NOTICE_FW_ACT_STARTING:
> +               trace_nvme_async_event(ctrl, (result & 0xff00) >> 8);
>                 queue_work(nvme_wq, &ctrl->fw_act_work);
>                 break;
>  #ifdef CONFIG_NVME_MULTIPATH
>         case NVME_AER_NOTICE_ANA:
> +               trace_nvme_async_event(ctrl, (result & 0xff00) >> 8);

I think we want a local variable so that we only do the mask and shift
once.

> +#ifdef CONFIG_NVME_MULTIPATH
> +                       aer_name(NVME_AER_NOTICE_ANA)
> +#endif

I don't think we need the ifdef as the symbol is always defined.

Otherwise this looks good to me.
