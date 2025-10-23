Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85627CCD193
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 08:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4GcAIMZkmScS92rveOb8PxtFbg42TmGSDL9qZcc9EjU=; b=ZabvUkfQBeLlqfvEXG6zPBVVEk
	QQ0WqieyO/UAi+ZhrCk/HqlKzOAglBxTBll0voxvjbEtS+8UyOq5UyIAjGW1iiYlAfxke88NQ+nV/
	RqwJTDKBwU24Lgeltn99qWklit5MNOqk6vJQo4Iq4OiQ1zzsdDgKKKN87MSSYCHKNu22hbqSFxPLL
	D0qrxr9A74NLWaLWnvDYEHCDGtfpIil8mr23oTIqC18manABbXafoIGJ6BhjfZNfLwPrlNKx8K/x1
	gWfYppkG5U62uCQAnZhWvvmvCu/CPautOXkG+DxmyNaGxURwyDMeh6maQK4B6igu3L5s2s2tG5Le/
	kNHI1OWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBqS2-00000005Ug6-0cVj;
	Thu, 23 Oct 2025 08:13:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBqRz-00000005Uf4-0gjL
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 08:13:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BC05227A8E; Thu, 23 Oct 2025 10:13:25 +0200 (CEST)
Date: Thu, 23 Oct 2025 10:13:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Message-ID: <20251023081325.GA302@lst.de>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com> <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_011335_364644_7CBD0A86 
X-CRM114-Status: GOOD (  13.89  )
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

On Wed, Oct 22, 2025 at 12:33:16PM +0200, Gerd Bayer wrote:
> Add a new error message that makes failures to probe visible in the
> kernel log, like:
> nvme 0008:00:00.0: error -ENODEV: probe failed
> 
> This highlights issues with a particular device right away instead of
> leaving users to search for missing drives.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


