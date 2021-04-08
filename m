Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2BCC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 16:47:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70688610D1
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 16:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70688610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/FY9fB/QrfZYxHf/FtHjplkeMJxqyw6Xd7driv8YNeI=; b=jXR6/aBVOu3HpSK/Hy/ReDxzL
	yysphv3enVB0ItIJuYEXjQ6ake/DxDetIL0LOjQRwIr0TyI1DhB/Y3Eijqk3vjRG3TvN3TV5XogVh
	ji5VLWKaS6K8jQI3OPQ4fsbjdoMfVZ3OILhdcWf7MVXGrIVRCi2Kt9jo+hCorYqricj38q3wyhZuF
	6oCbigWrB84WAIm5YyUnF95bmJR1AxbnhrvUcwH7/vnqObDAbpJ3dOBs+Gb911w4r28PplbHOjuz5
	KbT3jEhjxgV55Bz3dg1ugNsXTrcSzTbrERJJckA4y1Klaes/Eu3AivICq59skV215Kd+rs0Vtw7U5
	s+WbgAn7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUXoC-008g6v-HA; Thu, 08 Apr 2021 16:47:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUXnx-008g4n-SL
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 16:46:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E228610D1;
 Thu,  8 Apr 2021 16:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617900412;
 bh=jQD8OgVB2CA/DKZIlztRGKpj1cjD5D4UlxdzlzYHeCY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HbRfttNm/7H7NF3KSYWhc4hfxXvmVyP2aN+KF1GcfRmYwSimDkCHucBUsttopqJQT
 Ur+/YUJ34BtbuGTp5Q4Wyn8MgBMIQl5S6AILyvSulvFUbL4WUGKvzlrZJHiU20Vd41
 vgaZLABEo0DC0ylc16DbTZ+ludJImWOJ5YAwxFNoUjUY3F3Y9srU0yeVeqJwnQ0pw6
 fyI48QZ/JA0205Ryu/4B7cawkxj3KXEfRGDWVql8nXfFqIJO0hVmKUuXjGjx4MypCN
 eZMi27LPLUe9OH0Q/zOTs2Ls9FjSlj1AIss+796s+os3DtxGvZq8wVFxGMlS4CPRFe
 Nps7VYhCSp1Aw==
Date: Fri, 9 Apr 2021 01:46:45 +0900
From: Keith Busch <kbusch@kernel.org>
To: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
Cc: Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org,
 tasleson@redhat.com, tbzatek@redhat.com, prakash.v@samsung.com,
 d.palani@samsung.com, javier.gonz@samsung.com, k.jensen@samsung.com,
 mohit.kap@samsung.com, krish.reddy@samsung.com
Subject: Re: libnvme questions
Message-ID: <20210408164645.GA3667@redsun51.ssa.fujisawa.hgst.com>
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <20210407233706.GB32309@redsun51.ssa.fujisawa.hgst.com>
 <20210408075126.GC12847@test-zns>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408075126.GC12847@test-zns>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_174654_601143_8B197D74 
X-CRM114-Status: GOOD (  11.91  )
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

On Thu, Apr 08, 2021 at 01:21:26PM +0530, Padmakar Kalghatgi wrote:
> On Thu, Apr 08, 2021 at 08:37:06AM +0900, Keith Busch wrote:
> > On Wed, Apr 07, 2021 at 06:08:06PM +0530, Padmakar Kalghatgi wrote:
> > > Since most of the companies who develop SSDs, use MI(sideband) channel, we think this will be a good enhancement to the existing functionality which the nvme-cli provides.
> > 
> > Can we even use this from a Linux host? I thought the sideband channel
> > was typically connected to the baseboard management controller.
> > 
> Yes, this can be used from Linux host by having additional hardwares, like TotalPhase's aardvark, Corelis etc, which are connected to the NVMe device.

That doesn't sound something for end users, but okay. Can we see the
nvme-mi bus driver before considering tools and emulation?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
