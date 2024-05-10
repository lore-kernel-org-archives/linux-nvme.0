Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B6DC25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 22:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TYX1t3P8vxTyrszZ12OaRCKgK8HzCeKMv9sFCKEnUk0=; b=dm/HjCpCkWZjSwPPiUQzQOAYoE
	726d2b0HoCN7pEMMRIeDLKij2zc5ZxldW2Lqc5WLVBbqylcj7LF27H6R0l5esi/k9VnVpVnBXWAYg
	VNj+567SDdBki9LWecAcaYRgzBfub/sx/nuDW7hvCCD0Fdv5DZX6WV//eBilDw90nocEMTuEMvRsb
	kdoHBXiAewkGklq2UuTRiaQ2K0VOjpNi03DbF4T9gY8bJgk8W6dpHlTo8wqXJ00tT+L/Cb2UFk7sf
	VtqZPqZFUeQHzU2pEr7Hz+SY9sGGM3wBY+Fv84FW2TK2eoja12kX4s64Ve9RPjAlp0tT/Sj2mnSAz
	5h0BtkMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Ypb-00000006g07-2B3j;
	Fri, 10 May 2024 22:35:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Ypa-00000006fzt-2qXg
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 May 2024 22:35:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TYX1t3P8vxTyrszZ12OaRCKgK8HzCeKMv9sFCKEnUk0=; b=aRqc1QYNpkhRlH0e068qaaEp3q
	/2aDRoZhx/jxbft4rshF0vXCLfdvflZEtHkglS2m6SIa/EIOdpiU3MlK7z/ny/+Xc0ddnChNLi9Rm
	9XeWa91jWxfdE1PJ339P6mAH4WtL5gfOAv/E0LzX9b29Wo5FJk6lxqPTEtnlmmqeL6LKhDaG7nWFn
	Gt4mtEafFC7rfXiraatWwDdADS2q33AQpq61ZR50y2x8/2IkJboCLd5H5D/O2obYDO7t1zDJqTOfc
	VjvBhEKfDjbWeHRkLD7qu8k6ylzbR4Ogvk1UsKRJaFlhGxZlugxD5ZDF99/h6mlyJsbBcKwtEnB/t
	Ig+blKOA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5YpY-000000045I0-1zRq;
	Fri, 10 May 2024 22:35:08 +0000
Date: Fri, 10 May 2024 23:35:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/5] block/bdev: enable large folio support for large
 logical block sizes
Message-ID: <Zj6hHAVWSev-xe4R@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-5-hare@kernel.org>
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

On Fri, May 10, 2024 at 12:29:05PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Call mapping_set_folio_min_order() when modifying the logical block
> size to ensure folios are allocated with the correct size.

This makes me nervous.  It lets the pagecache allocate folios larger
than min_order (all the way up to PMD_ORDER).  Filesystems may not
cope well with seeing tail pages.

I'd _like_ to be able to do this.  But I think for now we need to
call mapping_set_folio_order_range(mapping, order, order);


