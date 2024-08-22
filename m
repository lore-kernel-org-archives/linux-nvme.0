Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8B7C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 07:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ufy1PVtl+765PIyrd6yi6dg/rc
	1RVxuMSQEU31V7vXN+GD8xErXmoCXQzB09ncyTdNYCWE5jsHZXF0nzrAvyrHZi9SSJYrVXHqNO0bd
	SAKde4PFamoEtOcZZXvo+6u5sV7cH9BQR1dNhUEdsLyDy9MBLVmcWT12nN/Gy6Z3bUPb2n0hmGop7
	EdXLTi1/mc+YWWv1+0YX081jaYI8YEWKB8Oa/R6z4O7DCYuIuAqEbpFG+iQAYRnirXqcBjFxc+AvO
	/2aPgiIdeg2yFYnEO+1WOQm1zB7+aNOZIylA0MYdfwlcuUEoQZFibGVmRZS0W6mIqTmYX7dy5p1Qv
	Cw8b+XOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh27B-0000000BpcE-29G8;
	Thu, 22 Aug 2024 07:20:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh21f-0000000Bn96-3dE3
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 07:14:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3993F68AFE; Thu, 22 Aug 2024 09:14:28 +0200 (CEST)
Date: Thu, 22 Aug 2024 09:14:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next RESEND] nvmet: Make nvmet_debugfs static
Message-ID: <20240822071428.GA6374@lst.de>
References: <20240822071916.3547318-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822071916.3547318-1-ruanjinjie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_001432_074970_B0348803 
X-CRM114-Status: UNSURE (   8.96  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

