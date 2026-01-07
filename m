Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4306CCFD63E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z1+/k6DHqXjJULORho+c42Tg3/FXWPpriJ2FwnUI3b8=; b=MRPKHibXVCbwaaF6OSIRv/DCSs
	WpiJUhwr6UnKN8hzMS+VU69QGxgno+99z0DBELJz4la0jMDGzu2XzPOAb4TSi4LLfD6g/NK3imLEB
	r3Q5o21SVpDA9KgC0xMimHXkrQev+Ybo7OQ/BKi1FhGsFQALw5WhNuy3+J0AOxDlkHbWRJDB/3En0
	jJ39jukBtjorMRaRgYxmPndAH39jZRZJFfL0+nv6Q8Mz4RV4OsjjwbuHzIUyqnRkjuRDmRGMMdjIw
	k1LS7YQMzHOCLXKpH4xvfUsGXR8GQHtqyhbZuCGgEok4/wvnIm5tSUydIOvkwQ2X4KmyHQIeR1Orp
	TNy4GbaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUcL-0000000F6Cq-3ZYt;
	Wed, 07 Jan 2026 14:34:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUcI-0000000F6Bl-0TuL;
	Wed, 07 Jan 2026 14:34:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B7CC227A87; Wed,  7 Jan 2026 15:34:26 +0100 (CET)
Date: Wed, 7 Jan 2026 15:34:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Arnd Bergmann <arnd@arndb.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-apple: Add "apple,t8103-nvme-ans2" as compatible
Message-ID: <20260107143426.GB14506@lst.de>
References: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_063430_294618_C49FB9E3 
X-CRM114-Status: GOOD (  13.81  )
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

On Wed, Dec 31, 2025 at 11:10:57AM +0100, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
> "apple,t8103-nvme-ans2" as fallback compatible as it is the SoC the
> driver and bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> 
> Cc: stable@vger.kernel.org # v6.18+
> Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


