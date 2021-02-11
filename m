Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E7C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:14:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B603B64E5F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B603B64E5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AAhXkIpszmh4MocATSYIWPXFCXO0tzTSAGQAt+ME/ak=; b=WJvjZw/v8E5aAjnnoVUEnyqAu
	JeLbbwDR0361g3fMws1SFya8XHPA1m+4wlztZ+9BU3lOa2xJAF+sAOlLH3zttmaFuH+8fLqxhSbET
	lQi24EW6wjIjr0Bgg38/k7uOtwzLbj0p0yZ9GCOBmGOpiq0Thj9KuSaApDJYu60QMelmKuADf0S7q
	llS4ZhQ9QjPzlmD181MkfbEMqY/k1/sTj6QUupaNUt3YLTV3ErV05xF9wtkIH/jiqkHuJBxQ6KJla
	6HfaQz3k3KHMQX37NZE9rqfm7+3x8KLm8d5Rf8/ZDG9PSvtejNkUd9/VS5WiWSh49SciAHaNeicEz
	aZtRHi6wg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGTx-0000iQ-N3; Thu, 11 Feb 2021 18:14:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGTv-0000iA-Sh
 for linux-nvme@merlin.infradead.org; Thu, 11 Feb 2021 18:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oJeY/qSOgInkxyAfgM0qs+uFt+SpKkSt6iH7/wzoqbE=; b=Z/VwM52V7sacf4INwweg3KgBol
 T7H28yIPf0JN9VpIxXiaDuBwB4d3IJlcnsABj/RWcKM9pKiCY3/fhCPUxtdo/dr3p1zCnZXUUws6W
 FYBVBQWlpdgCSlYjjxwZQFOn/wOH7wXJV6oJetWTkbaJrVLh7jhvH+Fd4K3DExYLpnSB/0gxcUhbs
 q/6OmYWe/zIeYXzzySjj7ADKzfzKZhgqsxSwpYZFkxdlXWwJXEKd8RE91bS4XNiGoq2Lj9MrpKvqc
 uwcBoPi+rXIivzpNoz1LuHx0Jft5G0yU1lgK5xai1tf6PJAWD3CJJ7oQayQYwIIzbQ5zmV3h7wr1d
 9cyzMEjw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lAGTt-00AaFu-Tn; Thu, 11 Feb 2021 18:14:22 +0000
Date: Thu, 11 Feb 2021 18:14:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roman Shaposhnik <rvs@apache.org>
Subject: Re: vhost/virtio fabric
Message-ID: <20210211181421.GA2522386@infradead.org>
References: <CA+ULb+v-2jigmQA=Z2WmWP0n3wCbEs_s94oCoNbjJMw14ATCjw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+ULb+v-2jigmQA=Z2WmWP0n3wCbEs_s94oCoNbjJMw14ATCjw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 08, 2021 at 08:24:40PM -0800, Roman Shaposhnik wrote:
> Please let me know if there's any work that has ever been done
> in the direction (even if in a form of unmerged patches) or whether
> if I need this functionality I'd have to implement it from scratch (probably
> aping a great deal of drivers/vhost/scsi.c).

The old vhost-nvme patches from Ming and Hannes should be out on the
list.  From the kernel POV we're fine with it, but the Qemu people did
not like it very much.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
