Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E81C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 17:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=oiAkJKqyIdahl/DK9ZpNVkEleX
	DMpBvDTJ28NQgyFZ/qLWqNEe89nRnX3zslc62SZFcM0q16mjTsJil3WnY3r1OzDOiNM4YUT5/k5Gm
	M8m2tIQuh8iIlicmTwEGqUCn8B2eQ8nKTq7OX4SNWwvwwolUO0FQNJsLJr4t0qe084XKWzMAes8Jw
	bNq0ODtLpof0yxiMmVc6irbFpFOGXfqa/ll+gZzC81WUdwGzBxfwK7ugK7YDap6RqrOHB97z1aAX/
	nzCGPThTMl8mTGysZ9BkFIfw5snoRCF3H1RcTbU+cF1rqGOULZ++s0bdElVGqjgV2h7u76/N9KXw6
	uQUV1s7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oKg-00540K-Qw; Mon, 13 Jun 2022 17:58:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oKe-0053z0-7F
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 17:58:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83F3F68AA6; Mon, 13 Jun 2022 19:58:29 +0200 (CEST)
Date: Mon, 13 Jun 2022 19:58:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme-pci: phison e12 has bogus namespace ids
Message-ID: <20220613175829.GE15847@lst.de>
References: <20220613144549.232686-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144549.232686-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_105832_445794_776CA16D 
X-CRM114-Status: UNSURE (   7.48  )
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

Thanks,

applied to nvme-5.19.

