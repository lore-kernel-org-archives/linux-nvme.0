Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AEAC3601A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OufFaCEXRsszYgyz82ULOQ316acHecpIhehpITIqHsA=; b=C8gECwKVlzCiP/lQKu3ClIYI+w
	XEMqe3ZIzK4WvRSRO4MVf2WEYhcNxDVgIFtPNvd07EJutxbyUws1dJwjImmQnUWUYz+8UUFKkP9MJ
	HzaN7kVs1GWEhGs+F3gPugHevWIrIzW89A3vsif2TZgA7oynWXbvr5sZFy6lqwG95mkIl/6uFALk4
	PGkosdBioxQdm+L6rO79btXZclzdrs7LuBHHNdQcb8j/pTU6TmOtasUZ9OETnSOQeIgubMz7xsEEA
	74WTwEjlLuE/V+wnT1rSjjuoHTci/v7wDTuQo3OtWGDwPR6aMWKBpNXfy7Z3hfYD7+m2wbTxQ2gxa
	zvFqC0ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0C9U-00000007jsB-16mZ;
	Thu, 03 Apr 2025 04:26:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0C9S-00000007jrb-0yDb
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:26:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18AF368C7B; Thu,  3 Apr 2025 06:25:58 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:25:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yaxiong Tian <iambestgod@qq.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 1/3] nvme: Add warning for PST table memory
 allocation failure in nvme_configure_apst
Message-ID: <20250403042557.GD22360@lst.de>
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com> <tencent_A06D513AE17E9D4B4AC66E84F447FE730C09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A06D513AE17E9D4B4AC66E84F447FE730C09@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_212602_407334_72FB937B 
X-CRM114-Status: GOOD (  10.59  )
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

On Tue, Apr 01, 2025 at 05:26:52PM +0800, Yaxiong Tian wrote:
> +		dev_warn(ctrl->device, "Failed to allocate pst table; not using APST\n");

Please avoid the overly long line:

		dev_warn(ctrl->device,
			"Failed to allocate pst table; not using APST\n");


