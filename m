Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C38C88E73
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S3kiUryi7ys2gWqYZn4Qj5z61a8AqX+Y1KsLFE3pDEQ=; b=l4EVK+K3m80jQTDE4ImTQfH9mL
	m+cHSd4noP3AFTz8apsYn50AqbnHf8DPoINw9QHc8zPPprJP/F9EwcW4LKXQmUBMbeNnQrpwJ1M1c
	4wi+0aVFtAM1A666LVJyC0h4VwEYpIKf1TbnEZ3DgAv9WOSdMqQc0JLWdvFUQD4538sTmHkhuuBbO
	4mVW1OfuaJae51hX2aWfjadWGq9QoSHTEiMwKGub0O7FOPDV9VPWO+ClOntZESrVsoj2xEBWVUms5
	tA1+VA90k8eoxoGZYYntvVJtVSxcFFl3MJOZSmQLeg/NWBGOXyycRDKxzlzj3RkqQrQWqyLa8M7I5
	usLhcSzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67qB-000000040Hp-0Z0H;
	Mon, 14 Sep 2026 14:39:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67q9-000000040Gx-3OeC
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 14:39:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DA5D9601EF;
	Mon, 14 Sep 2026 14:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E72B1F000FF;
	Mon, 14 Sep 2026 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396764;
	bh=S3kiUryi7ys2gWqYZn4Qj5z61a8AqX+Y1KsLFE3pDEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HexKKt3fFac6sIZs49+idp+3Xm8EsD9lAHQ8szU+YT5j1zbdyHO0H1b/VMiZTyaIv
	 v4Bhd7KPFnP0DkGoBOSbKWWBlmzazu8tkB2wcldkSc/gtD469tt70gMR4SFlt+Gk+t
	 jHyirFXJ7pdhrDiT9bDUvYvyQo15Aa6PvOZhSBj8o1q8LhdtKD4eqfmpP5wbq52O4Z
	 wS8XhkqjDqoaeuUkZsX611IU5Vffmz5AXrTbX2VJ4AAQeeAA7p+284KgJfz05fr/ZO
	 LT/jctvYi0Yy5rcqBsEDOCfdA9yi+DEbHfoSgvutk6/wwHYdPEo3TTdlz4F63alVOg
	 E4NWik788ZfQg==
Date: Mon, 14 Sep 2026 08:39:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: bump genctr when cancelling a request
Message-ID: <aqgHGefyCPcoNoB_@kbusch-mbp>
References: <20260913124053.86565-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913124053.86565-1-mateusz.nowicki@posteo.net>
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

On Sun, Sep 13, 2026 at 12:41:01PM +0000, Mateusz Nowicki wrote:
> The cancel path is taken when the host stopped waiting for the
> controller: CSTS.CFS set (dead path in nvme_dev_disable(), no CC.EN=0,
> no wait), or CSTS.RDY not cleared within CAP.TO. Nothing stops the
> controller from posting completions after that, and the second
> nvme_dev_disable() from nvme_reset_work() reaps them in
> nvme_reap_pending_cqes().

I think it was supposed to be that we don't cancel a request while it's
still possible to see a natural completion. So with that in mind,
perhaps the call to "nvme_disable_ctrl" should be called unconditionally
instead of only on a live controller.

The sequence you're describing is weird, though. Your controller
has fatal status, the driver hasn't done anything yet to recover the
device, so why were there no completions available the first go around,
then completions became available on the second? The controller
shouldn't have done anything in that time, nor should it have been able
to since Bus Master Enable was off.

