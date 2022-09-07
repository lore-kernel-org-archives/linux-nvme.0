Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADD7C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sIydPNQQkR9CkxlhCDiqI0eDR6mp7bdKQZ/QYsrsuMQ=; b=vxrt+8Bm57fdGlZfLFnT2YUjYR
	+yDEA/mJ3KkvjiJuTLvlJdKSja81RdGxmOfu+O5L0HaP4mk+3dUQFPWK1xzoRSehXkM2MT5brliNR
	he0fqxqT5AD4Z4Qb0CKkrnj+UpMG2YIDev2bf7CjicBBCCOdu3GroFvTx97QgSA2z7Y2/Q6OKUJqF
	X8E953ezTc4QtQ0Urj+C2FW98pgZWGGUTTw2Ab9XA21TWgnC4Bym1jISKkhzKq4brg/PsRa7s8hqu
	TO4wqKmh5NtGiQtuDoeujoVyv6jC+gdXZQd7qmhUWX5dlBq+r/RZ3UpAHz5xmAXmie+9LqZ2KEQU5
	MS5KoVnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVz1V-008I2j-ED; Wed, 07 Sep 2022 17:39:37 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVz1Q-008I1V-6e
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 17:39:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A4AC9B81E0C;
	Wed,  7 Sep 2022 17:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E20C433D6;
	Wed,  7 Sep 2022 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662572369;
	bh=BuzOleT2JzdxhmQ2iPJzJbkbvehTEvIDTkiuAiHbr40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmAjL9X7za88Y3VCddS4VeZ7xGe6Q6ijs4zMeCI0lYZiirewuGpE7bcP7iWV76UBT
	 iLemnhHrKU1qcllSmiHX/o+a1gExgUlicJCqka2UnsiukSQ17XDmQ6hWypajVCYawV
	 rPEyHbh9xrJ+VKG9LlU1jjZyI2cPcymQ/ajrSvrrLonZQV7m0oodeBzh54Y8O5Coal
	 UwDzVWyPsa87aKJtZR1dGIED9FcoUziMjmG0fyeuYhiv7l7prFlddCNypVJg1MSwZK
	 TvulHaHktrV3caL1/6rqMuWm9q6t+FtNERW4EVGMICSpYbl4Ort6hMJkzT0kLFDV21
	 ursfr7VYycsRA==
Date: Wed, 7 Sep 2022 20:39:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <YxjXTZY6aihDV2FO@unreal>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
 <YxiTxJvDWPaB9iMf@unreal>
 <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
 <20220907151818.GA26822@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907151818.GA26822@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_103932_412262_84FBF0A6 
X-CRM114-Status: GOOD (  20.73  )
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

On Wed, Sep 07, 2022 at 05:18:18PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
> >>>
> >>> This entire code needs to move to the rdma core instead
> >>> of being leaked to ulps.
> >>
> >> We can move, but you will lose connection between queue number,
> >> caller and error itself.
> >
> > That still doesn't explain why nvme-rdma is special.
> >
> > In any event, the ulp can log the qpn so the context can be interrogated
> > if that is important.
> 
> I also don't see why the QP event handler can't be called
> from user context to start with.  I see absolutely no reason to
> add boilerplate code to drivers for reporting slighly more verbose
> errors on one specific piece of hrdware.  I'd say clean up the mess
> that is the QP event handler first, and then once error reporting
> becomes trivial we can just do it.

I don't know, Chuck documented it in 2018:
eb93c82ed8c7 ("RDMA/core: Document QP @event_handler function")

  1164 struct ib_qp_init_attr {
  1165         /* Consumer's event_handler callback must not block */
  1166         void                  (*event_handler)(struct ib_event *, void *);

Thanks

