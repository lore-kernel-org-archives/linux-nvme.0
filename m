Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEADC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OdKd6q7VVmZu6vE+fSrmTrzPYB3Oq3rv09sQ4SZzZFw=; b=hkSZ88e9sUkQvhON5RIStL2X0G
	A3wJUaFVcGt5ejcQebq7uSyChwGsxZeiiOxGrCUlSjNfj62KbhKYBRY6oQ69vcjlII19gTcyMSSRI
	Xd21EJo9yrytzOivOJftN0/1Fb+BiLU7B/JKw9fnx/eRQtNWJOkCQ6QHezmuoi68vU5+e17DmD4u+
	kPZIL+reYX9l43AvtSKCkgqSSNx7qBA42tkPqkXtzmAgyH04xK3m5B69cFlC3AN8GKkoTpPQVxyc/
	sdWzkcOPjuaS5MlUjj9z7QHg97UCDtZEWqDvILVwskNjqyMFWWqpSezL/dcqvaWJuJuEyF63ZwN/x
	A6BdE5nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoSG-0000000DNs1-08ya;
	Mon, 06 Jul 2026 18:54:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoSE-0000000DNre-1y9k;
	Mon, 06 Jul 2026 18:54:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F5EB600AE;
	Mon,  6 Jul 2026 18:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A81F000E9;
	Mon,  6 Jul 2026 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364045;
	bh=OdKd6q7VVmZu6vE+fSrmTrzPYB3Oq3rv09sQ4SZzZFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XtnFv4zfkYmOH5NoiBju7aItKcdcotaeM+w4X0SQQxIlnvTwnfs7Pp8xiGajI9WrF
	 SyHOyBQlclZFtZiIUsPSb/5oEAyI48EqWJLwS3NQaFRX0XlJL5/MhXVWYtDg4wsUuX
	 PUY2hF6WODRklwNwud9lg4pgObeKThWR9eNpifzb5WYiRS50+/ol5i1lTpqvU4w8BS
	 rHyc6AQiLCo9cZBcCdzM5QdCGVIxRJZ5ubOSuK7Y/CBgMC9xibHPZAD3RZ2JFJxZ5p
	 SDFZNRNJVD0FtRPU+q/onEjtettFj6WCmP8FEO/3S482xlmr9iQjrBgDRuADxXfoYw
	 8U8JczjBDKYpQ==
Date: Mon, 6 Jul 2026 12:54:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: sven@kernel.org, linux-nvme@lists.infradead.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, j@jannau.net, neal@gompa.dev,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, baijiaju1990@gmail.com
Subject: Re: [PATCH v2] nvme-apple: Use acquire/release for queue enabled
 state
Message-ID: <akv5y0wqV76xKZmj@kbusch-mbp>
References: <20260618021543.3866850-1-hanguidong02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618021543.3866850-1-hanguidong02@gmail.com>
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

On Thu, Jun 18, 2026 at 10:15:43AM +0800, Gui-Dong Han wrote:
> apple_nvme_init_queue() initializes queue state and then marks the queue
> enabled. The interrupt and request paths check enabled before using that
> queue state.
> 
> The old wmb() after WRITE_ONCE(enabled, true) does not publish the
> earlier initialization before enabled becomes visible. Use a release store
> when enabling the queue and acquire loads when testing it.
> 
> Although the shutdown-side enabled accesses are not used for publishing
> queue initialization, use helpers for them as well for consistency.

Thanks, applied to nvme-7.3.

