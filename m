Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB37C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 18:25:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFF3206D5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 18:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LOloPXn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFF3206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=56aDC7mn1mbgJDsOPRZy0vIk5bp5EStptFK1obCu1zs=; b=LOloPXn4LqPFTX2m3nibFoBK+
	nqPDF+yYC5NdPIHdQyzr3bHnBTqTZlaffifsc2WrE6QBq3bAralAQMxbwVrzIBCVBM+XyfBSk+mxb
	u8r8Nzi59TU7IqvOEcbribdFq8jdGIq1mfcmdIXAfyQ3Y+lwTT0Q11iTcreENT2DGCh0mUnylllIk
	uhU5mJi3OjzN4EeK114fn9L4IGkrMnQsOS1+y4LYjCGFQdyiDt7wkOBnxq4110zrsparLpVzy/4Kw
	tnI/uVEAcu6z2Dgf+8cz1AujfeqnLYIeTq1zxX3kTc9JpYNcbaADfjNqyAu4V8N9GWpFP2m5NwPKF
	3/y6SHSqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ka10D-0004Xq-Ms; Tue, 03 Nov 2020 18:25:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ka10A-0004W4-57
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 18:25:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9B2886736F; Tue,  3 Nov 2020 19:25:48 +0100 (CET)
Date: Tue, 3 Nov 2020 19:25:47 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V3 6/6] nvmet: use inline bio for passthru fast path
Message-ID: <20201103182547.GB23300@lst.de>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
 <20201022010234.8304-7-chaitanya.kulkarni@wdc.com>
 <9ba9c9ba-7caf-e24c-1471-62c199cfcd4a@deltatee.com>
 <BYAPR04MB4965980B745F28E069B8460186140@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965980B745F28E069B8460186140@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_132550_389170_ACE0B24D 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 29, 2020 at 07:02:27PM +0000, Chaitanya Kulkarni wrote:
> > I still think it's cleaner to change bi_endio for the inline/alloc'd
> > cases by simply setting bi_endi_io to bio_put() only in the bio_alloc
> > case. This should also be more efficient as it's one less indirect call
> > and condition for the inline case.
> >
> > Besides that, the entire series looks good to me.
> >
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >
> > Logan
> >
> Sagi/Christoph, any comments on this one ?
> 
> This series been sitting out for a while now.

I think the suggestion from Logan makes sense.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
