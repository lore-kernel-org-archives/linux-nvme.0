Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB1AC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTZMli0oVOwq5NwdIaAMBAj8E752lPE8yEa2MtbExh0=; b=GolBDA+GXkwtK4Ud/F/Ls0mnak
	bwwAl9N9ESdO8QHFL1HzUAFtmv68A0XRpV+An9k/0q8AK7f2XTm2oVKTe5y8B9dwS0OaUBrnLR4pM
	zWnbyCinJ2kdqCT04WskFIdswV/dOrfw6ZayVzRBIAx1QzSFgf6qoF3s2uGi9Lx3pV6HmjwtiIEzH
	6Sg8aEwtNHp9NI/BHl57L3r4Mu9Urll1kTILojghD37KPPqnsJZT537DUVc1zipTe1IURAL5jZ0pP
	3aRCV6KWqTheki1ADQfhNUoIaJb4NpmEO6Luf1VDOGoQmUr+fEHuQBqvuxoC540V8W0BC1XpNO4cp
	/T7YXIlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petka-00F9rI-2Q;
	Wed, 22 Mar 2023 08:23:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petkY-00F9qT-2P
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:23:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A30E868C7B; Wed, 22 Mar 2023 09:23:10 +0100 (CET)
Date: Wed, 22 Mar 2023 09:23:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322082310.GA22782@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322002350.4038048-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_012314_931265_28B56E99 
X-CRM114-Status: GOOD (  11.72  )
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

On Tue, Mar 21, 2023 at 05:23:49PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This is for mostly for testing purposes.

I have to admit I'd rather not merge this upstream.  Any good reason
why we'd absolutely would want to have it?

