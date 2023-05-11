Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41805C77B7F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 13:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wXlava8w9OO7hLih7x1LWLkul08vT6AJRZxcuV9P3+M=; b=tVeGw/YVufp+fDjCVoH03N/fnO
	e2SKP8WRmP+a6VG5hW//bipgeFYdbTRf/AU0suNjQt0v9LDwfuLHfHa/QD7WlIxLizTFD70CGav1t
	6isKg0Eii9GqbuWvcQB2MmdDHUTCilV4vTuOQcW5X8B6PreUbgl/M4/qd6479A+SmlKT8gGWUDiuJ
	AQbxAXFHybi5bHN+1VMR84BpiAXvUhNrGcmOQAAzATIwQ103ierddP3xiW5XhOWXhwIkwrZrw3gA7
	ZbWNUff/NL6LAcvgi9J52DY7ZdcNYtUuSg2dzq0iQFfDACvwmuWnPfJpNiLGR5HYPnkgM/zjI0/II
	FByXv+YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px69o-008qIe-0G;
	Thu, 11 May 2023 13:16:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px69m-008qHK-0z
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 13:16:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB34468D08; Thu, 11 May 2023 15:16:25 +0200 (CEST)
Date: Thu, 11 May 2023 15:16:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, hare@suse.de, axboe@kernel.dk,
	oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/3] nvme-fabrics: prevent overriding of existing host
Message-ID: <20230511131625.GC29790@lst.de>
References: <20230510180231.18865-1-mgurtovoy@nvidia.com> <20230510180231.18865-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510180231.18865-4-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_061630_483101_25A6359C 
X-CRM114-Status: GOOD (  11.46  )
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

On Wed, May 10, 2023 at 09:02:31PM +0300, Max Gurtovoy wrote:
> When first connecting a target using the "default" host parameters,
> setting the hostid from the command line during a subsequent connection
> establishment would override the "default" hostid parameter. This would
> cause an existing connection that is already using the host definitions
> to lose its hostid.

We need to reject that second connect - hostids and hostnqns should
have a 1:1 relationship.

