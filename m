Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8907FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 17:00:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55D861580
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 17:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55D861580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fsKy5fGQ+zMCPl5Et2xIuOlBwGIRDwlJt+X8bZuKJMQ=; b=LaXdZnb2di44iLpUuEGRfUim3
	PEgMeqP4kJ70fEwg1bpgtKcOeK3p81MxElvdh5Lin4K5oGReMT63gN251iZIjptNdUv4vfmkrO58Z
	8mrhH8sqIoVPg8PsUx8CQupWXxVqIVGb6E57LpqL9Z1n5b3fWZKjXuzceyDXZ52z1WFB9g2qldeEM
	yxuk1NSAD2kaX9nR03n0zeNYnHlScvN+skX3jlOe3N0qnAGNYUj7tZPj51CGVPeDKGkcT8HUstwfg
	o9Et2Uf4TiLUPk/PpBfmOcTSjIbtmjNQr7nkhcZMzFptHw9LB4ZqLSKv6Z6NI0gsjg2PhV1RcW2L1
	RSwjf+NTQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMZWg-003b9h-B9; Wed, 17 Mar 2021 17:00:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMZWc-003b90-6d
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 17:00:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6215468BEB; Wed, 17 Mar 2021 17:59:59 +0100 (CET)
Date: Wed, 17 Mar 2021 17:59:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 kbusch@kernel.org, chaitanya.kulkarni@wdc.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com,
 nj.shetty@samsung.com, selvakuma.s1@samsung.com
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
Message-ID: <20210317165959.GA25097@lst.de>
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com>
 <20210316140126.24900-4-joshi.k@samsung.com> <20210317085258.GA19580@lst.de>
 <149d2bc7-ec80-2e51-7db1-15765f35a27f@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <149d2bc7-ec80-2e51-7db1-15765f35a27f@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_170002_400126_A11A5B21 
X-CRM114-Status: GOOD (  16.58  )
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

On Wed, Mar 17, 2021 at 10:49:28AM -0600, Jens Axboe wrote:
> I will post it soon, only reason I haven't reposted is that I'm not that
> happy with how the sqe split is done (and that it's done in the first
> place). But I'll probably just post the current version for comments,
> and hopefully we can get it to where it needs to be soon.

Yes, I don't like that at all either.  I almost wonder if we should
use an entirely different format after opcode and flags, although
I suspect fd would be nice to have in the same spot as well.

On a related note: I think it really should have a generic cmd
dispatching mechanism like ioctls have, preferably even enforcing
the _IO* mechanism.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
