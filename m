Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9733C64ED8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=a701NM0fl8RXahJriX8+voeNwr
	A5kGMbiaKualF8G5TZEiB6uSh7/SJVEneuj44vm8bY+jxFFsrDf8lJKPTq/Zr/eDEec70AUYN6afd
	Al9EcdwRe6rUpvnbBjv4AG6m81DP6U+XFdF65AHWB5bdcU9jyEc4TxUlj341LqSh+Dlex7TVE+F4a
	ZuzX3sixkt9g9qI26XpPqs0q8pM7TsebcFn79KOOulXPoIl3s700TYkYrFxDbu21ga6ophN4YqdBS
	GRDwyQDWRW1xYlmIJXR3YPG2GlI6HNeDbxWFJ8cZP/zre1JDOhUwMELxN9KWWvlNMErHQDk+jrhpv
	N0d72Aow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWgHe-00ALPT-3u; Mon, 27 Feb 2023 16:23:26 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWgHb-00ALOZ-Md
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 16:23:24 +0000
Received: by mail-wm1-f48.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so6812920wms.1
        for <linux-nvme@lists.infradead.org>; Mon, 27 Feb 2023 08:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=3HfHZEBIKcbFofcU9KnxU7pcih/rk4KGD+m8IIjPQedWfVOgZykvnQsPLDSXS1MYRC
         L+47ghMCv3h/9yNiaox7IgE0pNT1t2DgN07Kkew/HJZiS9qinPfVyq1BdO6Q6duwJHWz
         6OUfSVK3AuhwIMcCFIxAMy6nITdAgUi4idfefFlC686e7EaEfQw/AEY6vhw4Sjy1Yg0o
         sqNlE4DjcrzbRQf3sSS/Fvg/vNV75UQ0pxStBw5rwdimT+VRp4UzixHOQqbdm4gVxAsk
         Jkxo+2/GxgRN5g+sddQVdkgSKk6VfnWqXFTN60d936cyQmkJnsoC61dOg6XwSLHTww6G
         GcGA==
X-Gm-Message-State: AO0yUKVu7y9uMZYoKCVB/nu9W6DRTyJxVVfNBg/DeXZzeP7/vcc82ocM
	zvR7FPbRyZFQj8d4gP7/qHRC2Den474=
X-Google-Smtp-Source: AK7set8kyOHHUcyZGT2SY8SCkggr6aeyyqlZYR4XcLeSfJPSCc4j5nrN8UtiT30J4/mqvl+QuLpfdg==
X-Received: by 2002:a05:600c:468c:b0:3eb:42f6:ac55 with SMTP id p12-20020a05600c468c00b003eb42f6ac55mr3914002wmo.1.1677515000364;
        Mon, 27 Feb 2023 08:23:20 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c441a00b003e21638c0edsm9855113wmn.45.2023.02.27.08.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:23:19 -0800 (PST)
Message-ID: <a7423fe2-f8b4-17e4-b936-84e05e934ee4@grimberg.me>
Date: Mon, 27 Feb 2023 18:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme: bring back auto-removal of deleted namespaces
 during sequential scan
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, nh@edgeless.systems
References: <20230221222307.557935-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230221222307.557935-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_082323_763214_1FDD1B91 
X-CRM114-Status: UNSURE (   6.17  )
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

