Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F45FC27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gusV37GeNeY+oeCFRFa4YfsAprY6hsRabaSJi44TvCw=; b=KHwxa9wUhX3rcOd8eAxAf1aFKv
	Ilnha7EJ6jE88MbciDzxAOymKIyxHY+jEmXU0AdRvwAbdF/+7vF1ofTCu6wBawBxU2zZiYihKAecp
	MSmMujuhMVKg/TY1x4c/2U85OmzCucQ+uEng6rURiRaS8eqErIPtVyg9XFCFezu9B9pcbo7o1ljjU
	iGERZZ2OhDLcxzyRf1zCIeXaOtOWMok7p0DEWwHJ3pJBWLJKm92Y8NaH7ZPA+OVA+i0BeYuJvRo9e
	2EJKc4/golxPkwRqifwOxXRDsBdr53zRMjfovz7BaNyCdNFZNCPg0YEn7r0HSrF0tDiG4Lz0Q0boA
	mHxmcBAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbwL-00000004Zr1-3TCf;
	Mon, 10 Jun 2024 10:07:49 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbwH-00000004Zpd-117T
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 10:07:47 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4217fd95c78so1525965e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 03:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014063; x=1718618863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gusV37GeNeY+oeCFRFa4YfsAprY6hsRabaSJi44TvCw=;
        b=GLFZScXyAohkdo6x+awXr1bChG/hqgfJlCNUZKETxd3HBdlBHWt0WEn1bZuh30+EM8
         igNnUyAW13J7xWdShWBhaQyqW/Fxuam1L0qDdVA1rCuYC8o5sfIYfZPJ1Ab+X2Da/AjK
         tlZBVmnTKJaLVNePCFhdNx8ck/vaGq3pzV4DZi7yYEQCBYgcV0RCtq0Di/mQrbS2LDJT
         zFlHTfwJL44W3JBe1ibGn+eDF37cdmXEyTy9L1+2k5NE7FYfDcP9jr2ZgLBLQxxzIkhi
         7bYxaH9K1/wr+FjU9SqlXuACSYPW9pY8Apo6AOBosmpaLVLFkttds/jcgvcmhmxxatJX
         6Pyg==
X-Gm-Message-State: AOJu0YxbKjSpb+vIZYqTtdqyvGmoDzd87lVNudVdREcn05gQUprJJ/ss
	jaAi28SJO9glit3JtFXgmLnvMB+j0YxdMhSaZBMpDnzvbejjcn3c
X-Google-Smtp-Source: AGHT+IF1MvSTf+KQ/Fpbu6jYXs3sjGYXa/fDF+6ZROWh3dpcnxcOeS+ygB9F/kRaFlkWEJVF3Am3BQ==
X-Received: by 2002:a05:600c:5113:b0:421:b65d:2230 with SMTP id 5b1f17b1804b1-421b65d25afmr21427615e9.0.1718014063361;
        Mon, 10 Jun 2024 03:07:43 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4217f633f2asm63882665e9.28.2024.06.10.03.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 03:07:43 -0700 (PDT)
Message-ID: <9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
Date: Mon, 10 Jun 2024 13:07:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
To: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240530183906.4534c029@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_030745_334926_22B15549 
X-CRM114-Status: GOOD (  12.02  )
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



On 31/05/2024 4:39, Jakub Kicinski wrote:
> On Wed, 29 May 2024 16:00:33 +0000 Aurelien Aptel wrote:
>> These offloads are similar in nature to the packet-based NIC TLS offloads,
>> which are already upstream (see net/tls/tls_device.c).
>> You can read more about TLS offload here:
>> https://www.kernel.org/doc/html/latest/networking/tls-offload.html
> Which I had to send a fix for blindly again today:
> https://lore.kernel.org/all/20240530232607.82686-1-kuba@kernel.org/
> because there is no software model and none of the vendors apparently
> cares enough to rigorously test it.
>
> I'm not joking with the continuous tests.

Is there any plans to address the testing concerns here?

