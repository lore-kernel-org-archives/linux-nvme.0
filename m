Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9627C4332D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 05:48:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4E12072D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 05:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jym/VTqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4E12072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DIqUOSqlqD8jdnaxmTRl1unIgRpoZnz/nsRLgDMtAOo=; b=jym/VTqucn1GJk
	8HzMSYLSeSmwoKP5uv2KWYI2Mip0U7EHQQDwTgZdDfDs5yVCyopqf3MX7V7rtZCx/gsEqcBC62ZnJ
	2xlXreOiS15xwSSRQKmEl0T67rsstAl9khtgDObAj094BPv7w7Xazgw/Esp1TNNjzeWRPJADsb2tK
	1vFfhVOTFckXrThl75M54J0E8jjc4q/2I97vU4s+rH/r2upRepBC94LgFHCybaCoLm+chmpFBTeIK
	gZTY5WKOhX5lmSJF1ruQX1GhFfmAsKdCe5eOic4YSaAzXhGjsjW1Yl7FQmmfhGbOfEShRSVBCrJf/
	eyMG2owlXaFDAQoUqCiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFAWe-0007h6-PS; Fri, 20 Mar 2020 05:48:56 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFAWc-0007gd-GR
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 05:48:55 +0000
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02K5mmjY016425;
 Thu, 19 Mar 2020 22:48:49 -0700
Date: Fri, 20 Mar 2020 11:18:43 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: fix dsm failure when payload does not match sgl
 descriptor
Message-ID: <20200320054842.GA16482@chelsio.com>
References: <20200124173942.2744-1-sagi@grimberg.me>
 <20200319172339.GA29063@chelsio.com>
 <41b757fb-5ac0-db29-9bb3-6a8b68892dc0@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41b757fb-5ac0-db29-9bb3-6a8b68892dc0@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200319_224854_553330_463E468C 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Dakshaja Uppalapati <dakshaja@chelsio.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thursday, March 03/19/20, 2020 at 14:06:22 -0700, Sagi Grimberg wrote:
> 
> >>The host is allowed to pass the controller an sgl describing a buffer
> >>that is larger than the dsm payload itself, allow it when executing
> >>dsm.
> >>
> >>Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> >>Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >>---
> >
> >Hi Sagi,
> >I see this issue with 5.4 stable kernels. Can this be pushed to 5.4 stable?
> 
> I can send this patch to stable.
Thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
