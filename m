Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36082C25B78
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 21:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uY599MDCIjCv3UIyzbwe3bA9VXqb6OB7ySlkBu+KXLw=; b=RTPoNPL/ufGh0wyg1guaokEA/6
	NbImoJN2Ax/mVSfsecS2xsti5liMdAvQCYNFVoFyJySNUTFfDUVKzpCdtY3T7Zhejgkv0uIcMF7jB
	YsSRXpWeJv6KmGOV9qCztFA8dPQWb5cH4xVCAh2OdNQqi9ARoPBk4uiHLyMhv0ox+pHD8cEwZdLp5
	hxfMTQIzCd5IDpMRYgC9AKyGwmUJj8MmbHey1EbrUaYHrLZ+W/kMcy3Ja/qTVLwnryseFb4DUaa0Y
	SM1p1gCwrncz/+W0vDRlwwxVoMfSd0OmvE6pbaucBGZF9oft/7LoguOISRxrrXy7yaw+IbghdMdE6
	i0ZmlbCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEFD2-00000000OTZ-3tQp;
	Mon, 03 Jun 2024 21:27:16 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEFCy-00000000OTF-46kY
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 21:27:14 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35e7dde6223so13292f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 14:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450030; x=1718054830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uY599MDCIjCv3UIyzbwe3bA9VXqb6OB7ySlkBu+KXLw=;
        b=RjZtIZYDLBj5MYGPi3hEFR3mcFD0xpS95f7STKLeIr2bGCRJdQH6b0RpLmEJmcIDG9
         fCwXRq3zZC+55NuA/EfrWYywG2Kj4Kh1OUTY+7/bkeh/t+XbugawkD+9qlnQj3AU767+
         yqdRIxKjVZm6Ww3YsjF/pae6rgwNRTyKlMqHLVVc6d40iqHPONblfvfzSiBNg2zpxqIv
         8vDaJcdkDNXjgNfP2pMoU30pcEJ/TM4M6JD/FKMTc/MJMm/YPCDsWjFEytHYuzsYleJ6
         +GhkQcuKwesWSMdX7pswlbsxIYaGykDauajlW0+vJNFJAkh/eAk0DQvb4gtVjDlf0n+U
         c90w==
X-Forwarded-Encrypted: i=1; AJvYcCW3sOU8lRH+/O5Za9s1IYP4hlw53Aub4NAnz9eNWkIyGot5QKS73aHU/t7dCXwTC/KQiMGde6g7/vWZZID+Fpj6ivvSATHCCL+XfZoM2n8=
X-Gm-Message-State: AOJu0YwzXeVuODp8R45lVtL6aqyYUDWv8i8UZt7BbhsaQCkphaTVbEYq
	BjaDBHGO/3B2uXhUVkicTn+JEtOkx3Jiz4zjKvHy+K7eoRMrP1fX
X-Google-Smtp-Source: AGHT+IH46P8IN4JrAN5hCuulfHxINGqT3MUA6PYnKCaDFijovEp8eZHOBGyMyXYbErBqqHO2JIAUtg==
X-Received: by 2002:a05:600c:1c1e:b0:421:2c02:9779 with SMTP id 5b1f17b1804b1-4212e0c55c3mr82014925e9.4.1717450029553;
        Mon, 03 Jun 2024 14:27:09 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42134f12e72sm100165345e9.34.2024.06.03.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:27:09 -0700 (PDT)
Message-ID: <86e60615-9286-4c9c-bffc-72304bd3cc1f@grimberg.me>
Date: Tue, 4 Jun 2024 00:27:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: introduce helper sendpages_ok()
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, philipp.reisner@linbit.com,
 lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
 idryomov@gmail.com, xiubli@redhat.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
 <20240530142417.146696-2-ofir.gal@volumez.com>
 <8d0c198f-9c15-4a8f-957a-2e4aecddd2e5@grimberg.me>
 <23821101-adf0-4e38-a894-fb05a19cb9c3@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <23821101-adf0-4e38-a894-fb05a19cb9c3@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_142713_114390_BC0FB3CD 
X-CRM114-Status: GOOD (  12.82  )
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

>> I still don't understand how a page in the middle of a contiguous range ends
>> up coming from the slab while others don't.
> I haven't investigate the origin of the IO
> yet. I suspect the first 2 pages are the superblocks of the raid
> (mdp_superblock_1 and bitmap_super_s) and the rest of the IO is the bitmap.

Well, if these indeed are different origins and just *happen* to be a 
mixture
of slab originated pages and non-slab pages combined together in a 
single bio of a bvec entry,
I'd suspect that it would be more beneficial to split the bvec 
(essentially not allow bio_add_page
to append the page to tail bvec depending on a queue limit (similar to 
how we handle sg gaps).

>
>> Ofir, can you please check which condition in sendpage_ok actually fails?
> It failed because the page has slab, page count is 1. Sorry for not
> clarifying this.
>
> "skbuff: !sendpage_ok - page: 0x54f9f140 (pfn: 120757). is_slab: 1, page_count: 1"
>                                                                   ^
> The print I used:
> pr_info(
>      "!sendpage_ok - page: 0x%p (pfn: %lx). is_slab: %u, page_count: %u\n",
>      (void *)page,
>      page_to_pfn(page),
>      page_address(page),
>      !!PageSlab(page),
>      page_count(page)
> );
>
>


