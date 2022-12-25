Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A3BC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7m8nW/7DEbrBiabq/62IowJyNGdKNI11GqWpWIElV2w=; b=Z6fhn1Sq0oxlrsXVGDkIEmpAsl
	KySvNBbKEHvxrBCy9WAKM4X/VQeBXm0YbZ5FcxX6vik66YKHpEdtm9WMWKSnurQ99xYOum3+aIVpK
	EvvPATDT1uJcXEZ+3mH5T6LDhPxg4k21Wgm5515H/i6FSz1TQrFj8lEVViYSvfLTWl2vJapUhZE43
	kuKhc+sPjeUQ1QSXFC6mBZzO5eBSTr9xwNs0pnHUkvj+3IW9cTLgdre09PNJv77E69/Fb3qkN86DV
	/doIbcUDFzWWaSIXuQDB4267BZ3QdHPpWL4pFIVdU8dfMsDzT15KKdy7xor7pX0D2ha+kzzhJAmOD
	l717hlSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9PFG-00AW1F-8J; Sun, 25 Dec 2022 11:32:46 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9P2j-00APgO-NR
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 11:19:51 +0000
Received: by mail-wm1-f51.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so381146wmk.4
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 03:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7m8nW/7DEbrBiabq/62IowJyNGdKNI11GqWpWIElV2w=;
        b=QqsSBKPeUi7a/goteE/5Vuy2iSLww8s+YTAzHWBhXQTnOo4jP0IP5ktdNoQWbEQQgN
         rf+3dQGP5fOh3G/gdCQHwLG8WV5UDbohGdl6YDsWJ9wKAjMDKjyaxVini3kIFABa5BCb
         FiXl7CnbGD7/0z+fbupHTR5s+13I07nZtc3Hq1/3EHCD/gnZfdPWAp9B2tN7hbEYahZH
         RcED3DsE8Ge02Lnbb4qieexwYYcV2SMH4Ld9tSWdPqMEDriTwDptLfAzoBzN8uZAkfwC
         f1XxPa5id6QPougCYm539hmYDl/x5Yfqt/RgVJohsQ6DTvEh0XOm37BM8hWrLoaMUuIN
         ikHw==
X-Gm-Message-State: AFqh2kquKzvGIlf2r7uNRdRmBvzQ0wG6jXWSeKfa7IrQcUH49yjeql/V
	W/uUJboZp7W4/1Tdg6+Ejtimq0GpXRk=
X-Google-Smtp-Source: AMrXdXt4HAwxNPegRco7x0WbeCMwG5jgzjP4eCJY5V8+04c3EueQg+FPgZPR5ypwf9it7YVrzpjdVQ==
X-Received: by 2002:a05:600c:4d94:b0:3d5:3ab1:d630 with SMTP id v20-20020a05600c4d9400b003d53ab1d630mr11135227wmp.8.1671967185493;
        Sun, 25 Dec 2022 03:19:45 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w20-20020a1cf614000000b003cf4d99fd2asm10397290wmc.6.2022.12.25.03.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 03:19:45 -0800 (PST)
Message-ID: <f0d3c027-d793-8266-7c69-30a85f884b23@grimberg.me>
Date: Sun, 25 Dec 2022 13:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] nvme-pci: update sqsize when adjusting the queue
 depth
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>, Hugh Dickins <hughd@google.com>,
 linux-nvme@lists.infradead.org
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221225103234.226794-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_031949_876846_D740B6F5 
X-CRM114-Status: GOOD (  20.69  )
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


> Update the core sqsize field in addition to the PCIe-specific
> q_depth field as the core tagset allocation helpers rely on it.
> 
> Fixes: 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 804b6a6cb43a9c..b13baccedb4a95 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2333,10 +2333,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   	if (dev->cmb_use_sqes) {
>   		result = nvme_cmb_qdepth(dev, nr_io_queues,
>   				sizeof(struct nvme_command));
> -		if (result > 0)
> +		if (result > 0) {
>   			dev->q_depth = result;
> -		else
> +			dev->ctrl.sqsize = result - 1;
> +		} else {
>   			dev->cmb_use_sqes = false;
> +		}
>   	}
>   
>   	do {
> @@ -2537,7 +2539,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>   
>   	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
>   				io_queue_depth);
> -	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
>   	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
>   	dev->dbs = dev->bar + 4096;
>   
> @@ -2578,7 +2579,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>   		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
>   			 dev->q_depth);
>   	}
> -
> +	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
>   
>   	nvme_map_cmb(dev);
>   

OK, I think I understand now.

But if you want to patches 1+2 to be taken before 3+4, I'd make sqsize
to be a 0's based value of q_depth after we subtract one entry for queue
wraparound. So others would not get affected from patches 1+2. Then in
one batch make all assignments to sqsize 1's based like in patch 3 and
change nvme_alloc_io_tagset at the same time.

Not super critical, but there is a small chance that if 1+2 are taken
before 3+4, someone may complain...

