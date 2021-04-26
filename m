Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B92C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:48:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2138660E0C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2138660E0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LiqzjFyqx44/eE18146L5YKihvFqCg/+QpcLbizoPns=; b=VXVBZFJwyQaR+M9vzSqezl1gB
	kle4DfOLBR3+M7Cormzw99R3RUIONk+yUYrnAyt1NP+dES5GhNFZJiDD1/EimSpSH1hN7l4iO6yHd
	R+dsU79gSPhoxkj4zkpJUmwMqQwux3VBFAZgefZGIWQeJAJx2EE1R3zg/Nbeh9ZtDlvJLrTvt1FfM
	gIfrwqjwhyztf4Yd2te6+DsFcp235s0cIgJd+CTftvUv9Tk+jQCONOtjaP9A/8PbjlBZKT0GP1TII
	N7+mOxmyeW8eFuk1jXks3218P8OgAQECCsVyldtj+EFYGDZvUug5QgJBOukUlsPgU6dGdOxi7vb3i
	CpYTuf/pQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2Ww-007szJ-9S; Mon, 26 Apr 2021 14:48:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2SH-007s8N-MJ
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 14:43:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=apkZBgtLPT3sNMxd2z9f0a041nGZt+aJ0zrJaFv5Y4A=; b=ESB1KvTLppmc+O6iTGFNpPLTBL
 mT70h5owZtwZDPcnnPPwVZ2fTxo44WSQRBYp3JPN2GjtGnODdc/evJBNSk6+BhgqRVo9GEvAIvoX7
 d1Xb69bleKU7uw1UQ36ra0oxb6+257lSqbSOa6QzAETq7UDa8Qs4tyQATNdS3ghngIJ11G3TLZ8q2
 w3QZr8J2LcslCWeL3jiAAzflaLFDodZFsk1aK0e81OrG4m2IzTluf1zlounzC6WNmMButIe99Tikm
 vbLX1w5ILtykrcDdegD0q0S31U8vFN7EphMCkPIrUSZDTNFH8FPSO9b4QBaD8W20NOKY3AYGmCAHt
 Fhmx04UA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2SF-00G1Nn-7f
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 14:43:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2752468C4E; Mon, 26 Apr 2021 16:43:17 +0200 (CEST)
Date: Mon, 26 Apr 2021 16:43:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
Message-ID: <20210426144316.GE20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-6-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-6-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_074319_436472_5E54C801 
X-CRM114-Status: GOOD (  12.46  )
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

On Fri, Apr 23, 2021 at 03:05:58PM -0700, Keith Busch wrote:
> The block layer knows how to deal with polled requests. Let the NVMe
> driver use the previously reserved user "flags" fields to define an
> option to allocate the request from the polled hardware contexts. If
> polling is not enabled, then the block layer will automatically fallback
> to a non-polled request.

So this only support synchronous polling for a single command.  What
use case do we have for that?  I think io_uring based polling would
be much more useful once we support NVMe passthrough through that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
