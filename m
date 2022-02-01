Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8A9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 08:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UtotCnSRV6Ep/obTlVRoUman0h0xnGkPTaiRrGR080=; b=dnFRfmPIbaVC4GToCsqNYVhJI0
	9CxcZ6LwdWG7Ge+YdELsRDjiWsJHVlUGVQDaNMjxf+Nv8X7Q0oKnvJDvLvwHX2qjX1jMkRv61tgHh
	ikuOAwXl1DCQlEMg3O+j/p4HBqnwxQOF7EUywt0lR0ON2hQvG5T2SB9r81lvJBvIoUAytiBIo14+F
	GNByYPmT52Fv6O16eKdYoP0CaXMwIhICKaAZd3D9HWmFSK1/Hw3xUBRZ6WrfcVj0w/+1ovU0Wzkyc
	Qwb7jYYZTAaoUx6fgUXg/JWE/LzglFo3ud2H4y3DtjkhsH23YA5P4sVeFmrzBb1o/ZRiQ+7lyqC7+
	ykEd2xLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEoEO-00BTE1-9t; Tue, 01 Feb 2022 08:09:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEoEL-00BTDB-PC
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 08:09:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7852268BEB; Tue,  1 Feb 2022 09:09:34 +0100 (CET)
Date: Tue, 1 Feb 2022 09:09:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/9] nvme-fc: add a helper to initialize connect_q
Message-ID: <20220201080934.GA29769@lst.de>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-2-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128092015.19289-2-chaitanyak@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_000937_988489_373DFC08 
X-CRM114-Status: GOOD (  13.11  )
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

On Fri, Jan 28, 2022 at 01:20:07AM -0800, Chaitanya Kulkarni wrote:
> +static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
> +{
> +	ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
> +	if (IS_ERR(ctrl->connect_q))
> +		return PTR_ERR(ctrl->connect_q);
> +	return 0;
> +}

This should be out of line in fabrics.c.

Also I'd prefer one patch to switch everyone to the helper in this
case.

