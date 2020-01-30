Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A13C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 15:08:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B2E20678
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 15:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B7qVTQf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B2E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xG02MFAn/lNtO3fF5vA4YT8Se1yCk13OJRtbFSHckxQ=; b=B7qVTQf9wyBNy3
	mhpMhx96uJ6dBNY05LADhjOxD7sImLgv+GJXrXZ4OV0An76cu7JTrbmIAhNZJDaLdAIluuhkWyiWl
	ALwrtXLJHQgNX1OpJdoKH4Fu7MnI1Ld3HDgKqvKydZrbU4tz2ORUsHqSaUJGwVQb/5Qcps5EBYXwm
	V4iwrNfeXKe11x+1jq1N908mFotPiG0CkniWr1SrheKzZ7XTUhd97S+qKWQ6zOAGxmSqFlNE4231+
	A4uzbo1kXfMi12mdgsUvfPfvWzM74Em6746jeyNf6wS4xhKTtDDwXqvlc6Oe9uBMWC/LqOFluW+cq
	GUXB1oapXbtfZdVwzEfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixBR8-0000wB-Qt; Thu, 30 Jan 2020 15:08:54 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ixBR6-0000vW-Th; Thu, 30 Jan 2020 15:08:52 +0000
Date: Thu, 30 Jan 2020 07:08:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH v2] nvme-fabrics: reject I/O to offline device
Message-ID: <20200130150852.GB25427@infradead.org>
References: <49c2e737f21b4c2795de71c8d8d578ee@kioxia.com>
 <98e76717-1e98-92e1-0d07-d2dac4bd1d76@broadcom.com>
 <8b8454b9b2d44efab22df15af9df0a21@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b8454b9b2d44efab22df15af9df0a21@kioxia.com>
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
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jan 26, 2020 at 10:06:20AM +0000, Victor Gladkov wrote:
> On 1/15/2020 5:43 PM, Victor Gladkov wrote:
> > 1. Added multipath support for this patch.
> > 2. Small refactoring (according to the review)
> 
> Anyone have any comments on the latest proposed patch?

Where is the latest patch?  I didn't see a repost.  To kick off a
discussion please just resent it, in proper patch format and with the
proper style to make reviewing it easier.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
