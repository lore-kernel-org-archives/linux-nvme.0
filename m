Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C50CC19F2B
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XF56bdncEzbHIUYn8fIlKLl94jGK/CV1hAGGQT8RkfE=; b=yHu0YsbctLncVvbMZRJShwy5PO
	nHsPZfE2uVCGo52C31yuOaSlyaf/hTwVigPddI02EFtzA6WLx9IZxAFBpTOedWt4Y+JSgvVrMHUAq
	GLDVuBvMfiggyyDtgH362FKrHVsR2srpSVL8CgrQfDf2KI50H+15WrHQKEX0sFRoQbH1oNyVnmj66
	U4rzWrmLfYqpEi2O0Xgsf4ecF8QOMpZa4jik3zPgP9zbsxePHy9auQpcilVg9xajGd3EP5zpQuy6G
	lCZd6WCnjJEwffQcNNwrYFvTLcabj0EEWm6gruer7DisW8UYw1h9p6HFM9RPxwZ7SuEvsuJTVRrnu
	cnaHy1ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHPtl-0056Ad-9u; Fri, 29 Jul 2022 13:19:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHPtg-00566r-DB
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 13:19:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53E7A68AA6; Fri, 29 Jul 2022 15:19:14 +0200 (CEST)
Date: Fri, 29 Jul 2022 15:19:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] nvme-pci: iod npages fits in s8
Message-ID: <20220729131914.GA28052@lst.de>
References: <20220728221152.538648-1-kbusch@fb.com> <20220728221152.538648-4-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728221152.538648-4-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_061920_608937_E272A90F 
X-CRM114-Status: GOOD (  11.21  )
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

On Thu, Jul 28, 2022 at 03:11:49PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The largest allowed transfer is 4MB, which can use at most 1025 PRPs.
> Each PRP is 8 bytes, so the maximum number of 4k nvme pages needed for
> the iod_list is 3, which fits in an 's8'.

Can we use the chance to rename the field to nr_allocations or
so?  The nr_pages always confused me, and the comment does not exactly
help.


