Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADEBC021A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5r6m2ywP8yh9T5o1LC8qrUwAXWOQCaialTHoep+phc=; b=HPKK5f4up0qOMIp1CUhhq4WKaz
	HXT4B6KZNZUz2cNMAnjdPXjZvxEKDw912sYjmPpeXH4cGIe+U+uFVJkFhsA+Y1T3bXy1YPzFmIykp
	km9R/GF8cVY6RCpwiiMvWRPWYtZxuOvi9Ov9r5IGj1Jg6FG/p86E/Ch5mkxkI/QzBaMe1Ecsu/Kpf
	HLYP9mg2mFse6RKSHjV+4JiYHewwko6sRYabfzX+FuLzkpUfgzzWMkR/iSdrj8iJw6QYnLEXa7y8e
	K0C8mav9jwhmS3PWMV2WvlgH4ehh2vV9QiFPVLm6NUPY9B5sR+ZKAxb5OM85CD1soCMLO3PrTaQIk
	XVAAk3LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSdL-00000009vOE-3Vrc;
	Thu, 13 Feb 2025 06:23:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSdJ-00000009vNC-0hvf
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:23:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C153768D05; Thu, 13 Feb 2025 07:23:29 +0100 (CET)
Date: Thu, 13 Feb 2025 07:23:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: Cleanup the definition of the controller
 config register fields
Message-ID: <20250213062329.GA20095@lst.de>
References: <20250210002935.1744249-1-dlemoal@kernel.org> <20250210002935.1744249-2-dlemoal@kernel.org> <20250213060051.GD19506@lst.de> <9455ccc9-75d4-4329-938f-e5691d92caa5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9455ccc9-75d4-4329-938f-e5691d92caa5@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_222333_347627_5888F765 
X-CRM114-Status: GOOD (  13.96  )
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

On Thu, Feb 13, 2025 at 03:07:51PM +0900, Damien Le Moal wrote:
> I find the single enum for all the fields of the same u32 register to be a nice
> grouping of things. But I agree that more comments would indeed be nice.
> I can add that. But do we really need separate enums for each field ?

Ah, not really for each sub-field.  But the nvme code traditionally
also used a single enum for multiple register or struct fields.  If
I read this to quickly and that's not the case here all is fine.


