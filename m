Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D188C433E4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 07:03:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFA9205CB
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 07:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EWypv9qS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFA9205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L7f9jGCGA1aLnyP1u7wxTEnmMLLy2EalnSqpVuPWSaM=; b=EWypv9qS+LFsjjX7VDfJFHOXU
	PoEtjXWGBVVLHOk4cjej7R7v1moZXV3TVOA751esphF4TiqlJtpadr3YYQOEt0ybYLZGg/pxtn08k
	jqqODSGHKkDO/BgAOA3MVWwsIaqILTovnE98Q0jjBDPcsXDXMbAfRv0IWesBVN0wkPQcJdLTXGfhK
	WHvqeoHpJsClhb17b66jxu3ngltXsKVJk1B31wdiaGE4AjZgOEIKv5/0e52bk1rSy2YuQbvZgNl2t
	MbGBz5ikBp4lhixxi9mhIujOm6/kksSBnm9zqvW1zQBuXV15LujABO0xKWHez0W01vR0wk0492XQx
	uAylzo41g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvbS4-0006wl-Tf; Wed, 15 Jul 2020 07:03:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvbS0-0006w7-EJ
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 07:03:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3021E6736F; Wed, 15 Jul 2020 09:03:29 +0200 (CEST)
Date: Wed, 15 Jul 2020 09:03:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 00/10] nvme: use xarray for ns tracking
Message-ID: <20200715070328.GA22320@lst.de>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200715_030332_654211_8D74FC8F 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 willy@infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 14, 2020 at 04:30:47PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch-series uses ctrl->namespaces with an xarray for host-core and
> target-core. We can see following performance improvement when running
> fio with 32 parallel jobs where first 16 namespaces and last 16
> namespaces are used for I/O using NVMeOF (nvme-loop) backed by nulli blk
> devices mapped 1:1 on target namespaces.
> 
> For host even though nvme_find_get_ns() doesn't fall into the fast path
> yet it does for NVMeOF passthru. This prepares us to improve performance
> for future NVMeOF passthru backend which is under review which uses the
> similar data structure as target.
> 
> Following are the performance numbers with NVMeOF (nvme-loop) backed by
> null_blk devices mapped 1:1 on NVMeOF target backend :-

Can you make sure the nvmet patch is the first in the series?  That one
is obviously useful, so as soon as everything is sorted out I'm happy
to apply it.  I'm not quite as sold on the host side.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
