Return-Path: <SRS0=y1aL=4R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1348FC3F2CD
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Feb 2020 18:59:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0ED2467D
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Feb 2020 18:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rlnDgIzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0ED2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x/jkKEnfNn2MrKFPbydzyY3ntlNcLDCDccYdtBtMG7o=; b=rlnDgIzd3kMzZG
	HyTWb6ZEYjeWtiaLTjbnALXIh2uderE+Adne1mNx1mKl7dIpv23NRK+wYS0pBVusDnh62sq53uo6V
	R2ylYZsZOIFbz8voDy8KyKo/hJaBgW9Vhmyw07lo4Y0V2rpP4i+2eZ4sH0prktOEV7uD1w7KebgQ9
	zJknoLBWnmBoC00QBoHTOl9k3ROTE646W3tk05/sg/5tWHYoexJuYERRpXF2RD33n689RRuRw8iLO
	iLwErQeXZWSrJu9HeQfySMwMNyaOJDZwAOcRFilOCPmoV9Es47AHzEjLLYF5J3q5jT9Oa5+n0RUsq
	1HeqgwYDQKxHq8BmNPHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j87KW-0001tQ-Ph; Sat, 29 Feb 2020 18:59:16 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j87KV-0001tG-W7; Sat, 29 Feb 2020 18:59:15 +0000
Date: Sat, 29 Feb 2020 10:59:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: masahiro31.yamada@kioxia.com
Subject: Re: [PATCH] nvme: fix NVME_IOCTL_SUBMIT_IO for compat_ioctl
Message-ID: <20200229185915.GB5698@infradead.org>
References: <2caa4c913579464bbfdf06b36001ffc9@TGXML281.toshiba.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2caa4c913579464bbfdf06b36001ffc9@TGXML281.toshiba.local>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We can't just change the existing structure, instead we'll need
a compat handler for the 32-bit x86 case.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
