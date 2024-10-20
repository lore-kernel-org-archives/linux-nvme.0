Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E98D3C927
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=AiTHTFjzmFjZvL+H4d2lSwY9aH
	M9TuevnIUzqB6lsX/fz6m2OrnQExzRXR1HSwF8yiZUfnQln2DiY/RGOTfXAJfldrCZNpZez+s8as9
	b7dCQKdIQ0RVR+Yll8yo51Mwcm0tlse2poMxEtkG8owivsfPi3izLiaq5JFOkD5PCNeIIud/Dtrnc
	rSE0VHBGVKS91cjRaf8frIVLMg8K7XOL/55fa/xMH04HGSMlRPi5EZLCsKPzq74ZfIzCXTmufic4A
	X4xUe0F83s8EF/588xITN6Tozm4oadYK08aCBTn9Gt8bAAblhvzo4HPv/ZypeZykLZ1ZCPzDuCZN2
	pkxUZIlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fgF-00000005eQf-4BNG;
	Sun, 20 Oct 2024 23:49:52 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fgC-00000005eQ4-3VyV
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:49:50 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43163667f0eso23003275e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729468187; x=1730072987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DBCbzBhnRjfJqSih2IcR9zFXrJjECOBeVEFXNs98OSozm5S9VQ7h4+BG9bzs//1AMY
         CA71SwSC6TyZ2wrf1zlwbxwPZnR2mTj0QV3jnMKWHeRqjGFqktD2I89gB96H4ikTksDv
         tFzRJ9Qhd6NBLCaQboUxgeJkBIHl6/zKQv/ZaxK485+bXbuPe/ZTup1eLeV/mO9b8cXu
         Rx1JioWNvR8lrQC8itaL7PNY/Vh+S1VJfEexbjcpTN3KAUL73r++xyBVKUR7usSUMvKm
         vU2fdHNC/fWi5SoTTunA3kqJ0H9HH9yc1wMBVGu1sML84qHyoHuY11aAX7G6nunvURil
         LoQg==
X-Gm-Message-State: AOJu0YwKcriWaULAtsd1JloPLm/oZVcGiwBXCZ1ne7VQW2lfxTSY0E6b
	4vqh6OBpTcZXxS7hkniZDULRdAXFvsEPe0/zz5ASmduvOU/5ZhUstDgf2g==
X-Google-Smtp-Source: AGHT+IGBHD9Xq2MxD0saq/Frr5ovX0H7faVGUf/2QXKP2ZTX+VvCS1K+IDX0pcmFdM3iz1xwLlTsgA==
X-Received: by 2002:a05:600c:354e:b0:42f:8fcd:486c with SMTP id 5b1f17b1804b1-431616a3c84mr69486095e9.33.1729468187031;
        Sun, 20 Oct 2024 16:49:47 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b630sm2836704f8f.60.2024.10.20.16.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:49:46 -0700 (PDT)
Message-ID: <1b85f870-3a69-48ef-becb-72a71e96ceeb@grimberg.me>
Date: Mon, 21 Oct 2024 02:49:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvme-tcp: forward context to teardown admin queue
 function
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20241014165329.639998-1-dwagner@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241014165329.639998-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_164948_883828_BEEAB895 
X-CRM114-Status: UNSURE (   5.10  )
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

