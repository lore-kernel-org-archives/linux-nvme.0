Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1827CD37B7
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 06:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JNuldnQ7u/OqYdEwyznMvSUv5Xri/cwuquyFzDhukNU=; b=13kDsl8vkV/uZHDvwvaNsKwByI
	4N165PIXYFPYHwEzupi96L0AJZaBRgsTo6IwpFogfdAEeUvF2JxRSRPCqBKcN+N8yVKw/KZLvwYZE
	pHOdmjLj9pelUhybD/ALcehipvUqi1uHZ6nWMoMQAnrR95xFp/isEy/Hhvhj9brY3h5blL62Lkr1j
	thtCBFlF3RP6Us24Ib8b7OpNEEkQ1ref8bA54VNbchxk0rko8/o37fZBhLymWzkxSlcZf0XJvHpz9
	uE6OgUUL5liKq5199upFgB8M0SIEiGUTfaSWyWKGQzzYZ96YwsdMLJO9ZLrqun812lsONRbSWafpc
	PL78xEdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMK0U-0000000CTSM-2ExZ;
	Mon, 11 May 2026 06:20:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMK0P-0000000CTR2-1YBu
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 06:20:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 820CD68B05; Mon, 11 May 2026 08:20:31 +0200 (CEST)
Date: Mon, 11 May 2026 08:20:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	alistair.francis@wdc.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH] nvme/tcp: handle rejected keys for secure concatnation
Message-ID: <20260511062031.GA25956@lst.de>
References: <20260511005454.2486599-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511005454.2486599-2-wilfred.opensource@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_232043_692103_5221FA28 
X-CRM114-Status: UNSURE (   8.56  )
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

s/concatnation/concatenation/ in the subject.

The changes itself look good to me, but I'd rather leave review to someone
who knows that code.


