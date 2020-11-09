Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7798C2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 08:52:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4954B206ED
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 08:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q59eiY1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4954B206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+NLmyFjOX8V3Q/Uw9pLPcV12uIcNG5Qp4HG6Kh0dvfA=; b=Q59eiY1PvZ6IxlRvsgIHPk4G0
	Fwh76JW9n/vAnXtZC+u3aEd0BAmFSrZqTMeV/e2kET3QFRTp6jAyj4bDLp2ERicQIv3GD++gVyPFm
	pvIxOXH6f4LQAZIBX3Ru7LgV7p0RTP4ydiM/jold4efjI13FdhtdNI3aRzLiRgIVBElcWp7JcjV2Y
	hEmkALVYmAqv4aFGQG+qiNW2saaom1hkKx8e0pohxXSi7ZeROvuNAyKOqEwc7un7jYkZcTIhBLvWB
	qMwW/puap8rz1oun2zObjJEvGlgSqSipook/xVVj03xNkxgYGpqTc/KG5mEKykmEQr9E2/MWsyq7M
	CENdgJwaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc2ub-000849-UN; Mon, 09 Nov 2020 08:52:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc2uZ-00083a-EB
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 08:52:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A09B16736F; Mon,  9 Nov 2020 09:52:21 +0100 (CET)
Date: Mon, 9 Nov 2020 09:52:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: revert commit 1293477f4f32 as it is breaking
 BLKROSET
Message-ID: <20201109085221.GA27483@lst.de>
References: <20201106171835.38236-1-sagi@grimberg.me>
 <20201106175949.GA7529@lst.de>
 <443079c6-2dd0-f52d-4b2f-f7f9dec2792d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <443079c6-2dd0-f52d-4b2f-f7f9dec2792d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_035227_600814_CABD88CD 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 06, 2020 at 11:02:28AM -0800, Sagi Grimberg wrote:
>> Just dropping the else part is probably enough for now, although
>> as a follow on we should probably add a "hard read-only" state to
>> the block layer.
>
> Removing the else would have an incorrect behavior. I think its better
> to not support it (until we support it correctly) than to support it
> incorrectly.

I strongly disagree.  When we see a write protected namespaces doing a
set_disk_ro is the right thing to do to prevent folks from writing to
it and getting bogged up in tons of warnings.   I think that use case
is much more important than the corner case of clearing it later.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
