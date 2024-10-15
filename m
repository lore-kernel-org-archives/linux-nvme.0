Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2E9CFC267
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 05:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2yVEm3dZM7KZafwowkz75nqIXloZ7yjS1F20KKLAR0g=; b=R2Z+j8LPxRpPurLQXjGUjQOXRM
	KCxzsKU1tDtzYmEKDZrC93jX+o3zs6BHv+m8K6WVnd4N66JNy5J+a1rVry6/TDgMvn/c6r7K5GfzQ
	GDE7V/VDg2YSDNA4t0vqb4rtP10D9HCQqtnrlLRtzmKlHRC3JiN5wfzFHFNmbbO5A05SyDNbU6bSi
	sh+6ixo28x7h3iH4rF5ipQ+5rAN5MbGQdZq7MQ6WHBYJu9MS4ToeGnOltSyhVMOzI9gEyCY/SsVpu
	IlQKHfTGrrmv9B5uu6VCKeDPyu7U5m5O3f1K+j7uZcrvPVkrjYwDghtY2ZnihXe8PxA5P5p7WuzZz
	BRuoe1sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Zfe-000000074jv-0Tnk;
	Tue, 15 Oct 2024 05:00:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Zfb-000000074iH-2oJI
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 05:00:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 31F5B227AA8; Tue, 15 Oct 2024 07:00:28 +0200 (CEST)
Date: Tue, 15 Oct 2024 07:00:27 +0200
From: "hch@lst.de" <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v14 2/2] nvmet: support reservation feature
Message-ID: <20241015050027.GB18218@lst.de>
References: <20241011022612.50303-1-kanie@linux.alibaba.com> <20241011022612.50303-3-kanie@linux.alibaba.com> <11a10ade-fa1b-4dad-9a80-1d1681e8bd0f@nvidia.com> <cceb6b00-0c52-4788-96c7-9cc69928fa26@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cceb6b00-0c52-4788-96c7-9cc69928fa26@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_220031_873519_70258E5D 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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

On Mon, Oct 14, 2024 at 01:34:29PM +0800, Guixin Liu wrote:
> New 6.12-rc2 add a commit 5f60d5f6bbc12e782fac78110b0ee62698f3b576("move 
> asm/unaligned.h to linux/unaligned.h"), I change my code to fit this.

Requiring a -rc2 base for the next merge window is perfectly normal.


