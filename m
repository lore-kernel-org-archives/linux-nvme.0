Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F5FC54F54
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xEsuTZ/J/7jYlAh219+aGSAIHCzqRxzX//zpdlhopWw=; b=sZxnuFc/hpNKyzH5FKgWQLP15b
	PJvpk0t5p8bE52pRWsRJq5QsL3P4Gp9BK7KRbKn1czbOH0QFrmTI7+H46ZCYikI+C9psP6O44F5mi
	/6UMCVg34f8PGsYCLAbOxd7LSWbU/6VD0rrJB5lR7/QsQp+D7cYXYLProRhpA83KDx4pCOCtqGmht
	lv/oODr33o2FeDP7uOnIsRP506JGWAoOQ6mmj0kbnFQHNY+v0YM75an3r/As77Krag+sxAt4rXXhZ
	KmiI0kTJzpQ8f5g1I3eJLnzfWNlCo8KngfwqTBLRpvAs579zxKmSmLZPm3zx5VYy9qezgtntRVRWh
	Hd9RNP6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wolOH-00000005v1o-3G5s;
	Tue, 28 Jul 2026 17:14:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wolOC-00000005v1a-46NM
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 17:14:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5463360A5E;
	Tue, 28 Jul 2026 17:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41B21F000E9;
	Tue, 28 Jul 2026 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258888;
	bh=xEsuTZ/J/7jYlAh219+aGSAIHCzqRxzX//zpdlhopWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vzna6AE8VELXvjiBgRNtL2+G4GPkxBK0IjUwTpN0nHa7u3/jsEHbSn5p1meDTZWGW
	 IC8yjU/X9AKMRtIcI7D3XHMS2KPHuUjfKILMDdQX/Q8fZlWs2Jk8ko371BaIXre1q6
	 1KKMNE3LIvs0/cEQYi0EhLWVGaeB+gV5IRMc2OetZHJB1W+PMjPjFylhMsvgqzMTT3
	 oSDy7tHsVBBxr1VuJPIskPf/+1Td1BLqhGlwNM2lCgdcceBRrh8m+0ppuLAjg/pkm8
	 TRjWeHoRLblMYawH4z7iM0kxBbAhJ5fgOAQ78giQITqcUBVGPRuVBcc5zuGAykDgck
	 /OgrHHKhlC7+g==
Date: Tue, 28 Jul 2026 11:14:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH] nvmet-tcp: Do not WARN on remotely-controlled oversized
 SGL allocations
Message-ID: <amjjhnBMMcHACoKp@kbusch-mbp>
References: <20260727-nvme-tcp-v1-1-61c0e36763eb@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-nvme-tcp-v1-1-61c0e36763eb@linuxfoundation.org>
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

On Mon, Jul 27, 2026 at 10:03:31PM +0200, Greg Kroah-Hartman wrote:
> When fuzzing the nvme target code, I tripped a kernel warning in
> nvmet_tcp_map_data() because the length passed into the allocator is
> controlled by the remote initiator.

Thanks, applied to nvme-7.3 with a minor fix for an overly long line.

