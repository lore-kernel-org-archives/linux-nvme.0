From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Feb 2017 11:56:49 +0200
Subject: [PATCH] nvme-cli: fabrics: Fix to pass "host_traddr" to the
 kernel driver.
In-Reply-To: <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
References: <n> <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
Message-ID: <23f1e7ba-7085-2692-cc95-ef63a535a31c@grimberg.me>


> @@ -595,6 +595,11 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
>  				return -EINVAL;
>  			p += len;
>
> +			len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
> +			if (len < 0)
> +				return -EINVAL;
> +			p+= len;
> +

I think this needs to be conditional on if provided at all.
