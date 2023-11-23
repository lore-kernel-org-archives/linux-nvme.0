Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7689C61D99
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 01:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oORLPdmSkT7fywiwae+wqCVAqBVgc5XZ8rvnAnGFiYc=; b=OMHOHttSnGZqmQLYT9w7qN911i
	a8D65gPqsdCJhsVm/rRFjf+LwLOPu3UFjvF/z17t+Wx8kxeknOeg7NcX5sxguwHYwh4RySgVcI2B9
	pGmyKyZM+HRb8ihJes74RwqPXg8GwmZe+pc2rS/+S75j22w5JZo6ZryBc3u01sJzszZcXhQEBp5tc
	xFi2Psc+lo5iwGkvJdiqLyCqAny/zoO0Yqrn8CQl1FBsfQju94ko91bc8gm8E0Q2mqE9mTTlNII1y
	5kAEeUyVLFiGZdz+FJ1EiSSStpsmBdnT4e7d0Hf9d1SMEu3z3NC+AvPAFMUkUIn3YeKy82XG8gzqP
	cXBebYJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5yjj-003WcQ-1y;
	Thu, 23 Nov 2023 01:42:35 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5yjc-003Wc7-2k
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 01:42:31 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so56286a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Nov 2023 17:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700703748; x=1701308548; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oORLPdmSkT7fywiwae+wqCVAqBVgc5XZ8rvnAnGFiYc=;
        b=mqdezADiHAfkhtwPmK94hm5cQnrFpjV0uFTaEIasrhs4lBZopw8xTaX6VYXzKE+fhr
         wSsBI2Vu+Uy0bjrdZeWGsHZIHOdnEDnBSKDWPVuamOnLx+VC/tb5ZeBSMd672iCqPiE/
         2MYacUyIXCG1qCaUzJLpFQb3dH3KpNC6GBXiKWtCUir62Uf5jAh/lNJDHoBvMjwpq/m8
         +A+RqmMaa3j/g/Si2svDywtVCWuYjJCzI/1DVVch3ftz5MgnwYzCTRXXIhJ4okw/toGA
         xyT6mkXIZaEQyQvYGK01yDimLZRQYHr2/HkGqYQAlTnAJ9z/HAoqaoYUKWzX4wd7bEK3
         WNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700703748; x=1701308548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oORLPdmSkT7fywiwae+wqCVAqBVgc5XZ8rvnAnGFiYc=;
        b=sxX8qtmOQzGlsol5zRgwfgcYp1MHO1PrSdR645jDUxaJ9aIn9ebh8aLN8kLfVUBTh8
         1snEyekh54yHPMo6UcL6wAvl8QaipQ4/A6Qf7U8fa88RoVswDcjsS4BDdVSvBKgJ0hrh
         7b/2n2uXZDMmxvZ/aFQHXqrP0qN5xZ0R20s/xlYHIzOkMU9pxRU7qUmG1hy23PBTtF8C
         idgld6AaCPunDi2obvYQojBv+QMlnv3Sv7pZbnj/t72vG57YHBxLQGbo4Nzc8ITQZIlj
         lpoQ63mlbENJUfqfqfSbAppbS3XsIRMbxsAHjLdXzVC7dq9A/EDpN82JYU/q6xbXoBAt
         WLlg==
X-Gm-Message-State: AOJu0Yxcl0IhBpJr8LOtRMZnqukpOuSshzBoYOGKO6X5j+XFSiLF14Dm
	OGgMQS4wi7Q9eHVyoy7sLJYeEQ==
X-Google-Smtp-Source: AGHT+IFmhw56H/FIo6SGkKRX/ecBGszAJ+QW7KRUVB+NGb8s0mU1FnZYOsHxXGDdys/4OgZqZtF/xg==
X-Received: by 2002:a05:6a21:99a3:b0:18a:d4c2:cbee with SMTP id ve35-20020a056a2199a300b0018ad4c2cbeemr4888126pzb.2.1700703747526;
        Wed, 22 Nov 2023 17:42:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p47-20020a056a0026ef00b006c052e08813sm128761pfw.50.2023.11.22.17.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 17:42:26 -0800 (PST)
Message-ID: <ca200ed6-a70e-401e-b862-f690368e0266@kernel.dk>
Date: Wed, 22 Nov 2023 18:42:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-nvme@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org
References: <20231122224719.4042108-1-arnd@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_174229_135218_22B9A1EE 
X-CRM114-Status: GOOD (  12.61  )
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

On 11/22/23 3:47 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are still a couple of link failures that I tried to address
> with a previous patch. I've split up the missing bits into smaller
> patches and tried to explain the bugs in more detail.
> 
> With these applied, randconfig builds work again. Please either
> merge them or treat them as bug reports and find a different fix,
> I won't do another version.

Applied, but had to hand-apply hunk 9 of patch 3 due to a previous
attempt at this:

commit 23441536b63677cb2ed9b1637d8ca70315e44bd0
Author: Hannes Reinecke <hare@suse.de>
Date:   Tue Nov 14 14:18:21 2023 +0100

    nvme-tcp: only evaluate 'tls' option if TLS is selected

-- 
Jens Axboe



