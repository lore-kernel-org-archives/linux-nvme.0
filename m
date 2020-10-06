Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FCDC41604
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 04:58:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA6420782
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 04:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nOf5hxyV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCVMV8Qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA6420782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SbtuPKllIfVx8ucunzX7NL1/tgnXYm5TLnFWIY2Ts3o=; b=nOf5hxyVWN2BpNL0Xn4n0oy2c
	ov7Yh6Lr5Lc5AhCsnOFwg+TIDRlVP7Gm7AVcqQ8INJMAcpS2KkqHSYyk1MhXjvvcUfBxwPT31HCiO
	QRMs9Khc3pE4Ki0wYDWVR4LYb5yrPzyONd47N4BDTxBd2t1enwcLviIM+ItuaZ6pd2HT2hnvOQY8q
	ypcluMN5BAFb+g7ekFmuWM614nttsPZ+Tcs4/KtyFpMoHdhMupA3juK9TDcFPykX8EbdorPOzySj5
	sPYYcGVxFq9NRy3jzg/HyDMKWtSdnj0fVSZ3TA5GC7s+3vWRbWfFRNz+5My/sOpGpbLwtGANPLm5u
	BqOWqnNsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPf3A-0000XM-Rm; Tue, 06 Oct 2020 04:58:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPf38-0000Wt-Cg
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 04:58:07 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E71420782;
 Tue,  6 Oct 2020 04:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601960285;
 bh=No65u2z/JLmabKggIX1FzjIr8Y3OJWVr8Z7RrHC8IFw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BCVMV8QidVPtXU/OPsTicNP4Q6mD9B4onOLF+uqkufelA+VRt6KPk+l6FfiVzSm0d
 5jZqO2v+jiO0U3wh7ZjBC2vC7BBBSL157sXRkHPgF1yhRUDmDbs9GOULCZOeRWa+Fn
 DkqtE+BNDb3cZPJgUPH1Ax0pIKs2VzcQDDGY8qbE=
Date: Tue, 6 Oct 2020 07:58:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
Message-ID: <20201006045800.GE1874917@unreal>
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org>
 <20200929102046.GA14445@lst.de> <20200929103549.GE3094@unreal>
 <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
 <20201002064505.GA9593@lst.de>
 <14fab6a7-f7b5-2f9d-e01f-923b1c36816d@grimberg.me>
 <20201005083817.GA14908@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005083817.GA14908@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_005806_526039_533CDE11 
X-CRM114-Status: GOOD (  24.28  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 05, 2020 at 10:38:17AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 02, 2020 at 01:20:35PM -0700, Sagi Grimberg wrote:
> >> Well, why would they change it?  The whole point of the infrastructure
> >> is that there is a single sane affinity setting for a given setup. Now
> >> that setting needed some refinement from the original series (e.g. the
> >> current series about only using housekeeping cpus if cpu isolation is
> >> in use).  But allowing random users to modify affinity is just a receipe
> >> for a trainwreck.
> >
> > Well allowing people to mangle irq affinity settings seem to be a hard
> > requirement from the discussions in the past.
> >
> >> So I think we need to bring this back ASAP, as doing affinity right
> >> out of the box is an absolute requirement for sane performance without
> >> all the benchmarketing deep magic.
> >
> > Well, it's hard to say that setting custom irq affinity settings is
> > deemed non-useful to anyone and hence should be prevented. I'd expect
> > that irq settings have a sane default that works and if someone wants to
> > change it, it can but there should be no guarantees on optimal
> > performance. But IIRC this had some dependencies on drivers and some
> > more infrastructure to handle dynamic changes...
>
> The problem is that people change random settings.  We need to generalize
> it into a sane API (e.g. the housekeeping CPUs thing which totally makes
> sense).

I don't see many people jump on the bandwagon, someone should do it, but
who will? I personally have no knowledge in that area to do anything
meaningful.

Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
