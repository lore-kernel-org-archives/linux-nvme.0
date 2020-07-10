Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CBFC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 04:50:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430842072E
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 04:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NG6yISRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430842072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rn/JR6tWvx+no6OIuZtrAIb+7XHWiiFxNiIBKCF1Aow=; b=NG6yISRW+mRn7z8WUgAK9/JmK
	HN0EdHLdEihN+22JMF2p29M9qhvUwVRNGaU24IrdXr1TxATKqMFfaKpp7UxavPul6VVUuDgwQ+Rue
	gXvqntXZ/av7j1vPajyA0IdTaVJNmUzuzm9EeNzc9+XDpAXFwEXNDwU1dB0PQgEy85OOsaTSdEOjy
	Q2jFID7IEK0WE+9WQ87X/tYBdezGz1gtJiuoJAU5lHcIsRtX6yCKdRBDDmX/z2bxBsWpixxf8tZ4k
	uPeSCSHghsWJi9bD47lA1XCDgrVL2CJJSqv+hoEzXnGxCHcG6tTan0tFqjmJUBHbL1TCrA88p2ZLo
	zCt4iXGKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtkzK-0005nS-7h; Fri, 10 Jul 2020 04:50:18 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtkzI-0005mq-4d
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 04:50:16 +0000
Received: by mail-pj1-f68.google.com with SMTP id k71so2090763pje.0
 for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2020 21:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TXQFHHp7w6R+skTMM8Z4u5+ci1iIZUtCjEf75YiLreM=;
 b=TIgbQXP7MoTOP5mO3MeR7asIeM5e0b+OLgeKcF8epiZ3YTjm0J4Fxn2XZH9UKxwru8
 nY+PdhfXMc8k9fH/I7GSLy6cYygYmPyCOOYQyCSKULDtCDP2xH2bQceRMPBRfuF0MksN
 PU2gqH7EHPXkUyEoU2zQ0bnoC2mNwoZeOgfvIAEHheD3IuUoBTESnp8QOZm0B3r0FnWg
 g9NxeDDrxhGlAlgWmAgEInvWuUr0kBN3YIk8paYZweDrQB6nMHHLLyUh2hIeVWJngI+f
 3KkfW0FTLAMAQRaT8BD1yLDbtyRMmuZZ1vDgZoCc3rGLAbbjJeDzB3imMFfo+x6wSWi0
 ke4w==
X-Gm-Message-State: AOAM531ez2hAs1rXcHLjG0reW5rR2rp6ZEEwsdHdmgs/uU9rQHK7wXYJ
 ll/qdfUXQsGdVktJCmQ4L+8=
X-Google-Smtp-Source: ABdhPJxYEqeoo+UMiYZNkBlD2ZMErxl1Sk5HhWaCpPHiHrSklAUhhmpa2sk58hI2w1TCDszT0YqOFQ==
X-Received: by 2002:a17:90a:9285:: with SMTP id
 n5mr3385754pjo.27.1594356614783; 
 Thu, 09 Jul 2020 21:50:14 -0700 (PDT)
Received: from [10.92.82.19] (h208-100-138-50.bendor.dedicated.static.tds.net.
 [208.100.138.50])
 by smtp.gmail.com with ESMTPSA id e20sm4467169pfl.212.2020.07.09.21.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 21:50:14 -0700 (PDT)
Subject: Re: [PATCH v7] nvme-fabrics: reject I/O to offline device
To: James Smart <james.smart@broadcom.com>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
 <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
Date: Thu, 9 Jul 2020 21:50:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_005016_190824_430AE046 
X-CRM114-Status: GOOD (  10.64  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Ewan D. Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gTG9va3MgZ29vZCB0byBtZS7CoCBPbmx5IG5pdCBJIHNlZSBpcyAtIHdoeSBhcmUgd2UgY2hl
Y2tpbmcgY3RybC0+b3B0cyBpbiAKPiB0aGUgeHh4X2ZhaWxmYXN0X3dvcmsoKSByb3V0aW5lcyA/
CgpXaGljaCBicmluZ3MgbWUgdG8gdGhlIHF1ZXN0aW9uLCBpcyB0aGVyZSBhbnkgZGVzaXJlIHRv
IGhhdmUgdGhpcwpiZWhhdmlvciBpbiBwY2kgYXMgd2VsbD8KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
