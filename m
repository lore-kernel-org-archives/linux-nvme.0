Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9733EC54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Mar 2024 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rjWdMkAPatXKJy27sYZqJnmKGzquI+v7v0D4uwGHllU=; b=t6aOmcwE8UJTnMKmYz739KHQ9g
	SYfxdE5+jR0f7Re1+6tjZGNxCafiB2f7jRZkpqDwjrwjN3cYoQm5BWRmhqUQzyfwCBKJKYPVISkkH
	bp+vyPStvBSrVvjzWOtW3YIBfTw48J9+GdTKJT6cQpomi+gLmdOr2v+npT2GKx+MSZ+oucIa2VBYJ
	fxJJVV2PXF5z1t8AMSxKE096EFkS5V6G8ahYa/tombJd0xbFdTLSM3qxe11M4xxPo7ZQLPQj131Zc
	ZDLh/kCKFvJn2TKyOZp027ny4BbG48v59A1MtuGQsIoWqtq1ypsLWD6kcPuCU05wbFpESH6MCSVU2
	P3U6sSAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpXb5-0000000ARd4-1T7Y;
	Wed, 27 Mar 2024 18:01:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpXaw-0000000ARWl-1HgA
	for linux-nvme@lists.infradead.org;
	Wed, 27 Mar 2024 18:01:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 20594615C5;
	Wed, 27 Mar 2024 18:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9E9C433F1;
	Wed, 27 Mar 2024 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562504;
	bh=HduPs94q+QhQQ2NCQNepM6fIX356TE0KHJzgIrpMCt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbtYiscdFaK0nnBITplEVWR2ukuhlk4smChuTGuLPBDmz3A9YWyJkM7KUP2MU4Bxk
	 CU1RkK5bUJ5Ed+5w8n+oMlKn6GFtcPIzidATF/+mqlID3/0X4zrYonATNvTUh6r1ia
	 nLkHGJm+xmYiahpgEDveiQL2DRO1GpoFMu25cbI5nHeTxL8LhjUVfHreKAOgfZ1uE1
	 kctJfXrWU+VtBSmB3TYbqF7q2ay+R98iOqZ9JFL1Nkw0Q3NGiEJhCHGxk41ws89eA6
	 xORTc/DYESZLUwJbepN+2ghF40sD7Mltg5J6T0kRe1XDDH/LIhOxyIxaY0cloqQfiS
	 b7h6rsHwpXvbQ==
Date: Wed, 27 Mar 2024 11:01:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 2/2] nvme: cancel the queue limit update when
 nvme_update_zone_info fails
Message-ID: <ZgRfBqorU5ejb1lt@kbusch-mbp.dhcp.thefacebook.com>
References: <20240327172145.2844065-1-hch@lst.de>
 <20240327172145.2844065-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327172145.2844065-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_110150_462515_0E649E21 
X-CRM114-Status: UNSURE (   9.59  )
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

On Wed, Mar 27, 2024 at 06:21:45PM +0100, Christoph Hellwig wrote:
> @@ -2115,6 +2115,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	    ns->head->ids.csi == NVME_CSI_ZNS) {
>  		ret = nvme_update_zone_info(ns, lbaf, &lim);
>  		if (ret) {
> +			queue_limits_cancel_update(ns->disk->queue);

Could you instead move nvme_update_zone_info() outside the
queue_limits_start_update()? That way we wouldn't need to "cancel" the
update. You'd just need to save a copy of "mor" and "mar" in the ns
instead of writing these directly to the queue_limits.

