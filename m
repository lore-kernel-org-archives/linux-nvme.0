Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF83C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 11:49:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810E023CD1
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 11:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l5B/nsRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810E023CD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pnpkb0AeoGD/jm85OEMBkqod5Mr83Pf7OdTgRz9dA74=; b=l5B/nsRIJ5su3c2Qy9gqmCVj+
	v3wofkc/5S2HjTXIrSX2aHJ2DbWY+uoLd34Jyh7YSHQAfUC1XS2U63J4gYRxG4GlDcQwz/1InIggL
	uKCOUESzJayibSFwRSw4XS59fiL3Kxtk4z7s+ESENDy8HhlmZwio5rGS5gJ1raGrf6PnWTEy9sLlo
	1p1p87V25Qqn7zaV0mBxy8F4ASHQbF+BmxZSIGd8oZDSItr9hrRnY/gvdKGGggtVbJ7VQ4uWzJGyT
	ReskjGMox7EhhynCCzqJxDO6O3pBJUk4xGZTts2hLbByXNFTKJdEpDvc/SGTGw5O2fBAspHBwr6E7
	clomQZ/sw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpsHw-00052s-MQ; Mon, 29 Jun 2020 11:49:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpsHv-00052Y-7P
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 11:49:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CDCAC6736F; Mon, 29 Jun 2020 13:49:24 +0200 (CEST)
Date: Mon, 29 Jun 2020 13:49:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: fix identify error status silent ignore
Message-ID: <20200629114924.GA11247@lst.de>
References: <20200626174629.115730-1-sagi@grimberg.me>
 <20200629064349.GB30821@lst.de>
 <58b278bd-a585-8240-bbea-5991cea4391c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58b278bd-a585-8240-bbea-5991cea4391c@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

Applied to nvme-5.8 with minor fixups.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
