Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FA9C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=B2WlfiqTX0mrPtF/3gn9N7JxUP
	Cg841qHRl8NpMHq/7P9YPzGS73bwWcGIHb/0BJS4AQ76WYDWIkL8oiG4RFwSI+DszhxOQJSHJeSPm
	7b4s032i+gK1X8A73BmPwNhw4G/1aH+7sGB/Kddna2KPau5UZqcEso4VCl8iX+hcs6dwn6Au733/s
	aRys1Es0EJQXHVBvcbL7dz/PB80a83d0+e74YYPNhPjWQxWEw0D48Y3cOwIwvL0tSsznrskkzhp10
	kza33lqGpP16mFUawfLfnds1U3/VvO3y8LJ2aM7HpIBYoux/wlqu33L21U5t8KpNE6s93O3IIbJ9P
	PZER1KyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Xrk-000000017Oc-0Q4r;
	Mon, 21 Sep 2026 06:51:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Xrf-000000017N4-0aLg
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 06:51:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2C3C68C4E; Mon, 21 Sep 2026 08:50:54 +0200 (CEST)
Date: Mon, 21 Sep 2026 08:50:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: use assign_bit() where applicable
Message-ID: <20260921065054.GB13667@lst.de>
References: <20260919130820.3041544-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919130820.3041544-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_235059_318380_CD6F0AF3 
X-CRM114-Status: GOOD (  10.27  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


