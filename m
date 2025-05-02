Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10368C3ABA3
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 06:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1NwBBfmcujf/cpUHpPcDqO4/+knaltXokWQyTmFhVHk=; b=05sP1JXq8cKtoiMfbtviFY0KoT
	VzpsjXIM1lviWw3QAQFYE+Y/q/vRlq5jf94QGp/lB9gIwCqaRwBfc5XqOaQKi2G0w6+wmgcJvi0uF
	YrDpZUK5VYGf8jfg8j1yUk5UuPn546NuopRfYsQ+zXnY0EYvalAryGgqtKJpcheTWE5vxJwekDuYB
	lkRIwGVVV1kc7uq7lSgrXHZ2xN+B/XGXMXIS6CCUwyiZay8FbtnCZ5rsUh2scKm1G1m/TrYg59BoL
	Crx198fug7SIvYdVNk5C2CeN3MxeD5v9Xg52SDMu7EBgWXtvXocfzAlSHu6DihFRPujPJ1IMpzsH/
	NYGHNwVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAkGT-000000011e4-0880;
	Fri, 02 May 2025 06:52:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAkGQ-000000011dV-03py
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 06:52:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A136C68BEB; Fri,  2 May 2025 08:52:39 +0200 (CEST)
Date: Fri, 2 May 2025 08:52:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 2/2] nvme: all namespaces in a subsystem must adhere to
 a common atomic write size
Message-ID: <20250502065239.GA8227@lst.de>
References: <20250430171830.1494033-1-alan.adamson@oracle.com> <20250430171830.1494033-3-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430171830.1494033-3-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_235250_193656_42F67C24 
X-CRM114-Status: GOOD (  15.07  )
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

On Wed, Apr 30, 2025 at 10:18:30AM -0700, Alan Adamson wrote:
> The first namespace that is configured in a subsystem will define the
> subsystem's atomic write size.  This will be based on either AWUPF or
> NAWUPF. Configuring subsequent namespaces in the subsystem requires its
> atomic write size as defined by its AWUPF or NAWUPF to match the
> subsystem's atomic write size. If a namespace doesn't adhere to the
> subsystem's atomic write size, its atomic queue limits will be based on an
> atomic write size of 512 bytes and an error message will be logged.

I don't think an error message is enough, we need to reject the probe
for this buggy configuration to prevent data integrity issues.

Otherwise the series looks good to me.


