Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B31C55179
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 09:02:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D03E24182
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 09:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MC2hEm+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D03E24182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9jLKsb7TJEXKX4EeTO0pPS11RNIRxA0W9yw/7rf+DpA=; b=MC2hEm+rkDmMWBcLm4tfKUJOk
	KljtJmnDuVeDsuanGETBTGZh994MTxH7BCyBBD9p9b23yWCiwTfr9OWPCM+UeapPH23ZMS3eGXiMd
	DD9k3KmmHWLMPWQzfB9Ax7kx4Ddy16OUrDK/ty2ozNjp+DKZPiB7SEQZxa0JQ3zy1wVQt+va11M9L
	GhFiouyMUnsbl9JqE8N12fJLOErwCghAZOgXvw0yGaIxN0EVj8JL3H2mbKTN0qLb0hFs47B5Sazgf
	EVC3R7tsmO5KVJQhjdldnepo12UnRbEN7LxXFAeFqcoZj3uYZjLKmO0HiumNsmYPNNmiiooQ1c3om
	D08JG+Zxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVsy1-0005or-11; Fri, 23 Oct 2020 09:02:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVsxy-0005oN-Sx
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 09:02:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9436DAC5F;
 Fri, 23 Oct 2020 09:02:28 +0000 (UTC)
Date: Fri, 23 Oct 2020 11:02:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: NVMe CLI Version Tag
Message-ID: <20201023090228.w2gooi4vpj4aaugt@beryllium.lan>
References: <BYAPR04MB5656B49BFE47211B3A2F1748EA1F0@BYAPR04MB5656.namprd04.prod.outlook.com>
 <20201020175017.2avzkm2bwyeg2t3a@beryllium.lan>
 <20201020175644.GA1438267@dhcp-10-100-145-180.wdc.com>
 <20201020235454.GB1438267@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201020235454.GB1438267@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_050231_082953_4D57173F 
X-CRM114-Status: GOOD (  11.92  )
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
Cc: Sean Brownlow <sean.brownlow@wdc.com>,
 Randall Bates <randall.bates@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jeffrey Lien <Jeff.Lien@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 20, 2020 at 04:54:54PM -0700, Keith Busch wrote:
> Looks okay on my end, so v1.13 tagged and pushed. I didn't pull any of
> the pending requests like I usually do for this release as that
> inevitably leads to breakage right before a release. I'll start pulling
> new stuff in now that this is hopefully a good stable point with ZNS
> support and all the other recent goodies.

Excellent! Many thanks!
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
