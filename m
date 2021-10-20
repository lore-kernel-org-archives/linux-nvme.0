Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD24C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 17:24:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140426138B
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 17:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 140426138B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=1ZxVcUBl596YpqHkMkgjWq/hU4
	5wAwfYx3ymt0esGGfrAjTLvhssChhjqyXw370Fd1dZdicWOfP/5iImC9FNBMKth43sLnzF30bRoBU
	dJt+gKDUViBIGwXRfLmOZotwg9MZiGAcGRHuUH9dxq2YQPJ5hpKKWyJa8LXFCrKpuVWbhXNxJDyyu
	RgCyhnxe/A2aTgUBvF95EVwzYtjX7FSUDnqnckVuJKxjWzrGMdfwoIIx/X6FUsont9B7FHLURvPx3
	64uk8gyszBQ9AGeURKgnu5PeST3MPfQNbdRB7X8pMPoFngJw1IGj9faLyCEcKMMYoTKWAk5VxwCMo
	Zhc2j87g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdFJp-005JD4-1a; Wed, 20 Oct 2021 17:24:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdFJl-005JCl-2d
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 17:23:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7A20E68BEB; Wed, 20 Oct 2021 19:23:49 +0200 (CEST)
Date: Wed, 20 Oct 2021 19:23:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 John Levon <levon@movementarian.org>
Subject: Re: [PATCHv2 1/2] nvme-pci: clear shadow doorbell memory on resets
Message-ID: <20211020172349.GA4167@lst.de>
References: <20211014164543.1821327-1-kbusch@kernel.org>
 <20211014164543.1821327-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014164543.1821327-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_102357_310836_468EFD4E 
X-CRM114-Status: UNSURE (   7.87  )
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

Thanks,

applied to nvme-5.16.

