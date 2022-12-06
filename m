Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3CBC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hLuvpFdNmN2M8HLWHIRbKyc6PY
	FRGiRtkLBEF066b3yYp6+NTnNGosQeQTkLdupCDa5/DNbRA9Q6hF0ag/X3VZ2LDaeXtjgK2S4Zr8e
	FBNAe/88kscrvOex94c+JIFIzzfycOb0HMKFZCJlbDX12w0W+2gd9xHIRJ4xaaEcQ/yTFDhKcwM/T
	5GSnJhAO0gO8Fx9x45Y8q8QX4/xnOo9a8NY2wiP6gdmxu3t6uXRba2JWHyBllFCIlNtcuvq9cDTVA
	8pdz5VtPxA5YYsF+w+Y3/2VX6xMgP/IShcQCQ1lFGDfHFkkM9HD58rwkidLNJ/wDjviSwpwdoTKvK
	ePw68pZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wyy-0093qO-DH; Tue, 06 Dec 2022 12:23:32 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wyt-0093kg-TA
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:23:30 +0000
Received: by mail-wm1-f52.google.com with SMTP id v7so11064939wmn.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mf7Qh0pBOUA2X/MGQmLHg9ttv/IF06nSQIh1H4OeWlFebkTxnNgNZCKYz3XFhLHZi8
         eXsEPhlf5np1vNqz2a9prGnqXKiU2YUw1cDEYkuJ77EK5/YPl8xWsUp6KXiDXKnrAmTx
         0msx+CVz3K1bdAE+z37J+FUJWQEPJdHAnb+ax7QEMix3Bf/QvM/lCEfLqBxYz5YOC+FA
         ylebbOEZL7a3I37fmKjWTA9mSO0qFbLlQkx4Fo/iEUemCSd5byriIjjup2BeJWP8Ts7Z
         ZgO/B7t9+YIXA/xn2tybyJfDDnfEheZEK0NgNOGdbkQvVDatpTjV3hlbXRxJGK4E2KJ4
         MnIQ==
X-Gm-Message-State: ANoB5pm9qTiqeU0SQwbbDDXk7K3rl0GgBYJdjnpT75aQ2AZOVQtzZIiI
	0ELPS0+OqhPcbvzbc/MwG/g4wUndixs=
X-Google-Smtp-Source: AA0mqf5ITLhi9uhusEXIn2wTyjQnO8sccPThtAzOeIKsV+VN/4tUw6rGvEuBbijT+WehP2MFbv1vEw==
X-Received: by 2002:a05:600c:1e04:b0:3d0:bda:f20 with SMTP id ay4-20020a05600c1e0400b003d00bda0f20mr58011304wmb.105.1670329399208;
        Tue, 06 Dec 2022 04:23:19 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b003b47e75b401sm28041370wmq.37.2022.12.06.04.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:23:18 -0800 (PST)
Message-ID: <8a6bb3e4-54a5-bdeb-3269-3a2f6d4b1e09@grimberg.me>
Date: Tue, 6 Dec 2022 14:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 9/9] nvme-pci: split out a nvme_pci_ctrl_is_dead helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-10-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129132208.4337-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_042327_984330_E016AD20 
X-CRM114-Status: UNSURE (   6.90  )
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

