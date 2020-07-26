Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A447C433E3
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:42:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4A920714
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G1utmNub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4A920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e5p+8+XNP3sbZPr9fArYh1sKrsxL5NoBYzHmQlGzTJY=; b=G1utmNublwwvaxE1R0oVgHQjG
	AgK/oY0FPRjUssb+Mj7QouxQTMFjuYFGh3L8ux+3wNbys8AhvC2x0eJEDnjTHxxC8PF7jILuhqYxR
	68bsoNH7429adgC67Ore/n2wFGVqlLXeRCyM6SMcqqs0GM1VSPFuTVs2q6FkZaUyLPAJk4H7YGjaa
	/k3HRe4Z4VitfVewTQAb2s/XVwWQx7sgi26clyEDjGVDwqToUY3zYxPT3aDdSJvNOnAuSnVHN4MZt
	pKBv1VOiF9mJYOnOUJNFF2mkhW/aBW1pjnGIcq3i5b9JBu6GQcSBDQs/hBz3Q8djZV1oo4V13ZJy8
	9O10hptOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzinU-0000mG-6a; Sun, 26 Jul 2020 15:42:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzinR-0000lQ-To
 for linux-nvme@lists.infradead.org; Sun, 26 Jul 2020 15:42:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6873868B05; Sun, 26 Jul 2020 17:42:38 +0200 (CEST)
Date: Sun, 26 Jul 2020 17:42:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-fabrics: don't fast fail on ctrl state DELETING
Message-ID: <20200726154238.GC23930@lst.de>
References: <20200724163210.614747-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200724163210.614747-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200726_114242_158608_9EDA4E95 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 24, 2020 at 09:32:10AM -0700, Sagi Grimberg wrote:
> This is now an state that allows for I/O to be sent to the
> device, and when the device shall transition into
> NVME_CTRL_DELETING_NOIO we shall fail the I/O.
> 
> Note that this is fine because the transport itself has
> a queue state to protect against queue access.
> 
> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

I've folded this into the original patch adding
NVME_CTRL_DELETING_NOIO, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
