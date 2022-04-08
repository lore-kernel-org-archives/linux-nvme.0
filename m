Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAC5C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 06:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBr++v1qv1t3nZXiFcqOYIBvmHCty8TSnifbDoZ0+4A=; b=2QeVjzMSRmlJRvhyGXKF2pHfGR
	SACXt5nH/tJ/z1XBHh4o9iBwQYuNtL2+tvVo42zfkNM4wc7cpQfPczHjuYzJ/PYK1rV9l+nQ4OxRJ
	LkHUchHcfauouShYPGE95nwo+t8cxIKly7BfSX7AnNu+tnwdgYoG/sB3MrCxFnGdXGkDJB0HGFPOj
	oGZ/7NQAP6F1kcuQrh7xjQe6VLsdKog7QG2Fse+tAGS4o7gnWMqwcdXB7H0Za5ZYA/uyrOoN3WVg1
	jofks7ntZZy+P5AGlcze07bet1+INbyygS+uV2DGF5aZXArKADmTublsGrt6KCi03UmZwHa0oV1w+
	UygcD+0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nci0g-00FHQ4-2O; Fri, 08 Apr 2022 06:22:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nci0e-00FHPZ-6I
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 06:22:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BE9CE68AFE; Fri,  8 Apr 2022 08:22:10 +0200 (CEST)
Date: Fri, 8 Apr 2022 08:22:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: me@kingtous.cn
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, sagi@grimberg.me,
 kingtous <kingtous@qq.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even
 if nvme_ms_ids_equal return false
Message-ID: <20220408062210.GA410@lst.de>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_232216_423126_D48597B8 
X-CRM114-Status: GOOD (  15.58  )
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

On Fri, Apr 08, 2022 at 02:12:13PM +0800, me@kingtous.cn wrote:
> Yes, I only have one controller with one namespace.
> I've done `nvme id-ns /dev/nvme0n1` times before and after suspend. The only difference between the two output is nuse address. The nuse address's output is dynamic, the outputs are different each time I execute the nvme id-ns command.
> When the laptop wakes up, tty will show "identifiers changed for nsid 1". I checked the "nvme_ns_ids_equal" function, it will check uuid, nguid, eui64 and csi. So maybe there is something changed in uuid or csi?

Let's try this:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8e2d5..0c38184a3ffa2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1631,10 +1631,28 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
-	return uuid_equal(&a->uuid, &b->uuid) &&
-		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
-		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0 &&
-		a->csi == b->csi;
+	if (uuid_equal(&a->uuid, &b->uuid)) {
+		printk("uuid changed from %pU to %pU\n",
+			&a->uuid, &b->uuid);
+		return false;
+	}
+	if (memcmp(&a->nguid, &b->nguid, sizeof(a->nguid))) {
+		printk("nguid changed from %16phN to %16phN\n",
+			&a->nguid, &b->nguid);
+		return false;
+	}
+	if (memcmp(&a->eui64, &b->eui64, sizeof(a->eui64))) {
+		printk("eui changed from %8phN to %8phN\n",
+			&a->eui64, &b->eui64);
+		return false;
+	}
+	if (a->csi != b->csi) {
+		printk("csi changed from %u to %u\n",
+			a->csi, b->csi);
+		return false;
+	}
+
+	return true;
 }
 
 static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)

