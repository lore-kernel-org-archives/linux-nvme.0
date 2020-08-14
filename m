Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC2DC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:45:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E4C20708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XpyyoSRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E4C20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xObRWZ3OK5rHZvD++I9K/SXF/NEuM1hN9Kgsj8RiMQU=; b=XpyyoSRs91F2fVNkS34XGu0bz
	pIpIadoQHoKEh39raaLgKVXbshQxmrGzVC8ZAf9txE8XaRXEJfDTFNktciEszGFVnBeQswE3z4We2
	niv3bRw2emX9CQDLjn5WNrtbUnxNQ51lyiWWnDmfOxFtcQ2k1XEDfN/+WWtAGYfX64hOZp4Ky6ImI
	v1czx1H3aS/+dVvjrk52mJhgEjff5YqKsZsmTgBlEoU66ifGE48XJ+HBQA2gltwUCqUKG4vJBqNqD
	FGjQdenZ3vlqEFAzsdBo703AbfGkg8GJy8tfF7yzuPi6eIFbj3nIEGuP5LygUncL42e9ZSK4k9ZxE
	NTf0P3JVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TTL-0005dT-OA; Fri, 14 Aug 2020 06:45:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TTJ-0005ci-42
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:45:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8A00C68CF0; Fri, 14 Aug 2020 08:45:47 +0200 (CEST)
Date: Fri, 14 Aug 2020 08:45:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 6/8] nvme-rdma: serialize controller teardown sequences
Message-ID: <20200814064547.GC1719@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-7-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806191127.592062-7-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_024549_290073_0A16E6B2 
X-CRM114-Status: GOOD (  16.34  )
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
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 12:11:25PM -0700, Sagi Grimberg wrote:
> In the timeout handler we may need to complete a request because the
> request that timed out may be an I/O that is a part of a serial sequence
> of controller teardown or initialization. In order to complete the
> request, we need to fence any other context that may compete with us
> and complete the request that is timing out.
> 
> In this case, we could have a potential double completion in case
> a hard-irq or a different competing context triggered error recovery
> and is running inflight request cancellation concurrently with the
> timeout handler.
> 
> Protect using a ctrl teardown_lock to serialize contexts that may
> complete a cancelled request due to error recovery or a reset.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks sensible:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
