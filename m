Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9633CC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:02:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35A861028
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35A861028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NuFi4d8IrET1rL3c8L1qC1NmjKmhcjBrZSp5TqcN150=; b=n9DleFilPwXF6b62YkhINw6/M
	n4GLtyFCyphWD4saqsLxqZfefWwNiY1U2pvJhGOwezgqeb52IN74TqDRbXhQtX6sfAYbE76Kw517N
	M0rpr8lTeiPnrc8L+iP3mTr2q2VZIeIG8m8oNfVIwhFcd6lL7Rg+6R/8n2FAbnNc28W/QTRrgIaK0
	5Z6w7R/XbBNch3YwwxR5ldJ+an/79aNXh2H7GNZTaitBg47BWP5lrPrdcRLDFFtzR9MYWRz+a7Xgr
	vB6ap93jYshCY4N381Y/YSb7XW1x9/Mai00kSqehCAwfCGEEuZXXapSyYM1a3DXXi3sT47a9wQZMp
	LPl5vRC6Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihYu-00Fk5m-Qh; Mon, 17 May 2021 18:01:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihYr-00Fk5N-Tw
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 18:01:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=p0HXVuDdR/Rs7d3SsFAzvWjH+r9MYy+PoCzIkBf+Eq8=; b=BB3K7uekSD/6s2YKz+JGJh2Xcx
 5bM8XNtEM8RT7ctJnbxyIeQmlck5NYUMowyXCyemZa8AFhLwSWAb535cmIH5xkvkym6+T1IlGWXWL
 W1De9eIyZB6/o7d1OEtVEQVcD2wR1HMXUDnUpIdXVVkiZar4e5yJQqSTwrrUdifsIAIqbB8/LB7z4
 YiT9mhEx5yhyhjMPD8PGKvmrQ+6XJsEp0iWn/RmHr54OR/J6J3N9oeCPAsBslvp6zQpXgYEvj2yrG
 vupNi8AhkZBs+oZJgZEyST4vtr/qVmHGK6vPLSBvsYvx8nF8oB2l8ORGDUz+BJL2WopVq90wEWnhN
 GicW62fA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihYp-00E2Te-70
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 18:01:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CCD26112F;
 Mon, 17 May 2021 18:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621274506;
 bh=AuewAjUp9gttI2u4lRGS8zocvk3zaICTE3P/Ll+LkwM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aRxkw1tpMfY03nJOouQeq7poSTIGemx76+7q4KCg9DdqbgfoMsmxfc9730Pz6XsTC
 2x0+/eS6F6xrxEy5G4uLeBbhcJMKZ4DarNuWFRmp3o8KwU7rIz/KkxATxD5KM2SDAl
 aNPZXF5VBxskjBmU0VBLxwKQpyYtXjYDEkNRfUvD/dEYuF8Qnz/9aTZUDjnQYEa8/W
 dyMRyAUgnoxKP5bXiEWW/ZIRJ9lqhfHMxPHt89vKYrNJ/SzgGEl5cfm/Ehqfy3TWPI
 Kls2LutX3QqFixiJLOWV24022NOikEoC8Gx0Sm4Kr0/jWWJyz2fTm+OEePt1dw6Gll
 yRdcDzSpTt5OA==
Date: Mon, 17 May 2021 11:01:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv4] nvme: allow to re-attach namespaces after all paths
 are down
Message-ID: <20210517180144.GC2709391@dhcp-10-100-145-180.wdc.com>
References: <20210517081809.104813-1-hare@suse.de>
 <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
 <688618fa-a079-6d84-adf2-01ee36f95d76@suse.de>
 <20210517154942.GA2709391@dhcp-10-100-145-180.wdc.com>
 <4b32451c-2426-c86f-ebc6-9de74e0bbde6@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4b32451c-2426-c86f-ebc6-9de74e0bbde6@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_110147_298448_06E3D8D5 
X-CRM114-Status: GOOD (  33.29  )
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

On Mon, May 17, 2021 at 10:58:38AM -0700, Sagi Grimberg wrote:
> 
> > > > On Mon, May 17, 2021 at 10:18:09AM +0200, Hannes Reinecke wrote:
> > > > > We should only remove the ns head from the list of heads per
> > > > > subsystem if the reference count drops to zero. Removing it
> > > > > at the start of nvme_ns_remove() will prevent us from reattaching
> > > > > the namespace to the correct ns head once a path becomes available
> > > > > again.
> > > > 
> > > > This looks fine to me
> > > > 
> > > > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > There are potential corner cases associated with namespace management
> > > > that can cause problems here, but it would certainly be a user error
> > > > that needs manual intervention anyway. I suspect those scenarios are
> > > > very uncommon too, so I think we can deal with that later if it becomes
> > > > a problem.
> > > > 
> > > How so?
> > > We're keeping a copy of the NS IDs around, so after reconnect the
> > > namespace would have to provide same set of NS IDs.
> > > 
> > > If the namespace is different yet providing the same NS IDs we'll have a
> > > problem even with the current code, as we're using the ND ID to identify
> > > multipathed namespaces.
> > > 
> > > Or do you have a different scenario in mind?
> > 
> > Sorry, I didn't mean to imply this creates a new problem. It's already a
> > problem. :)
> > 
> > This just provides a chance for a recycled ID for a newly created
> > namespace to attach to an in-use head associated with a previously
> > deleted namespace. I am not really concerned about this scenario,
> > though, since it wouldn't work today anyway.
> 
> That is because we keep the device node around even though it doesn't
> have any bottom devices. Which is what I think Hannes tried to fix
> in an earlier patch.
> 
> Also, if an NVM subsystem happens to recycle nsids, it will trigger
> pretty surely. So I'm not sure this is an obscure case...

I'm not very concerned because (1) deleting an in-use namespace is
surely a user error, and (2) it currently doesn't work either, and no
one's complained yet AFAIK.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
