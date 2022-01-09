Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD53EC433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Jan 2022 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grA0cdw5lnO9WkWK/DwhFMP5UY39CgS8WhXA1sFFVq8=; b=37t64cwb5zL/dP8v0GRmoBZ9pH
	yK81QtboVHyxL/AbeR/OtPNQYoLj/DCWiKYMoIlSAXTe7l3QlMp1SzMJEGJCk3CRv07TTnUgxfPfx
	VJ8Zul/WuBb0bBPnC/WTdYS7YIIkW4GQMDqWLc8PWzSG5eNxmTUHi9h2UefVHMvRTufrmwmb/F5Bn
	AaifYwMaJ9XyClC/GRtR7ut+KG0ttGJq0L9HFoJoZ7J8zcfewK9DdhyH7+JhsVCvPFwHmumkacEQ3
	GPlNuKMddWCF51GEHEYVxinJEez7T1o9D235RXVPOIHWmG9QALr4KJ2VvFPbNJXegRPRJGx3b02jQ
	L48HVUPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n6XhZ-007oVS-Gi; Sun, 09 Jan 2022 12:53:37 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n6XhN-007oUO-6O
 for linux-nvme@lists.infradead.org; Sun, 09 Jan 2022 12:53:26 +0000
Received: by mail-wr1-f54.google.com with SMTP id k30so3909433wrd.9
 for <linux-nvme@lists.infradead.org>; Sun, 09 Jan 2022 04:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=grA0cdw5lnO9WkWK/DwhFMP5UY39CgS8WhXA1sFFVq8=;
 b=YDRYk1vzdi7x2+mYapOX0+n3JHLxJMfVGkOx+Fz0sh+u1f9Zc8vMPrBA5O9zuxsI/c
 zzY8UHA70w+DJ22tzIWbXtiVWci9lSq+ZXbnXSFG/uFUoz5UzUaqthXnBRHoP6mkQf9j
 zb2GExuW1LmusG1uHBiXeKuAcwQ60MZ2eunCowNaUHaS7cRubDazc0ei5YWryPh4OIQG
 BapZvyjMWVwcQ9ZfN67EKt203zDL5L3YqoG8FskhAiwcGmHVsWy8K7eRnMDVfhqckY9v
 l+49JE0WX9Tt+t3ltFo4ZpXoNyw9cY65GGNPH0ibOWPiDa4a4H0MhaurnwEp57Zq/R5e
 Mh1w==
X-Gm-Message-State: AOAM533vLM8F9QvVNn6DjPrN7QAKx101YHEpZGrzVBPDOtY8Gl8TDPda
 FbGokHQAdGbW4sbZzNHW+2k=
X-Google-Smtp-Source: ABdhPJxJ/93rgdQgBGTs+tjFxGX8oyPr9mzIhPM28zbabY5uED4+tJmShtT+/RBKYe4teDOpUbzu9Q==
X-Received: by 2002:a05:6000:1684:: with SMTP id
 y4mr59128621wrd.26.1641732802695; 
 Sun, 09 Jan 2022 04:53:22 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l14sm4177198wrr.53.2022.01.09.04.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jan 2022 04:53:22 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: remove unneeded variable
To: cgel.zte@gmail.com, kbusch@kernel.org
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Changcheng Deng <deng.changcheng@zte.com.cn>,
 Zeal Robot <zealci@zte.com.cn>
References: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5212915e-5e1f-7a77-f05e-248de382fcfb@grimberg.me>
Date: Sun, 9 Jan 2022 14:53:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220109_045325_269135_C5458AE9 
X-CRM114-Status: GOOD (  17.73  )
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


> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Remove unneeded variable used to store return value.

I actually think that ret is missing an assignment in the error
case (e.g ret = -ENODEV)...

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   drivers/nvme/host/fabrics.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 7ae041e2b3fb..f79a66d4e22c 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1092,7 +1092,6 @@ static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
>   static int nvmf_dev_show(struct seq_file *seq_file, void *private)
>   {
>   	struct nvme_ctrl *ctrl;
> -	int ret = 0;
>   
>   	mutex_lock(&nvmf_dev_mutex);
>   	ctrl = seq_file->private;
> @@ -1106,7 +1105,7 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
>   
>   out_unlock:
>   	mutex_unlock(&nvmf_dev_mutex);
> -	return ret;
> +	return 0;
>   }
>   
>   static int nvmf_dev_open(struct inode *inode, struct file *file)
> 

