From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 13 May 2019 06:24:01 -0700
Subject: [PATCH] nvme-core: trace discovery log change AEN
In-Reply-To: <20190506193320.30884-1-chaitanya.kulkarni@wdc.com>
References: <20190506193320.30884-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190513132401.GA2661@infradead.org>

>  		trace_nvme_async_event(ctrl, aer_notice_type);
>  		queue_work(nvme_wq, &ctrl->fw_act_work);
>  		break;
> +	case NVME_AER_NOTICE_DISC_CHANGED:
> +		trace_nvme_async_event(ctrl, aer_notice_type);
> +		break;
>  #ifdef CONFIG_NVME_MULTIPATH
>  	case NVME_AER_NOTICE_ANA:
>  		trace_nvme_async_event(ctrl, aer_notice_type);

What about just moving the trace_nvme_async_event call before the
switch statement?
