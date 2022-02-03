Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217A8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=nYjcAs+k82lGiIa4yZdl2ihIW+
	z/Fm7RkmFu1OWya9KkMDD1ixBKvcF0ESFxOpW1Vkmn+2nXlMXy5iBFedB++fZSPEJAt8cUOz2xgLS
	IOtA9TpBxNT5sZZFKrnU74n9Ly6ZwpEyqjDOixm65PsZ4x0EbDgjFDhxN//EL00y8TylukAyIq+m5
	BALOU3x6t44kavHHY2FpaABW/D6zK9uUkg0G2vPMYRDfsh1Rr5LolekEOUfAVPEizZQUGiLTm/SZs
	OnM0PYeCclRan+5ymLsxgjUJwWWk77RhO9ld1MA1Hc/b7166lHlPRr6Z7KaPx746TAGmVl1PZu0s3
	tL59yYVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFVeP-0004qb-Dd; Thu, 03 Feb 2022 06:31:25 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nFVeM-0004qJ-W7; Thu, 03 Feb 2022 06:31:22 +0000
Date: Wed, 2 Feb 2022 22:31:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, stable@vger.kernel.org,
 Uday Shankar <ushankar@purestorage.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-fabrics: Fix state check in
 nvmf_ctlr_matches_baseopts()
Message-ID: <Yft2unhvXO/fPK+Z@infradead.org>
References: <20220120201737.65390-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120201737.65390-1-jsmart2021@gmail.com>
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

applied to nvme-5.17.

