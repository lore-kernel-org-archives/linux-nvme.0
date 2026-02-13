Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA45EF48D3
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BxIfRHoXpdjVsSCv83KDq7udKWSwAWjyEx4yUc+0Omk=; b=Xlw7W/ZDiXuZVzmC07eiualxdl
	0GAruebosHT7OPo7lwoqaVMsrB6B6RNf1mzHoy3JxJMemV/2oJonl9ELvTAqRyPZaBlDZUnnfpcr+
	OnXMIKwwsAWXzB1kKlJ4d1LPjP+ntzhDLEi5x6pLH0uYqe9X+gZE3RhtZr55su2QbpRxsa8ZqjK1x
	zHge20KHP3k9ppoOmxdMK+GIxa6HP6uK9DzY+a9xRhFs8EnIJBz4JMvSWJVpgIZmX56ULyGNHf2CM
	bB59lujX1yqiSR5mi/KmCH6fBAtE+VnPQHGMOeNQ3uMGUMfliFV/chTBfsMBodnX7dLdigmGfCKQK
	6g63iIAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqmcE-0000000340A-1pUj;
	Fri, 13 Feb 2026 06:25:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqmc9-000000033z7-3SeJ
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 06:25:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CE9668B05; Fri, 13 Feb 2026 07:25:15 +0100 (CET)
Date: Fri, 13 Feb 2026 07:25:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/3] nvme-pci: do not try to add queue maps at runtime
Message-ID: <20260213062515.GC27228@lst.de>
References: <20260212164733.3006071-1-kbusch@meta.com> <20260212164733.3006071-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212164733.3006071-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_222520_467300_A14A137F 
X-CRM114-Status: GOOD (  10.55  )
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

On Thu, Feb 12, 2026 at 08:47:33AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block layer allocates the set's maps once. We can't add special
> purpose queues at runtime if they weren't allocated at initialization
> time.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


