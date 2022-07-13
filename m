Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF89DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wDaQ4n5/txsyQKpMWH8dnEvGv5
	vZx8zh8MNIibQ1948/AdaMW8cVUm5Dm1KOvHfyiAuPbU3+7xf48/rYMKg7CWJdIw0ViM3ovDKq7gC
	wagq3+QbfowMbx27ULd90GtdRkMQLLAiLWDUNbBhNaVqejDFj1uEpAhqnmXQN6zxf2XoD3ZI8kT7G
	kC6audjTf0WOeoPzcQXkR8ovEOYzBhCzW426WpJTPnGEpHGiOnBTUuc1dLvi5k4G2cFXrKH1U8VVt
	f4Sl2gzXJJ2WUdDMEzj8mRng5+cjgfeXpG7tYTVMnPqab251WUy3xgxtLgEBdAYKwhpjHCoJ1x9LV
	IYBQhw4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYb2-002Er1-Ed; Wed, 13 Jul 2022 09:23:52 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYaz-002Epv-DB
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 09:23:50 +0000
Received: by mail-wm1-f42.google.com with SMTP id ay25so6148939wmb.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 02:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=6IdJWJ6o/yLOspNBHham4ERaEzqsGjiFu+0Diwbd0IypZf2oRQ7DyDjPvnJUvRC/CU
         1fJG1oBJ6P3c47mfhtnCRornwCLjzxOSBOKUdsfqu3IRYXPN7ldNy6AR9JK1r7qEDOKZ
         UcnusGBIIvkqcI3NXwy0GfPXr8WavFl2h8yALkGCBXked7Sh0la+ceUn5XTyf+57x9Dr
         LXzjUkrnx59A/4G0KD33fWsMsdcrOaMwcUfrMeoupD0k4G+FiAAge3uFJ6tGb1FFSyos
         si1PO2knHvoKNLPU+4stfNcEPci+cx5gppiCMOxlq80iv1DQ6oFxNwitX9ZHK9qsO24F
         iibA==
X-Gm-Message-State: AJIora9re+j9KJKb64Ut53DxXcy2+BgVAcWFqCnP80mW57TYLDzCNl5x
	1y6pdE6k4eVfQIsjxFqUJt0=
X-Google-Smtp-Source: AGRyM1u+uGuOnj342jQeLrrpwomHQ+4nFk6P2H4Q632YXKdWReQ13+mz1ESMFnJ5JQ7uL4WKoL7CQg==
X-Received: by 2002:a7b:cbc9:0:b0:3a2:fd58:1d0a with SMTP id n9-20020a7bcbc9000000b003a2fd581d0amr1276732wmi.28.1657704227644;
        Wed, 13 Jul 2022 02:23:47 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b003a2cf17a894sm1559938wmc.41.2022.07.13.02.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:23:47 -0700 (PDT)
Message-ID: <c822ed3b-9d52-9465-d2e2-89e15ee74e05@grimberg.me>
Date: Wed, 13 Jul 2022 12:23:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/5] nvme: factor out a nvme_ns_is_readonly helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
 kbusch@kernel.org
Cc: joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 gost.dev@samsung.com, k.jensen@samsung.com
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713054914.1888305-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_022349_460668_70E1FBF4 
X-CRM114-Status: UNSURE (   5.81  )
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

