Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C44FC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zU9XE8ZAYO/ApK+TcPB+r/d+FFxwyuenFh5xrekPxZA=; b=PBpnQrr2oIqA95zxk5DGrFjb3V
	xSp7blIyM6fFct+JvTq+Vzoejh0r2n3jd21NB6giHoCvrq2Ih2ofVpT4hQm+4+HAxb+gJlSqzvhPa
	TvnsZ78S5brcRxwUumJjwZ5l8Rmv6vQfimIgTmbiUzipLEJ1bFZA2fbaMGZxgbyqSSkvJT6HZjqCp
	3I64F7e803zb+a5F1xex56KNM9w40uvHMXTp0ke9EZQwxQm2YHTK58rAwExG9suNDYMZ3Mr45b/RP
	bcr6DcpApdveFyEZVIZorIxyzxuFURmLueHMZzByacip/QctD+MJXIZLIEkD6iuqNCmRKy0VRUN5a
	NhL80alw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoMZ-007VxB-6E; Tue, 18 Oct 2022 15:18:39 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoJl-007TvE-0U; Tue, 18 Oct 2022 15:15:45 +0000
Date: Tue, 18 Oct 2022 08:15:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: hch@infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Frederick Knight <Frederick.Knight@netapp.com>,
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: force reconnect when number of queue changes
Message-ID: <Y07DIJf9BjHzPewa@infradead.org>
References: <20221007072934.9536-1-dwagner@suse.de>
 <20221017173817.j7cjvxnvs2lcntea@carbon.lan>
 <Y07A8HxPj4cM7RVT@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07A8HxPj4cM7RVT@infradead.org>
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

On Tue, Oct 18, 2022 at 08:06:24AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 17, 2022 at 07:38:17PM +0200, Daniel Wagner wrote:
> > Hi Christoph,
> > 
> > Please consider to add the patch for the current rc phase as it fixes an
> > invalid memory access and I would like to avoid that the code fuzzer
> > army is going after us :)
> 
> I filed this under enhancement and planned to add it to 6.2.  Canyou
> explain the invalid memory access a bit more?

I guess this would the minimal memory access fix?

---
From c881123281d429da61ebd049c0867f8520dbfcb3 Mon Sep 17 00:00:00 2001
From: Daniel Wagner <dwagner@suse.de>
Date: Fri, 7 Oct 2022 09:29:34 +0200
Subject: nvmet: fix invalid memory reference in nvmet_subsys_attr_qid_max_show

The item passed into nvmet_subsys_attr_qid_max_show is not a member of
struct nvmet_port, it is part of nvmet_subsys.  Hence, don't try to
dereference it as struct nvme_ctrl pointer.

Fixes: 3e980f5995e0 ("nvmet: Expose max queues to configfs")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20220913064203.133536-1-dwagner@suse.de
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/configfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e34a2896fedb2..9443ee1d4ae3d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1290,12 +1290,8 @@ static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 					       const char *page, size_t cnt)
 {
-	struct nvmet_port *port = to_nvmet_port(item);
 	u16 qid_max;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
 	if (sscanf(page, "%hu\n", &qid_max) != 1)
 		return -EINVAL;
 
-- 
2.30.2


