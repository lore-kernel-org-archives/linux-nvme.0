Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F401C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 06:36:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9CF60C3E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 06:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9CF60C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sGWYgmhwlTU4+FKyvs5yI/WEhYxDb7ID0OJL2tmiLwY=; b=klDkXUPSWB0w2dKpa/iqnv2p3
	1YXXGnplHI+ojMwAvTYW7m2Hx33NS2BqbnZHs4EcPF9VeZgKyCGOGmEvpLffnUzPFWGgFaay0St43
	YbKVUhfnyuGve2fElepALDDARMXxpHvzStbf9kg2RIa4NZLlXO0TR637o6YaOjZJ3r8XaxBATyGs5
	lnTJtsnY3cgscBfS/iIryJDLzIl9wEuYczHtMpqv4rBpMsyw+nUqo/XPmbEpQGuJRb4q5m79dSGM6
	QATxhbY6FPDwuE3/kPspaN9qQKMyyrrsKS36nFsyRsCYtlua9OQ2bFJPuKaVBQPA5WbRLTnYQRLSz
	DZHHwre+g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSDPN-00C6vi-Ow; Fri, 02 Apr 2021 06:35:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSDPI-00C6v3-6X
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 06:35:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4153A68C4E; Fri,  2 Apr 2021 08:35:40 +0200 (CEST)
Date: Fri, 2 Apr 2021 08:35:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v3] nvme: Fix handling of large MDTS values
Message-ID: <20210402063540.GA5570@lst.de>
References: <20210402013907.10131-1-bvanassche@acm.org>
 <BL0PR04MB6514CD8EA0289C5C52A1C47AE77A9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB6514CD8EA0289C5C52A1C47AE77A9@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_073548_519851_AA922FDB 
X-CRM114-Status: GOOD (  22.10  )
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

On Fri, Apr 02, 2021 at 05:00:58AM +0000, Damien Le Moal wrote:
> On 2021/04/02 10:47, Bart Van Assche wrote:
> > Instead of triggering an integer overflow and undefined behavior if MDTS is
> > large, set max_hw_sectors to UINT_MAX.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> > 
> > Changes compared to v2: reduced the two max_hw_sectors = UINT_MAX statements into a single assignment.
> > Changes compared to v1: removed a dev_err() call.
> > 
> >  drivers/nvme/host/core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 40215a0246e4..87d43309742b 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3123,10 +3123,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
> >  
> >  	atomic_set(&ctrl->abort_limit, id->acl + 1);
> >  	ctrl->vwc = id->vwc;
> > -	if (id->mdts)
> > -		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
> > -	else
> > +	if (!id->mdts || check_shl_overflow(1U, id->mdts + page_shift - 9,
> > +					    &max_hw_sectors)) {
> >  		max_hw_sectors = UINT_MAX;
> > +	}
> 
> Nit: this could be rewritten as:
> 
> 	if (!id->mdts ||
> 	    check_shl_overflow(1U, id->mdts + page_shift - 9, &max_hw_sectors))
> 		max_hw_sectors = UINT_MAX;
> 
> More readable and no unneeded brackets. No ?

I'll just fix this up when applying the patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
