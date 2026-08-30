Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBC7C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=yxyfSt6YzOQ04UJCwTWnpT4EBk
	gP3W/3QDZV7kTR0IXc+PCYLjKWA1fBW4JpHdfxWWBkevFGJfdelfDXJ4tJ5NTb7i7GPf5rIA61Hec
	FQ4yJraQuOGuI148tsJ9ETV7+uTUd7uuSrdC9SH7OWPGt1IS6YdXvlLBIJsCZMmfwUtmW1KiGqB6k
	G2e84HbFBKux+H63yG5jln7F/v5Fv+dJFQasPeyy/dvoc1ry/4A5dCMPPR2uZSBFl/oi6vq05rGAJ
	lwV26CfukPU7PJuL/LnbP558s7Q5oKCqesh4viqe2j4/Y6bV+9alrOCPTKwCf4dulIpL+FGDAYPht
	PkTogpUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mth-000000086ja-23FA;
	Sun, 30 Aug 2026 21:17:01 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mtf-000000086jA-2tTs
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:17:00 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso29188545e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788124618; x=1788729418;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KT/DVYttBcpn4ve0sSL/iGcnbUxZnnprDucpcJ2u9lIAv6h158Bdr/Kf4CkUURGN0B
         M01jkXqIOd78dQojYGT/hvGoPCNgOma7ka/vs62PdjjKsYOji4yIeQg5PNpokbpe4SRp
         qsXUng1y6EnskPoUYCEtJLSYj4olxE/OZ+aqe0h+zkgpOHVCvxv1US3fzFn3Hm88Er6m
         aXn2iGG2XBxARN/LE3lFHW539o8ZkeWNczEWs7uiOE7tcUK5FGJIBp5Aa4Tq8QkwJb7u
         AKYHw4NktoO58z41/x58NDy3gAa7Owr9+1NvKVfEQywLdAIcc+qP3sYuwHUlqoQndzhe
         bb4w==
X-Forwarded-Encrypted: i=1; AHgh+RrpUbxPPl81Ek1LlhL6xeWph603hcIYNBPPfrPpPaHQmCk66cVVkaTQ05SKhpKsIbwrECN5v32bz8iR@lists.infradead.org
X-Gm-Message-State: AFuF++l3iJWX5xFkpxlKnvtO2b+A3ZXNON+BbS4D94pLum20JlqEO0a5
	97bmf0HB699NdM/p5C1rNm1uoxoST1MD29HoTWHYwNdKsVuUbQsbwNj/2bn0blTFNeo=
X-Gm-Gg: AR+sD134TmXjCMBWzmSiYlyQ50tNQ59Vh8lAWacSi1eP+2G7+LyNczBEylUPpCbEUeZ
	+q0+yXKZfxK7tSTBDcNCLAAJSCsrFrGV066fzRFiNNTp7ZQy+wUc3UyK3RIE7TwZkziFsbr94cE
	sI8/DZNT+Gzxw64nPj6O87l80kpKdpqzEetkKRtQRDSzQATAtKomfed9kF/QS9wzOFaajf9Eask
	xurEjdoyzSyjLaJeWzDQ4B4DW4omEBQzlUzwqD7R0VKm2DmgV/BkWn5+UGnsqfwwJAU67P0kI2D
	UM/FufOcEAYkvENSfuEfzQl8hCfY4ZZNtWlN/qfxC3hHQnnRoijKTo9ngtN99dGOHzKHdxTTl/N
	JIS/2/JRq7antak6W4cztKQpwvzvzQkU73ltm2N/5oVvi3sW6FqdkT8ZLgXcj2bbpPduPynJE/s
	qrt3aDDoZGDi7UhrbfOBnpCAqQenlTv6vILZiGPfSNelRuZQxqxOFEZcUdppvths6FWgVuau7ab
	Q87YpmWONd2XNfUd9yboA==
X-Received: by 2002:a05:600c:6216:b0:49c:a2f3:fe9a with SMTP id 5b1f17b1804b1-49cd53bf560mr73470835e9.7.1788124617669;
        Sun, 30 Aug 2026 14:16:57 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9281772bsm110152965e9.1.2026.08.30.14.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:16:56 -0700 (PDT)
Message-ID: <a804fcc9-32e5-47e6-b43d-c4fbeaa482aa@grimberg.me>
Date: Mon, 31 Aug 2026 00:16:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-7.3 v2 1/4] nvme-fabrics: separate option tokenizer
 pointer
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
 <B5DBFE863C2BC94C+20260827130326.1390222-1-raoxu@uniontech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <B5DBFE863C2BC94C+20260827130326.1390222-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_141659_724926_F7D98C62 
X-CRM114-Status: UNSURE (   4.20  )
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


