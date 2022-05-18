Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025AEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 04:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9A6+JofltEFoj7YgsDM+78pjILvy+7P/odXSdgtbcY=; b=q2c2cCec4Qg7IqhiV0GEQz2gKL
	IhC6+SY/M1HwU57lt+Yok2FHB9NKStrOnTNdO8itvHY+Bq1iAqHVxNYRytRaDX+C4CWcLPhBFsAQ4
	CAaa73mHG30ytrWsB1966PmrxgDs+s8w9KO1UzFS4MBOOjYkbmPZ/VmwwJ7KFNikEq4dxfHbtFTo1
	a6J+WOPImTJKBgfnwNO4dPmsFwEGp7NZWbfylT+wJOFoTmW08Ou8F+dfMmknlRpAQNAdrtItMoKzm
	xpE/tR87v5eVZQRFfqlCxLgMdcDrGfpCowvdnYVYMcAubPc1nAYqCQyPyrxhmMw/VBpuP3mJH5/fV
	24RgUY0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrBkJ-00HBSR-IE; Wed, 18 May 2022 04:57:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrBkG-00HBR3-Ee
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 04:57:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 22C5B68AFE; Wed, 18 May 2022 06:57:05 +0200 (CEST)
Date: Wed, 18 May 2022 06:57:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Tree for May 17 (drivers/nvme/host/fc.o)
Message-ID: <20220518045704.GA30131@lst.de>
References: <20220517194118.2caa01b8@canb.auug.org.au>
 <5958ccea-d89c-8b1a-15d3-19d8cacd141d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5958ccea-d89c-8b1a-15d3-19d8cacd141d@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_215712_664317_2B4DBC11 
X-CRM114-Status: GOOD (  12.05  )
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

The patch that adds nvme_fc_io_getuuid need something like this
folded in:

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a11c69e681180..3c778bb0c2944 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1911,7 +1911,9 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
 	struct request *rq = op->rq;
 
-	return rq->bio ? blkcg_get_fc_appid(rq->bio) : NULL;
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
+		return NULL;
+	return blkcg_get_fc_appid(rq->bio);
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 

