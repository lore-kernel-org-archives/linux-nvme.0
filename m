Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E1EC4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 15:29:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2FD214E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 15:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LyYT1kmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2FD214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CfimAvHkpwlKJ3HWXJr0NCIiMgJO7tfltyY59xUqx8Y=; b=LyYT1kmuyc3w3F
	S5E9fW3vrSXCTDya7e+9qhmsSoCnrR+h7Lz62eWQGvSZ8S/VjV5ouBABqeCMJEddp5+KAyzJswfgv
	qSTfoG5E5w/X4w36GUr6P/bNWesNpctcYX0U0bki7HSL7gdWvs2sGGKZvsUFkgU+gkOI0LGOEHFPI
	v632f5niZ31CoL8NeBoGNcrdhom13/9TjS0u2FMPH+vIU7Lr42zu5qV9uX/J4xp3W6cIjlIjJFoVP
	xw+rPsKzOrvlwkgr5SMBk5lWB+ZtzVtdAJfdedI784cgcMEF2F0ECAB50Nov4fpLth5DiPkHpIEe2
	adcCgSwSyskwXgSpUbVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIaNd-0005BH-2x; Thu, 10 Oct 2019 15:29:29 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIaNa-0005AX-UV
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 15:29:28 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1iIaNY-00048k-Pk; Thu, 10 Oct 2019 17:29:24 +0200
Date: Thu, 10 Oct 2019 17:29:24 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-tcp: Remove access to sk->sk_ll_usec
Message-ID: <20191010152924.jlr53aunkj7de5js@linutronix.de>
References: <20191010150622.reqmasxgavug4amm@linutronix.de>
 <20191010150719.GA617@lst.de>
 <20191010151023.gru6fhrhy7gxxwye@linutronix.de>
 <20191010151444.GA638@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191010151444.GA638@lst.de>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_082927_130258_DB55D9D6 
X-CRM114-Status: UNSURE (   7.44  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 tglx@linutronix.de, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2019-10-10 17:14:44 [+0200], Christoph Hellwig wrote:
> I didn't really understand that comment, or how it applies to the
> nvme code, given that it never calls setsockopt with SO_BUSY_POLL.

So that part of the code is never accessed from userland?

Sebastian

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
