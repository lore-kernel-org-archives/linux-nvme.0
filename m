Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8F5D2F7FA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEFApiMpjeuKNdO/lvm+QVIqO2UPrM0dnb3DChnzzKM=; b=GU2+4BFSkKKKshK/W9bvSVl26G
	AnLZ64Q8XJH+xW+cjMWfqf7LMPl4pYNe6tynmBl3KrdMfQhx4t2TxPIBVh8H+xo8LBnFMdSKYW7oZ
	IiMYwxvFtKyWvuaXqFVPhkMPjR9fkmV7qiKt2LMS+eBo2LW4I7Gwt/EaKsXK97Z7T8TnjePfAku/0
	38L8fym2KWeYJzpVf/vfXeLI1NPxn5Jilm9DVwZNyVvCmeo2cpOlBoMcvSyShVZw8CT91Qmz81z8a
	AnJo9cq6vcClEo00dwevErlyRQeG1pKD1ZaTqPCD6VQslN03AhVZNbYaXtvbj8mq/K1li5FMD4vYd
	+IfEupBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LO5-0000000E3In-3hRE;
	Thu, 17 Oct 2024 07:57:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LO3-0000000E3IA-1f3Y
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 07:57:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2800D227A87; Thu, 17 Oct 2024 09:57:31 +0200 (CEST)
Date: Thu, 17 Oct 2024 09:57:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 04/11] block: define meta io descriptor
Message-ID: <20241017075730.GB25343@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289@epcas5p3.samsung.com> <20241016112912.63542-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-5-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_005735_600700_032A0406 
X-CRM114-Status: GOOD (  11.23  )
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

On Wed, Oct 16, 2024 at 04:59:05PM +0530, Anuj Gupta wrote:
> +/* flags for integrity meta */
> +typedef __u16 __bitwise meta_flags_t;
> +
> +struct uio_meta {
> +	meta_flags_t	flags;

Please either add the actual flags here, or if there is a good reason to
do that later add the meta_flags_t type and the member when adding
it.  Also maybe the type name wants a prefix, maybe uio?

Also from looking at the reset of the series uio_meta is in no way
block specific and referenced from io_uring.  So this probably should
go into uio.h?

