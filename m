Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B45C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cSHNnp8t4nI0UH5wIrpO3ALUAEJR+D85HAv+LIZmFsA=; b=4/PcitBuOOJsEmtZl6kJWjDjfT
	lKOekqikS7PzwCcUfTgqqK/UXzZio9wkXrmqjwsIcoHzzRDIOXmUWgkveqc8Jy7+498wCr88mhDpb
	+V+wwnR0aNC0uKlc1E4if28IcOhE6KPsdecI4Swl9Xs00IS7PohsXc+aX05TYl/0lnFScqu3mC3qj
	bN0C0reINVFv3A7MjNCECyGBtc59kc9unJ8YZ8coIYS6t6ent9NRqsU0YHiynrusMIwyUR74GSYSC
	RxBx/bQK2Z1vxkmGIkx/Nokl7ZGG3pCUvgCZDTK19fywZATNrwM6d8ODwle51Yp+2aVXCq7WjaVkg
	peDJdn7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox3Sk-00BzuC-1C; Mon, 21 Nov 2022 09:51:38 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox3Si-00Bzsw-2Y
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 09:51:37 +0000
Received: by mail-wr1-f53.google.com with SMTP id e11so6075708wru.8
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 01:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSHNnp8t4nI0UH5wIrpO3ALUAEJR+D85HAv+LIZmFsA=;
        b=DdX1CDC9OEoVTL3jor1mw58jUxe6+MDawG/U+Dgdq1tuxfmACn2tj+BnUtK/WeC0iW
         rHe/EuWeC20F00ewzDkOe68sqnxQCkxoauClTjm0nb7fAIbGc1ciDW0IhbBf0aRGDIur
         nCjquRiA1ojjt+ZlURl4S66EaduUO9fTc/0ZLBxqxpeGOpkos8w+qwpYmXwsnqsxPNa/
         eiRK4dbaivLz/fERXkfMX0GUgixSPf7kZroIaeqXtiI9g/vp9VXfpEZq3DX2FSkCYkCh
         bcCOZVrttP+wgwnkyEI0ZSYc0nD/zaWh3hDtOcNnyG7NBM0hwVjjDs93mb5a5bp3hMtm
         S3lQ==
X-Gm-Message-State: ANoB5pkYLEJn7iMULPKrw9mEXHyxMUN4rwueAWyjqifxZpuL4qKI8Scd
	477O6zlXgrDGzj0ZJxDaiPw=
X-Google-Smtp-Source: AA0mqf5/vme52wFF76C26kFeqw1uewPuJYVo9PoXce/weWIEj9/9HupQJnZnqxCPUvXNEi6q7WTOTw==
X-Received: by 2002:adf:f642:0:b0:241:dd7f:a419 with SMTP id x2-20020adff642000000b00241dd7fa419mr571079wrp.205.1669024294019;
        Mon, 21 Nov 2022 01:51:34 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056000081500b00241cbb7f15csm6099947wrb.106.2022.11.21.01.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:51:33 -0800 (PST)
Message-ID: <b86df48d-2fd2-fe90-a1c2-721cb51d826e@grimberg.me>
Date: Mon, 21 Nov 2022 11:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, hare@suse.de, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20221121062113.84721-1-zhangqilong3@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221121062113.84721-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_015136_142621_FB1B6413 
X-CRM114-Status: GOOD (  17.92  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Zhang,

> If dhchap_secret is not consistent with options or
> nvme_auth_generate_key() fails, we should free the
> memory of dhchap_secret to avoid memleak.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Please have a look at nvme-6.2, if there is still a leak, please
send a patch against it.

Thanks.

> ---
>   drivers/nvme/host/core.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index da55ce45ac70..e06d1b3961fe 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3748,13 +3748,16 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   		int ret;
>   
>   		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
> -		if (ret)
> +		if (ret) {
> +			kfree(dhchap_secret);
>   			return ret;
> +		}
>   		kfree(opts->dhchap_secret);
>   		opts->dhchap_secret = dhchap_secret;
>   		/* Key has changed; re-authentication with new key */
>   		nvme_auth_reset(ctrl);
> -	}
> +	} else
> +		kfree(dhchap_secret);
>   	/* Start re-authentication */
>   	dev_info(ctrl->device, "re-authenticating controller\n");
>   	queue_work(nvme_wq, &ctrl->dhchap_auth_work);

