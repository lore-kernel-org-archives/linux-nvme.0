Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01D5D75E32
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYpC3dzMX2POMj92fepelguscLl+P1fSkMW7axa2eQ0=; b=3VtKcOYoBY+TQt3Lo9txMP1C2D
	9LR3iqDoTINiWRLJ7K0vnj9UZCqMrXPelSj3ND8iKaAb3dEyBpSpB+NWDF6mhu3//hZeMsc/yGuNF
	kLSgl89gODAy2B4i5BqoWa+s68ycfNTaTW0xdQwnSTYET3pamLC3bHOwGT8qqAZlKKp0LLvEXXK81
	PGXF2n/f+ugV4ZqIWx/8VQgXo+OzxY054AUsKCGmIuthTZGNAnw51+aVM3MxxcWgEZFsbDZGwtbfs
	3ryes5gnQ0Pox8p6ibuYQU9/rtbd2VOeba5UUMNA5NYS0vq3ejpwcbViVS7zQJ2RPz6uy9bpwBWdT
	XVLHM0+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tESU9-00000002QI3-0cKC;
	Fri, 22 Nov 2024 12:10:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tESU6-00000002QGn-3BuI
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 12:10:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CAAE68D0A; Fri, 22 Nov 2024 13:10:00 +0100 (CET)
Date: Fri, 22 Nov 2024 13:09:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: handle rw's limited retry flag
Message-ID: <20241122120959.GA25831@lst.de>
References: <20241121102454.122247-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121102454.122247-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_041002_940342_1707FA65 
X-CRM114-Status: GOOD (  13.21  )
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

On Thu, Nov 21, 2024 at 06:24:54PM +0800, Guixin Liu wrote:
> When the nvme target receive an rw command with limited retry flag,
> handle it in block backend by setting the REQ_FAILFAST_DEV flag to
> bio.

Do you have a use case where this makes a difference?

The code itself looks fine, but I doubt it's actually useful.


