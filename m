Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAC4EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=cpoFoEtFvJj/gytbORvs9AXqTk
	xr6fvqQd2BWMjESAypQgJETF4EoKz9MI/x4QhcMvjeY4CDvtF2qtBw3v9A5gU18DGlHABE3WBT5y2
	Ee16N2mEPpmpM0nGb4kHN01lKiweQiismsLyJegAczVrkkv164HlVv1W2oWth+FNWJ5J+Lj4ITBeO
	3mfTdf6iOdVDOQC8rAkh5r7urpf5Tn+R6SfaCsGojj+jAXCZ1dteMWcnDVm6+6EzLoXTR8weArfkS
	kjnclk1Ht5C9KklgeqynPCOd6xytsLoQPHlrZl46dyL5p8pF6V/djGF1r2Gpdaz2fNojvElEMhz+J
	7jpBGegg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWZ0o-005teB-2n;
	Thu, 17 Aug 2023 09:09:50 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWZ0m-005tcb-1K
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 09:09:49 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fe3194d21dso13725275e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 02:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263378; x=1692868178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NrzaiX5Fu5o9FPhxKM+T6NVL7M6p22HdlpnnOFNtkYs1lB5gdo018bLdvCdr4J0tkm
         3HaSZPxD3NaAo9PfzJPuj0NT2XXu7hhJXUsKHaLaU8bNV5UmFPnR0DrPOebl3Xi7kULC
         fkh+54Q8ekwgII3qFe5T1dN4xyPuVulYYsmVq0g6Qtt1VIMSBx1GnMN00fB1Ysmu97XV
         dB/Jnknw+Qwu1GORN8x56hnFLwoYmt56UkSwvjq7v4JpNoCoSurHShjp9KXZRTHLjf3F
         BGSPT4AwJY9hESTLt/T1DrFpoS4wEdkRJ6SFg2YhRKPbMGcRdSqHb7kwZtd44hfS0oO6
         TEJA==
X-Gm-Message-State: AOJu0Yye9Ne9H5QIdOGvhjjOf4pOjeDUKsB6zLVUsDBNgfuDLwj6xfJB
	jjMnBeV/8VDc8W3eIb+xs2k=
X-Google-Smtp-Source: AGHT+IGj6dNN+zpaXvGqC/LQdnfZDiM+LduNGZzkfM2LyqeC8kTFre2YMIbbwRWsKtg2xS5Js7zgqw==
X-Received: by 2002:a05:600c:310b:b0:3f9:bf0e:a312 with SMTP id g11-20020a05600c310b00b003f9bf0ea312mr3610127wmo.1.1692263378181;
        Thu, 17 Aug 2023 02:09:38 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm24177001wrq.85.2023.08.17.02.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 02:09:37 -0700 (PDT)
Message-ID: <f7fb851e-bc96-1c28-c5ab-fd5b5ca5ccf7@grimberg.me>
Date: Thu, 17 Aug 2023 12:09:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, Rakshana Sridhar <rakshanas@chelsio.com>
References: <20230815114200.50705-1-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230815114200.50705-1-varun@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_020948_468050_6B672F3B 
X-CRM114-Status: UNSURE (   5.76  )
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

