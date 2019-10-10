Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE02C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 15:30:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F27214E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 15:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rAaj4whU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F27214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=trOUZGejMWi0poMbx2dN5Ju7IfTNfLZwTGMnVX2uRag=; b=rAaj4whUK0puKX
	i70USyptVy5MHjHjED1Xu7gQFZFPZ2d1rNCFoqprqv0N/57dfX7m16vb3PU4p5MNmrs9aqred0pxe
	Tv6/YF48KPZkwh9UNTlsssIOqaalru9EjXD4Mb8haLZZtLMfWKxMV8H/ASWyhMrMkeASH6J1hOwY9
	VD7HWV6LoESkqj3q/VdfUvRJJ4hfyAiIR5QEFRpO6+SefHDI11+q5oTHd+CzppOdq3FdNqtB33kze
	GsyiSsgq8SaJf1MEU7QDUErQUHXmaAk0197Phg7uz6vV/mlBN4uapJ2tjHLiTJavO5CkL5OQWN37K
	bxbOE/Y7t+j4zdXt16Bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIaOD-0005pk-7C; Thu, 10 Oct 2019 15:30:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIaOA-0005Ns-DY
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 15:30:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 60C8568C65; Thu, 10 Oct 2019 17:29:58 +0200 (CEST)
Date: Thu, 10 Oct 2019 17:29:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] nvme-tcp: Remove access to sk->sk_ll_usec
Message-ID: <20191010152958.GA1057@lst.de>
References: <20191010150622.reqmasxgavug4amm@linutronix.de>
 <20191010150719.GA617@lst.de> <20191010151023.gru6fhrhy7gxxwye@linutronix.de>
 <20191010151444.GA638@lst.de> <20191010152924.jlr53aunkj7de5js@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191010152924.jlr53aunkj7de5js@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_083002_619259_B4CBA374 
X-CRM114-Status: UNSURE (   9.42  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>, tglx@linutronix.de,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 05:29:24PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-10-10 17:14:44 [+0200], Christoph Hellwig wrote:
> > I didn't really understand that comment, or how it applies to the
> > nvme code, given that it never calls setsockopt with SO_BUSY_POLL.
> 
> So that part of the code is never accessed from userland?

No, the code uses sockets from kernel space.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
