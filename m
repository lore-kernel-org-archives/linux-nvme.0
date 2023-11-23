Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D56C61D85
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 20:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSloKbp86UiyOswV753VKR+ULy2TcPDIFU6JTx1BHg8=; b=eokTpORHY2wTCLtsexOEnW3c9i
	1CxQwuqx6YCH2oprvC5nO6eZpXleV0o0om7Zw0uy9RmOZwlYxrJXJ5YS8aCUZkW3GeMkGGE+Q/fWc
	bee5Hj6JdLLibjl03RntjDs0D6b9Igl7wW/4ViPFspsbwpsFxrgk+3X61bcYvR/6brZtgl1AvNamK
	ZFFmDTwNLHk5miLJA6j4HYuc8UqdDzq+1+SM2ndfrkXh+d0e2BqjQPt7kn361G88hH20p3wTOmnMt
	p7NL6xaq5Is+fse4F3S9YoN8b7BcNiFwqZAFXfsN/RvI9vM7kILcpVpvFvo7XQO1+ra+NLQzoy97Z
	Mr1u6d1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Fwd-005ffn-1k;
	Thu, 23 Nov 2023 20:05:03 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Fwa-005fdm-05
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 20:05:01 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so226957a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Nov 2023 12:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700769898; x=1701374698; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSloKbp86UiyOswV753VKR+ULy2TcPDIFU6JTx1BHg8=;
        b=QJvRsjMXEu3VbjA2A8Sd3SRm2eXmG9EuiKy1DePJluIt00594TVf2sPdrzvZD1cFo7
         IDNC/O9MkKiAw4LJ/e8XI4sKjqmlihQLefzN2Z9oCLEBjiA9WKooixoOF225MRxPohN4
         w+yIqbg/EwPK4Oubaa+xEMbDOOBwPz8pVUrWG40qKWD2kEhmhkXqNVbdgnK0No0CFUoU
         IEH0mnohxq5+vHVSvscFymmIFsje7l/WKtvhyWi9OC13M5LIUWwR/bT0dEiN6sRwtQw5
         bIF86StlDP2FQ/lLOGNfo+CM5HakpeTXHpEPXa/NMkj4jokZ/ouieHoiKBWOUBKLGkF0
         SKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700769898; x=1701374698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSloKbp86UiyOswV753VKR+ULy2TcPDIFU6JTx1BHg8=;
        b=iz9V04nic7xp7mQYHZpwV0EcBnTv8QX84xgHOM7B38L3uFdWMHaxYrT/kzsGxstmB5
         K3+mAl7ZUK3UDJsP2u75PYNs3Yfrs5sgFX02KhPH6nqnVuAViL9GNAMNqLN9zPR+0qpl
         Iy7++EZpZQQjyL7ilY8G6TzIVC/E2ZDMaSjGrZMRVc6Y9MStHVXwwWk42pPkHTgJ92pZ
         PDyZHbPfqc1ZaoHe4UiqxlIBpEmgd/8bf4TZ+JoQfcNoO8TDBXGy0ug8n2XD+LWHs3c2
         JWNIk/Gnvt+CfKBiZ91Ywl42kyFK3UHspaU8j/+w4X03ror69zSr/95RDAlcxDkhIfgj
         w50A==
X-Gm-Message-State: AOJu0YwoWT0FxNZ1BHUUZAUEkvRQpUS303L5wxRUlbVY//OsJX0Oaf7J
	9SEPsAE3L1204Lb/gMzj/XjHt0zMCqfjfmdskH9Ajw==
X-Google-Smtp-Source: AGHT+IFkd3TNIFngcpqmaOP6yzGlh39X9sE8ua0oX03sz71V9GSS4EYsfgihju9WseoKWmkyNlYZlA==
X-Received: by 2002:a05:6a20:e11a:b0:185:a0eb:8574 with SMTP id kr26-20020a056a20e11a00b00185a0eb8574mr901433pzb.5.1700769897643;
        Thu, 23 Nov 2023 12:04:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z12-20020aa791cc000000b006c0316485f9sm1604516pfa.64.2023.11.23.12.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:04:57 -0800 (PST)
Message-ID: <dd7290ed-800f-4523-864d-45b5c2dc93cf@kernel.dk>
Date: Thu, 23 Nov 2023 13:04:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20231122224719.4042108-1-arnd@kernel.org>
 <ca200ed6-a70e-401e-b862-f690368e0266@kernel.dk>
 <a9ef56fa-725f-4d18-b408-ce0ba13c2d6e@app.fastmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a9ef56fa-725f-4d18-b408-ce0ba13c2d6e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_120500_065862_842D7591 
X-CRM114-Status: GOOD (  17.90  )
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

On 11/22/23 11:25 PM, Arnd Bergmann wrote:
> On Thu, Nov 23, 2023, at 02:42, Jens Axboe wrote:
>> On 11/22/23 3:47 PM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> There are still a couple of link failures that I tried to address
>>> with a previous patch. I've split up the missing bits into smaller
>>> patches and tried to explain the bugs in more detail.
>>>
>>> With these applied, randconfig builds work again. Please either
>>> merge them or treat them as bug reports and find a different fix,
>>> I won't do another version.
>>
>> Applied, but had to hand-apply hunk 9 of patch 3 due to a previous
>> attempt at this:
>>
>> commit 23441536b63677cb2ed9b1637d8ca70315e44bd0
>> Author: Hannes Reinecke <hare@suse.de>
>> Date:   Tue Nov 14 14:18:21 2023 +0100
>>
>>     nvme-tcp: only evaluate 'tls' option if TLS is selected
> 
> Ok, thanks for merging my changes! The commit from Hannes
> is what I had in my v1 for this, and it was a correct fix
> as well, my patch 3/3 was just a more elaborate way to do
> the same thing that I did since Hannes did not like my
> version at first.
> 
> The 23441536b6 commit was not in linux-next yesterday, so
> it looks like our patches crossed paths on the same day.

yeah, it was just recently merged, which is probably why it wasn't there
yet and you didn't see it. Not a big deal, easy enough to resolve - just
wanted to make sure you knew about it. It should all be heading upstream
shortly, just sent out the pull.

-- 
Jens Axboe


