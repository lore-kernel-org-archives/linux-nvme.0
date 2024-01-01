Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1999FC4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=mVjeU562D5qDsK9Yq+C4vznrQy
	vWv+5oySrGmEudfLaA9RsC3o8fxhrG5XX7sSwL+xy8v9eyX4/rMp0q0opBpp42BDwfd+bnw+Mb8z9
	XJ86olEA12440tDkKH6Mxm5Z27xLJ+LgxX0HsJtvWXrCPlU0ECbKYoOpczQlg8ZChAP2Ehqt72w3A
	dO+kWPfyDUa8QRzNEADEj30Nsn/5diEm8Bqhq7leyk4IHiIO+A9eyhMWiCjjg7Z8kDZAgvSo5I4Xj
	w/rqwDaJ7+q7XB+YfWR00GUGR2pMiGtlUpoL9oS32DuyhCyEgMFPL93576PbybaoZmpUJq+HWtSaT
	74/yJ3Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEy0-005rK3-1c;
	Mon, 01 Jan 2024 09:52:16 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKExx-005rJ4-15
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:52:14 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d855d0e40so2712725e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704102731; x=1704707531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=R9sYW2htjwsqXfJyY7QU8/lU259gBVx4akRGqEFqaxMGBW1axNd7YTpEPVECCsi/rH
         PEPHzhH5RW23c710QeNrwEqLzfmygINHAHpyBhQgG+g1LU052zsbfYCcsakLl2iaqMcZ
         jqVvRQeyk+jqL779QsnzsqeEiggpRlkb0kstaWsP/UNzWmTpGE8PU46wmYeBseJVWx84
         EHyJzxQKY36bZhaf2MBJLM4kYd6BtVcSTl05kwXRRO53601nR/I4Ui82/WMqZ/58qCV4
         nKhKOocclf+n0xHnezc8vGJST5Y7ZN0d+kSzYSFNfnD8qeYatERPQfLV1puLv4f/hM9X
         5LGg==
X-Gm-Message-State: AOJu0YyIGil4ydcs6hNhZ5t8O+RJyBMLDRgGGMD9ZVzJRJTa1XBAlQle
	ukdHUkxLs/3ZqaVxFdm2ToI=
X-Google-Smtp-Source: AGHT+IEhZSXL0tU8DA5OD5M+tlzeV1KoW27AGKZjAUwtyE/t8ONhjsFOZ1o13eD3DQIggi2S9FR98g==
X-Received: by 2002:a05:600c:1c12:b0:40d:5bc3:6a5b with SMTP id j18-20020a05600c1c1200b0040d5bc36a5bmr10831013wms.2.1704102731402;
        Mon, 01 Jan 2024 01:52:11 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b0040d6ffae526sm13976226wmq.39.2024.01.01.01.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:52:11 -0800 (PST)
Message-ID: <d34acb9a-bb43-45fd-9a7f-490bc7c7977e@grimberg.me>
Date: Mon, 1 Jan 2024 11:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-common: mark nvme_tls_psk_prio static
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20231226081412.180149-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231226081412.180149-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_015213_370165_116D2251 
X-CRM114-Status: UNSURE (   5.24  )
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

