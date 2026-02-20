Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C93AC5ACC1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVcyHLQuUkknR71CtFWqukCCln/EGzf2gQM3jagot5Q=; b=jRP9d/YuUeNbECbtMEic1la6P0
	iZOqUFaR8hElu0EtLDYl6oxsQXQ1e1w4X6YfmkbdkywGBD+O68axS1QzpLi2rAM9PVfWf+O2sJ2B0
	+VhgTCDPvWquep8mrzudKgzqfM3AItR6fJgcsrTMEn8jxlNlTlWNRkQTIOiG6z+M80M+9RGmR2Ug6
	MIuIkejD/pSs7Qt6z4FTjYtIYKLkhHQzjulAz3m9bsCPd50ewhIt5NhG+q8w89yf5QuyJIdMKwkeq
	/TYMeAMwjlqYdCAoC74LQLA2fK7dmvZ+ugH3YlZpe6vV3Pbt76mVhLWcwyYFp/NjjzrQ6r8SpK+z8
	GeciIZZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT3S-0000000FAyZ-1r0K;
	Fri, 20 Feb 2026 16:08:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT3Q-0000000FAx1-21Ff
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:08:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 542BE68B05; Fri, 20 Feb 2026 17:08:30 +0100 (CET)
Date: Fri, 20 Feb 2026 17:08:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] nvme: always issue I/O Command Set specific
 Identify Namespace
Message-ID: <20260220160830.GD15071@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com> <20260220032809.758089-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220032809.758089-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_080832_662351_D1E1D049 
X-CRM114-Status: GOOD (  17.05  )
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

On Thu, Feb 19, 2026 at 08:28:06PM -0700, Caleb Sander Mateos wrote:
> Currently, the I/O Command Set specific Identify Namespace structure is
> only fetched for controllers that support extended LBA formats. This is
> because struct nvme_id_ns_nvm is only used by nvme_configure_pi_elbas(),
> which is only called when the ELBAS bit is set in the CTRATT field of
> the Identify Controller structure.
> 
> However, the I/O Command Set specific Identify Namespace structure will
> soon be used in nvme_config_discard(), so always try to obtain it in
> nvme_update_ns_info_block() if the controller supports NVMe version 2.0
> or later.

This was done kinda intentionally to avoid extra roundtrips and
tripping over buggy implementations.  But I think you have a good
use case to extent this, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>

>  			goto out;
>  	}
>  
> -- 
> 2.45.2
---end quoted text---

