Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC67EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 07:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYOFqLSRHAu5MLd25PfQDPMyHFmuHVY7VvwHCUQMTwQ=; b=GPc7nr2R2gTh7CO5+H26UmWrc2
	CsI5qGXHu9ZLyRzrM/5u6NqMvXwZaXIur+6V0bii0xgOBb1xZABTI5VC3qKWsGOYGwz/7vFWQS4Qt
	oSrWUN2SQfMmUtNXggUD6KZcR1dS5ubcqLKnSdH6SJqr+YvQBxizUS80A40iGh+HUxN12Mz4KPo2B
	a1nb9JlowWxFuFH26b6hXf1bt4locSR6ZyP6yGcdC8v5C0Wet3vTTxcSBpj2S9x3wM0TMfjeWN3nh
	j6qiOaH8BL9xueMRjELUmvPKaGsXoMfakH2zPrjyiSk0/BzrlFy0LLRbX8WRMSRbQC3Guj+VpgV76
	2n0XnSOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n50pW-00E4Q2-P9; Wed, 05 Jan 2022 07:35:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n50pT-00E4P7-6H
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 07:35:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 64DA468AFE; Wed,  5 Jan 2022 08:35:22 +0100 (CET)
Date: Wed, 5 Jan 2022 08:35:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Message-ID: <20220105073522.GB3524@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211227164138.2488066-3-kbusch@kernel.org> <20211229174602.GC28058@lst.de>
 <20220104193807.GB2666557@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104193807.GB2666557@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220104_233527_404191_058FBDF0 
X-CRM114-Status: GOOD (  13.88  )
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

On Tue, Jan 04, 2022 at 11:38:07AM -0800, Keith Busch wrote:
> On Wed, Dec 29, 2021 at 06:46:02PM +0100, Christoph Hellwig wrote:
> > I wonder if a restart label here would be a little cleaner, something
> > like:
> 
> On second thought, this requires another check that the *rqlist is not
> NULL before 'goto restart' since the safe iterator dereferences it. I'm
> not sure this is cleaner than the original anymore.

Ok, let's stick to the original then.

