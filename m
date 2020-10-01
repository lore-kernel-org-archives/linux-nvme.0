Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A64CC4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 17:15:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5666A2085B
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 17:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f5O8yOQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5666A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+pzb6Yu/IHeSvbeHCVM0Fsr7vtYYuebLne/WkWwHNMM=; b=f5O8yOQYHgTPPTxaUtdV1owO5
	nXJiL9IsZw+niGMuYE8lY16dUHr5w4RgzYKTUiaDuwrjpycZtBoLrA9ch93fu6KiSMBuDGL2MDP2o
	I5HD5tg6BvSWceGwj70RLMnf6ClWsFkOcYkK3j7ftpMPLcXpMawfOtgk8ehdIkmbfqvIjDxB1ECIZ
	pQ5kyj/FwcUMoHXrk/e8LlkJHyoozIv4RsIc9NJuqq3+qM0x7aXGMXcjhKbQL8WjSCiSmsOoN7V+T
	zzuwXlDHVGW+TGiJvRRluTBe1CndZjbFKht4tHmMu7Vhl9A1U0k+oT9WTfSnuZ1JbwB3ne9Cq6MpV
	EJzRTR4tg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO2Ac-00064H-FH; Thu, 01 Oct 2020 17:15:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO2Aa-00062F-Dx
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 17:15:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A871168B02; Thu,  1 Oct 2020 19:14:57 +0200 (CEST)
Date: Thu, 1 Oct 2020 19:14:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 17/20] nvme: query namespae identifiers before adding
 the namespace
Message-ID: <20201001171457.GA29475@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-18-hch@lst.de>
 <20200930094411.GA189371@localhost.localdomain>
 <20200930100453.GA191465@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930100453.GA191465@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_131504_626350_27881EE6 
X-CRM114-Status: GOOD (  18.19  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 30, 2020 at 10:04:54AM +0000, Niklas Cassel wrote:
> > For the subject of this patch:
> > s/namespae/namespace

Fixed and force pushed.

> > nvme: remove the namespace identifier verification in __nvme_validate_ns
> > 
> > None of the identifiers (including the new CSI) can cange over the life
> > time of a namespace, so don't bother with the extra query here.
> > "
> > 
> > which now seems to have been squashed with this patch.
> > 
> > Squashing it is fine, but perhaps you could add that information in this
> > commit message?
> 
> Hm..
> 
> I now see that nvme_validate_or_alloc_ns() in v2 of this series does a
> nvme_identify_ns_descs(), while nvme_validate_or_alloc_ns() in v1 doesnt.
> 
> I don't see a change log, but considering this, my suggestion that you
> the above sentence from the squashed v1 commit no longer makes sense.
> 
> What was the reason for this change?

Where does this this still show up in a change log?

The isn't much point in checking the changing identifiers, but we pretty
much get it for free, so..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
