Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4C7C00140
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 14:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vo+8tXqQG5ULmLrC5vyg7FLWUr1FA1/wh0gi3z/MQ6Q=; b=G1Kf+qdgmKYHE5qEIqlknZXECI
	xXKTw0xwcMvHmnXhy6Gktsz6gb1Kc875m0dQf5BClzXA3O9ctpzVGVsJrskxQSmrDDrCnLGdxImdP
	57v6lrm6U0f1GYrnJi7XZfNl63iFEdF1Jx3X9bJhFQ7NGEcRe+gLgKz31QHiMilDrL8I1qiz0v/C5
	HoRBWrupZQvRN19wtcAkV3ZmR4eSr2q/wpf3W1bvjBf+Sx6RO18tjw8SL+T0kgG9mnTM2GHpd6ak9
	+Ovt/XJ3z0gI8Z3bTyV9vHv2iydpL0bqBATiQTgGUX+dwIgm2feSDc4RpGMnrku0oMdKDIcSpmmPV
	NYbfVLQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPm8D-00BPJW-I5; Sun, 21 Aug 2022 14:40:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPm88-00BPE7-DP
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 14:40:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 60EB067373; Sun, 21 Aug 2022 16:40:39 +0200 (CEST)
Date: Sun, 21 Aug 2022 16:40:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Derrick <Jonathan.Derrick@solidigm.com>
Subject: Re: [PATCH] nvme: don't flush scan work with non-idle request
Message-ID: <20220821144039.GA3384@lst.de>
References: <20220812182147.1564958-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812182147.1564958-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_074048_804435_2BBC8E0F 
X-CRM114-Status: UNSURE (   8.63  )
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

With this the flush_work is lost for the target passthrough case.

I also don't really like the double call to nvme_command_effects().

What about just removing nvme_execute_passthru_rq() and open coding
it in the two calles, with the nvme_passthru_end call moved until
after freeing the request?

