Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B004C3ABB6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 04:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=An8FJYbH7fHFCmKYgxAkvcFLQI3QFlSqGo8/j4F+HEo=; b=b1POgAUpySpoZCH2GxH39lYfom
	tzqU7tD8ynI7Lwbp4/ag+ElWj/zKbP0sF8/tg2H0pOWMEUXSWMBYbJX9vssL/XliMf66OxW6cg2+o
	z7VkDnNqWVyfNZTVS8NufDY2qF77qEeSrqo7Rva8NNdudEs5qmxRrUt1zzq9xC4tHT/ga3hZ6e5UF
	n2fA+sIi3Mga9nY+EJWKJS1M/5/ixkGyU+SNRjP2Qzpq4B/s4YA6hwkRncpWBfwZ9Ot+PDkUxDpgi
	Dyw15NDBbiUPKVy4ou/IWCtUeEepltJmjeb1cgdtagtZSvtwo4zdMFRNhLBn53C7ypfPykxbCk+BT
	wUtOH9uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCWhj-0000000ECQU-0eQX;
	Wed, 07 May 2025 04:48:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCWhh-0000000ECQE-2Jep
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 May 2025 04:48:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=An8FJYbH7fHFCmKYgxAkvcFLQI3QFlSqGo8/j4F+HEo=; b=cXm7VPcR9aVtGwZXAcX98RkvTQ
	CmAeWl1uWbUmvoEbglH4HTLHa6iTUORtApA+GKg/gxQg65CuXrOxe0edykZRdpwgT7+Y2frsINzDa
	pgWIiZ8awAgW9mCwhynnWpHOLycjV0WsD2LRbc+wByzYCOOtv/LFegrpRqVfOeyWj85u0XSVIDCqI
	m+J09USB4jlbk1jwh3vl2wJQG4UT8QghcBQOrnDyN/7vje4ah4DQaRenx7SrdzPsNVjzUactDwnIY
	mF4P9xNyJCycFNvWZR7ow6dODohqw63O1D1lnSeDEecdygkZb+qxsNxs0m0AW9RzaUzOX57Kq+uMQ
	qlAhuGtw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCWhW-0000000FloE-1fjH
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 04:48:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFA5C68B05; Wed,  7 May 2025 06:47:54 +0200 (CEST)
Date: Wed, 7 May 2025 06:47:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <20250507044754.GC28402@lst.de>
References: <20250507033536.work.088-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507033536.work.088-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_054816_932582_C9833F4B 
X-CRM114-Status: GOOD (  12.05  )
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

On Tue, May 06, 2025 at 08:35:40PM -0700, Kees Cook wrote:
> The only reason nvme_pci_npages_prp() could be used as a compile-time
> known result in BUILD_BUG_ON() is because the compiler was always choosing
> to inline the function. Under special circumstances (sanitizer coverage
> functions disabled for __init functions on ARCH=um), the compiler decided
> to stop inlining it:

Can we place just fix um to still force inlining inline functions instead
of needing these workarounds?


