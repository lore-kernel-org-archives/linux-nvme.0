Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B0C433E7
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 07:42:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AAE22243
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 07:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUMv1kDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AAE22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rUb9gJWMk4+gJxJHlyfC7U6tSnRl/WDE0hIp8Ctw3XQ=; b=nUMv1kDBC5MqmFz+AyfHiYKJz
	uCrAe/CPG/DWz2m+hV1KSIc3exIBgeiPYXmTB/o0gWwiNbqnW3plQaR1p4TpFO0qsRQY6FSKZFKwf
	JAWTsSDlzzON+z8I5jrqKxmmot86F+/U+gEz2dRuSYWoolB2el0WttMBZu0746Tx0oy7Hj8Hp0wBW
	+ahJOi7xYG4bKBKLjENjlRIrwSNYAp8ZpwM9kp/O7K2sUunf0PNhn4iTTq3RZguoPzKVd2xbIiMdS
	foo38tirRH4IFvGENB2+YATtAv6aSubfWhGUQF3DYpc/ikX85XYoXxBU5fpu9zha1ohKk5TDB0vLg
	pxtEtJzcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSxu9-0000NU-8C; Thu, 15 Oct 2020 07:42:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSxu6-0000Mj-8t
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 07:42:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 272BC68AFE; Thu, 15 Oct 2020 09:42:22 +0200 (CEST)
Date: Thu, 15 Oct 2020 09:42:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: set passthrough command gendisk
Message-ID: <20201015074222.GA14082@lst.de>
References: <20201014203845.1400053-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201014203845.1400053-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_034226_443583_BE8ABCCA 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 14, 2020 at 01:38:45PM -0700, Keith Busch wrote:
> The nvme event traces for IO commands are reporting the wrong QID
> because we never set the request's gendisk. Set this parameter if the
> passthrough command is being sent through an IO queue.

Why do we event need the check for a non-NULL disk in nvme_req_qid?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
