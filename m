Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE996C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w9w/Kxwv1KuKwGxC8NruOPHd1Pq+K4HEm11yHYwoomw=; b=3fYbUUS5ucSiM6fqvPjbIraL5B
	e79CMjZDbK+YFCmysp1zlWf3uAC7KHx4xpoKlkMPxTh8hQRFeFdbSEaUipNy5JlInvHLLMjfOcTSZ
	j5Kx+hPSK8jg7sKcqPhLhgj6sqORfbfnVE6Lle7mIVtsnJjtb92q4gInuf0t+3jedssd1VQcZ1H6X
	uce2oLXjQwe+ASYdDxzTp24VTgLSFi51teeXNxh8pl7IDVCTVeOymtMAx+5uxJYWo4Vg/FU3bytpK
	I1C/JVzrmHokfBviaAmQzsHCjCJjgwDb5BmYKjpgvB5U9WZI24yyPq7FuRyhLu0tg1Az+tPozVH5j
	QQcTfqvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtMY-005jwn-2E;
	Mon, 08 Jan 2024 17:24:34 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtMW-005jvh-23
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 17:24:33 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e43928c10so3120535e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jan 2024 09:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734669; x=1705339469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9w/Kxwv1KuKwGxC8NruOPHd1Pq+K4HEm11yHYwoomw=;
        b=CGOJWtYMjJu6qtSUHgipA1R2cNMrDnTGl8pFI6olUw7b7wCQpO7WTSvmc6CWhIpVSE
         ovNlPKvUc/INt+mKUa+o8kojVE/unROvQdyY8NKzikZPP7f7DZmsjUHmUv+/0WCT6MKL
         ii+IekpjoWEwEPpajFzwaK5iSKtEsvUz3i3ugFamjSdqJyZVFiDzRRCBnpSPL2i0n0n5
         dIR9Gd7ej3qjP8dO9+obQax7rDrt0bPR/tvJOXHz9b1+zeMuPRKReB6b2d5BevlXGP6L
         pla5DQqyqh18V/3u/jxRoHwmBnDd1JIwll7Kvf+3nIpU1JG7z025I4Om7BW0I/PQLnql
         XhiA==
X-Gm-Message-State: AOJu0Yw0kJF4HaAtDB3uqOHZQw91Acl3BnuYPaQugBI1sBa2TtZarwaa
	NtLVrLFqfKkaGVuhBTRjCvY=
X-Google-Smtp-Source: AGHT+IHApEBD4s+5HOcvcsyPPf7X37eNlSOkkrXJH1UpkZiWEtx2BPDE99Uqg+K5kFAdtHQO6iFWsA==
X-Received: by 2002:a05:600c:3c83:b0:40d:891e:92a7 with SMTP id bg3-20020a05600c3c8300b0040d891e92a7mr5160748wmb.3.1704734669060;
        Mon, 08 Jan 2024 09:24:29 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b0040e3488f16dsm501198wmq.12.2024.01.08.09.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:24:28 -0800 (PST)
Message-ID: <2b52c1ec-6be7-44ff-8ac0-f476f889f019@grimberg.me>
Date: Mon, 8 Jan 2024 19:24:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-rdma: enhance timeout kernel log
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org
References: <20240107002950.6233-1-mgurtovoy@nvidia.com>
 <ZZwf46jEVOxfiZtu@kbusch-mbp>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZZwf46jEVOxfiZtu@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_092432_670277_B010E79A 
X-CRM114-Status: UNSURE (   4.50  )
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

FWIW, for the series

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

