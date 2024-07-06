Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3BAC2BD09
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jul 2024 21:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ngI32ntyobAs23HYOfqRlwcFrA
	gwr5gUd7tN0zSyrppUowdHW8fP/fh8e+ncBQIR/wYLBk3zgsjQo/EKb+/GVcexKadG2NAKLM6DDmz
	RMFcUyMmKhIw7aJWwP+Y+zoI7wEFFpvV5ZaazzoWjIZ/+S2V0LwwTap223YHZ0BECAb17Ia+Dehvm
	+NEQZ8MsSs+MJACZBaTbKqEcDmDf+SkweokP2LAqW+/gYiL7C06b4f3yM+wf0LKAnapL7a7QhjSyz
	F6qpPJJRk4Cjxet4WAqxo089/FLr0vYdk62Ig5/CgGtfJ4NgMP7OTCIlvWAGecuCW4jY0WYRjOCHi
	B83Y266g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQD7U-00000000rNM-194C;
	Sat, 06 Jul 2024 21:39:00 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQD7R-00000000rMi-3A6Q
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jul 2024 21:38:59 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4265dd11476so1132595e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jul 2024 14:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720301935; x=1720906735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QTXfrBi/1Ps3Z+zhLjXmilsnz3kz1uHcg/CUGj2tMVrC+NPnD2Ll7CX/9jAzTYiQnU
         mNJhCpfTI0xmgvDVf501XU92q26kKGELftD+lcngqFlddje774OiOwrtwJ38iKuW6XqG
         XAuCQGlIG4s1kdry2gJIq4g1kPb7/knTvQwWTY0OdQrxZxXD9wKDx7zGhc1Ht+v903jU
         zR/ihLnYWygxUH83EnIBaiuQD9dKQhuqs83CP8QjoSGqIcRj3QehJT1X7X2J+JqceJjx
         kfKELjgtnYdxBlPX4UOlaA9FK2JLtQPH/VhDDLedS55qTn/FB1390ZpID34VufOXV0tT
         2akg==
X-Gm-Message-State: AOJu0Yx/DSdaQAIRGoxJnDFbYPddVzZVSvtPyGxgj0bEsRlnMZh6dGpC
	eHMi1MEKlGZ+rp3Zhn97dC8cE0Y+bw8EpW8TwLn64rSxIw3IiVtn
X-Google-Smtp-Source: AGHT+IFVwjkPnYrmk5ALGfyo2NXR96Of3Gc0DBiPziXssRy+61xYic2pBdOeLdGcXc94TTHXNkBx9A==
X-Received: by 2002:a05:600c:1c9f:b0:425:7ac6:96f7 with SMTP id 5b1f17b1804b1-4264a35297dmr56129215e9.0.1720301934782;
        Sat, 06 Jul 2024 14:38:54 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d165bsm108546225e9.4.2024.07.06.14.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 14:38:54 -0700 (PDT)
Message-ID: <7844890b-1473-4cec-a12b-9ee039979a41@grimberg.me>
Date: Sun, 7 Jul 2024 00:38:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: implement ->get_unique_id
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
References: <20240705164640.2247869-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240705164640.2247869-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240706_143857_829100_5561192C 
X-CRM114-Status: UNSURE (   4.48  )
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

