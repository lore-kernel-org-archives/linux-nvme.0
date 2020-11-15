Return-Path: <SRS0=Y1qY=EV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E7C2D0E4
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2020 15:45:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD1E223C7
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2020 15:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r6qW7ouG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD1E223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F2ynk3z8l2qZp113xb0keVfBdKtSkxZI2M59x91uuDA=; b=r6qW7ouGj2zZ4gRR5dv47Pml8
	bZ/sxolZUBJik7Ys9pMQ8pDz/AD7cukFMvlyNaUYzYDXhJ4Pq2XErt53jIyg177t4N3JsSI9BHsd3
	pUwBt54gv2wqxiKCeZHFcyu6+nFvWglWSHMWtK8BphNjVpv8GC1D5nJrKy5474k4rF532vWk+7jaw
	kZse5UMLyB89ti65Y8ao+5qMp9vFIkutlbo6bHf8I47G1d6aoM16dkY4nTSCocVYrJLcG/kSBShNm
	XlePhFWB4rryV+P+x4Y4fhxMmgfVgMdmx2QvWUEZpL6cdrtRcWjdJXt9mHqTps6CgX/e2Xlcb8pFM
	WT2OlBq0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keKDV-0003DY-7f; Sun, 15 Nov 2020 15:45:25 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keKDP-0003Ct-LJ
 for linux-nvme@lists.infradead.org; Sun, 15 Nov 2020 15:45:22 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 15 Nov 2020 07:45:14 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::f5d9:1f19:c784:d6e9]) by
 SJSMAIL01.us.kioxia.com ([fe80::f5d9:1f19:c784:d6e9%4]) with mapi id
 15.01.1779.007; Sun, 15 Nov 2020 07:45:14 -0800
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v9] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v9] nvme-fabrics: reject I/O to offline device
Thread-Index: AdaWdQzkT4yPihEMQ1G37SjzcV1SkQBlirEACNZKrFA=
Date: Sun, 15 Nov 2020 15:45:14 +0000
Message-ID: <a3245f7368364c5b83cdd3ed3a61d718@kioxia.com>
References: <319b8b1869f34a48b26fbd902883ed71@kioxia.com>
 <b6f09a8e-e633-e303-1f39-cd380fd92f2c@suse.de>
In-Reply-To: <b6f09a8e-e633-e303-1f39-cd380fd92f2c@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201115_104519_715720_03C0A2B4 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Ewan D. Milne" <emilne@redhat.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Hannes Reinecke [mailto:hare@suse.de]
> Sent: Thursday, 01 October, 2020 11:55

> > ---
> >   drivers/nvme/host/core.c      | 49
> > ++++++++++++++++++++++++++++++++++++++++++-
> >   drivers/nvme/host/fabrics.c   | 25 +++++++++++++++++++---
> >   drivers/nvme/host/fabrics.h   |  5 +++++
> >   drivers/nvme/host/multipath.c |  5 ++++-
> >   drivers/nvme/host/nvme.h      |  3 +++
> >   5 files changed, 82 insertions(+), 5 deletions(-)
> >
> I did some more experiments with this, and found that there are some issues
> with ANA handling.
> If reconnect works, but the ANA state indicates that we still can't sent I/O (eg
> by still being in transitioning), we hit the 'requeueing I/O'
> state despite fast_io_fail_tmo being set. Not sure if that's the expected
> outcome.
> For that it might be better to move the FAILFAST_EXPIRED bit into the
> namespace, as then we could selectively clear the bit in
> nvme_failfast_work():
> 
> @@ -151,12 +151,16 @@ EXPORT_SYMBOL_GPL(nvme_try_sched_reset);
>   static void nvme_failfast_work(struct work_struct *work) {
>          struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
>                          struct nvme_ctrl, failfast_work);
> +       struct nvme_ns *ns;
> 
> -       if (ctrl->state != NVME_CTRL_CONNECTING)
> -               return;
> -
> -
> -       set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> +       down_read(&ctrl->namespaces_rwsem);
> +       list_for_each_entry(ns, &ctrl->namespaces, list) {
> +               if (ctrl->state != NVME_CTRL_LIVE ||
> +                   (ns->ana_state != NVME_ANA_OPTIMIZED &&
> +                    ns->ana_state != NVME_ANA_NONOPTIMIZED))
> +                       set_bit(NVME_NS_FAILFAST_EXPIRED, &ns->flags);
> +       }
> +       up_read(&ctrl->namespaces_rwsem);
>          dev_info(ctrl->device, "failfast expired\n");
> 
> ...and we could leave the failfast worker running even after the controller
> transitioned to LIVE.
> Cf the attached patch for details.
> 
> Cheers,
> 
> Hannes
> --

I'm not sure what makes sense to move the FAILFAST_EXPIRED bit into the namespace,
Because the failfast mechanism characterizes the controller as a whole.

Any comments on this?

Regards,
Victor


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
