Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6BDCFC616
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuAGHalgN187aCTAXH9tWoiSlW7vz7FjqGo+Yy8WtoY=; b=nokIPZ7pr84KJWP8CeuxYIX2i8
	THQhfLDhmfiMy3b5oI56bZSMSzPMuZVGfjSKxDt1q8JmwBpIOZvrnn/1RlxJpltpvpzxjdbfszLP7
	Sl/ztjEnOuoFVjaoa5wUcD+r+jB85KwGMcukUqO+7Vo/kRi95fmwizKSLhOQrQ1fZ6Fdo5zFK0Z44
	XbC6IFvtrarjAh1wmyQNbQac0LB7zNUSwpHlt/pd5MBzpwnvWUwiMgeL4WVDCvJswADpjDxtbrWKH
	BZqH5s9o/2tb8tqH/EGbsjU85yxn/XIwVJYCNQlg5K7CiUOCycv1XESpcjVRUXlOdxd9WR8utqbF6
	vKCPgXzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAjn-0000000FeS7-01nb;
	Fri, 11 Oct 2024 08:11:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAjk-0000000FeRH-08nV
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 08:11:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FBCB227AB3; Fri, 11 Oct 2024 10:10:56 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:10:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v14 2/2] nvmet: support reservation feature
Message-ID: <20241011081056.GA3320@lst.de>
References: <20241011022612.50303-1-kanie@linux.alibaba.com> <20241011022612.50303-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011022612.50303-3-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_011100_237192_537EACEA 
X-CRM114-Status: UNSURE (   8.27  )
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

Looks good, thanks a lot for all your work!

Reviewed-by: Christoph Hellwig <hch@lst.de>

