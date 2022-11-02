Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5119C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6sCkwj9YSprxNmaofEdMTvLEH5B6xW9TB9afqYojreE=; b=f3P4b8mY9SKnsDa2rFPk0vG8WG
	aL+B6xyzabWhgz0xjegx1rpuiDzN1RjDjXVI1QFxZf6KoZ6VwQmiZU7wc3EHmfONXbonqvjPz+Dgk
	lR2Kx+ePNJWOXxOh/tiq4XGaI8mnBdvrmoORxaA9qabYd0rpzdkODu2u4A8hqsSDVwm619krWnUeu
	BTQhr7O8XF8VGFH1LSwud66Nc2Y0o+QB6CioRQKcXlmL62iWaE2MdLUJfeMD8I/aFwVQT9FneUtus
	jwkwgO/asL2q8VVwJjnCc8kQ66nHmYPJZwdtPnGZiiuLPUIMyakoiUhM4t56/xWEwLZPM04ttXKXC
	xl/IYRqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqMcX-00EoUM-4R; Wed, 02 Nov 2022 22:54:05 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqMcU-00EoTN-8B
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 22:54:03 +0000
Received: by mail-pj1-f47.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so159516pjk.1
        for <linux-nvme@lists.infradead.org>; Wed, 02 Nov 2022 15:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sCkwj9YSprxNmaofEdMTvLEH5B6xW9TB9afqYojreE=;
        b=PffWdFJQGywz/DiqiwXVMT6NnCdAZZP6dziX1bjp4Y1FQHPoMBXtAVw6surPwrX2yS
         nvQdgRfIrwyuzZyzQb7rtAjyqbbzQs+Mvxc0mDjc3zI+C6srKI6RNdypn1DbDp+kHwq/
         C0hYRY+Q7znYn3u9CP81KJD0qRRn2eqiwD8Pii7pRWcyrZNQzmq3/WEF+3W46pkiP8F/
         JQvpLHPie0sOq9l/1+3DI3eYbOSRLS10uB4vir+5FBW9BLW4lePd0l+QFBKlbCw3MPAP
         LPNtu1OgdaSs55BaBmpw8K49CT/FTilhWldBPQhelsk+eCtsor6+226bggHDVriEOXWR
         ap0g==
X-Gm-Message-State: ACrzQf24FrYYG8GQBgpUZ5h98+n6fFGUT1DUrWLRmcZS/uK/fw3HO7gx
	3AIgsrSGwt4YSvg4d6lvb8g=
X-Google-Smtp-Source: AMsMyM711K/XUrQHKPUtbBSxzz99QtzdPWA4ooVlF037LAOY+yPo/0v1VhBhBLoucp5Sp0Kf7/u28Q==
X-Received: by 2002:a17:902:ec86:b0:187:2430:d377 with SMTP id x6-20020a170902ec8600b001872430d377mr16640073plg.33.1667429640140;
        Wed, 02 Nov 2022 15:54:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:22d3:f380:fa84:4b89? ([2620:15c:211:201:22d3:f380:fa84:4b89])
        by smtp.gmail.com with ESMTPSA id t4-20020a63f344000000b0046f8e444edfsm7630960pgj.60.2022.11.02.15.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 15:53:59 -0700 (PDT)
Message-ID: <569dfa4d-0f0e-a596-1f38-2f4ccc555fe5@acm.org>
Date: Wed, 2 Nov 2022 15:53:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 01/19] block: Add PR callouts for read keys and
 reservation
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-2-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221026231945.6609-2-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_155402_319427_F0D76439 
X-CRM114-Status: UNSURE (   9.37  )
X-CRM114-Notice: Please train this message.
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

On 10/26/22 16:19, Mike Christie wrote:
> +struct pr_keys {
> +	u32	generation;
> +	u32	num_keys;
> +	u64	keys[];
> +};
Is my understanding correct that keys[] is treated as opaque data by the 
kernel? If so, is it necessary to convert the persistent reservation 
keys from big endian to CPU endianness? Some SCSI stacks keep 
reservation keys as __be64 format.

Thanks,

Bart.

