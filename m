Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DED7CA5FED
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2026 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+kjweTI65fcbDGIFtPcxvD1ult6uA10dTL5DcUau8hA=; b=KcYyADcjZ8y1OoXr4JPQZkzIsw
	QtcRdhpEt6ykcua9LnAP3VCx/0nRfmADA0faxTu9LUD5lVJk6VyQ/7YHokcScUV5PB8zEpduDvkLT
	VA6b1iXB1zaeCa7/+z43EGQGAPneahyJtfFy8PmyWTv26VadskCR3ChzYQuwqqBw2KF+TvBOOuJdM
	08axh4O3LgEXMv/PqHuRq2HcsKhtunxuCJVdQ+g1Cw0EUr2FqfpxdVPmSmysaa5/xS4ixIu1yqMoY
	cMAYS2EDwi7m3l6LKWfvD4WTSxAONZImrpy6rSu6V0fyoAAd+31J9hJGFX7d1un5d0qoQHXjPFcQ0
	xeoUvlJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE2x1-00000000aQc-2xPT;
	Tue, 06 Oct 2026 11:03:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE2ww-00000000aQK-2XvV
	for linux-nvme@lists.infradead.org;
	Tue, 06 Oct 2026 11:03:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A716B6022C;
	Tue,  6 Oct 2026 11:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD81F000FF;
	Tue,  6 Oct 2026 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791284589;
	bh=+kjweTI65fcbDGIFtPcxvD1ult6uA10dTL5DcUau8hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L4JO7IKLvVg0/a/cdjG1WSVN16TXYE1A17K33VozE4sp1w4Vsj3CtYl7P32phXSVj
	 DraZZcflmOIbvxfyEc+RUjxeRC7CpmOd0mo/+MrePIDydNfON0sqzNaePHSGI9QzeE
	 Z5FJ0x5ka8DhYrFKMGXS1UYOqmjRUrsnOxqpJbQV79g7UAzLgQAcadafPOc25QZxwR
	 RRh3Z9t/AMC8emXwj6ljc1HZCruRCVSFqnMbAATxBJECQMD4NKrNIeea0UATkZl15S
	 hFV5YFtReHmUy6LlgWmcLgoBrf4evT6qTG+XlhRPelj+4FpQszVDQKBq8S6zyEoHe0
	 6xfH+60lie4sg==
Date: Tue, 6 Oct 2026 13:03:04 +0200
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
Message-ID: <asTVaAMaOen5D395@kbusch-mbp>
References: <20260903152623.614951-1-kbusch@meta.com>
 <db8c19f8-d087-4e3c-8424-6a90760cdf16@suse.de>
 <arFphFDlyHpnCv0J@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arFphFDlyHpnCv0J@kbusch-mbp>
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

On Mon, Sep 21, 2026 at 11:29:40AM -0600, Keith Busch wrote:
> I'm still trying to see if we can achieve a similar result just by
> making duplicate connections and letting the multipath policy handle the
> spread. That does improve things significantly, but I'm getting worse
> performance than this RFC, and I still don't know why yet.

Best I can tell, the duplicate multipath connections does what's desired
on the host side, but the target side (standard Linux in-kernel target)
ends up queueing all its work on the same CPU, so that appears to be why
my RFC is showing better performance.

