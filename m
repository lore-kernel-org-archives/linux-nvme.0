Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA652D0EE00
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/RYkXbjr0Zws5PkDP81koxcOw7wQafJJolXOcPbtL0=; b=b4Hd6pOOcyjqjJ6urx6UKcLBiK
	TEEXag0Die+r36fJ7VOjxQ8//eY7aqhvYy/FZ6OuqWhr1FA3juQrt4pBei7qKlmEnWYRsMZGeS0rY
	r2bEvqtQcW5nSd2IpI8lp+E0MDPOfyKspxcKRg0Q5ph+hFZp7u4Q7fpJVwbhMjJmmDdkjuCwbMcwa
	jFx2bYWxQIz2BpdXjWphudMv/ZaEy9vgplhvib07mZIAX0XMqZ0X8hClrxq1e6uTyYL9Mu8ER6pM5
	M43P5YQ0ILGwLcE795gd/fvHJju50gLfC4PDFe7tMAqO+jLpthtnFlerw3OeYV/jDei77Q++gQJMA
	v/rS4HVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNwzv-0000000Dfz7-3TMK;
	Tue, 25 Nov 2025 17:38:39 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNwzY-0000000DfxB-43wb
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 17:38:38 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-948fbdbc79fso137578939f.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764092296; x=1764697096; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/RYkXbjr0Zws5PkDP81koxcOw7wQafJJolXOcPbtL0=;
        b=1NriZOjq1teWzwJDNLYRZc/+KEWnvtu7VNqjCSoCdQ4nvlgN7Xx3xBVH/LxkrZQhIq
         kbhJ9nIsJA9KYrqiwNbCUII5W3/hm2Nsx7aj0IpTaIaHASUaD8bN88c70mEsqWc2X1yL
         bChu8Zs/m97VqWGHv78qUkafqbR6mhoWRl5gASurUkm0tV/xgZIZADNfnP6xOlT3KR3B
         OBt7GHcPsUFCYC9vkkBiOBEvhFvyO6hU5RBotPJSR4tR7Pah4YyW8K8acHWA5dC2c8Jy
         jXaBfJeLfb8UUZb+jISzBeQPq6v0oVgpSp4ksfa09WsTh28DMy9ZI44gZZA+DOjgEwf2
         kcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092296; x=1764697096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/RYkXbjr0Zws5PkDP81koxcOw7wQafJJolXOcPbtL0=;
        b=m68cxDSLNwPFp4V8XWwQMEZ1HHEU0jp74mLocJJzzPE/pLAyjzQU5rNaG1B+lRHf14
         tEosNcivHL0Rpyu3Ba/smQbD2XDEh8MSWf4ApWFeiG/QPIqVLrl82f942u2kGujHGRUw
         SrOVEe22f9pEoZj7ipNlI54OmU6LSs31KY+UiOkOOVaKL+9fnsNaIRfKuN8mFQ51fNgO
         M8XCpbaDe839QTQ0ch/wgk0W0/i8SgZUCB3ldnqgUEGLSSDuxFMJL6Oq5ujT1nOBQp+V
         yYPj541eR81AOmgBrS8u5Zr6aXl5phrbDBNHdQEeNdnOQfdpr5pqfyn+8Y7B32won+CB
         BMRg==
X-Forwarded-Encrypted: i=1; AJvYcCVPXluaIU4zAi0sSOrG8q+X7/2uOTMvQ0Nse/DItDUihHeiIag5cJ5kjx1CzWkE2h9M67a5Ywu3jEUW@lists.infradead.org
X-Gm-Message-State: AOJu0YzLZA2AU0kJWgbYEtg60UndeAsWwSBzMYtaUPXyJnOUBNnUXc3S
	RhyKzHRbHZ9T/IEA8Ul40iSGiTgsNl0uNF2Af+987PpKkVZMkI3P22pgZxdKWdiVtcY=
X-Gm-Gg: ASbGncsq9fPPRX08QcERWQ3aiw8Ke6Zw911le1TbG6jdHOAb7MWQUOYRKJP4w9wRr03
	xlzboYjn2mBTKABpDbIiuzwpOLvREFIC/Pkcq3twdaJb+Agwcu77UmCq3sFlSqYIAtZA328u3Vv
	TleEcgos1UJZDmPskRNCiFjK2aTRNPTcrR/DfLYzLNfAa5VXonQOkJQmW5WDI9m4JTK3BNADyAM
	e/0YX/qiLYrwIWo4ehuEegst4EFlimeoLpl0bNGrOzAVMD0Ph1+Owu6DtBiISiL+2pttdzpGU2f
	k4lJ9fvN+wjcwAwxWpiECiIBCsd0hx4Hpe5aT3lEnH8BXDwgNa6ZUkNfZ7SZLhoMhwcQa/DOvDq
	e7jE1LDPlQgYR21zGu6tU+3rmyF1dNF46TiLF0xyx8m/zwO1jWHaknxSLJZaXLLl8CFc=
X-Google-Smtp-Source: AGHT+IEIHRk7SwMmVS4xtcTCAS6Qp+OrN5pgC4aYwqKQ9jNrDNwsm/zNssFdQ4CwiXZVR7EmZb+prg==
X-Received: by 2002:a05:6638:c0fb:b0:5ac:cd9a:4c4c with SMTP id 8926c6da1cb9f-5b999555c41mr3179432173.2.1764092295677;
        Tue, 25 Nov 2025 09:38:15 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48bdcsm6970840173.45.2025.11.25.09.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:38:15 -0800 (PST)
Message-ID: <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
Date: Tue, 25 Nov 2025 10:38:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] block: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
 chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-2-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251124234806.75216-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_093817_035156_D5A5E4F4 
X-CRM114-Status: UNSURE (   5.90  )
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

On 11/24/25 4:48 PM, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error check
> in blkdev_issue_discard() dead code.

Shouldn't it be a void instead then?

-- 
Jens Axboe


