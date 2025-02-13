Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89A4C021A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EN9hozUEjrM+zYicT+42pJFI80EO6BdmZLDjjPYi7LQ=; b=fMEyxiomO9d+esb6RvS/ecF1er
	1aMcqpD0s3SRMTn8ts2n1VvoClcvL+t49TqU3ECmX8e8XcO8el9AcYxxxfWTv4Xe6prPPnZKyk+/1
	/nWLZ3OaiWTZcHFtID1AoScySzFbZu84fAdmgK9YA104LItjUCa7afOHxP6wpdPFWUejUfrIk0Diy
	wyCT9wCALmBr5RV6l4zt3Q1YHvwbC5PeaUt/2GjI2eRRvb7nd8vYdA0AyrTM7LT3xyXmlhxChqRST
	2NbE+Swn4pzWtnLwB6oXEonZT6Xr2OgNnkJiY0XCq1V+jihsdR3jmK3Jiwo3RKhzN0DH3zSZ4ug6j
	hmjRndnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSPg-00000009tY9-1cEf;
	Thu, 13 Feb 2025 06:09:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSPd-00000009tXG-2i7p
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:09:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5ADE167373; Thu, 13 Feb 2025 07:09:21 +0100 (CET)
Date: Thu, 13 Feb 2025 07:09:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/4] nvmet: pci-epf: Avoid RCU stalls under heavy
 workload
Message-ID: <20250213060921.GA19608@lst.de>
References: <20250210220657.1762684-1-dlemoal@kernel.org> <20250210220657.1762684-4-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210220657.1762684-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_220925_873571_2AB65D64 
X-CRM114-Status: GOOD (  10.87  )
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

On Tue, Feb 11, 2025 at 07:06:56AM +0900, Damien Le Moal wrote:
> The solution for this is simply to explicitly allow rescheduling using
> cond_resched(). Howerver, since doing so for every loop of

s/Howerver/However/

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

