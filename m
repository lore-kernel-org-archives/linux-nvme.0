Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3225FC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Nov 2021 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=48eYlEx826NsL9H2Qu4SmF6n0GA6Z/qzaVFrkJrELCA=; b=HMmtcptRUeH6ERwdJPPRW2BfN1
	IrcLrHKo6XVpcZtSYVvmZN3NS7v8gWa7WPQ7Vwdvt2jhezL0Zba5DPmFEeMFLOrTP7Gd33C5cjR3I
	H3XzhLKfHwWZC8qw7ByzU7+L1JVzPUomcxk0Iu34druWIMGHS5YcYkavqMZX3AObnT0WpIJk4UJHG
	e4hKJkUJfUoO+feDWXFWrx0rBTT8Me0cpxDiODQ7BGwwh+WzNsMc5km3QDrtWWeHxvjy/rVFhPqPL
	TcteIXvSHC3hGLCZl6AUS6PCnxa++32aPa2ksP4Bm+/Vwxe4HaeLlIGxKmZzZQ7EA8yZRHw6gr66/
	IkEWHiWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mojjG-00DTgv-OB; Sun, 21 Nov 2021 10:05:46 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mojj3-00DTgV-2R
 for linux-nvme@lists.infradead.org; Sun, 21 Nov 2021 10:05:34 +0000
Received: by mail-wm1-f43.google.com with SMTP id y196so12534360wmc.3
 for <linux-nvme@lists.infradead.org>; Sun, 21 Nov 2021 02:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=48eYlEx826NsL9H2Qu4SmF6n0GA6Z/qzaVFrkJrELCA=;
 b=Z+ly/zC4eB0beABI9tEv3P1BkigdGDz10Y/Dr0AxzqExXhIAYmMLrIHxHEn2AF7D1N
 k/fIDpK7kCynQHzW4yxsZg8l+u5rWt/kWvJ7XLELpl+pxRN4pUyXTrByxKn9RexOeLD2
 ULqW7KM2/taepjeSQAvbdIUDSP6qLnCasv+bDSCQR5OfMSw3xwey9ovD/pGrYNKjLEXy
 zzQMrOpUNpMuU1mnnbOImTuBt6lub8rarZHIdgXGHZZjjGN3WgNtQGXuVanCqlmYa42m
 36FJHWP/X9LInyNOsrqvN2QhArxKe6CbZzSAmXe8bA44RS4yWtOJc2tkEztHL9EO/uZw
 MyyA==
X-Gm-Message-State: AOAM530kSRVF0wMijURga++nyJNIfTd+DzKdbW0Z91EvnScmSoM48RTW
 9RM52C9A/ztQj6gF5hgYr5Q=
X-Google-Smtp-Source: ABdhPJycd62d7i/U88aqfxSf+kfNfKtdN4ozX70L4VgPKyLG5V+R1ULObMc22Ir6kKDroXLubISROA==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr18277840wmi.171.1637489129761; 
 Sun, 21 Nov 2021 02:05:29 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j8sm5261966wrh.16.2021.11.21.02.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Nov 2021 02:05:29 -0800 (PST)
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 chaitanyak@nvidia.com, oren@nvidia.com, benishay@nvidia.com,
 borisp@nvidia.com, aviadye@nvidia.com, idanb@nvidia.com,
 jsmart2021@gmail.com, Or Gerlitz <ogerlitz@nvidia.com>,
 Liran Liss <liranl@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
 <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
 <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
 <20211109190432.GA2661484@dhcp-10-100-145-180.wdc.com>
 <e2d589ab-2457-a3c8-ba2a-9e4f813d9a72@grimberg.me>
 <fc27faf4-c876-ced5-c9cb-2d6730e07f2d@nvidia.com>
 <53205a07-1af6-38a5-c60c-ca7d12226202@grimberg.me>
 <609a6156-8705-7bbc-6be2-ca940c8a3c79@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <07211f4d-2aa0-630b-c8e4-1405c5462502@grimberg.me>
Date: Sun, 21 Nov 2021 12:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <609a6156-8705-7bbc-6be2-ca940c8a3c79@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_020533_155068_B22250E7 
X-CRM114-Status: GOOD (  21.41  )
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


>>> 6. This series just extends this quirk for fabrics.
>>
>> I don't think the patchset got rejected, the ask afaict was to document
>> known broken controllers - exactly like pci quirks.
>>
>> Here is the original question from Keith:
>> "Are there really fabrics targets behaving this way, or is this series
>> anticipating they might exist?"
>>
>> I don't think there is any desire to keep any controller that got the
>> spec wrong in this particular case unusable.
> 
> The example I have is the new mlx5 offload for nvme-tcp has HW design 
> that, unfortunately, made an optimization that relies on a indexed CID.
> All the testing was done with Linux kernel's prior to the gen counter 
> change using internal tools, so chips now exist with some performance and
> memory foot print implications when the gen counter is operated.

I see. Well as said, I don't think anyone rejected the proposed
patchset, we were simply looking to understand if this is a real
problem or a theoretical one.

> NVIDIA is committed to NVMe standards compliance and will fix this 
> design in next silicon so no quirks will be needed to get the best 
> performance.

That is great to know.

> I guess we can put this discussion and patch-set aside until we come 
> with some performance impact measurements with the mlx5 offload HW.
> All we know right now is that the new CID algorithm triggers bad 
> performance using our internal simulation.

OK, I think that it will make sense to revisit this with the next
submission of the offload.

