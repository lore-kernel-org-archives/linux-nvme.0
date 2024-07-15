Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EBDC3DA4B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 20:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=drCQ9j7adeNpqn7R/0YTdxBm7kLO5bSNM67j7kPpUL4=; b=hbR7zn2p7cA0M2T+9/x0VXiZFb
	Ew1s5D6cyJHsNuo751EXnl4xaw22U0IUMZ7vj664KhNdsqZqnjsgkPKCqGKMVadvlIik4o7UMocML
	DBOUhflv2f9HkS5PD+NghhmBsPiYl7+ZqFyELdroM9vnf3wXFHaBXMbMf31xGzbTHyU5+fWZ/7MGR
	wTrlLq7JB4/v5v9qElAwmFSdQopvYbRJpKuzHQ4QwSlE53/QboRus8UxfgtpTv+IYNxLirj7NZkss
	DKCRUB3I9mc53o+QYxqo0e11fCbksYif/CG/6jmPLyEtakOXcFoJE+51g70fH2qnPJRBFVC32R5VJ
	oscndBxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSeu-00000008MbM-0vF9;
	Mon, 15 Jul 2024 20:50:56 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSeq-00000008MaU-30jf
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 20:50:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CEA56CE11EF;
	Mon, 15 Jul 2024 20:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469A4C32782;
	Mon, 15 Jul 2024 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721076650;
	bh=DsKv1AnbLIi/huCDomUZSsXmSWwVkesZakSY1Ot4E10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBx1NCskOtENzvyYcblevhJxDIA5+vo5nA5XHlD8Q4m6Fi5vfNySjP7GH624wmmTV
	 qXItdniWSCy73pv/FC48KRnouYOfB/5IKs01Thc27AWdY74qj2B0v0bjSka3lQt30/
	 i/+WZHX1L8eSayNofrevKjZofKLGlMQo2hJYc2qGjtnUpomxuunZqS07jrCcCvI9MX
	 68isftP1phj+YU/vZHAvcL0QN/PDU0NPPSjPzgnk50RCgIIJa7q7RXmU+pqEVcYYDU
	 oxg9MJ/hJD8DrEqLBQ3ybW+v4r+RaIH7zuGE8DiTYnR/Ca+9hZWFK7XdVu+GsEOJ+j
	 m5POjaD+Rnf2Q==
Date: Mon, 15 Jul 2024 14:50:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-fabrics: Use seq_putc() in
 __nvmf_concat_opt_tokens()
Message-ID: <ZpWLpxwNTYlIbdAc@kbusch-mbp.dhcp.thefacebook.com>
References: <45f97bd8-21eb-4ef6-bc7d-9201e7447c08@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <45f97bd8-21eb-4ef6-bc7d-9201e7447c08@web.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_135052_947847_D8098F55 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Jul 13, 2024 at 03:50:24PM +0200, Markus Elfring wrote:
> Single characters should be put into a sequence.
> Thus use the corresponding function "seq_putc".
> 
> This issue was transformed by using the Coccinelle software.

Thanks, applied to nvme-6.11.

