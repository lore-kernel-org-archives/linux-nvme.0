Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94775CA0EE6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 05:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XzmOwAg9V5+Re95R8l7al5vYiO/Lz8CtJ5MsaXPFqNQ=; b=WSivuP9J8Gb7nq76no8y+wGBmu
	+pj1Q2WGtvUjRIybGcPrCm/lQfRT1AEfFGq4vgm2ijUg+pOL9KlqbcR8SyFJliCOqoOQH073r5+Cj
	5qlyBM5TdUxrmGsIjshk68FOZD0jJOiBse0tm3Vs54Fk5GeaFUoZcdd0BRyATHqLAc+tJVvmrpdpe
	PwXIjq4yPJuH9T9WpmcrDNtnPPuqByaFyhS61i4jxi6rG+HLobLRh21AUrPiHerVleJjH/uZwIDIY
	1hch36z7S8b8HZHFJH2IpoJJ+zZLY7qaDKSRa89MJ8AD4XCwTWxjM2jVoJLbIXh1+5IQ4pw4UqmON
	UkQ8BtCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoxRZ-0000000FqkO-3dzf;
	Thu, 21 Aug 2025 05:02:33 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoxRW-0000000Fqk1-0KBJ
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 05:02:32 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250821050217epoutp0232a00dd5b2e14901d0d582f947119a1d~dr6FSRbQZ1343213432epoutp02I
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 05:02:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250821050217epoutp0232a00dd5b2e14901d0d582f947119a1d~dr6FSRbQZ1343213432epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755752537;
	bh=XzmOwAg9V5+Re95R8l7al5vYiO/Lz8CtJ5MsaXPFqNQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Y90/6wJ2dxy/30/0Iwx37uljZqi2AL+K91TjtrM4es0pHrc72aXDN6BizklQ1Bvr0
	 9dh8yjmCSWqsR3LMhJkqpamLywpQgj7Uca6Z15e4dAgAQlz4XVdRuX/Z+hKKFzs3yO
	 jicKthMNzWw2k9AAFJ/vv2lnBCMRNvi+4yK++cO0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250821050216epcas5p1d136233410cee048eaef6416175f7e44~dr6FDsuwi2935929359epcas5p1R;
	Thu, 21 Aug 2025 05:02:16 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c6rlr0st6z6B9mP; Thu, 21 Aug
	2025 05:02:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250821050215epcas5p3e28030f8f86f656ada4680e317c870ef~dr6D6iaLv0864708647epcas5p3K;
	Thu, 21 Aug 2025 05:02:15 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250821050214epsmtip2b79dc2847c9a83dd87e41f611db87361~dr6DNMmAi0453704537epsmtip2S;
	Thu, 21 Aug 2025 05:02:14 +0000 (GMT)
Message-ID: <c78a7ce0-1bee-4773-9f29-45f68c9fb5ff@samsung.com>
Date: Thu, 21 Aug 2025 10:32:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix PI insert on write
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <aKXeCrrvy_0crpmn@kbusch-mbp>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250821050215epcas5p3e28030f8f86f656ada4680e317c870ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250820162759epcas5p23e1e53a536f502082fc0e869a72f9c41
References: <20250820081150.2463767-1-hch@lst.de>
	<CGME20250820162759epcas5p23e1e53a536f502082fc0e869a72f9c41@epcas5p2.samsung.com>
	<aKXeCrrvy_0crpmn@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_220230_634883_CAC97768 
X-CRM114-Status: UNSURE (   8.76  )
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

On 8/20/2025 8:09 PM, Keith Busch wrote:
>> @@ -1039,6 +1039,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>>   			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
>>   				return BLK_STS_NOTSUPP;
>>   			control |= NVME_RW_PRINFO_PRACT;
>> +			nvme_set_ref_tag(ns, cmnd, req);
>>   		}
> Do we need to check that it's type 1 or 2 before setting this?

Seems so.
And if the check moves inside nvme_set_ref_tag(), it will keep 
current/future call-sites simple.


