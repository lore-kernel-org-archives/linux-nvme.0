Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54252CFC274
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z6KyzRh6wvX2ugTED7VQ2oBDb9ERRgX6OeR0fwlDsUg=; b=KinIMq0JSTRwrrpw7J+9DvCdVL
	2xuwrmszm0Vmg1gsDN/GSUgnSMsxNRqIF3lp5hzjZfevI70jng9D4Ob0TXD5YTGdSZ9hXvrso3nJB
	rP2bWPPDvXElQ4K0MoWu7IqiBEHe8JLJVtSr/XteoCvl/XeWr2SEYiJi4oR1O1spWW6/Q7mea3pZm
	5dH3A0JPHQVepxDpJXKGPxCEflow/5MK43bR2sS0R/X6jyyTL8WGnZq/F7l4rS3rSv+5AH35ezSW0
	fixdCwacAyaD502PneF1Y/2zNNxLlC5QafL3pCm3cKsKAt/a1oaSCdbsnm6Yb55fAly2qFweJ5ha5
	OyfG+OpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0clW-00000007U5f-2tZ1;
	Tue, 15 Oct 2024 08:18:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ckT-00000007Ti4-01tv
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 08:17:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 03CFE227AA8; Tue, 15 Oct 2024 10:17:33 +0200 (CEST)
Date: Tue, 15 Oct 2024 10:17:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmetcli: reservation configuration support
Message-ID: <20241015081732.GA27471@lst.de>
References: <20241008080800.7712-1-kanie@linux.alibaba.com> <2263ee49-1c8e-4aa8-9682-fbea57350b13@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2263ee49-1c8e-4aa8-9682-fbea57350b13@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_011745_212116_53E8F2CA 
X-CRM114-Status: GOOD (  11.19  )
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

On Tue, Oct 15, 2024 at 04:15:28PM +0800, Guixin Liu wrote:
> Hi Christoph,
>
>     Could you please take a look at this nvmetcli patch?

I'll try to find time to do a nvmetcli sweep this week.


