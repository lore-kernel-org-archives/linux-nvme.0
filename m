Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30961C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7FH/cZqwHqkstNxttHiwShTx35esBf5x9xB4oSROZV8=; b=lbsfJlUE0L6H5hBzKvEsem7tA2
	UMUl8g1IL2zFjklxhBRpR2b86DUSICkbvrGpBi8c2JDWMCZqgnmMKakuNKe478T1KaaSQEJWQpe2o
	/q6OgtZHHqK0AlW86yfugxWATuhqvm4XLmkjpt/+Ir33hBDKTsCabN3Hv+CNaLfE4KFeycKdmYTQi
	AqLc26xf2ypLUtsxvdaKCes9ocOg9E0Z0dadkizHxp98nFRl8aUU3g0f9Ccl/tfrwXlT4/TPbrAyd
	V1iOjdGsXwR9u/n/QhpFkdL5uROxaVKhYIl7apTDTKOu2PCdKSMIn8vlnhdsoabc64dhSbT2ZpOaJ
	mRJVjROQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngkSb-002bus-3r; Tue, 19 Apr 2022 09:47:49 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngkSP-002bqZ-Vo; Tue, 19 Apr 2022 09:47:39 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 003B75C018F;
 Tue, 19 Apr 2022 05:47:30 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Tue, 19 Apr 2022 05:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1650361650; x=1650448050; bh=7F
 H/cZqwHqkstNxttHiwShTx35esBf5x9xB4oSROZV8=; b=RSNMLGBgDgANeCVu2V
 Q5XHDMelTAniUUIJTvqtY/gqFdq49d3ifi6JBihik0CL1OUDgw05mqp0Lpz0zCdB
 S+er/mNixteyESDqYCQ39ReAQ8A+leQO9puqemXGoN2Zi0w1z35IqpUzooo2VO8U
 Woo2Xq/3XBQny8D4RyTA6WFNi17+4VnuLzxnmdZds97G3+cQWHOx8NUYtrndOzeF
 GoR4xruJ1l6FB7qFpFnPRzpAYPsl9j46NGsXquuJQSrTEknQz0PlHZbJHaepc475
 L8fIRYlGbsVULD6+vn4TuZNe0jCW2zsA3CvsmhM/fUwyNykatY0tE9E/vl1Bf5se
 5m/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650361650; x=
 1650448050; bh=7FH/cZqwHqkstNxttHiwShTx35esBf5x9xB4oSROZV8=; b=i
 9+RnVzSBgugZuECfHOZAm1xZajUYSMp4J50UH1XscbROtWy7CZbImt4vsnCWwnUm
 VlpB5SZxTQfcXSdNDN01myghMsKbdvumzkPaNt/mMSJgUPTPtNICGu5evM15G8wz
 ASnEMn33h7dmqy7/iYaPMzQHOkBZAU0sls9fnwcgU5/ka7bYzFFvPKzNidqSkuSe
 k3np/lZLQXva9Qqn3e6Lc/WWas0UTmjBXImqcD65lkkwamWNuoHgvRdsyPWiEPbk
 nZ+fu0dR/+Z+3X5BYwNTYAyrdiUIrAy4Frs7tc4a2HVhf2KPn9znXrxIogiB/E/O
 TgCJXAYa/R34WoNYaalQg==
X-ME-Sender: <xms:MoVeYrRJuEmQp9OW8ELRO8bnthEO0E1WFsyNa2BPvqBWi-lWsaeqVg>
 <xme:MoVeYsw1lUdMLnjHiptY3r0o2-ITx7IsrpiOlcxAF8w1eGVx4B7VY_qciHDvKX6y9
 dyyTrIRU_cgvRV5zsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvddtfedgudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:MoVeYg2ITQBfhRV73oNcpoGHcpcUqG9Ou_BT8Fz5l8XLObV8cV1S2w>
 <xmx:MoVeYrAHHsDC-cCyRFihVJpCApcmXoa4_gMeOJUiuJN4EunHGOnB_A>
 <xmx:MoVeYkgqNbqu-9hFaBiAWD3eemd_RJdaMh7oMIr6KozBdnIeNLrmUQ>
 <xmx:MoVeYlbifUtunMt4WlgOCSCylCF2Wp3l0iTAgDoVhfa8tEuOghHmLw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 500B22740692; Tue, 19 Apr 2022 05:47:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-387-g7ea99c4045-fm-20220413.002-g7ea99c40
Mime-Version: 1.0
Message-Id: <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
In-Reply-To: <20220419053157.GA31530@lst.de>
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-7-sven@svenpeter.dev> <20220419053157.GA31530@lst.de>
Date: Tue, 19 Apr 2022 11:47:09 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "hch@lst.de" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spdx@vger.kernel.org
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_024738_121711_EA2EBF4D 
X-CRM114-Status: GOOD (  13.42  )
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

On Tue, Apr 19, 2022, at 07:31, Christoph Hellwig wrote:
> On Fri, Apr 15, 2022 at 04:20:55PM +0200, Sven Peter wrote:
>> +++ b/drivers/nvme/host/apple.c
>> @@ -0,0 +1,1597 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Apple ANS NVM Express device driver
>> + * Copyright The Asahi Linux Contributors
>
> Is that actually a valid legal entity?
>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>
> Does this controller still not support 64-bit MMIO accesses like
> the old Apple PCIe controllers or is this just a leftover?

I just checked again and 64-bit accesses seem to work fine.
I'll remove the lo_hi_* calls and this include.

>
> The rest of the code looks fine to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!


Sven

