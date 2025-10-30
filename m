Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439C7CCF9EA
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 06:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mo1e776+UxVu7E9tGjrN6btd+vWw6inY97Hwh9LfoJA=; b=HPskwMoO5k2r6/lkeGX4CIom0B
	uGEPcq18mE5WhiQjclmGEhVaza0lBc/esP7W4DxiiwlkKdOXQQkpW+aTmZR75K7J3oCZCxF8NIvgc
	ckLPGxczwK/zqDB2baN7+XYjDTy8JL6EjAhb3tznzfQHQNJ+tbo7MQzRJzXdZGqG3k+mzoTatzw3W
	5x3hfz64IBO0pqmEb2wmgnc5s+VwzkXwN4lLnWl4DdQFvAjtBAxw9KN4ZY8XNzIsuYFAPPWIyN7yU
	vH0oTk5tgW/salT6h1jIpvHo4fWCFBEHJ8IZH1/83HQqgJZSv/NfNrKRzv1uOkjtsR27AUowXix2d
	3ucTJO/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vELjZ-00000003XHv-1w6y;
	Thu, 30 Oct 2025 06:02:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vELjW-00000003XHR-2fDU
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 06:02:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88CB5227AAA; Thu, 30 Oct 2025 07:01:55 +0100 (CET)
Date: Thu, 30 Oct 2025 07:01:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvme: split host and target nvme_auth_extract_key
Message-ID: <20251030060155.GA12793@lst.de>
References: <20251029145745.3723258-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029145745.3723258-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_230202_839388_2C1BCCAD 
X-CRM114-Status: GOOD (  16.63  )
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

On Wed, Oct 29, 2025 at 07:57:45AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The host and target share common code, but the config allows you to
> disable support for one and not the other. When support is disabled, a
> stub implementation needs to be used, but that would clash with the real
> implementation that the other relies on.
> 
> Split the host and target implementations into uniquely named stub
> functions that either call the real implementation or return an error if
> their config option is disabled.
> 
> Fixes: f59ae5c9e356b5e ("nvme: parse dhchap keys during option parsing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510100105.cibujuUJ-lkp@intel.com/
> Signed-off-by: Keith Busch <kbusch@kernel.org>

This seems a bit backwards.  How about dropping the stub entirely
and guard the calls with IS_ENABLED or if needed ifdefs instead?

> -	key = nvme_auth_extract_key(host->dhchap_keyring, secret, len, &generated);
> +	key = nvme_auth_extract_key_target(host->dhchap_keyring, secret, len, &generated);

And maybe fix the (pre-existing) overly long line here if you end up
touching this.

