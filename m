Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDACCC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:10:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B6D2078D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KnjgdDVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B6D2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xqil1pp3cfV/BvxjUxcx/fehPil+2VJ6fGHOdLnsTjA=; b=KnjgdDVZ3oTLkvWxeRRUG4S/J
	DErUFsv/y1g/DphDCvkAUL+XFDSxtKB/YkN+Pbou1RBOujV+lFZuo5jTtshOLF+sSXlThbGmjInLv
	mchJvKQRa2Zsaweecp27n5MtX2ytvZ00eMMQ+vGKMSWEj+osfXReTqYRoIYGxtGb+Yy5DBQGhuNKS
	RYd/D77hKOn8iNJ+YFNbgh4s0f8sbLan4efGCHh3n5AwAIsadkPEXQxMBlqdzs33v57cBsui2ar8g
	EjF8rfY8trc1L4P/6tLHmP46HBI99590ISKXPwS7oOkhppn5Y0dKX7gDjiYCKGBbvYb4NyEP3i01u
	WvJOY6h9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dmZ-0006mg-R8; Thu, 20 Aug 2020 06:10:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dmV-0006l5-LQ
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 06:10:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0DFFA68BEB; Thu, 20 Aug 2020 08:10:34 +0200 (CEST)
Date: Thu, 20 Aug 2020 08:10:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 8/9] nvme-rdma: fix timeout handler
Message-ID: <20200820061033.GD6188@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-9-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200820053651.197057-9-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_021035_870156_563ABC1B 
X-CRM114-Status: GOOD (  17.25  )
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

On Wed, Aug 19, 2020 at 10:36:50PM -0700, Sagi Grimberg wrote:
> When a request times out in a LIVE state, we simply trigger error
> recovery and let the error recovery handle the request cancellation,
> however when a request times out in a non LIVE state, we make sure to
> complete it immediately as it might block controller setup or teardown
> and prevent forward progress.
> 
> However tearing down the entire set of I/O and admin queues causes
> freeze/unfreeze imbalance (q->mq_freeze_depth) because and is really
> an overkill to what we actually need, which is to just fence controller
> teardown that may be running, stop the queue, and cancel the request if
> it is not already completed.
> 
> Now that we have the controller teardown_lock, we can safely serialize
> request cancellation. This addresses a hang caused by calling extra
> queue freeze on controller namespaces, causing unfreeze to not complete
> correctly.

I still think this should be dev_info instead of dev_warn, but otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
