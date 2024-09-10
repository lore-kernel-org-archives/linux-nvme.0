Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E6BEDE9AB
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixrlv3tZtoXEaPzIH7qeYoEDfnmLzucZfZkOQExt82o=; b=iEgMb63Z+Zb/AGiee1M7YO7pOX
	lHs76vVNKkONDhAk73KCPAP1ea25qtjpOTXBs5kP1YXVn0Cmj8C86zRsP2+MMRoGKedKPh1XWbttz
	XXMWeoc25vMjL4/wGf/cN3v5xyU+P+4cedyOXavkntKZAM/OWtFIh3jnR872/87187V8HyOFmiOq/
	oMEYKmUC9+hN3BUgl4+oXr76mjgipSl0IIP2uIOaDbPFjpI2uJ0B4OzI+KOJkRd8OseP8sh3zkdz2
	hX+/RvYbls+nfGeVlZAY4PPRLCmg4IFFtroaGJ8uzjW8RKF8RbmKVjOi7K2vyDHUi/eAy09h2FCgt
	D9gF1+ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so4Wg-00000006W35-0Ijn;
	Tue, 10 Sep 2024 17:19:38 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so4Wc-00000006W2H-2ZBM
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 17:19:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5364FA44718;
	Tue, 10 Sep 2024 17:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B28C4CEC3;
	Tue, 10 Sep 2024 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988773;
	bh=Jc2puORiYOo6/PGjGJmiUGrpWVJCAW6zaHCUDlRoGBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YranuHzJ9O+PkhMM3y3l1AnOorUXlqQcyQwRVZS/I2MXrKLTxkSEksGcflLatAMsC
	 4/kt+ZrS9ugZZ9yVCSCvuhUSfP0poZrCz3oE97PAhK2UkTim4klKquEY+Kx01d9X9P
	 MvCOFl3/enrM4UlnoDdDOSM9NgREXE+5+P7lrmPf/5NK5SLZsdp+OL80v9z7QjeYgd
	 M85c3CEG05kKH67y3PR4hAuE1wgiEMe8n3A2InyDWc/2cno2zny4TBHcSFAzSp+RPw
	 qv2w+atYYdvYmpvf4/NkCptgGCEREaftSw2v9ngdba8BKIEDs4cwpRrqe0+7h6BlnY
	 ghHs1MsCCVZVQ==
Date: Tue, 10 Sep 2024 11:19:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv3 09/10] blk-integrity: consider entire bio list for
 merging
Message-ID: <ZuB_ok2gkamg2_Sl@kbusch-mbp>
References: <20240904152605.4055570-1-kbusch@meta.com>
 <20240904152605.4055570-10-kbusch@meta.com>
 <20240910154843.GI23805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910154843.GI23805@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_101934_732171_33EFEAB6 
X-CRM114-Status: GOOD (  15.55  )
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

On Tue, Sep 10, 2024 at 05:48:43PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 04, 2024 at 08:26:04AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > If a bio is merged to a req, the entire bio list is merged, so don't
> > temporarily unchain it when counting segments for consideration.
> 
> As far as I can tell we never do merge decisions on bio lists.  If
> bi_next is non-NULL here it probably is due to scheduler lists or
> something like it.

I think bi_next is always NULL, so the unlinking should be a no-op. But
just in case it isn't, the current unlinking will get the wrong segment
count from the resulting merge.

