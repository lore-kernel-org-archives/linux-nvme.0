Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E68C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:24:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DE020722
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y/U4odDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DE020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZSeY6em203mG+fuQUUBwHsEDsAf/k5Ja7MJ+k6FbosA=; b=Y/U4odDBk62Iqc
	MXU6o4u7GoqGI2CBRzPm71ozKAe1F5w0VeH+80/LeAVGHAkXkrbipcL4TQEBD9W/gHiksriymgKUE
	79eiZGh5ddfx6Qd1JVZA74ydg/ku5Jc9+yLpGFFfkSy5ORZwJaMioRelMcthzKOKxKaQDCE/X7EYW
	sL2akUfVEmc4MPiNUHremt8KGk0kZN4GREb6psqE6KcKB60w3oy72hFyvUIhvJKYXGZIcpIBBxOe9
	LDkLiCrJB20j6NzjQvWoIov6GADwTph62ohRF1yKNLOOfIABYJYoT7OqVTpLxP9gLwRCQq5oiY5n1
	uGsR/y8Xd8ed9PgLgVgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZddS-0001Uu-7q; Tue, 26 Nov 2019 16:24:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZddP-0001UL-Gu
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 16:24:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C885768C4E; Tue, 26 Nov 2019 17:24:12 +0100 (CET)
Date: Tue, 26 Nov 2019 17:24:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Message-ID: <20191126162412.GA7663@lst.de>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_082415_712070_D7D8FBBF 
X-CRM114-Status: GOOD (  10.95  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jen Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 John Meneghini <johnm@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 27, 2019 at 01:05:46AM +0900, Keith Busch wrote:
> > +++ b/include/linux/blk_types.h
> > @@ -84,6 +84,7 @@ static inline bool blk_path_error(blk_status_t error)
> >  	case BLK_STS_NEXUS:
> >  	case BLK_STS_MEDIUM:
> >  	case BLK_STS_PROTECTION:
> > +	case BLK_STS_RESOURCE:
> >  		return false;
> >  	}
> 
> I agree we need to make this status a non-path error, but we at least
> need an Ack from Jens or have this patch go through linux-block if we're
> changing BLK_STS_RESOURCE to mean a non-path error.

most resource errors are per-path, so blindly changing this is wrong.

That's why I really just wanted to decode the nvme status codes inside
nvme instead of going through a block layer mapping, as that is just
bound to lose some information.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
