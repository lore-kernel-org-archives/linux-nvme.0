Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7E3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 05:36:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAB2610C7
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 05:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BAB2610C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FKqwk8FcE5nwQ2k+80Ipg2fQsyA+BEBSyE+3izYuU7E=; b=APQahvrGUDdzYv/PG7/iBctV2L
	1hq3Dbpd/hcCQLmppsj+fGU4DEFmXn2yO6wZ5I0OZmAHUCzMCILxM+P12Zjq8Jg2avLU2PgtoyXHV
	dwwimbJxJEqlF9JD2n7EXTgUZDVm8P/cSyYhkrs+tflfEd3Nh0eYw1K85QqL8BmHASk6U1h0el8DI
	8LyBPXMmDI6Jrx/IDWQDpcO+acUyDjbxbp6DCz9wgrFsDpYz2MZySY+zJUk2tIunUOfBHI4chvOSh
	iBh4eq8fA4rNpitUOJtD+q7esFlPpDSViV66YWumPuWxW76dVy149lQUzYRWjVSxFo2scecZ9s5Ux
	L8KVhXBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mchnP-000BTC-2N; Tue, 19 Oct 2021 05:36:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mchnM-000BSr-TA
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 05:36:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D618B68AFE; Tue, 19 Oct 2021 07:36:07 +0200 (CEST)
Date: Tue, 19 Oct 2021 07:36:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <jsmart2021@gmail.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com
Subject: Re: [PATCH v1 0/7] Centrelize common fabrics code to core drivers
Message-ID: <20211019053607.GB20206@lst.de>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <4002b4b2-1a57-8c4f-c2cb-5c4bf13aafbe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4002b4b2-1a57-8c4f-c2cb-5c4bf13aafbe@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_223617_134061_33D95CB7 
X-CRM114-Status: GOOD (  13.36  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 18, 2021 at 07:08:06AM -0700, James Smart wrote:
> I've been thinking we needed to do this for a while as well.  FC should be 
> part of this, and up front, so the abstraction is tested properly. I'd 
> rather merge now than spin things again.  I'll go through this over the 
> next day or so.

I'd really love tp pick this up quickly so that it doesn't go stale again
if we could get a few reviews.  The merge window is about to close.

