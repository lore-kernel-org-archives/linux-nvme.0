Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1686DC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=11eF6S3UsLuAQLuoHLt5sJMbkNxdrTEW7lesrH0LoHI=; b=DAT6Hkdbp1AySj6Mp0y+EiryKW
	J0bC9Kijeu+3yySNqKUfx/j9dcGQj4D+bZ068u7WhaArvu3oq5YMARxYi4twKV+KzYwwSbIC3RZeZ
	DgT8MG5K1D/cPK5EiwrEEBmcEObKUVBqNnAZqQq6KK8cFw//AqxiXJIYWeMBIiM50TEe8KegDqvJA
	jl6WLeYtbqop+qnnZ5f084qmJi3WuSHFTQXPRdid22z6mchujvpjplt2KXB5laddiPESpVHmXxqLR
	zruGDLz5KKR5jGn/qmmtsKysUXQp/BvHBpXUlILQAgaDPSIyslpVu379UjTg9xyBeVo3r2FLEpIr4
	Y5Q/l5Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBGLo-00DCe8-2s;
	Thu, 07 Dec 2023 15:31:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBGLm-00DCc7-0F
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 15:31:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8CF6A227A87; Thu,  7 Dec 2023 16:31:38 +0100 (CET)
Date: Thu, 7 Dec 2023 16:31:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 0/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <20231207153138.GA20644@lst.de>
References: <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-4-dwagner@suse.de> <hryojvgqgmhie6s3ykr6242bqybb2hnzfiywwaij4cmennvb6r@xs5ibnslvhg5> <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-4-dwagner@suse.de> <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-3-dwagner@suse.de> <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-2-dwagner@suse.de> <20231207123624.29959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hryojvgqgmhie6s3ykr6242bqybb2hnzfiywwaij4cmennvb6r@xs5ibnslvhg5>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_073142_256985_94E0A7F1 
X-CRM114-Status: GOOD (  14.81  )
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

Hi Daniel,

this looks generally good to me.  A few comments, all but one are
cosmetic.

> @@ -1676,9 +1678,9 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,

This an now take the ns_head instead of the ns.

> @@ -1776,11 +1778,11 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)

This can take a ctrl and ns_head instead of the ns.

> @@ -1835,8 +1837,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)

This as well after updating nvme_ns_has_pi to take the ns_head.

> @@ -1898,7 +1900,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  		struct nvme_ns *ns, struct nvme_id_ns *id)

This as well after fixing up nvme_lba_to_sect to take the ns_head.

> @@ -2052,7 +2055,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,

This one as well.

> @@ -128,7 +129,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  				   sizeof(struct nvme_zone_descriptor);
>  
>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 get_capacity(ns->head->disk) >> ilog2(ns->head->zsze));

This doesn't work, as the head disk doesn't exist for !multipath setups.

> @@ -162,7 +163,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,

This could do with ctrl + ns_head now

