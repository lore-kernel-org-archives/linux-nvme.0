Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B68CC7EE21
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T+NYfpanY1avBheyuuF8TZa3tnbnUeGdTgsacBUeRBk=; b=U/o0GWkT6YQgPr8P2fvD3im1B4
	uak88/nEGEWeOiJlChePrnAsisd2I8fJPSHT4b91Dacu+8Au04h1yI8fcxW3vbU/QZS9OJOctvuOX
	TS6s0No+uN6Sg8cM77S40ZMc+dRWV4/9/8LxeLkusdIvC06DRWlPF5lIBtDdJK2ji/YLZiftdwlKI
	ZFGsm8kXNFueqoLynJBqulSxDZFhafrF3t1Wg0bKjGrGQYR0iITDSJf1WSn1uGhpDTDrhcHm4a6ch
	RaLVG6OijsVzMp6FRUzaBjJnFHvt9i5bdBzQgEsdznSJtqOGxYLqe2WPmNl1BwcE/kWEx5eWTsk+Q
	6rnj5jtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puUAk-0075DR-0V;
	Thu, 04 May 2023 08:18:42 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puUAg-007554-2a
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 08:18:40 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3063b921c7eso15311f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 01:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188313; x=1685780313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+NYfpanY1avBheyuuF8TZa3tnbnUeGdTgsacBUeRBk=;
        b=DsahfL0Ld0PuoR8RbvU/nKngCO4TNR0cKssBg8Zii6UOlu48AwbFQGcx1gONP7IG9P
         nOEsxlWPMm2vurf33IbOs5IHbDxARRn/QnS1YkMTksEIplbc8nCmjYxT0eJSL2S9tokE
         0txTUt3JLo7Iuj+tv0hHcP6Fk8JbVFdZ3PPXxpPGlqLwkROh53ylfToQTbq79mtb61zt
         sQzyiDzno++HkLWEPStgJ27llSx9cVu3zIPhsRQma6AEB4hm253jlcH72VP9jW5Vmmsz
         WiZ9Lil53DHI1DmPUTOc9dQYH+HZ0jS5FHVSp2NMSlo09LkhsbBZU0fzz6mPsjDUZ+n6
         j0Mw==
X-Gm-Message-State: AC+VfDwVDQ3KaJ+sB3IALMJkUkvnFKFLaIsoRkkXTNX/zF/p0pyEuUBF
	Mz5hwAeGN4Q5V3DtEg/1arY=
X-Google-Smtp-Source: ACHHUZ6LjGONLuy+Dmabu/JugVD4a5/kEuacR/NO5k4yZi3i7aAJLg+HORZvtw241GL81++yrBGiBg==
X-Received: by 2002:adf:e8cc:0:b0:306:2720:b00d with SMTP id k12-20020adfe8cc000000b003062720b00dmr6490891wrn.7.1683188313349;
        Thu, 04 May 2023 01:18:33 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id b2-20020adff902000000b00304aba2cfcbsm19700380wrr.7.2023.05.04.01.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 01:18:32 -0700 (PDT)
Message-ID: <17ad8acb-bf02-f194-75a4-b1508c8f6cbc@grimberg.me>
Date: Thu, 4 May 2023 11:18:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme: Fix memory leak in nvme_init_ctrl error path
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Irvin Cote <irvincoteg@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20230503150925.863308-1-sagi@grimberg.me>
 <581f5ee4-7adf-fea7-54cb-11a56e3f082c@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <581f5ee4-7adf-fea7-54cb-11a56e3f082c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_011838_915435_5E92FF3D 
X-CRM114-Status: GOOD (  10.77  )
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


> I try to apply this patch on linux-nvme nvme-6.4 it is not applying,
> which tree I should use for this to test it ?
> 
> nvme (nvme-6.4) # git apply init-ctrl-fix.patch
> error: patch failed: drivers/nvme/host/core.c:5137
> error: drivers/nvme/host/core.c: patch does not apply

It is on top of your series for the other memleaks

