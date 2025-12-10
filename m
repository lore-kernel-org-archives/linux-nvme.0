Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64642D3C92B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n4vjuiVWtSeDDJf5R2NBM1m79JOYpshPwskFvViMdAw=; b=RElKpxsTcf/v9Hld2H6OvxhmPK
	MwLWtBiIUXVlHohqzm/EDslr+L/EO5OWfCmfaD3DeN+98YxYZwNZwifrK2Z1vZHbi+yxNprpef8jW
	E0MhsOvHPhBt67gMvhG6MOxyNM4F3qskymRoIKjvKdK+klrpDcS58FbqNvOojbdbC60JlFsGJeDtd
	W9F/dO9I2dT7FxAGlAgJhVlmXhRyIgHAboU0JYTrcqdQ37cGQcPSs3Qnhhl1VrWSJIvjnQl/fI+2e
	qnpjbvf8qDoY+XJqhpRBveaPTRMZOZuELDu0E9AvbyLlJ7Y6H5OSNq9T7T97TJfXYt5Jqt1RVrpHF
	yjRMhFQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTNVJ-0000000FfT5-1f8S;
	Wed, 10 Dec 2025 16:57:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTNVG-0000000FfSh-12dF
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 16:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765385842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4vjuiVWtSeDDJf5R2NBM1m79JOYpshPwskFvViMdAw=;
	b=GtQOUgUiYFGGcRH62PMmkaKekNitZoWxqIufjh6W9Y1OQup2hIj3riQU3P0dO3ArPtJjIx
	XcDeXx+BT0Fsn3GIZ/yXrgaeIXiZW3AL3XpHGQl/g3EZUCHSp6ju9JPcBQzB19BvbOx0pf
	FqyNEA7VAfrNSHLptJtNdpqntmqcZXg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-6sKfyFTsPgeVyjJMWwLRrA-1; Wed, 10 Dec 2025 11:57:21 -0500
X-MC-Unique: 6sKfyFTsPgeVyjJMWwLRrA-1
X-Mimecast-MFC-AGG-ID: 6sKfyFTsPgeVyjJMWwLRrA_1765385840
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42f9ff2913aso1402213f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 10 Dec 2025 08:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765385840; x=1765990640;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4vjuiVWtSeDDJf5R2NBM1m79JOYpshPwskFvViMdAw=;
        b=Sqyw4RV+C40IKWOIbfIZTs8WTTmPNpBx5abegwjsJNtC0HFnLPS2RHKcjGVeiuAUzL
         VzymvovNMM8takmRozGsUXjYXOidL3GwVsaHa09TMVUkqS31PhSBnBy7pL4kocsULByq
         uf5EZ9YP4vsyfJFiYZfVbjYNwlM/X90UdlS+kP9Ekrchg5F1oB83ET1majXu61Vl39TE
         8+NtvyO6mRNpobCP3ZJ5r44oYuVOmwnFvSzFL8BWXoqrQJ2ubVIVZ8PTmY43WHmFpvmV
         WsMvBkRFBJafYkTBnk+vejjujymk2NUjjVm6d7B21WDOxusCSx1M+OGSSkKMyXBM8CIF
         sFJA==
X-Gm-Message-State: AOJu0YzfbWr1rpaHUA2DV3L+UtwNtisD5fGRtknQIPaXWhqHOvgjL4h3
	6ssvQ58oRzZMNGeLFu3rN/ndEiGq2xPrJRyRPuQ1Li9fTSKql2kVxXU/8J8GF3bNMvlNiZs816K
	wA8vaXBG0rVSiIcSx0QYa/RJdTN2H7jm+Bf50SDDdcdl/Bl3r9xcaLv5TX5YcgB8MUUno
X-Gm-Gg: ASbGncvRDJvO1aDVyxf7qKLiAmT25D28w0+glR7TfodCAG5dPJbySw2elMjdIVn19xG
	Rbb6gP35+UgRLoIHyB5VZo606cnnbPjqTpdbVEdW2zlfNi2zFD6XRF5nTn51d/VAg4GqNjRfR9q
	JSml3fLMv9g/WWltwPYt6t/WgvwS+vrfmFiP/ey2usAZu6DWWfrS383kaNXQx5NkO9mE1Sr+Yr7
	a366AfCZUxzx6ksuXgbf5THwSlKW2in4CAEg1lhiWLycd0/9tJ2Cu+gqab6/BxXKyfiCCpsCSLO
	De7Sxv9s6T0KBwSmqMjsAvH+K2CSd69w+DvKZUfWEnQcI4HORv7AAxFIp6ZhCtM/vv35+cU43Fw
	aebK/7n7BSsFPezEIci01fchVmkvaeXqDBjoPpHq1ra1kE5lTWWX78vLArug=
X-Received: by 2002:a05:600c:4703:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47a8380c006mr28364455e9.11.1765385839637;
        Wed, 10 Dec 2025 08:57:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1ErKmvwfO917QfwpOmc3kdwchwTX5DWogSYZNPVxkP8iDCKVQ0toYxrjvCOwIlDXwEtINDA==
X-Received: by 2002:a05:600c:4703:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47a8380c006mr28364255e9.11.1765385839191;
        Wed, 10 Dec 2025 08:57:19 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8837fdd5sm1473825e9.13.2025.12.10.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:57:18 -0800 (PST)
Date: Wed, 10 Dec 2025 17:57:17 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Keith Busch <kbusch@kernel.org>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Robin Murphy <robin.murphy@arm.com>, Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <aTlXuhmsil7YFKTR@kbusch-mbp>
Message-ID: <6cb5157f-c14b-5a86-c26d-50aaadf8d3ca@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <aTj-8-_tHHY7q5C0@kbusch-mbp> <acb053b0-fc08-91c6-c166-eebf26b5987e@redhat.com> <aTlXuhmsil7YFKTR@kbusch-mbp>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Si67V4TkMU5thJPNJE87xXRD_YkFbVIVlfZkv0nRL0_1765385840
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_085726_366063_A2253BF7 
X-CRM114-Status: GOOD (  18.96  )
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

On Wed, 10 Dec 2025, Keith Busch wrote:
> On Wed, Dec 10, 2025 at 12:08:36PM +0100, Sebastian Ott wrote:
>> On Wed, 10 Dec 2025, Keith Busch wrote:
>>> On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
>>>> got the following warning after a kernel update on Thurstday, leading to a
>>>> panic and fs corruption. I didn't capture the first warning but I'm pretty
>>>> sure it was the same. It's reproducible but I didn't bisect since it
>>>> borked my fs. The only hint I can give is that v6.18 worked. Is this a
>>>> known issue? Anything I should try?
>>>
>>> Could you check if your nvme device supports SGLs? There are some new
>>> features in 6.19 that would allow merging IO that wouldn't have happened
>>> before. You can check from command line:
>>>
>>>  # nvme id-ctrl /dev/nvme0 | grep sgl
>>
>> # nvme id-ctrl /dev/nvme0n1 | grep sgl
>> sgls      : 0xf0002
>
> Oh neat, so you *do* support SGL. Not that it was required as arm64
> can support iommu granularities larger than the NVMe PRP unit, so the
> bug was possible to hit in either case for you (assuming the smmu was
> configured with 64k io page size).
>
> Anyway, thanks for the report, and sorry for the fs trouble the bug
> caused you.

No worries, it was a test system in need for an upgrade anyway.
Thanks for the quick fix!

> I'm working on a blktest to specifically target this
> condition so we don't regress again. I just need to make sure to run it
> on a system with iommu enabled (usually it's off on my test machine).

Great!


