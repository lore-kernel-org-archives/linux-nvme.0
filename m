Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBD7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+nHjO0FlWSafR3YjpOT7rt4Z0HBx2CppoEaBPIpfN8=; b=HZPjykHe3qxfLBk/Zz0eyt4/PL
	1iEPGCliFGgbY8OXj+WqXN+9K5GpFuQTDJTuKvBLR6XTajGJAs/t/X0KxEuOE0UAKoWthQHKh7Adm
	Pvt9AtI0JTtBFW/KHhH7MPwesVtmLrCCybYQGoKMM9rE2qkas2yiGMIeGEUlu8RqH7PMuPYQsD4zB
	sbiEkF7sdyWVwHXF1gmZ+i5tcJiRC3eGz3MEXCV6qnl+Im6nMRRuJJhCkAQWi90C5yr+O2w8gKZ19
	77SivyuMgdmG2D9gRrcajMN+4nBpliCwlgXTMWdIqa9F/hQJiwnX2iizWGgP/tPv3GAp9KnusIQmZ
	1jMjLyqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTex6-0042eq-0Z; Mon, 14 Mar 2022 07:17:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTex2-0042eA-NW
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 07:17:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3CF0668AFE; Mon, 14 Mar 2022 08:17:05 +0100 (CET)
Date: Mon, 14 Mar 2022 08:17:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niels Dossche <dossche.niels@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v4] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Message-ID: <20220314071705.GA3903@lst.de>
References: <20220313234114.37931-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313234114.37931-1-dossche.niels@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_001709_086780_078B2E21 
X-CRM114-Status: GOOD (  16.13  )
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

On Mon, Mar 14, 2022 at 12:41:15AM +0100, Niels Dossche wrote:
> -	mutex_lock(&ns->subsys->lock);
>  	if (!ns->enabled) {
>  		pr_err("enable ns before revalidate.\n");
> -		mutex_unlock(&ns->subsys->lock);
>  		return -EINVAL;
>  	}
>  	nvmet_ns_revalidate(ns);
> -	mutex_unlock(&ns->subsys->lock);
>  	return count;
>  }

And now we lose the atomicy vs the enabled check.  I think we'll need
something like:


diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de069..46d0dab686dd6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -511,7 +511,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto done;
 	}
 
-	nvmet_ns_revalidate(req->ns);
+	if (nvmet_ns_revalidate(req->ns)) {
+		mutex_lock(&req->ns->subsys->lock);
+		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
+		mutex_unlock(&req->ns->subsys->lock);
+	}
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361c..06ba477fbf771 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -586,7 +586,8 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 		mutex_unlock(&ns->subsys->lock);
 		return -EINVAL;
 	}
-	nvmet_ns_revalidate(ns);
+	if (nvmet_ns_revalidate(ns))
+		nvmet_ns_changed(ns->subsys, ns->nsid);
 	mutex_unlock(&ns->subsys->lock);
 	return count;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de683..17cc1cda836cc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -531,7 +531,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 		ns->nsid);
 }
 
-void nvmet_ns_revalidate(struct nvmet_ns *ns)
+bool nvmet_ns_revalidate(struct nvmet_ns *ns)
 {
 	loff_t oldsize = ns->size;
 
@@ -540,8 +540,7 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
 	else
 		nvmet_file_ns_revalidate(ns);
 
-	if (oldsize != ns->size)
-		nvmet_ns_changed(ns->subsys, ns->nsid);
+	return oldsize != ns->size;
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index af193423c10bb..731f529e11a51 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -542,7 +542,7 @@ u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
-void nvmet_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 46bc30fe85d2b..56c20502b7ef3 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -123,7 +123,11 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 		goto done;
 	}
 
-	nvmet_ns_revalidate(req->ns);
+	if (nvmet_ns_revalidate(req->ns)) {
+		mutex_lock(&req->ns->subsys->lock);
+		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
+		mutex_unlock(&req->ns->subsys->lock);
+	}
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);

