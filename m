Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1543C7115C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 06:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+e0mjZ7qCc2ERvB8ZX+fjY3UqQjytIcocRTP4vLXrFE=; b=UGf4GwSFwMs6hY2p/Z1QkGNGfg
	nsmbxe47LVEGu8Dp4676DhTqmdBxnjLcf/HDgiC32WwjybmWX2WDQzJUxobMnnk+Xoj8oxhYbwUeq
	IRQz5xaqs7UmImKv8/J+ZEzUUHwVXt5zPH1R2aO5kgD0AXWDfOGlw4bbZ7xnCmX/azBkECTXJO0do
	2zD71Phd7LV/KJiGajxi+T9vHur3B8OkqpIpeQHdcn0bLTLi4wJIw5ZlFpxMCPD+h7dVojEroBoA4
	cKN0NXgfatn2dkYl/B5Zsyv6jpyZGbFpsjxLtON/NI74bss5FZif9qEyA+fuMK4+cBid1geVV7mRn
	ZAq3h9Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJNp-00000007dSX-1nXB;
	Wed, 25 Jun 2025 06:13:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJLI-00000007dDy-2aaE
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 06:10:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC7B1227A88; Wed, 25 Jun 2025 08:10:40 +0200 (CEST)
Date: Wed, 25 Jun 2025 08:10:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
	axboe@kernel.dk, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: Re: [PATCH 1/1] nvme: correctly account for namespace head
 reference counter
Message-ID: <20250625061040.GA9457@lst.de>
References: <20250620080257.27993-1-nilay@linux.ibm.com> <20250623122019.GA22176@lst.de> <a16bceaa-cb73-4d23-b145-25d5bc74eded@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a16bceaa-cb73-4d23-b145-25d5bc74eded@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_231044_796033_4F2C0922 
X-CRM114-Status: GOOD (  11.66  )
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

On Tue, Jun 24, 2025 at 07:54:29PM +0530, Nilay Shroff wrote:
> Thanks! I'd update the above typo, however today I was testing some code 
> after disabling CONFIG_NVME_MULTIPATH and I realized that although the
> namespace head (ns->head) is still created, its associated head->disk is
> not initialized in this configuration.

Yes.


> So I'll send out patchv2 with the above changes.

Thanks!  Please also add a comment to nvme_alloc_ns as the logic is
fairly complex now and future readers will benefit from an explanation.


