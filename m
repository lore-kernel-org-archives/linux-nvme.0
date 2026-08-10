Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E546C5B567
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=45GJg4DdR8fxsyWTUTzmsb31qjR+e5VPVXAfajuJn3M=; b=LODqjy560PR7bughhluQXi3Tvo
	2I6uuADh2nQfdKGTMiloeBT9T6Vk24o4J9FgQ4yPGPXMswWL0bZnhFm4Ld+fheSHIvH0Hd9YnAfwc
	hOVxOnlsNrgpb1fXxs1uJ5ligQvSd2hglpBhxj1mdM+rSxiqfQ8rXTfJjOFbLQqwEdQbzBOJAfpbb
	bAYgj8iOBvN8RE7Kdu5264BxtyuNxwgrdKSEKRtJbF1kYo9mGSh9m1zlq0lUU83yX9rhiOBuOvD+f
	PY+xAhm88xOzgvItrf3qCkz86FJVx/ildvWvoXsAhdJ6E4cwSiS1X40H6m8au0/e2ha9vG/XLXQm9
	GqNSOWFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVXB-0000000CjOk-1Yyz;
	Mon, 10 Aug 2026 19:19:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVX9-0000000CjOU-22Ka
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 19:19:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D03FC404CF;
	Mon, 10 Aug 2026 19:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670141F000E9;
	Mon, 10 Aug 2026 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786389578;
	bh=45GJg4DdR8fxsyWTUTzmsb31qjR+e5VPVXAfajuJn3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UHt+8F86r6cCx8NGNppe5hotztNVM+A2vuWFb9QifYrWMQ5ZgnscEvitG2SHn/kZQ
	 PWpIkqir9w3C5P9AEO9YtA2gMZwlvgUXrqFZyV3v2LshhPTHIM3lfmj7LpVS42wG+2
	 CIvE5mnnW78UPGMWazMXaIPJKGMKRrMiPoFNfI6oXAoil0p5uU/EHfiQkEuCSBDwxJ
	 Mv9GDecV2L5mfBbLzqXPIXbbXUjrm/VUsIfkd1lnBDkT6TWLEDjzTeVP5/jGGBvX9+
	 5sbIjrr/AQGL+E7IzTu9LQncpebIr3XxdAhB+BSGABaxe88vKGIjxOpHofTlXgjWkV
	 T3PwGBxdsm27w==
Date: Mon, 10 Aug 2026 13:19:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, mlombard@arkamax.eu, kanie@linux.alibaba.com
Subject: Re: [PATCH v4] nvmet: fix Reservation Register Replace for
 unregistered host with IEKEY
Message-ID: <anokSG2B9H1nCsfN@kbusch-mbp>
References: <178521959386.52051.17173420094473200063@linux.alibaba.com>
 <178527555910.84385.14037905470970123793@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178527555910.84385.14037905470970123793@linux.alibaba.com>
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

On Tue, Jul 28, 2026 at 04:26:01PM +0800, Zhengrong Li wrote:
> When a host sends a Reservation Register command with RREGA=Replace
> and IEKEY=1 without being previously registered, nvmet returns
> Reservation Conflict.

Thanks, applied to nvme-7.3.

