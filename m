Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE8C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:14:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E8465127
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E8465127
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uaSiHKGKHcoVn/L0zFS++cEBdsDEkopu1Mx9OVXB2dQ=; b=DUsqYfS0Mu/oqKAPFcabGo8po
	C9kH0l8E+j0o8S+TriUw402vaT6vVZS5z1uyESkq1Lycg09z3Yd5j6SmgdDDIuUVnrtwVIBEhtBPG
	CEa2Vok52YjuCs/xcJT9IGxHe8dYBIvaNlLbVdR/qKZu1+SoqBd8bQfXp9vS3T4yL0466yo6m56yB
	Fol1DEQwB5NEBir1bBsXzZEb2jKuj4b0m7UH8R76/EGl3Ww05SC50OkTneHooet1KTFNsGAUD16EF
	jwpe1NdyGaB4K6nAX3uwQ0WHUUcK68GQ6MLpkdSBt/B98Zwsrzfwc/mDMAVnoAwKJqfjnGLcFLQVo
	aKOKUQgRQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMECl-001aKC-7J; Tue, 16 Mar 2021 18:14:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMECe-001aHa-K8
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:14:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E220E65127;
 Tue, 16 Mar 2021 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615918437;
 bh=OEqOAInJbBo0cpiKAP0ohQE7QeXZONtE8zaNGLl7RSk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mb7NFMd09823nh2rLQhUJO3bPy933ar0QoQnNYIQNlZwFvck6d0uNc0t1TiLS8y3O
 VPsIhrH1+Iqc8eHuAUZh5A/e2L49HG0mDW2bMmm/eO4nj8BW/xnhumqCLQ8vqxKVrH
 SgCFVek6+9n3nKb3tdNTYSi79altKzlNttDt0/RzqR3WVAeYi9aaR/57yhniGpQYVJ
 18jcuTcBKhOyRuJN0psJtXNuoElecWOGlqjeWDgr8vLCFjJIDAxoxda/LyCSqdF2WB
 ZvDkk/fylpbqEUyP7Ciq5gsGx3WIrsWG+S9LxK1FEGxMLWzGVoMLZXhWHwy3VyetQZ
 QarEKPKKqiWbA==
Date: Tue, 16 Mar 2021 11:13:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] nvme-pci: allocate nvme_command within driver pdu
Message-ID: <20210316181354.GC4161119@dhcp-10-100-145-180.wdc.com>
References: <20210316170632.4161183-1-kbusch@kernel.org>
 <20210316180255.GA30086@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316180255.GA30086@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_181401_207190_9B09D965 
X-CRM114-Status: GOOD (  14.76  )
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

On Tue, Mar 16, 2021 at 07:02:55PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 16, 2021 at 10:06:31AM -0700, Keith Busch wrote:
> > All the nvme transport drivers had allocated the nvme command within the
> > driver's pdu except for pci. Align pci with everyone else and replace
> > the stack variable with the pdu command.
> 
> At some point in this series nvme_request.cmd should become the
> actual structure instead of a pointer so that we can remove this
> indiretion.  I'd be tempted to just do this in the initial patch,
> but I'm fine with any kind of patch ordering.

I tried to start off in that direction, but had some trouble. All the
fabrics drivers embed their preallocated command within a larger
protocol specific payload, so we either need the indirection or have a
copy of the command.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
