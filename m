Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411BCC4361B
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 09:28:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26F4225AB
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 09:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26F4225AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rb5I6eJxnpnfZJWgXVu9rrSIFC2vTpe3xV1ppoYtPlc=; b=i0q6nGGn4IY9Gjcw9me+7scUB
	ouBpL9VYKMfOTLPBSZCyltCpEfkJS4tdTrrj9bEROowgN4vfnn6aQv2IRxGKNNWbH83pAz6nKguIm
	mBXEA8sCvA8nTPiK5kqWRFIFYrlvIBcantIKVyTy8qJfxpJIc+vOq3SqHmJ0A8mwMYX/vaJ6Xd6Iu
	f0oVrpNirtxgXZKqCoBneiYoO3++N3euMMa3lbUzK8wTthqIsCYtcrtt6FN4EzJxFYCOIjQVGlvrE
	QUr2wkBc0NCIGPhA9EHXktWl+Ul2FcTm4Al0ogl0GJXjYNBt2IRkNy96M+T5tAS6++k5Okg7HNdnh
	584wPaT0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl7OC-00069k-UV; Fri, 04 Dec 2020 09:28:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl7OA-00068z-DV
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 09:28:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BB5C36736F; Fri,  4 Dec 2020 10:28:28 +0100 (CET)
Date: Fri, 4 Dec 2020 10:28:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Message-ID: <20201204092828.GA9208@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-6-chaitanya.kulkarni@wdc.com>
 <20201202091018.GD2952@lst.de>
 <BYAPR04MB49654267EFD18AF2A65BECB486F10@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49654267EFD18AF2A65BECB486F10@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_042830_575012_AF5A26B2 
X-CRM114-Status: GOOD (  17.77  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 04, 2020 at 03:20:40AM +0000, Chaitanya Kulkarni wrote:
> On 12/2/20 01:10, Christoph Hellwig wrote:
> > On Tue, Dec 01, 2020 at 10:22:23PM -0800, Chaitanya Kulkarni wrote:
> >> Update the nvmet_execute_identify() such that it can now handle
> >> NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows
> >> host to identify the support for ZNS.
> > The changs in this and all following patches really belong into the current
> > patch 2.
> >
> 
> This and each following patch doing one specific thing for which host
> 
> side component is responsible, with one patch for backend handlers and
> 
> wiring up of the same on for admin-cmd.c and io-cmd-bdev.c seems
> 
> we are packing too much into one, unlike what we have has a nice
> 
> bottom-up flow for the implementation, why not we keep that nice flow ?

Patches should do one thing at time.  With this series patch 2
is very incomplete, which makes both review and later reading the
commit history very hard.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
