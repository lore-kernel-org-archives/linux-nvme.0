Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C1C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:30:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950CD6574E
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950CD6574E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gVjvILJxI9o7OgCatX2Y4rXzKghiq5DtK5LXNwPTQDs=; b=KLzw/jB3bLUMjoAaCjBrrLGag
	R0y5mtDP4oXXupNJ4D/mh8pXAxx5QKWR4Uc5VVFnSaMEjOynL4lk7wSaLxNz+Zyi4gzkaWjNAbvJx
	yRyF2lrqft0XFYAxq1RB0/L73J34xPWjQmHiYyenzvh+WWr7RLf5u0jAsaOeO3QnvXlKFd8OmqhTl
	1M7tv7l9VwGhSdSv2xAZJpfYiOju0izPQiZYbp6YiRuSjRBDb0ZJwBtNOxLt5z60mXnJpKaQRmSPS
	nDpo8imBLXhcGcUtlW6itAZlDlM/ZZJEdM006qfHIiy+lsyV2+wR3E968TTT2zdV15/KAc74qigOc
	h89SB5voA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHcoJ-007Kcp-7y; Thu, 04 Mar 2021 01:29:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHYbP-006WDZ-Io
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:00:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 13CA6AC54;
 Wed,  3 Mar 2021 21:00:13 +0000 (UTC)
Date: Wed, 3 Mar 2021 22:00:12 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: allocate the keep alive request using
 BLK_MQ_REQ_NOWAIT
Message-ID: <20210303210012.deorolbbpazpwiqd@beryllium.lan>
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303125304.1200789-4-hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 03, 2021 at 01:53:04PM +0100, Christoph Hellwig wrote:
> To avoid an error recovery deadlock where the keep alive work is waiting
> for a request and thus can't be flushed to make progress for tearing down
> the controller.  Also print the error code returned from
> blk_mq_alloc_request to help debugging any future issues in this code.
> 
> Based on an earlier patch from Hannes Reinecke <hare@suse.de>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

And for what's worth, our customer tested this. I've done the same patch
during debugging. It fixes the deadlock as Hannes reported.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
