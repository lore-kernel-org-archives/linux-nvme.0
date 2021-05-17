Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7816C43461
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 15:50:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783EE611CC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 15:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783EE611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xlbZj3B/hQSnzd7m2Vx22vpAjzdst1EKEJvixUzGLsg=; b=Ilq9DUzJvxFYj0q1wb3s5CQb8
	b9ytENpDJEyEmnceaSZ9af+MMCzeceIK+XCRt0tMZdAlbDf9oSBJbLV94thqtUiD8mjwFzpL3wDft
	huh8MvM+91ye3SZOM6UPQOp+iaYFVM7V4Ka7jzJRwCWJt8MYWVoPk9WzoOsMLRoKdJna+FVdFMGWP
	KLeRnYwWU4wILAFZ2j9JijoB/YwaY/oDDTcfasErs71uYfKdGXDJ+lyogzQsX9V9ziK77Xyls8xF+
	NJQkJvOBRgDo7HaU5HP9objq7DpjwZX9xYM1i+sf3tnZN3NxzYDlu7JaQxQYKIl1/8lR5Ew6xS27G
	cZHIUiqcQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lifVB-00FTrF-QW; Mon, 17 May 2021 15:49:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lifV6-00FTpg-U1
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 15:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fTP7N7lZ/38b87xmpT/LhBRqsK1+NVn+DVCLJ7uCeSE=; b=DZPYBy0/cj59VHP9Eb1hFPjsYK
 0NnrAsJlzupZIV/u1TQ5IvsXOzSYHkHgXNGvloh9/v2YOL7x75tv3/WE1eh2W7hrGmhlPPTh1DfSm
 /vnNq6OQ4qug87VI8XFDHF9AjrAx7MhoGiad+TUf9UmS4Tp9NEm+6OqPJnSg7/627j/kXfJIc4EhI
 jHpXcFBiNdFvpWHPAHtSQm2PrmPjJA6POSp5l+OsmTg7upOM4jKHa17iWnSl9cuVV+Hq2tPwrQrM0
 Z76iOp2slb/BcJCNA5R5LfGvx48cmJUPPGiAZmMncZ0cvud3in3b9LzipTXTD/Hk0DMXKGS7kxXa1
 FbZmKFqQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lifV3-00Dwkw-1I
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 15:49:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EBD060FEF;
 Mon, 17 May 2021 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621266584;
 bh=726hiXdfkA5LyUICb+Sf7bx8S7i5D7SJgPvthIWEuwg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RE+lDRmUJZbscZPMhPhCKYW5JFhvuKsKSRzzq2TVs8zmFaf/Bgj0iE+OyKbQcyQA3
 lJw9h+V34ipl5QuGpBtvr5l1JwHK0FTmRKqr0zssQ2hy1UYBzG+F16v4Vx3Eed1Y2m
 kplA5PxcTE/nCYdnXFS1mf8rxrvkH2Pop3rXkNvTyzxvLsy16aV/huwSlfx5oBL1Ap
 n4CZSlzYLvK9sMkhwygbr+b0HyG4Q5ezKB3wA+Z2KmfrZCTFOQ8qv5tAq0g3KF3pAu
 CqJ3LmHj+uQew+gxHcSGs2uf/GlfkorjNGg/OdHbXfprbzSeYIY4n4cX+qMRCG5Fc0
 XeKSxHGN3nVRw==
Date: Mon, 17 May 2021 08:49:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv4] nvme: allow to re-attach namespaces after all paths
 are down
Message-ID: <20210517154942.GA2709391@dhcp-10-100-145-180.wdc.com>
References: <20210517081809.104813-1-hare@suse.de>
 <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
 <688618fa-a079-6d84-adf2-01ee36f95d76@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <688618fa-a079-6d84-adf2-01ee36f95d76@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_084945_117016_2F4E2F63 
X-CRM114-Status: GOOD (  22.71  )
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

On Mon, May 17, 2021 at 05:36:39PM +0200, Hannes Reinecke wrote:
> On 5/17/21 5:26 PM, Keith Busch wrote:
> > On Mon, May 17, 2021 at 10:18:09AM +0200, Hannes Reinecke wrote:
> >> We should only remove the ns head from the list of heads per
> >> subsystem if the reference count drops to zero. Removing it
> >> at the start of nvme_ns_remove() will prevent us from reattaching
> >> the namespace to the correct ns head once a path becomes available
> >> again.
> > 
> > This looks fine to me
> > 
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > 
> > There are potential corner cases associated with namespace management
> > that can cause problems here, but it would certainly be a user error
> > that needs manual intervention anyway. I suspect those scenarios are
> > very uncommon too, so I think we can deal with that later if it becomes
> > a problem.
> > 
> How so?
> We're keeping a copy of the NS IDs around, so after reconnect the
> namespace would have to provide same set of NS IDs.
> 
> If the namespace is different yet providing the same NS IDs we'll have a
> problem even with the current code, as we're using the ND ID to identify
> multipathed namespaces.
> 
> Or do you have a different scenario in mind?

Sorry, I didn't mean to imply this creates a new problem. It's already a
problem. :)

This just provides a chance for a recycled ID for a newly created
namespace to attach to an in-use head associated with a previously
deleted namespace. I am not really concerned about this scenario,
though, since it wouldn't work today anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
