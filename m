Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC2C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 06:05:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54160206D4
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 06:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RqUtnnzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54160206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1m1wku8fMlgkePpt1d+LaiOjfOqKkjxTWzqBcyd1F8E=; b=RqUtnnzrG9XKwJerAEWnrFag8
	i3gVAX4juv1bfrG2ZiPJ8Y5KPpD+E4qxyVfIO1f+NJLFOBsRmcPFif01RL7C93t5iWKh98m8r1xAJ
	ZK8SiQqT67VvrE9ygda7T2OPfwQkyoPX9Km7OvM5RQwDYCP+wMu9JpQf4joIxIp8D4d7r3IDSt7ih
	W7QEdFOrxGj8YsGNaEhbBNcLd2yU1jOIebDp2hp0t2UnUjLC3Vl+AZxtl4Z8bK5zhGyKlUAXsBHsK
	DyAhFEL3FpXcHqLyvL4ExI7L1l13aE39PSABTsmdqTzeppqPRQjmq9RgWJglCF5EypjWmlSsy26OS
	ubugkIy8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0fDX-0000nc-RD; Wed, 29 Jul 2020 06:05:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0fDV-0000nH-2R
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 06:05:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 90F9168B05; Wed, 29 Jul 2020 08:05:27 +0200 (CEST)
Date: Wed, 29 Jul 2020 08:05:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
Message-ID: <20200729060527.GA31594@lst.de>
References: <20200728053523.21657-1-sagi@grimberg.me>
 <20200729054500.GA31113@lst.de>
 <16c71600-1656-b6ff-026c-6ae92944d346@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16c71600-1656-b6ff-026c-6ae92944d346@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_020529_309395_C23EA82F 
X-CRM114-Status: GOOD (  13.15  )
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

On Tue, Jul 28, 2020 at 10:53:41PM -0700, Sagi Grimberg wrote:
>
>> Dropped from nvme-5.9 to wait to the discussion to finish as I want
>> to send a PR to Jens today..
>
> OK, this is a bug fix, so we can send it later for sure.
>
> I can also send a patch that doesn't touch the USERCMDs that
> James is concerned about and we will fix that later...

I need to catch up on the actual discussion.  I'm heading off to a
vacation today and just need to get everything in order first.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
