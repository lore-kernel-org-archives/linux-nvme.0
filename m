Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAC9C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 19:22:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50B061440
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 19:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50B061440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ojI8XxfsB7/anu+myf7wYIR237RuWwnFoCabFcPLMg8=; b=HpQkmKwzIPJ8kQ5wnXXR15WM1
	OGzL9k7Ax5WlOGfNPqArcCIXdPQQQIOl52OeJ6TEQ5uS6ueo3eba9CIdtVRBOs8CxIYjD+dOvzY2N
	li8VAl65F99Y9C9oqisJkj64l1XSAc6pNfk/j6x0tjBy/+Xn1hWqQ2mZEkaQfc3ce1XYayJk7ZLGR
	mAuI3EejzzOTuzdDVneuRA8fVdtCKNiK151YA8uQkDKdUAC9d4fD+3pCBWEVD+Au08hDqcLwGzMYY
	4idkteJguQyfkLc89EQ7ZWloF4apxNLfLjqK5Y4Aq7J93JQBzk8HfBVI9nqsJUB0eyQgCB7+Tz0mf
	6aZM/mILQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbplM-0049BZ-QN; Wed, 28 Apr 2021 19:22:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbplK-0049BR-Ms
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 19:22:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6VWeEyAolyUDX8hUX6Bb7oOMX/BbDm8lstDkO6pBkIY=; b=KrIp4W4Wgk6SKrFOxTVPDkTwML
 +FOjE0EbbJV/jovbDUON+LNVmWcGlaQSL8hPGdS6s5b2jkB3BXZDDgMoR8+lnQcjugNcjRGHpHxay
 2Dt3YhWkFh0Y3eX37vwE7gBMPeKWlKCfgekadAEeXrPmx3rc2NG8MDCLipjPbYc9wE5esz4IbYT3Z
 CDflPGqdi01ExoSwQBzJCdVQkrUIwIpyYM/pJo/cc974zqro7kBFzJhvH4DJKgQ45s96Zdkaajjkc
 E0b7TA3yO2km2XK/OK/Zm1DOn/jgnVm4nV1RrqrG9P09EWUwtBvqggV0C/0AKR4oEPH7dcKCa6bma
 cJ+r4xxA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbplI-0008XS-Ao
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 19:22:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39D0761440;
 Wed, 28 Apr 2021 19:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619637735;
 bh=2QMQ1x6FQIP149wbNO5nH5A+azVaw46p/6/5DmOldsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J/5EBDFsA2u0Z4OJ7FAaD1D67pyVT8tFI33F09c9f14MkMKrh5ibaQO/TnQoRe/bb
 07WbcYKyoCW4TK6q++U79v1DWKlRIv/Dw1G/G6hawjBG7/ziT3CHfuXDjEHiPm5F3f
 SPoE4Ns774POYiUwpDTqqYRgeoaa7Q1Cszz1zb1ZPJNee0D9636wlxmsMlnxVhFto2
 bw4nluxFHatqUcyUOWtihvP1vUqH8nbN6rQL1gpD7XxRZTmvOVufk/h55FGYjoUBiM
 vSXHsu9WEjfExd3WphEz2bNYiE4DYuOrrv8g6VWGUAlCH5HlRcHJ3sxdD+8EVEbXDS
 kYWhJbGCSxY/A==
Date: Thu, 29 Apr 2021 04:22:08 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] Generate uevent on namespace AENs
Message-ID: <20210428192208.GA22589@redsun51.ssa.fujisawa.hgst.com>
References: <20210426202842.42096-1-nitram_67@hotmail.com>
 <BL0PR13MB42914E1160F96F3EEFE518009C429@BL0PR13MB4291.namprd13.prod.outlook.com>
 <BYAPR04MB49656A4930E8A4367DFD9AC886419@BYAPR04MB4965.namprd04.prod.outlook.com>
 <SJ0PR19MB45443BABE01370BAC883B32DF2419@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB49655438E37C566A45D4E9CF86409@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49655438E37C566A45D4E9CF86409@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_122216_430526_652FEBD1 
X-CRM114-Status: GOOD (  10.42  )
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

On Wed, Apr 28, 2021 at 06:51:48PM +0000, Chaitanya Kulkarni wrote:
> On 4/27/21 05:03, Belanger, Martin wrote:
> > Hi Chaitanya,
> >
> > I'm sorry, but I'm not sure what you mean by "proper commit description". What is "improper" about the description I submitted.
> >
> > Thanks,
> > Martin
> 
> Commit log is as important as functionality :-
> 
> 1. There is no commit log in the patch but in the cover letter.
> 2. Subject line doesn't involve subsystem prefix.

Also need the author's "Signed-off-by:" tag on the commit.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
