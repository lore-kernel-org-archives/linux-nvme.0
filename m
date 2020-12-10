Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85886C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 15:16:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED0423B45
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 15:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED0423B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t8fUv1JNKZc1bnAdxM3oLCquLORFfqYY1FxVUFey2oo=; b=qoa0cpUyNtY81yClAuqUeibEv
	JFyWG7Z/ft3/b9jhurg57qiezCXi/WicdOQdqDUu/tNJe4U+7qxRsvyVU26wOUjFFq6S9+8d/g52O
	Xpq3CGZF7Gvvnozg1vgPCgvK+zThzVb+b2TrYwHLDzbDiOBTchS2isTCcH3A5VwzNrhVqbCb7/DOX
	fO+vaX3DBIMDCBNbroK1zaWkSktQyWywYQuWBF0vKCjFEMHeRckQvHJrS+NYUU1/SnPN7qBmUdDx6
	DDxr3uwPi1J4aMtGfn3D8mmWj/H2j5lZR5U6zcAhEov5Sqr62eU8fjUC1FJOO+4T0+COJbqYTnVZk
	kSPmUxASg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knNfh-0003uQ-Fr; Thu, 10 Dec 2020 15:15:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knNff-0003tv-Tj
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 15:15:56 +0000
Date: Fri, 11 Dec 2020 00:15:51 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607613354;
 bh=wZ0fhXkz4eYhyDN6W2nvKxllZUC9st97abBTE3rinAM=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=Amne4wUYqSTUh6m1H2fsbq3Bo492mSIS2YCUa1Su+2RHqTmluhjJwTFXzJDyKOGHx
 HUBcs1SzTgN9CF5Im+lG82IfbWaJZwcFCMCTslwgKYpnpqjLDNJQl/POBc0UpQqoG7
 k4A8XYZOalcmA0o7Su3uKWUHb9/teAdX4cg/NYHQgtnApldDSb5bbiV1VCxoY9XntI
 ia9cIbutAsyiYRLcxTMd18bLqc3O8mFVQAJh3ecevIwruwphG7YA2pPL54Iup5vZaD
 DZjymLAVBGS94lZ9ZXiaJPc8CX9wQdTUlwInTGCQcN1B3ObdtlBGpJzWFEGoFb5/WQ
 WGWm5D637vWAw==
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V4 0/9] nvmet: add ZBD backend support
Message-ID: <20201210151551.GC3645@redsun51.ssa.fujisawa.hgst.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202092019.GA3957@lst.de>
 <BYAPR04MB496565EF0AF026C16225792C86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496565EF0AF026C16225792C86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_101556_053191_A2A6463D 
X-CRM114-Status: GOOD (  12.58  )
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

On Thu, Dec 10, 2020 at 03:07:32AM +0000, Chaitanya Kulkarni wrote:
> I think something like following (totally untested) will help to avoid the
> scenarios like this for ZNS drives so we can rejects the buggy controllers
> early to make sure we are spec compliant :-
> 
> # git diff# git diff
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d9b152bae19d..7b196299c9b7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2166,6 +2166,11 @@ static int nvme_update_ns_info(struct nvme_ns
> *ns, struct nvme_id_ns *id)
>         nvme_set_queue_limits(ns->ctrl, ns->queue);
>  
>         if (ns->head->ids.csi == NVME_CSI_ZNS) {
> +               if (!(NVME_CAP_CSS(ns->ctrl->cap) & NVME_CAP_CSS_CSI)) {
> +                       pr_err("zns ns found with ctrl support for CSI");
> +                       goto out_unfreeze;
> +               }

I think you want to use nvme_multi_css() for the 'if()' check, but
otherwise this looks like a valid sanity check.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
