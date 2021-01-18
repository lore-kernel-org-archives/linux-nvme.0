Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD66C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:34:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0997206BE
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0997206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8M4ipTM4rZORl/6NChnsFMulxAKVcVyYuPvoaDmvNCw=; b=JhV1LGd0hUsPtN51YedV/VpHm
	SxVJGlbp2CkjpfIENb1rhDU5GjNoDDgLgUMPLWR0uGu8Y6LyeEyvyLpDZbFSfa6EwjmZYyki5sJUR
	zlw3Lasrb/M6B9VHWg//8QwMPrjtJxgCY1bw26FB2FPASQAPqEphqDAV+AAhdkgHYhUeM0fuq01Kv
	qeIACD9zsacYlB3J2DJu2CdiTz3o/GMHvKlE5Z4Y7ePXmmm9OofZ9+pnRrxw8QS1RuVLdB+AFNGkt
	EY0pC9fo8b5DaWgGyT6XBgqnZlT7K8XIiYGAh57yht06vqxsf53R7vZosDUCzHSzySzQV3rjJMFxN
	KphY6K+fQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1ZMQ-0002IZ-Tv; Mon, 18 Jan 2021 18:34:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1ZMN-0002HR-AE
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 18:34:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B3AB767373; Mon, 18 Jan 2021 19:34:37 +0100 (CET)
Date: Mon, 18 Jan 2021 19:34:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V9 8/9] nvmet: add common I/O length check helper
Message-ID: <20210118183437.GB11556@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-9-chaitanya.kulkarni@wdc.com>
 <20210112073503.GC24288@lst.de>
 <BYAPR04MB4965136E54EA80910B9ED43986A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965136E54EA80910B9ED43986A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_133439_489386_7B79BD21 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 13, 2021 at 05:07:16AM +0000, Chaitanya Kulkarni wrote:
> On 1/11/21 23:35, Christoph Hellwig wrote:
> > I can't say I like this helper.  The semantics are a little confusing,
> > not helped by the name.
> >
> Is it because of the name of the helper ? if so can you please suggest a
> name.
> Because all it has a same code repeated in the three backends and it really
> bothers me to see duplicate code, but that just me :P.

Also because it does two rather unrelated things.  Or in other words:
I don't think the helper helps the readability of the code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
