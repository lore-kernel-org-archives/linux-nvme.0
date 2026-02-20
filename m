Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8888CC56206
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vn/NiemWnDH+f/sF0poi6b0v0cIRyIEqcAwZGzyzE9s=; b=KS5Q4j//qyIoTFEx6woF7RI2t1
	omlxpbg4iVQXjoSoQpo0EvpGKlk8Ghq2D11hNUVPjYL9wFBzMHaL2f0gzcin70FUWeDF8/0bNHJ9M
	AuEg4g5sJkoEGAIyIN7vsAeEv+yo5FMY46oQUsPwg3fKY/ZGsLyzeUtZ3MZoGL4SCpJf52of8JHrk
	GBP/sq/rYzZySDSFzx1Knok0+yBUTMgOfgkr3ruPLjS2kiwJVqiIwjkl1H3Ny/lKUxskgDdw8SATh
	Xbfnilk7B3e4w2634i2LUETvB8qonIIOifxyiS9tSMcSJKJJNB0D2RvlehIww2nyfeIDZ1cfiflha
	v7JaWWgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSUp-0000000F2D9-2shV;
	Fri, 20 Feb 2026 15:32:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSUm-0000000F2B9-3ii6
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 15:32:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7852868B05; Fri, 20 Feb 2026 16:32:37 +0100 (CET)
Date: Fri, 20 Feb 2026 16:32:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Abdulla Nasirli <nasirabd@fit.cvut.cz>
Subject: Re: [PATCHv2] nvmet: lift blocksize restriction to 64k
Message-ID: <20260220153237.GB14359@lst.de>
References: <20260220151259.20372-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220151259.20372-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_073245_071990_0B4EBFCC 
X-CRM114-Status: GOOD (  12.11  )
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

On Fri, Feb 20, 2026 at 04:12:59PM +0100, Hannes Reinecke wrote:
> With commit 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
> we can now support up to 64k block sizes, so lift the restriction on 4k for
> file-backed namespaces.

Still not sure this is a great idea by default.  Yes, modern Linux supports
64k sector sizes, but even then just for a few file systems.  And this
changes existing setups, which will now break when upgrading the kernel.

This needs an opt-in.


