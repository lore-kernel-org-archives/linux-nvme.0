Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A443BC6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 09:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i2/eW7CpkLpnOOssp3OAsuugC3X8OBV9y9F7HY7PF2g=; b=hWcM0k+rcAlh//PAXVpHqHdezX
	Afr+Sbww2Cbh3rYfBPZcEdi5sNES6t4AyGpTipEY+wAsDwdPTC2e+8Zftde8zr1vuBx34+5JikmZp
	1Fd892tkDgYF4CfE0m0KzlgjRN5AL6gZKdg2/UA5fVXqHuU1Mqxyi+cRGbiM0IvSSgYUWfsQA/VMD
	I2LJy3PyW9WXJ467CfjRSpr42NwO9sHFykCqxH05PcDRSxMqTJpIPUgqyvBEwpUSqTxBPtH6HoaE+
	/isx4m4fzpS8PlqF5ek2YjQ/3ftmg66NyKPXhgnfSH9pInW6tUdR7AB2Mvl2IGr681luJtEB5ZuL2
	9mvsXUPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcjTy-00FoBB-0B;
	Thu, 16 Mar 2023 09:01:10 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcjTv-00Fo8T-3B
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 09:01:09 +0000
Received: by mail-wr1-f50.google.com with SMTP id l12so783894wrm.10
        for <linux-nvme@lists.infradead.org>; Thu, 16 Mar 2023 02:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678957259; x=1681549259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2/eW7CpkLpnOOssp3OAsuugC3X8OBV9y9F7HY7PF2g=;
        b=Gi5FR9k3G883kbgJZJqaR/SrSVp3R/sgf/+ARAZizNNSKccylossfYU9RqrVrJmGe9
         vSqFC+ntklDdSTBeqjbT98FfaBNYdVZHdTc5dShOOHbo1dGbA6M1L+B24nwMJ4Wgo2kf
         sLS+DsjnwhUlrQQbmc2JbOvjJ62WoyYXzKE0FV4qAhXatQIqp9+BUtBhniQkCH+9CbE0
         B0P8fMj94A5FQj7zYjMgJ6x1n0wgGQPSdklykmU9/dpiQ81OAu2Hyf1z0mQ2AB/lLc6S
         FJ+NhRnjXUzbhlXdKCNTKdvKoZAafOSweQj7c/cyyakoPkRDcbecnNOUuHvyBZ4yAz7q
         rpsA==
X-Gm-Message-State: AO0yUKVI4uAqwqYW/NRYU05weqy8PgGT1Xof20cbbAAVyZm5u5oXXvoj
	uGWvf8332bYpnqo5q/m4LHg=
X-Google-Smtp-Source: AK7set+Nz6o0aM7QtOxWokmv/qqkJaTrxXOckF0s0d/yY2Ut1/fyss8n2UVYCm9fVzvLZYFLBh56wA==
X-Received: by 2002:adf:de8f:0:b0:2c7:175e:e201 with SMTP id w15-20020adfde8f000000b002c7175ee201mr3648180wrl.1.1678957258945;
        Thu, 16 Mar 2023 02:00:58 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e25-20020a5d5959000000b002c8ed82c56csm6592697wri.116.2023.03.16.02.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 02:00:58 -0700 (PDT)
Message-ID: <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
Date: Thu, 16 Mar 2023 11:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_020108_026804_E0F7F2EE 
X-CRM114-Status: GOOD (  13.94  )
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

> Could you try this patch with your tcp polling queues enabled?
> 
> ---
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9e5e0277a4d95..12f7ab369f7ba 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -844,30 +844,12 @@ void submit_bio(struct bio *bio)
>   }
>   EXPORT_SYMBOL(submit_bio);
>   
> -/**
> - * bio_poll - poll for BIO completions
> - * @bio: bio to poll for
> - * @iob: batches of IO
> - * @flags: BLK_POLL_* flags that control the behavior
> - *
> - * Poll for completions on queue associated with the bio. Returns number of
> - * completed entries found.
> - *
> - * Note: the caller must either be the context that submitted @bio, or
> - * be in a RCU critical section to prevent freeing of @bio.
> - */
> -int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
> +static int blk_poll(struct request_queue *q, struct io_comp_batch *iob,
> +		    struct bio *bio, unsigned int flags)
>   {
>   	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);

You need to pass in the cookie as well.
Probably can pass BLK_QC_T_NONE for blk_rq_poll...

