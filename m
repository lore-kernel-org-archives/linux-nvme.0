Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB23CD4F3C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4oasd/yJa0K1TRSG+ZPHoS2lgQfXO6TXKwK7m/2VakY=; b=T5XOsSk3YBjYeQTlC8wd+253Pt
	0efmDXks5zavpOxrKiN6UeF0vTfyO+HfWaoVG2FIpAwtD8jPdqMol+MFJWThY1RtR2ZGHBLuiudh3
	XACv9j5ysq8R8x2l18htP7m5ojKZ6SYPp0xeJ6RgCuChnse41R2n8MKUpi6ndO/oQIPL/XcHedztf
	wwXt+hIvX/0oJhsjYlhMvB1qbTX2cwq60HUwUIBpb83DmE6N0R3HcN1+rRRlC7JC8LVyE/xQM+KA7
	V72Cx/dL1Z7ilvsJgGI/+A+aJYTwbfDiAmaO230XzMUnKlwqdE4mRDm/CuOpUHtSr2vAwNahliU0q
	N4M7NnDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPihP-00000004xGx-0GI6;
	Wed, 20 May 2026 15:19:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPihO-00000004xGo-0z32
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 15:19:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7504060008;
	Wed, 20 May 2026 15:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CD51F00893;
	Wed, 20 May 2026 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290345;
	bh=4oasd/yJa0K1TRSG+ZPHoS2lgQfXO6TXKwK7m/2VakY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bJvU0lrg3TUf6173gpDpGIGJGMQgML3JDhFJxP+0Hl4dYd7EjyewbFsMrE7Asfkzo
	 VhtnnXVavSXo9HqRxK60rZmBdMaqFQ4imiYwYvNNd5cvoJnobMTxWLpL9Qiex/b90R
	 ANP1fHonZym1o7ppMSqjSe3GI040XgeC8VJyiMSBBxfl8ni1MFmMrWyBs9cMb3h/RQ
	 8TDsxllnvNHFhAlHvzB4W5u7M5yjIGjx/n+CzDVgHsp25wdES+eYYmZsz6OUe6RAm+
	 r9nrkaiDSaG4ZQOBtO8xDpA0O5/gm7Ptr39Qgpvg/NHp34yKVBydBJjr8Ae+OWBmih
	 KrdpbccY5o62w==
Date: Wed, 20 May 2026 09:19:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	tom.leiming@gmail.com, coshi036@gmail.com, Igor.Achkinazi@dell.com,
	dlemoal@kernel.org
Subject: Re: [PATCH RFC 4/5] block: move bio validation into
 __bio_split_to_limits
Message-ID: <ag3Q5wdOBFNclfMe@kbusch-mbp>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-5-kbusch@meta.com>
 <20260520072548.GC14937@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520072548.GC14937@lst.de>
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

On Wed, May 20, 2026 at 09:25:48AM +0200, Christoph Hellwig wrote:
> Moving the checking from submit_bio_noacct into __bio_split_to_limits
> means that we lose it for bio-based drivers except for the few that
> manuall call bio_split_to_limits.  So we'll still need a helper for
> them, which could be called just before calling into ->submit_bio.

Oh good point. It looks like many of them don't even want their bio's to
split, so probably would need to factor out a limits check from the
split so that both can call from an entered queue context. Thanks for
the feedback.

