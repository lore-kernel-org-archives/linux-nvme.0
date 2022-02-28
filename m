Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45056C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Feb 2022 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rIIE+6znq1tRJvl+TlHj2+b3hEUePJ9pjiSKZ3FM0KQ=; b=gQcRpwgA31kv9MIycDLG8ZaQNb
	aQ+uMUEXO6/FPGi0K90BWUPdjc+a+FpyYSIQHNfB3chEIyelQULEfaA/CzApe+oajun7qB0pt+/VX
	BXBHqvyy4eZ3aeXCV8BKQB9BYdRqSOqfjjnKw4Ios0Xh11/zftkEBFOjy+6L4owI0tfRCCZOLfxUK
	oIUp7n+9rMwDiKK4a8mvvbdgCrIJBB+2tpmggiOeKit+fXicdBSruqE38PhK/MNHP3ylLdg83FBWc
	Oxr4aCo8fdpy3t7lSuRjt8jICy4TYQlSUG4QCixA9bGVgv0bn5hSWAxRr+mdySz87yye323jzZSUh
	prfqBs0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOcEl-00BF4M-5O; Mon, 28 Feb 2022 09:22:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOcEd-00BF2l-UY
 for linux-nvme@lists.infradead.org; Mon, 28 Feb 2022 09:22:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3971168AA6; Mon, 28 Feb 2022 10:22:16 +0100 (CET)
Date: Mon, 28 Feb 2022 10:22:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Message-ID: <20220228092215.GA8549@lst.de>
References: <20220227234258.24619-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227234258.24619-1-ematsumiya@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_012228_159156_3FA6A8DC 
X-CRM114-Status: UNSURE (   9.50  )
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

I don't think we should add code to the absolutel fast path for
blinkenlights.

