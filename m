Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F424CDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 16:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZiFfzfDT+TE+Qb/nnQ2O8ZP/C51cp1Nsph8p2iZw78=; b=I08XakkirXX+h52LuAY2g6Rrhm
	coRslcBfAp+UZgbRsX69Q6ikI67VVa/MEJ83aHZYRJ/47tsc89pSY/pbv6IrVcBdpp+G3jEHhVXGq
	v0txYdumFJAqw1TIPU3MiCk95OD9qKa84QZrGIT1qZRSQLUhlxds2u0++F/3MANPycyItVV8wG2kT
	RJzaVHH2PzoXlH0rBzup/Bnjl72+owuTqBRsjVMnfkk0uScZcpZk8mDZmnMsZ5ig18ZQYHQ1HaH4M
	VueZtJG1KUU2uTpiBOG46SmR4Xx2lnHJUpg/uPW3nyN4vNXN7d+6KRNrsAapKSfqzM8dGL1qnmR5o
	yb4BflUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt9tW-00FEyP-22;
	Wed, 18 Oct 2023 16:59:42 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt9tT-00FExu-05
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 16:59:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 5B710B823F1;
	Wed, 18 Oct 2023 16:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF4AC433C8;
	Wed, 18 Oct 2023 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697648376;
	bh=IkYp3DutBuwLl41Z00YpjxCEmxZ1n7+3FgHXdVZctgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8ym5s4DfLWNEvqN50hmA0UJHOugIU3Ug57VjUEuikdeG56XrTstmyqCtomviHzh0
	 9erAUWxpPVFDf7xH1ay+be4b9WT87vtZQm05GQZHSv/bNaih3ghoTtfXidmbmXmkRH
	 oEwrxN5M06CRBgXaV/g8d/ywDYXtGe+qurlC1EhBCUDkb8iXIz5SGrN7/ihPfvkeZg
	 FA8aMXOsBnUXRs1nRq9tDcW5KLHuxJmqm3AxWbD89XdGO6/6tmuBKlP/t88XOPSoCE
	 PYhgOz2VoUiQpQ074rF5r0T5byB0H0Jikrz82nmHXhQb0BT9Blxx2AF4fc7Nn1DCWJ
	 JM702u+hWdH3w==
Date: Wed, 18 Oct 2023 10:59:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme: fix error-handling for io_uring nvme-passthrough
Message-ID: <ZTAO9ZVhs_73oP0d@kbusch-mbp>
References: <CGME20231018140334epcas5p128c55c56fb9203a19479cbf86175a1d6@epcas5p1.samsung.com>
 <20231018135718.28820-1-joshi.k@samsung.com>
 <20231018155020.GA26481@lst.de>
 <CA+1E3rLS0y9nZ0Kg1OKf6SX-nLpSps8S9ZHSRSFbPV6STM841g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1E3rLS0y9nZ0Kg1OKf6SX-nLpSps8S9ZHSRSFbPV6STM841g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_095939_242334_B036BF00 
X-CRM114-Status: GOOD (  13.71  )
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

On Wed, Oct 18, 2023 at 10:20:10PM +0530, Kanchan Joshi wrote:
> On Wed, Oct 18, 2023 at 9:20 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Oct 18, 2023 at 07:27:18PM +0530, Kanchan Joshi wrote:
> > > @@ -508,8 +508,11 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
> > >       req->bio = pdu->bio;
> > >       if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> > >               pdu->nvme_status = -EINTR;
> > > -     else
> > > +     else {
> > >               pdu->nvme_status = nvme_req(req)->status;
> > > +             if (!pdu->nvme_status)
> > > +                     pdu->nvme_status = blk_status_to_errno(err);
> > > +     }
> >
> > Hmm, shoudn't err take precedence over the nvme status?
> 
> Since this is for passthrough interface, nvme status should get the
> precedence since that is what we want the users to see.
> Same happens for sync passthrough too (in nvme_execute_rq).

Right, blk_sts_t 'err' will be non-zero on any nvme error status, but we
want to report nvme error status if we have one.

