Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEC8CD6E60
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T0FXHK9O4zuaNeYDoiuUWHXIdd8oARiy6HIpq2GBZcg=; b=PsKxBf9+5IsJm91Z89LjmeNhff
	vCX6+lXRBIjhz5wkGzetnMMOeNI84/707FbhZH5rn0Lv2B8KYLAoPljHlVU3YmEhGlMfDC667LOAt
	RGhElX2WATUczFNkmjAYgizKn+HSn9Yf7nxoyf5Wf+cGvYcrRtOi2iBh8zzgISMgxS2l2Y0d1gNB9
	WvJYtbqV0GzAXdha3zZa8oSUi0HMYINc94J9iiIZ/ssAis9de4X2Vz7vxZrNKeoCIv4GrZXLF0toh
	QEdsfSetuQ+FYL8w9Rh5T2vqAkXhzBcp556AAMyrLxjU+PpwmC7qXEM2DQlSh5zohVQ1StMw+Pb5N
	C4th80mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOHD-0000000CzCV-1JhG;
	Tue, 02 Jun 2026 12:31:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUOHA-0000000CzC5-18YL
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 12:31:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C9A794090C;
	Tue,  2 Jun 2026 12:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752CF1F00893;
	Tue,  2 Jun 2026 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780403479;
	bh=T0FXHK9O4zuaNeYDoiuUWHXIdd8oARiy6HIpq2GBZcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kW+U18jEXQ5pbEEsISsR6vM6tmq1ikhAGnbnrflwve4vogMcbytAX//iS9SIjwqh2
	 Xux3VEHEl3CeAN89vd71ct9PXKm+UIvWFGMwTRweaDbnKC09UweXdQ9WIqbb7JI49H
	 Vj1mlli4qpme5ycW+O0TUdFEvMW09u+IWQpslBKCbftSTKPwfR5Aq5eP7CPqTSgy1I
	 ShZFA/j9O7Kl81FRPBRMdTi1SfwdmgZ4V3DUbkvXeq0dHAPOQhy6EgtPVjCtONhuok
	 phmEMkBbthMhGalGC2nakfU3fhDdeVtLnGUEURj7hFZO+7su0r3VwyKjMT3opNc2RP
	 TZ/kgrbOp8y0Q==
Date: Tue, 2 Jun 2026 13:31:14 +0100
From: Keith Busch <kbusch@kernel.org>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v4] nvme: refresh multipath head zoned limits from path
 limits
Message-ID: <ah7NEVWsaCYfVEcY@kbusch-mbp>
References: <20260528073601.4139342-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528073601.4139342-1-sangyao@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_053120_324939_690730D0 
X-CRM114-Status: UNSURE (   6.90  )
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

On Thu, May 28, 2026 at 03:36:01PM +0800, Yao Sang wrote:
> queue_limits_stack_bdev() updates the multipath head limits from the
> path queue, but it does not propagate max_open_zones or
> max_active_zones. As a result, a zoned multipath namespace head can
> keep stale 0/0 values even after a ready path reports finite zoned
> resource limits.

Thanks, applied to nvme-7.2.

