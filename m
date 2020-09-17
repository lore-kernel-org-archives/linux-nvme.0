Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01022C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 05:48:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8711220770
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 05:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZlR7d0eB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8711220770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5L1OfPuD6uIlYbg5TWn7EOMhET3Ocs62pMn/vr6UJ7U=; b=ZlR7d0eB2+X66hRShPG7fZVtV
	2MfmifmJylUkmUGz/dycVumxPvspp2smn2havdh0dFv+jrR6P+K1sLttVVNqNb2Ui0DyO241rsSaG
	ScDKyjktt3jk9d/qYZN7+SmjSXbgv1HuXEiOx4uBfSxq/bGS9ivOA+xXoHu3ze32CqhhH+muog6z5
	Tha1KY2Xb7d64E8/tOGwaKiZSIW5Y+ovdweMC40c9mYwBWgR5SsTrxTleWmXiQmYDhh9HYUBNA3Oc
	oZTptgL7JEfdWBcel63VHk6km5XxYDqpb9ROzfPeLfA9zzQL79G/9J/zimveC1rezKiHioNcb8Xxq
	5SxTAdFeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kImm8-0000y0-5U; Thu, 17 Sep 2020 05:48:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kImm6-0000xQ-1X
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 05:48:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A398D68B05; Thu, 17 Sep 2020 07:48:02 +0200 (CEST)
Date: Thu, 17 Sep 2020 07:48:02 +0200
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme: translate zone resource errors
Message-ID: <20200917054802.GA31594@lst.de>
References: <20200915181230.3674743-1-kbusch@kernel.org>
 <20200915181230.3674743-2-kbusch@kernel.org>
 <CY4PR04MB37511B210DF4E12A481E0268E7200@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200916210054.GB3676296@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916210054.GB3676296@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_014806_189319_408E55D3 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 16, 2020 at 02:00:54PM -0700, Keith Busch wrote:
> I believe it's safe to use for the completion side since the special
> handling is only for submission errors. But I agree this type of double
> meaning could invite confusion. I'll send a v3 with your suggestion and
> we'll see how that goes.

Two remarks:  Can you include the scsi patch for Damien so that ZNS
and ZBC/ZAC are handled together?  Should we use a separate status
for active vs open zones?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
