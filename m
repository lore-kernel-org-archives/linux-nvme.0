Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BCFC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:03:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DFF6186A
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DFF6186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9hw86eunm+dOqYXh679315GnFmdjY75LHHDEueMYZ6U=; b=EHKxbIDPTZ9Y1ppJn/dXuIXkU
	S7gbRQ8Ceq2NGWk5Y+HELRsyHdzdtrFNSJQ+RV4JwIWHFDVRMqU1sGszYfhWCK3SplG8sAJEZI2oM
	0LrF3nFTIxOTp1tp6DxKJ/KtmZk0Iath7NbT2b6hfcqF0hUU1RO5aBNYaNcdulNQaEmzObOm4D5hm
	Nme4vzSIpIx/MJ8+/FC9dKAutmmx/f4JMZ4i086/9GFfk3VcovRP8/NEYzCPkYHthrHhpZQ98hcmB
	NpGiO26CA1khvjiSycIgBia/nhkqZi1//UaS/fd85ODdmMpV0YT5I9fQG55OvbCjRQWPETBIlDsRo
	1of+sy7Pg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEGU3-0006Oa-5J; Mon, 22 Feb 2021 19:03:03 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEGTz-0006Nm-PU
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 19:03:00 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5240AAF28;
 Mon, 22 Feb 2021 19:02:56 +0000 (UTC)
Date: Mon, 22 Feb 2021 16:02:53 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH 00/35] RFC: add "nvme monitor" subcommand
Message-ID: <20210222190253.6ftslzvqt3iz3f3s@hyori>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_140259_967707_CF0026F7 
X-CRM114-Status: GOOD (  11.56  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "mwilck@suse.com Chaitanya Kulkarni" <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On 01/26, mwilck@suse.com wrote:
>From: Martin Wilck <mwilck@suse.com>
>
>(Cover letter copied from https://github.com/linux-nvme/nvme-cli/pull/877)
>
>This patch set adds a new subcommand **nvme monitor**. In this mode,
>**nvme-cli** runs continuously, monitors events (currently, uevents) relevant
>for discovery, and optionally autoconnects to newly discovered subsystems.

Is there anything missing from this patch set?

> * Implement support for RDMA and TCP protocols.

I'm working on the RDMA and TCP implementations with mDNS/Avahi support, and
I would like to submit my work based on this monitor solution.


Cheers,

Enzo

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
