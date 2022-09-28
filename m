Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7C5C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dKSJWsaz2k2Rz3kNbppOUzRD8OicKQ/iayXhM8rffPU=; b=MF/xKae1JrjPtJPvqSNYj1IKqA
	sygmRqUDHCDf0+zA0PjQKxUubcjsVTFNF5yep1Cgkbuay7WtsncICof0IVe/rdpm/FpsM6mf+iYx7
	XAbfP9FJm0V6raLkt4bcTxTs8hp45aVzNy/MIIM3Ctmp7cHRwOzEZMva+ECaoqxoZmWZ90hiASYul
	yxwyP1ICNZgGTSoYiiEIr3CDst1m3Jc4xmAodcG0T63fMo9EEb2Dn3eKsIVHFY/WJOSfXMS2J4gEN
	tKlvMYx6AvXf0SXqo+CKk4nT94KpqiVVodttTKGAs18ftWSUDZLbt4u96FU+ZnQI9L2K2XtXdIK3M
	TUj5StXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYLK-00GjPL-NX; Wed, 28 Sep 2022 14:47:22 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYLI-00GjOH-OI
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 14:47:21 +0000
Received: by mail-wm1-f42.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so1145207wms.3
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 07:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dKSJWsaz2k2Rz3kNbppOUzRD8OicKQ/iayXhM8rffPU=;
        b=KSsTl6N5YmSQ8Y6CcN0iwZNOKItAlAJITYSdR32dgHuKKfToe6hDXUFSYjcYBgAb5C
         gTrBMLWBKsh1oU8WUKJgqNlrQyQ3Ck1bbsxjj+5lCMMeR+X6Z4DC7kM3iHf/BPsKVEXy
         PCHX3u0D3DeyIWiiGbOc6rJLAdO3uiJSpX6yysVJvmMN6E9MBqqwqqjs5AaEtMRl6esR
         lVXnk11kq8+sU9XQ8q7E8DSKu4QU0jLwByobw33CyUMhZqslsLe7Kdq145K/I+CD2Hs+
         6POKG+d0+kWzBl485e+R/fY+K3ead6qcLej125HaP1DUT8qwbn7w3f1+klr/Y+O/KmKo
         pVVw==
X-Gm-Message-State: ACrzQf24pK0hqMZ0O0nv4YdwtjubcqrqB6XX33YKy+CBioNBzPDkEHm0
	MXbeZf6JEftecqSlKaYvbyU=
X-Google-Smtp-Source: AMsMyM52NSab6Rs8LAi0TQgYLsj0YfdZ1a0kciP3sgbNHYmOzL5hVNO9A+jyjWgzUUofo+qQm4NVvA==
X-Received: by 2002:a1c:4b05:0:b0:3b4:90c1:e249 with SMTP id y5-20020a1c4b05000000b003b490c1e249mr7284717wma.201.1664376438222;
        Wed, 28 Sep 2022 07:47:18 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003a5f3f5883dsm2234534wmq.17.2022.09.28.07.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:47:17 -0700 (PDT)
Message-ID: <88638fa8-8ef8-6e52-0c5e-7d8729ce0784@grimberg.me>
Date: Wed, 28 Sep 2022 17:47:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stefan Roesch <shr@fb.com>
References: <20220927014420.71141-1-axboe@kernel.dk>
 <20220927014420.71141-5-axboe@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220927014420.71141-5-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_074720_815746_F5990DBC 
X-CRM114-Status: UNSURE (   7.69  )
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


> -static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
> +static void nvme_uring_task_meta_cb(struct io_uring_cmd *ioucmd)
>   {
>   	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>   	struct request *req = pdu->req;
> -	struct bio *bio = req->bio;

Unrelated change I think. But other than that, looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

