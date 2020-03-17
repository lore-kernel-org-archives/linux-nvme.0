Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F428C10F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:49:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEE2205ED
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 12:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sG9cg+Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEE2205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/RINMTE8deBtRCmI9v0cgTJrxuOSMpyYIc87xQ2WiBw=; b=sG9cg+KbulPPab
	8TCKebgK7GqNlgIpCkPdj09GeidxQd0HQAxsCVd4pZTBXjljt7qY/FOF2u1Jxj1eR1RAy/PagEucb
	SqdJPHMY8UbWSP07UmLVcSACOYBCYiUEha0jfNijcMcOm+i/9nB1RwXaNSAenV0tdQHlWJ/3taE9Z
	pA/Ww/6aTSfHqQt8VrFq/VYM24zYpog/R8TAd32sg2+ZTBgc5udYmNXg4P1igRzV2Hl2Z3zV/L9sg
	5CL79Cx7Nvk5FXzGALf+KO1Oy4Ho0ExNKcXtNXlCoA9MvJME8eBtVhgnADr9dSLQ2e2amHihUg0si
	mqh3/4JDlbnYZlvt8k6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEBeu-0007J3-Nq; Tue, 17 Mar 2020 12:49:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEBes-0007Ij-M0
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 12:49:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3240568BFE; Tue, 17 Mar 2020 13:49:20 +0100 (CET)
Date: Tue, 17 Mar 2020 13:49:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: stop mad sqsize increasing and decreasing
Message-ID: <20200317124919.GD12316@lst.de>
References: <20200313124410.39193-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200313124410.39193-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_054922_865874_19906870 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 13, 2020 at 01:44:10PM +0100, Hannes Reinecke wrote:
> The NVMe spec only states:
> 
> "One slot in each queue is not available for use due to Head and
> Tail entry pointer definition."
> 
> It does not say that the actual queue size needs to decremented
> by one, it just means that we'll have to leave one slot free.
> So kill the mad decreasing and increasing of sqsize, leave it
> at the specified size, and only decrement the tagset by one to
> ensure we leave one slot free.

Not sure what is mad here.  All the *qsize values are 0s based
values on the wire, so the on the wire value need to be one
lower than the proper value.

Maybe we need to0sb / from0sb helpers to document these annoying
things a little better?  (%#^#Y@$ NVMe designers for burdening
us with this bullshit..)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
