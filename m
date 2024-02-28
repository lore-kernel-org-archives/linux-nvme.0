Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF0EC5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=; b=2Rfbbg59GcfVabzFcIJHoMMAeX
	+r7j0nk5K9huSYKJDptemkt8yeFkrLNI0aNvt8vuQp71cIvh13wbEEqVTQjXkIFi3Tdsfsklj8AL4
	tleG7xn3TtppqA0FJALe/WR2CsIm4pnJNdu2addmZzhcBL5N9twUd7FQMRkI0RTWQypN8h+eYPgCF
	PonFlmVr7L/naW7VlItwTikHGTLdFkS3KjY1YBC/3K4VlUBfYjgD2GuZDA1fpvXYftURDtQtFIbzv
	6p79bYE65ujsvwNHZ8NLjus0dgyRnwYCEOCi+8+hVvynVBkoM7u1XaEmGlRBPYx62Ka8d9Jxx5D3R
	50gF9DcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfMOr-0000000A1N5-3hUt;
	Wed, 28 Feb 2024 16:03:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfMOp-0000000A1M8-117A
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 16:03:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A48046189F;
	Wed, 28 Feb 2024 16:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA07C433F1;
	Wed, 28 Feb 2024 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709136194;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeL8yBxIDV7J8GfPzpMgiAfhqo3dZf225t0YhqokGGy7PyF6mjQ/vMHAlapICrVfR
	 IrTTuLW25huelL0XgXaA1KZpnBdHpD0y7M5MUbQaxlhNdSvfPvAg8IDIuthJkfcLfa
	 GMJ8iziSvUpG+XbJFzAbu9GSL4Ivu/sj9RRY0fdq3ZdmxPEkBC1jU6rQOpczLpwIUu
	 RvEW7A5K3q3/Usvpvx9yO9tsk+1mQgm5UjQmfhyW7WUBTx7EZD1Sxc1xIHZdhLcQxj
	 tR7quQ/4eUjel8rX18e6URCqfWgLgKD7xftV9W8H6TXSOuwP46MPvyR5CjegYVqYU8
	 B7A1NnqcmWsPw==
Date: Wed, 28 Feb 2024 09:03:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-fabrics: check max outstanding commands
Message-ID: <Zd9ZQBpF2IsMJ3Td@kbusch-mbp>
References: <20240228023759.99111-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228023759.99111-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_080315_356880_35012543 
X-CRM114-Status: UNSURE (   5.62  )
X-CRM114-Notice: Please train this message.
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

Thanks, applied to nvme-6.9.

