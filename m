Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A80C19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIk4Rj8hkrset5Bq1b3xI7jiQsFzwYLel82keS0u7aQ=; b=sMyG1uBLrTvfp2q44ZkX8/wocS
	IrP6eQdpfpghh6UrCdXCjMR9CEheA8/HDg1OOxAYkR8/FesIFduEaYhUzsf2JivMrW59HcZiHyAPa
	DVZndpz24cuHG8F5Pn4NG4sK/HONMl0Zxv7CxYF7inVkSCRndCnmgkhhyaZp/zufPiv6Bp3Y2kraw
	NoEWgE8DO66YFIpNcUm3DTp9OOG+/WbnTHMz3PMPkCyP3uPjf+2XEn/Pv21Q8wVCiGhC17CBpAluQ
	lUxDwSb5DHbLGaz7JmxJx8DSiktT1AgIcNO18bGuiz/iEwZwkVF+ko2503f8oHUBOb223y1U3LD6+
	LmLBfxMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tppZC-00000008JYx-0jY9;
	Wed, 05 Mar 2025 14:17:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tppZ9-00000008JY0-3AJv
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:17:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 753F068C7B; Wed,  5 Mar 2025 15:17:40 +0100 (CET)
Date: Wed, 5 Mar 2025 15:17:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
Message-ID: <20250305141740.GC18065@lst.de>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org> <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_061743_934335_CDAA7573 
X-CRM114-Status: GOOD (  14.97  )
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

On Wed, Feb 26, 2025 at 07:45:54PM +0100, Daniel Wagner wrote:
> +static void
> +fcloop_lport_free(struct kref *ref)
> +{
> +	struct fcloop_lport *lport =
> +		container_of(ref, struct fcloop_lport, ref);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	list_del(&lport->lport_list);
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	kfree(lport);

Maybe it's just me, but I find the kref a really horrible pattern over
usig a simple refcount_t.

Otherwise adding proper refcounting looks fine.

