Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C63606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QZYSBYU5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbMiSqwU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CbvFTcO7mThiG3kWIN9sgMvXTwQ+ShS+mdMYbKYGTQA=; b=QZYSBYU5YzDw/BNhhSJpr+pMmq
	ZNcaQaysnnqSiE0P30Qo1z+WYOgd3q4eSP1AQYw3zRU6ySyr6Q6xc8i3IH/3LNB8cS8rfS6xYBvDn
	Ccyv/lUd/grsnqUrJ8HUfSXB6/OXzzhQsnE1W8nicwhrj4xIyzDFAsjDGUstOrZ3TmQY6ut0AMeYG
	8rcVVbuSsiqVvR2tag4HUSzOKRfSURjBr7i7UldwUjr5jQmNZYEmtmEY8lJ0Qbf3ciP1JcevwoGda
	Fmf9SqNGkDMwFXJkO53JYOpd9D0gswGhF/KXBDkiZS8eI7O5OSqyYpFiE+MhoEB6moy/ut4Bd9e1+
	0RbeWRyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJuxa-0000000EQPI-1Q5B;
	Thu, 22 Oct 2026 15:44:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJuxZ-0000000EQP4-1htG
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 15:44:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2911143490;
	Thu, 22 Oct 2026 15:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7881F01825;
	Thu, 22 Oct 2026 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683845;
	bh=CbvFTcO7mThiG3kWIN9sgMvXTwQ+ShS+mdMYbKYGTQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KbMiSqwUyXfBQQXiKvAwkdIbFSBbFmCxbouM6PfAP14qs2rn19C5RFqlc465RzaOC
	 dZjMmOnIcQ+ICWkPYKsn26KVanw56rLFa4Q+t1P+oBFsw9wk3xMMNkE6Vb9drxoIZc
	 8SPEdjnaggrnU5jQRV8Zp/vgy355nOhFsCeGMhCy7eONP4haS0kStro7wS35pRkLJ1
	 MLfPVJ+pyeLey21/mMZ12kHGbSp5F3bdyVbvYNPLc6Szbyztgoi1ByStMSdrYEA9/Q
	 k+qxhumtzs0qeckDvnj5/cjYCVyAofn8hS96xzAmGWpuxK207QA1RaB3Td0K9dVJHg
	 Qks7MsZVTGw/g==
Date: Thu, 22 Oct 2026 09:44:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-multipath: avoid size_t underflow in ANA log bounds
 checks
Message-ID: <atovQ0rG0Bkj0yp3@kbusch-mbp>
References: <20261022120323.6684-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022120323.6684-1-marting@netapp.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 05:33:23PM +0530, Martin George wrote:
> The ANA log bounds checks subtract the required size from ana_log_size
> in unsigned arithmetic, which can wrap when a rogue or buggy target
> reports an oversized nnsids. Compare as "ana_log_size - offset < required"
> instead, so the subtraction can't underflow and bypass the check.

Looks good, applied to nvme-7.4.

