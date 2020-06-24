Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 03:07:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139E520CC7
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 03:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q1O58gkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139E520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cw5Ob5VeM7jApSV8aFd5dKwkpT01mYwThDj5wo0Z1sQ=; b=Q1O58gkVWLrhuppCT3q2u7+Fbn
	dwW9TD00ShvHnYAHw4HV9ldd4iQtTFbmTD3r2CEl5/VnhV6Q+RHvWAUDl52Cv/tja5LjzBm2sUBlx
	3/Tf92XkKEIVANqFWxYTCDT5MvIRLAouNaWzq+Ozbb8amg3O/D2dl4GxlET7SuxFQOWZq/gi/IAw+
	+gDPoodcL+GVnwbDWq/Dyh+QTILqDTeMzV/YNAaJ8On0bvHdOmm24FXJWyUuSO2j3KEO2b2DXOpwy
	pMoiSGcZI+HoJpXpdDIU4uiJQjydVNAFT09pomw2ay82sR1kuiZpvp7DZK9Yt7B6maeOH8vMuqn6C
	rW+TZhCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnvkY-00012H-TR; Wed, 24 Jun 2020 03:06:58 +0000
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnvkT-0000xN-F8
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 03:06:54 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R811e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U0Yj-gp_1592967997; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U0Yj-gp_1592967997) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Jun 2020 11:06:38 +0800
Date: Wed, 24 Jun 2020 11:06:37 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200624030637.GA66445@VM20190228-100.tbsite.net>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200624025715.GB1291930@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624025715.GB1291930@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 07:57:15PM -0700, Keith Busch wrote:
> On Tue, Jun 23, 2020 at 09:24:32PM +0800, Baolin Wang wrote:
> > +void nvme_set_arbitration_burst(struct nvme_ctrl *ctrl)
> > +{
> > +	u32 result;
> > +	int status;
> > +
> > +	if (!ctrl->rab)
> > +		return;
> > +
> > +	/*
> > +	 * The Arbitration Burst setting indicates the maximum number of
> > +	 * commands that the controller may launch at one time from a
> > +	 * particular Submission Queue. It is recommended that host software
> > +	 * configure the Arbitration Burst setting as close to the recommended
> > +	 * value by the controller as possible.
> > +	 */
> > +	status = nvme_set_features(ctrl, NVME_FEAT_ARBITRATION, ctrl->rab,
> 
> Since 'rab' is an 8-bit field, but the feature's AB value is only 3
> bits, we should add a validity check.

Sure.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_set_arbitration_burst);
> 
> I don't see any particular reason to export this function just for the
> pci transport to use. Just make it a local static function an call it
> from nvme_init_identify().

OK. Thanks.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
