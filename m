Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33BDC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:26:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0EB6023E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0EB6023E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pNaO3VU1Eiz1BI9NAj8ROjYe6svUCmhvbvep22f06Nk=; b=4a4SvlBqHM3qaO
	RaQSI36PnPEVuyxZ5p7T/BjG7xmMhg41MkAmTWGlZqQD4vf7a4+QkYXdzy0sPsvbArr7EykeWYQRb
	evZ5lpQ8nGHVf4sDaCFcjIEozkfyXC0R2pAjZnNbc9RrDoAnt3XRBwV3MF1HbSq6phT+Zbo39ah4t
	1U9BOvOBcllGHnLeVcgTFYgLV0GqaZEEnQ/3+jvGUK4qCsvD5wfBDnTbnwxI3HudsqeFWIHZuic5t
	4OCU2qRO02H6afPgXJ2pUYXV6Gt95nGb8MSaGkl+e56BGgs9fb1c2AciwBaXOK1Z0fwxp5PRA3o/R
	80HKg7ln3pPpzP47zveQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUGC-006Xar-GF; Tue, 08 Jun 2021 05:26:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUG9-006XZz-U9
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 05:26:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EC1E267373; Tue,  8 Jun 2021 07:26:39 +0200 (CEST)
Date: Tue, 8 Jun 2021 07:26:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough commands
Message-ID: <20210608052639.GC13828@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-3-kbusch@kernel.org>
 <CA+1E3rJM3sGLsOuPbYVH6kaTR8S9ogfe+wryuyWpqnA-pgDsEw@mail.gmail.com>
 <20210607161512.GB21631@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607161512.GB21631@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_222642_143299_98E8C84F 
X-CRM114-Status: GOOD (  12.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 08, 2021 at 01:15:12AM +0900, Keith Busch wrote:
> > The new code doesn't retain this flag.
> > Looks good otherwise.
> 
> The flag is only used to select an apporpriate hctx. We've explicitly
> selected a polling hctx in this path already, so the flag is
> unnecessary.

I think setting the flag would still be useful, if only to prevent issues
with new callers and/or better document what we are doing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
