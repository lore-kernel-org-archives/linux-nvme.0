Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70575C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 01:33:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5F520663
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 01:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IG1U8tRL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RSgYcDv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5F520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rdjtAENE+nVANVeefb4XS3GRQJBQ+ecVV7gawRB35K4=; b=IG1U8tRLQvSlrprUdKxsn5Rng
	FW9vT3g7EY3NdbHJQHqZZY7AVoKzFoh938jGsThyjWYHN4oqzo2AkeOahYFOeo3+C/zMjMzPGR0hp
	yFqLHXK6YlLXIYILuqYH77S42a5Em5eGOfedI1HLyA+5viIwHby5yOu79f6p2H6gWhrBs4HFpcThx
	CJkwBT28rZH1dKlJOprlEUZST3xuSdoBb20EIdKBfs6/pGt9DYg37dPwg5+sJwuadv78lCGIeEIPP
	mIjhN2gEz1cpPocmhnNbLL0lbNldHHbTsJrZJWkCp3hGtTs5EQgN7GNK4dMEDa8yhdGJkBplB8PZL
	ve9folvjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvWIt-0004jP-Ld; Wed, 15 Jul 2020 01:33:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvWIs-0004jG-9j
 for linux-nvme@merlin.infradead.org; Wed, 15 Jul 2020 01:33:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mIxcaQ04SkGT+6Rj7wj5q+fUCdgNhHexHvD++FdCFsk=; b=RSgYcDv0YXS2WfKF+rKVoLpB83
 pReWWfonDqoO2aYOxwPNESvE0UmKzhhy+Duk6qFhMcFdJwDflg9zfiqWbPYZUrPBwINFYuVXgmwFh
 H0LNyP+DkSKCQerR8eoQUKTPKFrx8Jyypx+nCeyluyzxt5N2+aP5uTq/XrH/bDRor6j44g5zEOtcD
 66TS3mByByxqM2xwbSQoR8zUnUDyD+EKhYFq6ReA1o8122iF69pF9/QNXbK0cVqEvQIfKuVL200vd
 19y/o+Wiv/zg5n2/1HUtt89xeWLYRA+7ja4jtRaa+heSPJuW2zVHrbkH3Ye8C7PsjRk03tYNh/ZMK
 34Jl76BQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jvWIp-0006NV-25; Wed, 15 Jul 2020 01:33:43 +0000
Date: Wed, 15 Jul 2020 02:33:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 02/10] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20200715013342.GD12769@casper.infradead.org>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-3-chaitanya.kulkarni@wdc.com>
 <20200715005509.GB2772284@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200715005509.GB2772284@dhcp-10-100-145-180.wdl.wdc.com>
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
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 14, 2020 at 05:55:09PM -0700, Keith Busch wrote:
> On Tue, Jul 14, 2020 at 04:30:49PM -0700, Chaitanya Kulkarni wrote:
> > @@ -3933,9 +3918,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> >  			blk_integrity_unregister(ns->disk);
> >  	}
> >  
> > -	down_write(&ns->ctrl->namespaces_rwsem);
> > -	list_del_init(&ns->list);
> > -	up_write(&ns->ctrl->namespaces_rwsem);
> > +	xa_erase(xa, ns->head->ns_id);
> 
> Since you're using rcu to protect the kref_get() on load, we need a
> synchronize_rcu() after removing it from the xarray.

No, synchronize_rcu() is expensive.  We should instead use call_rcu()
to free the ns once the refcount hits zero.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
