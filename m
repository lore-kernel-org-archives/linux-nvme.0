Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBEDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 06:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALuWy96hXKdkA6htpHu9kbleriFA66PcgtRJq3nTaE8=; b=K/6OwxMbUvILn967z0Re1DXkN4
	oUvufUyZBzNzYwnWBrTdh4SkqPps3W6LfUpvouqdYvj/tahqu8Ur5FMNanEhE27vOOqDdTXzLYeC5
	RAZ2slyFhzdT6n2FrQbr8hVHM0rf8YzpNci0+1q5vyaoJsiJcTky0WAcWnvSeGFtqNpXmvZan/FYI
	VOpkmP/dnLuj9hYMe2dq6IPcJvTTF4WW6rBwoUuto11iCYqFa4SvTWXBHh63Z/1q8Vp7sAWyrgAlh
	yoflDCeRLzm5AVu49S3QAZ16ESZtTzHGX/1lmm+vap7sr/G6z+CbfgInBe0odB3WSGbkl98UPVbix
	/h2sJsAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny6QI-00HLCT-6q; Mon, 06 Jun 2022 06:41:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny6QF-00HL46-2g
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 06:41:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFC3468AA6; Mon,  6 Jun 2022 08:40:55 +0200 (CEST)
Date: Mon, 6 Jun 2022 08:40:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefan <stefan@pimaker.at>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220606064055.GA2450@lst.de>
References: <6d463ee2-62d6-e36c-7059-af7fbf8639c8@pimaker.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d463ee2-62d6-e36c-7059-af7fbf8639c8@pimaker.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220605_234107_301963_3AF5C9B7 
X-CRM114-Status: GOOD (  14.90  )
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

On Sun, Jun 05, 2022 at 01:58:07AM +0000, Stefan wrote:
> Ran into a boot failure on my workstation today and I traced it to this
> commit, reverting it on v5.18.1 makes it work. Quad-nvme boot raid.
> 
> I saw some follow-ups adding quirks, so I added NVME_QUIRK_BOGUS_NID to my
> drives (1cc1:5350 for reference) and that worked too - if this is ok for an
> actual patch let me know.

Yes, please send the patch, the controller reports a non-uniqueue EUI64,
the rest seems to be not reported at all and thus actually ok.

