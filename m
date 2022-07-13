Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E653C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 09:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=pkQVlWPJLH+tPFD4seo8uBFS6O
	QMfos4VpDU1dCLl47ITxSa4aS7Dgc9GTJkX/JIxG9Wc7q/xQsVv1xAGFBhZhJAWlb2OPl3dYBgFm7
	yZUfq8iqba2q10XnmRhIZVVdvKaHvYVWWt5t8iED8WGpTD4qPXQmhXGdHP6cc1L95HT+jaU/FxAXO
	dOr39b6tQzq7KXZkDU2eHBLa5gTQs0+p3oPv+8w1dgOhJGT9P4qRQ8lsi1Hg/S7LVL/u/u8kCEg96
	8wTyszk/DVZJhiMf03KnqBhgVYBswJf7yGZ90kUvbYExG0b9FLuNd1B2i1OgqU/6LIpR05axXYXDa
	AAQlmh3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYPj-002A7q-CU; Wed, 13 Jul 2022 09:12:11 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYPc-002A4d-FV
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 09:12:05 +0000
Received: by mail-wm1-f47.google.com with SMTP id p4so6142432wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 02:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VoNLZtmb0t3aHFGlqgrliMzhVGGCzh5AMzbgDJOeYjAdwmQUz1Fkw6bh79ufaSGAVy
         Y3lp0bA9Xpd1N0BzFtzqLCdoA8SmtpzAmTcZJq48uVKg7by4zNIBC+/MgFDE1i2X13F7
         YONPnA2YI3ljn1S0D8SnI5l7yaHOv+stWDxu9kuB7BDOqya8rFv8cAY2DWycTuPO9lJR
         7nAby5Cyu6mNVnkXSbrWh6tJ2GxuGAQtHbC3nDpOcI0cCsM6ONZTJbkSYdXC46MkuJEU
         HLfZ86nAH/LTkoGIlzIUMipPy4fbXKFGD2R5hwb+gPnIMBGUZ6B7KBY7fslRA2++dupl
         NLYg==
X-Gm-Message-State: AJIora828hgyRL7MTOOZfaKEufSSk3jztBv0I1UwcI7jjnLTZMU3xMJN
	Bn166F8xfFSuH/19xseqQMI=
X-Google-Smtp-Source: AGRyM1tG6ySiFWr+cxjFTr5vY5Nq2CeFsqAFFuKQDsdYo446InORqqQU/zW5OFz5ps57bPUOcfQeqw==
X-Received: by 2002:a05:600c:41c2:b0:3a2:dc9f:959e with SMTP id t2-20020a05600c41c200b003a2dc9f959emr2548469wmh.166.1657703521649;
        Wed, 13 Jul 2022 02:12:01 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c0a0c00b003a02b135747sm1519605wmp.46.2022.07.13.02.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:12:01 -0700 (PDT)
Message-ID: <311e2208-c030-9885-9f2a-266d2bad0912@grimberg.me>
Date: Wed, 13 Jul 2022 12:12:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] nvme: generalize the nvme_multi_css check in
 nvme_scan_ns
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
 kbusch@kernel.org
Cc: joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 gost.dev@samsung.com, k.jensen@samsung.com
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713054914.1888305-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_021204_531278_458D1902 
X-CRM114-Status: UNSURE (   6.20  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

