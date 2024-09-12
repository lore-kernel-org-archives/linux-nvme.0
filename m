Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5665EEE6457
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjl9d4I+MDsYyxdyMz4VBOqk2OD6bH0zLUAhhrOM4GA=; b=Il8/K6mqOo04XD1TK0WGAwyY2U
	AHJiDMYe+BAHToJ5PsWinf/wm7P94xucXdmyGvuKOZQQzfL02uC1hUuwRRhs3XO8Njh6/N9AtU+X7
	sVzCTiJWgAzo82BOEQIKKifB8cG52RtQahCUd8xLJtQpZfG9iOMoVsn57QcWZNwF+fBYCSUOwaQkk
	hv9naskUEFnmOYqzaO3pYLD9bnNF/cfsXL203K6+rAj7CLSb9NU1e3SDeShuueVBC1F6JwUGu4K+8
	5ILV0Dy2G1WrycknsBg9Qc+ki+pOWNO6QoDewExalhAYArj0gNCZrLb+/eHfwKSgfgTT/mYsVqBf4
	Gnr+hP7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soeU9-0000000CEAT-0ZtR;
	Thu, 12 Sep 2024 07:43:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soeU6-0000000CE8Y-32Yx
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 07:43:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AC7E68AFE; Thu, 12 Sep 2024 09:43:20 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:43:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 05/10] block: provide a request helper for user
 integrity segments
Message-ID: <20240912074319.GA8375@lst.de>
References: <20240911201240.3982856-1-kbusch@meta.com> <20240911201240.3982856-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911201240.3982856-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_004322_934082_A2863265 
X-CRM114-Status: UNSURE (   9.90  )
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

On Wed, Sep 11, 2024 at 01:12:35PM -0700, Keith Busch wrote:
> +static inline int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
> +			      ssize_t bytes, u32 seed)

Please avoid the overly long line here and maybe use normal two tab
indents for the second line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


