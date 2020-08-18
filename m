Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC8C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:33:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6372067C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bv8JLF+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6372067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jqEjlXT7t/GhtraKxBmVg2Y5pPB6ym7hk/7bSqwTOz4=; b=bv8JLF+7bNokDbwTaVFTpBjQK
	Cs3hwux4exAEhEkChtfBpz7JbsuqeSt0mOX5KcUyT+Ws1a+j4c9QLgL5Q5XGoBZSBehWNJYZhiaZH
	5Wt0AakVppAMtfkUALOj4VCGduyekxQTNkIb2LaYtZurw1Q8N/UGVgki08r9ZYBz4jSuclIWIK9rE
	GOnOIhqyYTpuReIGR0mI3Icrz14EY7+Ft0Y7ubNf3+KLLX4kjan4Ft4HQGIvJ+rI1X2jhBHUhULPi
	HarglR40ER2Si+B8WxOhgoveVQHvnmgA6UYyZysoHsKqnmiQu55r17ghKU6SoZhdfDZJC0wXH5z18
	CfqIviOzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vC1-0003zL-6Y; Tue, 18 Aug 2020 06:33:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vBy-0003ye-D6
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 06:33:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CEE0968AFE; Tue, 18 Aug 2020 08:33:52 +0200 (CEST)
Date: Tue, 18 Aug 2020 08:33:52 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: Re: keep-alive timeout zero value
Message-ID: <20200818063352.GE1754@lst.de>
References: <MN2PR19MB30052F070D1839045AB6468DEE5F0@MN2PR19MB3005.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR19MB30052F070D1839045AB6468DEE5F0@MN2PR19MB3005.namprd19.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_023354_581973_7EE20874 
X-CRM114-Status: GOOD (  11.72  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17, 2020 at 04:19:36PM +0000, Engel, Amit wrote:
> Hi,
> 
> keep-alive timeout is allowed (by spec) to be set to 0h
> In this case, the timer will be started ('nvmet_start_keep_alive_timer') where ctrl->kato = 0.
> This will lead to an immediate timer expiration
> 
> We thought that in case of a zero keep alive timeout,
> ctrl->kato should be set to a default NVMET_DISC_KATO value
> (core.c , 'nvmet_alloc_ctrl')
> this way we will avoid stating the timer with a zero timeout value
> (This is correct for both NVME_NQN_DISC and NVME_NQN_NVME)
> 
> What are your thoughts?

Yes.  Can you send a patch?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
