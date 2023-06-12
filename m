Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81940C7EE23
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MsCMEoHsTrQThx8F58+kVjxstTf3fc7Qe8IBz0BEg7Q=; b=4jBY+xeYSOlpt78nWsA48GVR/j
	HCxJgyMT6yy+4kzue3xbIEjjLF4PLmxhmwzwO1uVwWFqjvt33gWjds+swcke1ZxtCDjT4qIZsIFtd
	lrPWDENUw9kSBsVIrbN5JO+oCl15ZXZlJDqyl86JWg8IBj7GEtzIla+9jjwoxsPrXZHy0QeCSgVpf
	P6H8cRpRy+VbfKrPeq+Wze910aUyiiFt3tC1fnWfSXGyKGKUOt1SunSiZHAy+G1MnHweEaa8WD3f9
	eatoJuybQL8R14vJA0Cu7/go/kJ2SzW1OlHuwFfEJGBKxjRvO65jgpB2leuyYfikhzorynuSUgXXP
	xBq5JoDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8bjz-002som-1O;
	Mon, 12 Jun 2023 07:13:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8bjw-002so5-0z
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 07:13:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF5B62014;
	Mon, 12 Jun 2023 07:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F78C4339B;
	Mon, 12 Jun 2023 07:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686554003;
	bh=M/vyPvgpbmUMzqiWEq6GJrDY7BY/ILutwv2mSK464tQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NqV9xiBsktWcOOHmr+3W+SCuPEFYP7q5dwL8oyeiisBp096tIfbaoc+Nx4+V2ZB1d
	 2CWoacxSqpYGVHgG+p2KZF5oXYlyDCvQk2WSCo7ctyPJrpD50rCqFmO8KKvqifQDkm
	 to25PcX/akBf28BI8QT/m3RbQAgKVePvgsoOJ3Dm0aSYKz6mr8K6U4RODUZKfQTt6S
	 OA9q9rXpYGtf2b4Q5hHum81LUlLFfV/JU1fqSkhqNd7dnANr3Sa0rW1F7f7fbE7BQs
	 0e5YBUsTrY3wHxN4MV7ZvVXGycbmjM8C31AXKPEppD4eumSeZs5CHSUWQFQuUa3IX2
	 frMBpRSSxio4w==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Message-Id: <168655399888.1341983.14853412430695427413.b4-ty@kernel.org>
Date: Mon, 12 Jun 2023 10:13:18 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_001324_386903_8BD66F0D 
X-CRM114-Status: UNSURE (   7.63  )
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


On Mon, 12 Jun 2023 14:42:37 +0900, Shin'ichiro Kawasaki wrote:
> When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_private
> *id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
> KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler() [1].
> To prevent the destroy of id_priv, keep its reference count by calling
> cma_id_get() and cma_id_put() at start and end of cma_iw_handler().
> 
> [1]
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: prevent rdma id destroy during cma_iw_handler
      https://git.kernel.org/rdma/rdma/c/fd06a5925e4773

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

