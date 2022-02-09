Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C48BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZYx1R7pBgSQotHzPG1A707sgByV79UZvvP6PN+4bzs=; b=eFkRBqisEEvm9tXl9k4pRn2W82
	pyb4QhJa1cdpb5oHLFCC0rhJT7na9efODHGLZC841k+bsCFRWDBkkyjfPQlzay5c/o7IeiY5c24ne
	Pribe8tIRmhio6OHoEN9H1QXEPAXy0lWLOqJ7UAOsJoOlHx7eckkpnhAyDtfHJcDMwYHq9XUtZzL4
	MvChXCa9lJoDvYP5dX1s7t9kJdwo9Wunc1KwqX6dkrZ0+pd89ErgNWCXDeNDwls5+6FTY1DI5pv1K
	Q3mofZ145NasqjDeFbohNWYviK7IYvUi5nyEpBEylEIHr/Dkir7QIjARfdoC71EYFy+Km0awhv68L
	kDGwKDfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHnNh-000Ecn-Vj; Wed, 09 Feb 2022 13:51:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHnNd-000Eaw-FQ
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 13:51:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B50C668BEB; Wed,  9 Feb 2022 14:51:27 +0100 (CET)
Date: Wed, 9 Feb 2022 14:51:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, kbuild-all@lists.01.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Subject: Re: [linux-nvme:nvme-5.17 1/2] drivers/nvme/host/tcp.c:920:25:
 sparse: sparse: incorrect type in argument 2 (different base types)
Message-ID: <20220209135127.GA20537@lst.de>
References: <202202092122.25VLa0rQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202092122.25VLa0rQ-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_055133_701660_F4863008 
X-CRM114-Status: UNSURE (   9.74  )
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

I've folded this fix in:

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1096a0b0a268f..891a36d02e7c7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -917,7 +917,7 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 		union nvme_result res = {};
 
 		nvme_complete_async_event(&req->queue->ctrl->ctrl,
-			NVME_SC_HOST_PATH_ERROR, &res);
+				cpu_to_le16(NVME_SC_HOST_PATH_ERROR), &res);
 	} else {
 		nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
 				NVME_SC_HOST_PATH_ERROR);

