Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809AFC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 20:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHHdz+wtVwYfCmTJUyu+3iOhIuWJtXHqo98nT5qe+5U=; b=vnrrk9XA18gEax6zzNvYTODuEc
	/rgOferMDB9qSLtJO17ZMsq5hXZldFCQQOFXgNf2d+kXmRpnr6R998QgkDjK+kAwyCmzuAcJvvg+Y
	99E/QlDxRcsq6nj9nhUdqGjBjejDIpay8BITcIIOAiKcFcquX160TUyW5b6OZi18WqY6rcp6HbLnM
	3xPslPWOJy0wEqnLDvdzm/4S+Z9oQnRVaUaa1rquQwhbdT4Y6T+iUKkPoZDbURle3v0UK2TQFfS/J
	p+Yb7BTyvIQFQy/Ef7IyDfJx7//0zwnYzrvf+LjvO390U353cpZEb/8yA7X2CwZlVG0euPJibed8c
	XE1elJUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGPs2-0043fK-1q;
	Thu, 21 Dec 2023 20:42:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGPs1-0043fC-0H
	for linux-nvme@bombadil.infradead.org;
	Thu, 21 Dec 2023 20:42:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WHHdz+wtVwYfCmTJUyu+3iOhIuWJtXHqo98nT5qe+5U=; b=OEWlua4W+Rjf6fYb2pKNd8mklz
	SAMeX5fGAJPMfXuanODlQ3CcAY824bvRhsevJV37jaUbhkHUm3P3Ud4Pi0Cw7dgr5OHdSqo03FenM
	ib4oHKHAUp3jgcZHfgjODZ/Qy9fqy317ppd5Q2EzAvCNXw2S+U58lb0bQHoumeFf3A0t7NyMsQmad
	Ji86yLXz7KSUz5J5HUiCu/ckqd6mFT+9cDdURrW4JOagkpKpNtm40uUMsPQukuHv1xOqNp42bkPGS
	XDBAgpyqR/V9rE9SJo86VXheefrbY5st7V1iGDPIFEIcUWAXDTsc5cW9lw1HjkxP6J3giwphYXjkw
	6380Q7VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGPrx-0067eC-RW; Thu, 21 Dec 2023 20:42:14 +0000
Date: Thu, 21 Dec 2023 20:42:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZYSjJdF1wyqeCFhU@casper.infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
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

On Thu, Dec 21, 2023 at 12:33:08PM -0800, Bart Van Assche wrote:
> On 12/20/23 07:03, Hannes Reinecke wrote:
> > I would like to discuss
> > 
> > Large blocks for I/O
> > 
> > Since the presentation last year there has been quite some developments
> > and improvements in some areas, but at the same time a lack of progress
> > in other areas.
> > In this presentation/discussion I would like to highlight the current
> > state of affairs, existing pain points, and future directions of development.
> > It might be an idea to co-locate it with the MM folks as we do have
> > quite some overlap with page-cache improvements and hugepage handling.
> 
> Hi Hannes,
> 
> I'm interested in this topic. But I'm wondering whether the disadvantages of
> large blocks will be covered? Some NAND storage vendors are less than
> enthusiast about increasing the logical block size beyond 4 KiB because it
> increases the size of many writes to the device and hence increases write
> amplification.

It's LSF/MM.  If this session is being run as a presentation rather than
discussion, it's being done wrongly.  So if you want to talk about the
downsides, show up and talk about them.

