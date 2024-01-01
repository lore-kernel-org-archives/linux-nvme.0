Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA84EC47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pmiB147S5w6CXHG+S9chuuHRcWXJHmvBeNi9qzFdZWk=; b=LdVneSEELqrnontxRFCPpB8MNg
	bQrKoFgolKbuFfxG0IMpBCPP/Vo87FQ/5w7CrhAJ2esuRZwrV327wbZfN8+0VoprcXSoQDdASBtCx
	AuAMiPMoMHYGw5Ga7ym2K3chfNdN94xOjjJkQ+haj0yHjaGvz6p83muFobe5OLRmfJ/TJeYKtk+IQ
	/CCrdCCvYezuDV11+QFRHjqVSE1gOwtwuripfOb8UTjqrTCLo60duNY1xv/dmIMdAXCJZ+GmZ4iBM
	rCSqWPEPj8dTPJM5ynBRhXCrS7VHYTXTuKTMsARdFu51i+XAl7YGhgoE4ywqUwqTSJloL+dG9LGMx
	bvv6TOVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEi0-005pyt-0f;
	Mon, 01 Jan 2024 09:35:44 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEhx-005pyN-20
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:35:42 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d377bd169so25346505e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101739; x=1704706539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmiB147S5w6CXHG+S9chuuHRcWXJHmvBeNi9qzFdZWk=;
        b=N4hmeSDJsOgWpL++DJHASRY1f5//1oeBTmtMXbvMv7PwTrxehkRaturGN6MMMws2b7
         dL3q2Ue5Fu5nqvI2XhD2zsyq3YOzzM2cnLUs7ebukM6hwkCtlOIZd1FYSt/JfAOjlHzx
         V8mlW+NZcprs7BKZHN9XMTAp/EF5oGY5aUFQlz0ulTipU/dsDuIe3qCB5jnJJED3mV5C
         jISUVe06pjTByCtnH6dBiSjs6YlbqAXQw0mZ6lP+p+IwYcy4UlJEIsG8THX6Na4+0iS+
         ciLRYGzthkNv4LhzTV9atPb3kO//hMfwGNaiYfJbR8Q5JeUprdsD00NgBkzl+QRZJ0Ld
         AYjw==
X-Gm-Message-State: AOJu0Yz3GFAffsc6fnwFbayENfXCCdX5glRSGRG4e1xRvSo0Z0KEfpg3
	0k2ZiczCFsstTaQd70LMZMrdj5uhDBc=
X-Google-Smtp-Source: AGHT+IGyWhgnnDo65/IwlBFi935RMC/otrKU5nVlhz3ywkj/U+Hg4aeWUZ1RBexwYOQEBUYAS/lHGg==
X-Received: by 2002:a5d:598b:0:b0:336:ef13:3018 with SMTP id n11-20020a5d598b000000b00336ef133018mr10525369wri.2.1704101739566;
        Mon, 01 Jan 2024 01:35:39 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b00336e69fbc32sm14048382wrs.102.2024.01.01.01.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:35:39 -0800 (PST)
Message-ID: <764288fe-0a62-4c22-9f10-307d5a156239@grimberg.me>
Date: Mon, 1 Jan 2024 11:35:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] nvme-rdma: clamp queue size according to ctrl cap
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-9-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-9-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_013541_661634_AB43CFA4 
X-CRM114-Status: UNSURE (   7.40  )
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


> If a controller is configured with metadata support, clamp the maximal
> queue size to be 128 since there are more resources that are needed
> for metadata operations. Otherwise, clamp it to 256.

Does the qp allocation succeeds or fails if attempting to create
256 size with metadata?

