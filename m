From: m@bjorling.me (Matias Bjorling)
Date: Fri, 05 Jun 2015 20:17:02 +0200
Subject: [PATCH v4 4/8] bio: Introduce LightNVM payload
In-Reply-To: <1433508870-28251-5-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <1433508870-28251-5-git-send-email-m@bjorling.me>
Message-ID: <5571E79E.2050907@bjorling.me>

> -
> +#if defined(CONFIG_NVM)
> +	struct bio_nvm_payload *bi_nvm; /* open-channel ssd backend */
> +#endif
>   	unsigned short		bi_vcnt;	/* how many bio_vec's */
>

Jens suggests this to implemented using a bio clone. Will do in the next 
refresh.
