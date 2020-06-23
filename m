Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323EAC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 16:28:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2128206D4
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 16:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="th1STfQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2128206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C30/h/8dCKow99TUHPeYFadsfKzwfu4jxnuKWdpcgdc=; b=th1STfQ3j07BgKWs9XIEvR+w7
	GmJQTXU9zxOxnWQPKilVV61JUPysG9WK13rsVJDKFHV8gC8hQaoZDHe1QOXMgjvWZImPFz5Yq9uXS
	6dYH2A/UX0WVmy75H1miVREzoYuMOa0aawIDwKx5OhV475ABJAgkK2ki50gPnGpLuBEXezX9/71A2
	FPZBdeQ0wvmWNeUsNd5vkU+eBREsfj8kdOhiBp0XOjD3/+k2q1gI7G2XhoFIA5l6Ipe1qYA0IkeJ7
	2MbqLBauXeHS+m2LgmN2Bkv9V4fbqMhXwwG2OJNoyl4d0MglPUxjlIph8N+E7fL0SVQmfdORIGjvt
	Jav/M+sjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnlmT-0001Fx-P2; Tue, 23 Jun 2020 16:28:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnlmB-0001DP-1m
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 16:28:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 078AE68AEF; Tue, 23 Jun 2020 18:27:52 +0200 (CEST)
Date: Tue, 23 Jun 2020 18:27:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported macro
Message-ID: <20200623162751.GA4846@lst.de>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> Introduce a new capability macro to indicate if the controller
> supports the memory buffer or not, instead of reading the
> NVME_REG_CMBSZ register.

This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
a backwards incompatible change, as the CMB addressing scheme can lead
to data corruption.  The CMBS was added as part of the horribe hack
that also involves the CBA field, which we'll need to see before
using it to work around the addressing issue.  At the same time we
should also continue supporting the legacy pre-1.4 CMB with a warning
(and may reject it if we know we run in a VM).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
