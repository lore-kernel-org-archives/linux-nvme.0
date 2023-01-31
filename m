Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B40CC38142
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6cJ8tW+8bEbeBmnIsFBccEWW1T4kP/EH4l3cpQdwPiU=; b=mZ2eaQsapCiangVFbRqgWtb+l+
	xPXdw4yxUgwjiFolO+yBzHia5Q8enIuaqmT66valcoar8anaGPZmtGNHGmg+KzLRNZViJdjvIE+QM
	l/8aaogkYf8c8rV2EOVhk2a7XHGENVdWFahzo2Qekl/5zcW0OKZZeeahRFhSjL/XW8zLnxRuFqeRf
	kmn6sIyxIaggbL5sl/DzO4tfM2HqC7WPDFXv5u81zoEthAnpt9+NjEkslBeZhr+E25/hpQHIyg9Dy
	AFhBAjWF4wz75J6q/VkfAsfyuoJbqFQZKZtCfuQvFCMhfO6RXA4/uqW7XkGsCxttLSf5yYNX0zVMn
	bQob+uvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMmTS-006sDA-8w; Tue, 31 Jan 2023 08:58:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMmTO-006sAr-Qa
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 08:58:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 782CB68C4E; Tue, 31 Jan 2023 09:58:29 +0100 (CET)
Date: Tue, 31 Jan 2023 09:58:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <20230131085828.GB3139@lst.de>
References: <20230130101449.1772800-1-hch@lst.de> <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com> <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_005839_022248_B32DAABB 
X-CRM114-Status: GOOD (  13.80  )
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

On Mon, Jan 30, 2023 at 11:43:28AM -0700, Keith Busch wrote:
> > Why isn't slot_reset being called after error_detected? Driver should be
> > returning "RESULT_NEEDS_RESET", which should have the pcie error handling
> > always invoke the slot_reset callback.
> 
> Are you using an older kernel that doesn't have
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=387c72cdd7fb6bef650fb078d0f6ae9682abf631

Oh, that does looks like the real fix.  That being said, what is
the point of flushing the reset_wor in nvme_error_resume?

