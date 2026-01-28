Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B0AD3F079
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T325+KaAj6XjwsziZiQu+EhweOtILOjwNW1wCheIVhU=; b=Qqv2vF0IjVTjRehQn8JBQuz7VO
	qsG+ouV19+wJtZKHAk6kyoH8CyzHQxLASQ2NZhlSCEaL4ApTwHtrKlujYeRxg0gADU8Pf5TSK8Irr
	jpQzUlecufhh8jyMOHQ1OTHCHnEYTNS3VvDJSaoP7aqXz5TNTCryN833q5mE7PoGD6pBxR/pmCubY
	Fttcujnq4/HAzO3m+SL8n7Da1m/PL+NYzy5n7NtOqPsh6pCljSSVOIY/v0fx/oZF+E72dYWIozOvn
	Wv+w+ZYOZiAHm0+g7esmTfi23lSc0q3RiSyk45EDfSz+ZNs0SzBlcP/LduagJycqf6qep70Ru8Rjx
	JcZ3G6Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl70f-0000000GDyr-3cfZ;
	Wed, 28 Jan 2026 14:59:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl70f-0000000GDyf-0FEb
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 14:59:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0AED460007;
	Wed, 28 Jan 2026 14:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0F7C4CEF1;
	Wed, 28 Jan 2026 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769612347;
	bh=gVOMR1V4hcjeaNYFYShKh4GCAi/n0lKjKVqv/7s0UjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXYgIgZQFpF4OaS2aeeh29HK5PXhUS6cCC9vxUcDunyQ/KZJL1RMIixiElusW8/Kl
	 n8yNYfLEWh3H2unOQH0bXnc2ismKxpNUUc/iuT+e0D+B9ICQZXheGbr82f4ptADSq2
	 YySOlRXCrqmnZmk+XLeLNngwD2SzJ0EcRF0zJRdAnJ1KweUqNV4K6x6NxkXEriFBo2
	 lm/Jci15Jfsesy2hvdnmb2GaVxY+aevqf1Ju60+/Lljv/kK1m1S7QatgzDuzE97nz7
	 dYfVD1djkmQ02JPD8eY9zRwymtgNAF0S0BhzJnWoolIaH11Tz+9+0TfJDV45zzjKpN
	 yz1jZaDr2UILQ==
Date: Wed, 28 Jan 2026 07:59:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: fix parameter order in nvme_free_sgls() call
Message-ID: <aXokOX20HMD0E_PM@kbusch-mbp>
References: <20260127195907.34563-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127195907.34563-1-roger.pau@citrix.com>
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

On Tue, Jan 27, 2026 at 08:59:06PM +0100, Roger Pau Monne wrote:
> The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
> parameters swapped.  This wasn't noticed by the compiler because both share
> the same type.  On a Xen PV hardware domain, and possibly any other
> architectures that takes that path, this leads to corruption of the NVMe
> contents.

Thanks, applied to nvme-6.19 with updated subject.

