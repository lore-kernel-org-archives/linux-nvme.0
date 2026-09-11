Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7024C88E53
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ZmKlwpvmRli0Zc2zV79xl5YnBu
	Dzsd2eTvw3zYCBBln0a5FHag1AwH70SLHHq2OdQcSDbtVpu4Zz4HYv++f8q40B2PKR9IDW2BioA8l
	65XYk17hwUCaQgNRBRFdYUmkuRG+VbAygC+g9csC4SFKpTvSEbzOAB39I/w+AH/6aHttMY+Kxzs6l
	HWNY/QE1TvuUAbOgsEp6AcKyVpOAD7CSzI2JvVSIcOUFBYe2hYr8iiNP1fviBkKaD+f+xxoRFcqmx
	LzYZ7L7N8T0h+bmnTLpq9gCAV24Kth5Kb4x7cmXAWO07ZiOMrbpxru4gTiACO9hAGdiQuDXGeN7fk
	+06jDHWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58i2-00000000Aap-2o8E;
	Fri, 11 Sep 2026 21:22:58 +0000
Received: from mail-wm2-f12.google.com ([74.125.225.140])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58i0-00000000Aa9-3H62
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:22:57 +0000
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso4046485e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161775; x=1789766575;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Qx2QwqwCsIGBBOoeSDtZHEiXF97Pw4od8KpoUugPd+bt/yP44S2IhLSoZereEgEByI
         ND3EITow2nY/ZH41/IYY7ZiKxQuRAb3P/KEMklLPKQBdmMaBanPoBsxgO1Y9P5YCQboS
         RE1IolMKm3VRoDZ1YavUvXzIUUJUsvISAN/GeM3Z/S22SNkbqjwFJkNbWwDXXsJA2rUu
         GF3C9ZvpsHiOPmwbJOLRylD6UyXlPRvKTa3VvYSrdeznJ+HbIZtxp4mTAcD60OKH7feG
         kkvPsKD6kygegcrH2247/jBnixrApAzcbU84tkYhGUlaJGaDxzH/VBJsrlGTrZ1NpWjA
         wtFw==
X-Forwarded-Encrypted: i=1; AKwUvBwW5YJ+1ZrHJLHfUWR0062KK5KlRAHni4n3JCV+/CqPN9rFfZpN3A4FBQXAFjs9xHxI5MncHuN16eJL@lists.infradead.org
X-Gm-Message-State: AFuF++mNg62lHcAD6DIiwqbpsT6Cvltyhz0jRUmaAGS+v/3N0Ji4a7BR
	dyykD2Y9xHu9ctaWQ0XTLjqSTl4DtBcfl/CizhrqOmQx8SuvPGio42N8
X-Gm-Gg: AYBFou2ymAIV7nNwYm5i88jNf44iNt2JW3/x8soIKTJsdn/7yW6mnE+KimIKYaVzIDV
	iGIqa7HS0TILXyNVGIZF3GJGfKFow/FE5Tcf/znusCTL17+GXkZqJOThMRWtXVryi7kuEJxuvwO
	M7jqQePF3tHCsJrnpVhd9/45vI50MjcwPb1o+QdofjBmOQ2WSwHyf3XXLsKLBiQgRXSdVijuyAc
	9NlysCsceFtk6gM2/Zc4EIop2EHiIn9F5TrQnTenAmi3gn1W+bSlZJ/FarK5io395EnY40jwVMB
	8v0oZH9hdRpjcOLug7qk+ncsEpJ4mVV6Ns4EEevPrG4wVuRa77ulR0SLF0itm4uPteV8ZwZHATY
	FmyTFrKVM5/m+STUaZf7XSzsyUTBwtvFF4OyfszfH0kwtRKiUVNKP4sPFBMtfkyLsJfgvHK76I5
	ynDxlxy0airJbhyQSH00h8Cl79KMrBakpGv/AJc5DMpaacC7zLCIdjrOPE3TmpwLgSHtpBy6735
	mlyYvZOF9aSudPBLJf8ztDvASsj8f0o+NQDj5Yl1NCj
X-Received: by 2002:a05:600c:19c8:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49e619f3ae1mr131418245e9.10.1789161774848;
        Fri, 11 Sep 2026 14:22:54 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e81asm8787126f8f.7.2026.09.11.14.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:22:53 -0700 (PDT)
Message-ID: <59b0d6b8-133f-4a53-9754-bb308231a763@grimberg.me>
Date: Sat, 12 Sep 2026 00:22:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] nvme-tcp: store and use the caller's network
 namespace
To: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Solganik Alexander <sashas@lightbitslabs.com>,
 Roy Shterman <roys@lightbitslabs.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, mkhalfella@purestorage.com,
 randyj@purestorage.com, adailey@purestorage.com
References: <20260910202812.1642832-1-sgogte@purestorage.com>
 <20260910202812.1642832-2-sgogte@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260910202812.1642832-2-sgogte@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_142256_835985_FD8ABD14 
X-CRM114-Status: UNSURE (   5.93  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

