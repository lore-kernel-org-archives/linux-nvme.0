Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EDBD767F1
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 17:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x40+SjEaq5943TtiP/UXom9Wy7SciOs8xRpZ9sdjGNw=; b=HjSZWylfeBe0QDrY8Ei5S6YFqD
	iPtyFqB9GHwAPErTKJA10c+6BpUKkyFGzNTQlOSOb2TIYulZNRyY3XnoqNAbHB8sh10x+1l5tC3Pe
	MK0spmYEwIyrd1nB2mmkURaF0YTXXYS0pKcjuHUhzdHerqoF5jDc69WJwQAMMG0nN2pMSUdA2LQ5x
	ARS89V8D0IDkP0Mm52HIstbc5IAoFkr3Y4kS/SnEU4hNUnjJwHHF7Jo6Z0m6Ghs3Rp0lcONVmlIt5
	Mm/AJ9fEkAHJofQZ5zUu7IP455hmoNmnBp9sKyHZZM1uGiDRIW+s6tP4CBZ/HF21XE3FgQfzGeocL
	WDTnmg/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ZBY-00000004NVK-0R42;
	Thu, 31 Oct 2024 17:42:16 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ZBT-00000004NTa-3LNR
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 17:42:14 +0000
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-83ab21c26e5so45380239f.1
        for <linux-nvme@lists.infradead.org>; Thu, 31 Oct 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396530; x=1731001330; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x40+SjEaq5943TtiP/UXom9Wy7SciOs8xRpZ9sdjGNw=;
        b=UXCVCbHU34ipVndBedzEfxYFxgxCN3MWw7ay/3lQNKMHlGCoxGI5KTgE+82PoU7wzG
         HLYPxmeS+7NFcGHmIqpF4h7e6+h44/p9pILjrR1isX/ynI2h2ypv3MEpi7mx27539Vwo
         pw8WqD3QZPvSg28o1Mrf1Tbo1hJoEygr8MoUJnn64I4I9d9bvrEbs8b1GtA0CGQEnF8p
         NzIMO+5GAsBkXObc34wkeykEJ4uY+88ti7aa4VnU84TnaUACWlqIQuqr6Trzx+Tmg7WY
         iGklaIYHhVG2dm800SBKsudk3xgyJccdiL3BNkWxp31HxOn1QWnW3ur0kNJ1f9QZEJJX
         Ws5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396530; x=1731001330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x40+SjEaq5943TtiP/UXom9Wy7SciOs8xRpZ9sdjGNw=;
        b=a0hO4r+vUBDIhWuYhiJWXUkqGguh/8zjvfDAsXQ5dhmWTTH0nYC0SZO1O85Fbvadez
         RaBPL5Y0kIKz12umVnOQGt/YNXmox8NibH1ESo4pJnw4MS4En6ycfD911dcfRLW2nw+f
         7nzD7zBxWRv5RZXqVShA6uIKf1ODjB1ROVGZlkDQXmBjEXBctmAIuZe3zEHBy4oTNPrj
         aCr4npiXsGiofnIFSD9t1mHoqthSsf3IU1nDvDoqND7NSuHzqdArPPjDZdCYjYktEbjo
         GxqWMAko0nbAeFZPhvTrqPv2ejYQga0FNbueqtel2pKRLfChHaG+uT1kIzWG8v64uE3C
         xrqw==
X-Forwarded-Encrypted: i=1; AJvYcCXxXuGEdkkq3pP6dLUoGbGsWqDj8Y2V0xVZxTLtTAOpVtAr9Fcylb5HGfxsTncZnYnAvgNVWKczXtro@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/R34Ogd9RhnIhmzGYEHfg8RmWBK8mufxbY8EMm5IxYRj5tGzU
	Hnc/el3TbwswMcfMYm4Ivf+yuqK5gNJiyHGT7DTyquFIB+3IA37LS5u0booyYpw=
X-Google-Smtp-Source: AGHT+IG0ksmejkYn/tsWOFj5UDq65mB5fTjw0uagwhlJwyCNesDEnrmSpfLQj8+GbqVblFhVpBgdOw==
X-Received: by 2002:a05:6602:15d4:b0:83a:c242:82aa with SMTP id ca18e2360f4ac-83b1c5cd123mr2127656539f.13.1730396530549;
        Thu, 31 Oct 2024 10:42:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67b4b157sm40604339f.22.2024.10.31.10.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:42:09 -0700 (PDT)
Message-ID: <2a0fc88a-53af-4d7e-b8fd-8cee3f0804a1@kernel.dk>
Date: Thu, 31 Oct 2024 11:42:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031083450.GA30625@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_104212_221727_DECF4D47 
X-CRM114-Status: GOOD (  16.17  )
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

On 10/31/24 2:34 AM, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 07:44:13PM -0600, Jens Axboe wrote:
>> On Christoph's request, I tested this series last week and saw some
>> pretty significant performance regressions on my box. I don't know what
>> the status is in terms of that, just want to make sure something like
>> this doesn't get merged until that is both fully understood and sorted
>> out.
> 
> Working on it, but I have way too many things going on at once.  Note
> that the weird thing about your setup was that we apparently dropped into
> the slow path, which still puzzles me.  But I should probably also look
> into making that path a little less slow.

That's fine, just wanted to ensure that no push was being done on this
before that was resolved.

-- 
Jens Axboe

