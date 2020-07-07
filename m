Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC0C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 07:11:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F9920656
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 07:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eA6q20pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F9920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lq5zpqkZSdVFaRsClKfHIvcCICRwDZeL0YoM5Yj2k18=; b=eA6q20pb7u9wfYNpK5IB+YFRL
	LvVh9XF5TLhM6Dm/gQONMu/f9kY7sckbby73N8hAxbvKmeshOAiZJqnkBs2HPL2NxqP9WSnEBBI4v
	MALXv+p9/aDFtuSM5Eph+8GbEj83S5/RYYhIOtpyGmo9iFGMU5mvOUjiiBni9Ca4Zp9Rlp9h9bGqM
	Qi82tSmKEu623MF5g1Poin2tI6ohYW6OFTN19NI+sRf2xXosl/x+hNn6S+ruHcf0XCSBdoQcCMsvZ
	JhokOPQiZNMUamVz6eDCJtYwpdKUq7I4g93KLpK7kgHfr2M+ZCGYpwTW7h5Ef304VER7HKx5yDvbf
	kQji0xncQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jshl7-0001mb-3e; Tue, 07 Jul 2020 07:11:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jshl4-0001mD-Kx
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 07:11:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EC64568AFE; Tue,  7 Jul 2020 09:11:11 +0200 (CEST)
Date: Tue, 7 Jul 2020 09:11:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [RFC PATCH 0/5] nvme: reduce repetitive calls in fast path
Message-ID: <20200707071111.GB24011@lst.de>
References: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_031114_815454_1A1C759F 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, james.smart@broadcom.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 06, 2020 at 04:15:19PM -0700, Chaitanya Kulkarni wrote:
> Hi Christoph/James/Keith/Sagi,
> 
> While reviewing other patch-series I found that there are repetitive
> calls to blk_rq_nr_phys_segments() in the fast path for NVMe Transports 
> (pci, rdma, fc, loop). We should try and avoid as many repetitive checks
> in the fast-path as possible.
> 
> This patch-series reduces multiple calls and minimizes the repetitive
> checks in blk_rq_nr_phys_segments() for NVMe transports.
> 
> P.S. Tagging it as an RFC since I've not tested rdma/tcp/fc part, if we
> agree to get this in I'll put more effort in testing.

blk_rq_nr_phys_segments is pretty trivial - just a branch and struct
field access.  Does this make any kind of difference?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
