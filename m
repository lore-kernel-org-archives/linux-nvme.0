Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F5FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/NnyMcCYH3ANue06RCdIVGNr17cueUOrcz5mmIA7XXs=; b=MhHHJ74//4m8cafTxTPIA6JJVS
	FV+/E0AuOcEvU3Ds8PpvOJgXMRETX3HTn00SJKSOh/e2nN6usATpBwPQ/GNwm7y4Clt/C2VLU7qt/
	b/zoXZh+AOjqxkNwk1lMhLNYnWHyz7FzdsQciZURRrzo80ZN8Q1jOg9gdv6GVB7SRdS7vwCH090zx
	8WogO32OVnWybCGl9skTs3TIo+4ihDs9SJ/Dy2U+ShBmBGKzNUi99bxAjvqMUcyTGvaREPgB/ARhP
	h9Gf/Hkk3oejqtVsUCGRVGV35vvrSvvbNln7qOlarPwqTr8161+ZTdJ8iZ+6svgQjazxVhR7YcSmx
	V1rrMN9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKLw9-007RVG-N7; Wed, 16 Feb 2022 15:09:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKLw7-007RUE-HP
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 15:09:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 71E2A68B05; Wed, 16 Feb 2022 16:09:39 +0100 (CET)
Date: Wed, 16 Feb 2022 16:09:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
 joshi.k@samsung.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: also mark passthrough-only namespaces ready
 in nvme_update_ns_info
Message-ID: <20220216150939.GA18782@lst.de>
References: <20220216141220.4162670-1-hch@lst.de>
 <20220216141220.4162670-2-hch@lst.de>
 <20220216145737.dijq4xgmmn3ky2yg@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216145737.dijq4xgmmn3ky2yg@carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_070943_745622_C85B7358 
X-CRM114-Status: GOOD (  15.88  )
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

On Wed, Feb 16, 2022 at 03:57:37PM +0100, Daniel Wagner wrote:
> On Wed, Feb 16, 2022 at 03:12:20PM +0100, Christoph Hellwig wrote:
> >  out_unfreeze:
> > -	blk_mq_unfreeze_queue(ns->disk->queue);
> > -out:
> >  	/*
> >  	 * If probing fails due an unsupported feature, hide the block device,
> >  	 * but still allow other access.
> >  	 */
> >  	if (ret == -ENODEV) {
> >  		ns->disk->flags |= GENHD_FL_HIDDEN;
> > +		set_bit(NVME_NS_READY, &ns->flags);
> >  		ret = 0;
> >  	}
> > +	blk_mq_unfreeze_queue(ns->disk->queue);
> 
> Do you want to unfreeze the queue also for non ENODEV errors? It seems
> ENOMEM is possible.

We always want to unfreeze it, just as before.  The unfreeze just moves
after the place where we set NVME_NS_READY.

