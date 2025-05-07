Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C7C369DC
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 05:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/KtHFDMABoCUeRvhM8IRHPZ7Wu/ia8CvULMkbW4Wcw4=; b=n53vsdTnShGU+G4cJEHEUYSTCF
	oRiwUbApj36Q+HByNeB+mRqF20QKOJRl4veNK94y9c+/tZ/UMjpDtB0zp36c/QKxaGcElY2Z0Qq3P
	rQzhVCXC6nnL0LGlfCJtzdCetQlFUP+z6vsQ9T6kAQLw6AH9WGPMRXmSc5xOi7xJNSxoq/vg+2TKA
	EX7qToH4IeSZYPc4T86pBNYsyuTB3DRMSXBwlteAweh5oaXsOxAscmAqH7WrOB+YOA0qiWhg/oV+t
	U2zaw8vi/qSOftnCnaGmVH+cHxWwDEo5b0SFB4KeUipLK7B9iYfv2CcY6CeEXlNLsruBhHbuG8M08
	kT0nokbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXlB-0000000EJNp-1ASS;
	Wed, 07 May 2025 05:56:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXkl-0000000EJJx-32M3
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 05:55:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9830EA4D44A;
	Wed,  7 May 2025 05:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20619C4CEE7;
	Wed,  7 May 2025 05:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746597334;
	bh=c4CC6V9Grz+vwsqhkE8/eAXGhDDEiWIUvw+08z+578c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqUjdo1qTUWhDSCMMnoR+//QvT+AD9SDt9KvXS6o2cPixrOg7E62Ie2xy9AthxQNa
	 y/2FDZCiR+59WlQj6Lt6iaWr+nNEDf0gY3d96TQifcTjqzs904K9JnwnJpAQlLgCCS
	 Kwy3E/Ixl12ODLEfdD+bDwNL0oeZ97DSdSbcYe+xhsZmXOYwmfK33X0pniCDb1Kfaq
	 FxZBgtpSloN7tTdNXQ0HW/6B27y14LifK6slMj88nxIbjU3knK65SfO/dpVmG3Pp9b
	 o/npecIhv7y47oZYKd5PkI3yF4G6ZZfv6N2wuxKEhxQTGxU875DlOWfEHC806lae9d
	 ftUBSyY1KJ/iQ==
Date: Tue, 6 May 2025 22:55:31 -0700
From: Kees Cook <kees@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <202505062255.130383D3B7@keescook>
References: <20250507033536.work.088-kees@kernel.org>
 <20250507044754.GC28402@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507044754.GC28402@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_225535_827533_80CCBCC3 
X-CRM114-Status: GOOD (  13.93  )
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

On Wed, May 07, 2025 at 06:47:54AM +0200, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 08:35:40PM -0700, Kees Cook wrote:
> > The only reason nvme_pci_npages_prp() could be used as a compile-time
> > known result in BUILD_BUG_ON() is because the compiler was always choosing
> > to inline the function. Under special circumstances (sanitizer coverage
> > functions disabled for __init functions on ARCH=um), the compiler decided
> > to stop inlining it:
> 
> Can we place just fix um to still force inlining inline functions instead
> of needing these workarounds?

Oh, I don't have the history here. Is there something about UM and
forcing off inlining?

-- 
Kees Cook

