Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE194C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BF2pB30woD5mAZAyjXmWSHLZVdoYAEN//DG5sM10lY4=; b=ixA5EEhRmZMuso0VJg5Enq5xPh
	TuD97NrZDdOgC4gla9PeFadz5D59FV7DTTzNI1hcDOJvw5r6eCFw93ja0qegixG/QBcYcvf2I6C9O
	20lyHUlXLz9zeTGYbAnOowryISWRh+tRm5eoN2WXvFNB3TqttPZGARrselp/O9HKQsNR7p3UyXnlC
	3d5DdUEHYQrdbAxqH/d5AVodJGoQYZb/hLXCi2bJH2aRpS9kx2zfoHZg3IxM1CepazoDGIp0gmajw
	ezQj9v2XmFUgYEmv+N081LgHY6zqgHWT0JCwpaTQYeMV7peZh7XTsqQl5rwcpL4LOLN1X6s8lcXCT
	5GIrgQBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS31z-00AREp-JX; Wed, 09 Mar 2022 20:35:35 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS31t-00ARE8-EF
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 20:35:30 +0000
Received: by mail-ej1-x62c.google.com with SMTP id gb39so7678036ejc.1
 for <linux-nvme@lists.infradead.org>; Wed, 09 Mar 2022 12:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BF2pB30woD5mAZAyjXmWSHLZVdoYAEN//DG5sM10lY4=;
 b=HQiaBtzNunspQ6STvKZSPHgonutsQ/jPZQxKC0wiKsZpIX+Hc4nG6haRKUzuM9f09+
 dDvjtReHe16uXBJ7zqaXyKWCT6N1QeOqocGMBmgHaJcfZCeRvOLbo98NKb/BmoeYitya
 /N19UHCgr9E+chTQBQDMOiMZ4SvoG4IJr9DTF3iD0L95mPl02ggGQh/42mhPD0eKvsqt
 7sniNxGBTWVvSyfwEKYAwxBh3OuegDoIyTtyXhqPoWivwUIYk6kpnEejfIg7HdWZICyD
 54ev3XzCXrzsiQu9R919xeMmmTKVN8OZzM+pxSmzD1mFyY0EwWDYFcSDVV46s3hjggtS
 VQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BF2pB30woD5mAZAyjXmWSHLZVdoYAEN//DG5sM10lY4=;
 b=OXCMQXIxe4pWvk5edS9p3wrV3gA48OgJUcEJsDoB28UQyJQhHj69YwitE+iogO3f9p
 edKpnAP8TEpreKJ5gwwGuxQ9/VUe2BPRzkXMA1dRcfGCx8TOGWHu14WKjPYvzd8QI0cs
 MjhytyCSPB6Vdu1lqH9aPi+bQpHQDbR9zCe/50UjLgSeetu+I5agadqWUBYTzHjH+a84
 4IIsOAsS3f/iv11quXHaL2nT62K0LBagbt3DXqBFux+nxoCnSdaNQQnI+x/bkkkl090p
 WC2jMhBz2f1DtjYKYAn1brvcLsd9+mpsVkfbHtpNgDwco4+V4Y4T436tkjUECr1OCncZ
 XCow==
X-Gm-Message-State: AOAM531l1xSmn4MwEX2sehENJIEthepPZqkfJUAr52r/NNzSj31oMZaR
 GSGkDTb0Adm5c/87rjUXhJUsFlswpuEK+A==
X-Google-Smtp-Source: ABdhPJyBYxRlcc13023JxDhyROGgN4dLu5wTRksix240bGBt5lp0iz9a21x9CeRL0Ojj2GO5uYJCsg==
X-Received: by 2002:a17:907:3ea6:b0:6db:4b61:b46b with SMTP id
 hs38-20020a1709073ea600b006db4b61b46bmr1493649ejc.402.1646858126266; 
 Wed, 09 Mar 2022 12:35:26 -0800 (PST)
Received: from nlaptop.localdomain
 (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
 by smtp.gmail.com with ESMTPSA id
 gv54-20020a1709072bf600b006da7953530bsm1130391ejc.104.2022.03.09.12.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 12:35:25 -0800 (PST)
From: Niels Dossche <dossche.niels@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Date: Wed,  9 Mar 2022 21:34:50 +0100
Message-Id: <20220309203449.63125-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_123529_509490_2B89F862 
X-CRM114-Status: GOOD (  11.88  )
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

nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
held. The only caller of nvmet_ns_changed which does not acquire that
lock is nvmet_ns_revalidate. The only 2 callers of nvmet_ns_revalidate
which do not acquire that lock are nvmet_execute_identify_cns_cs_ns and
nvmet_execute_identify_ns. Add a lock for around the call to
nvmet_ns_revalidate in those 2 functions.

Both of those identify functions are called from a common function
nvmet_execute_identify, which itself is called indirectly via the
req->execute function pointer.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 drivers/nvme/target/zns.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..6d1f5e02d27b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -511,7 +511,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto done;
 	}
 
+	mutex_lock(&req->ns->subsys->lock);
 	nvmet_ns_revalidate(req->ns);
+	mutex_unlock(&req->ns->subsys->lock);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 46bc30fe85d2..5182b802de27 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -123,7 +123,10 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 		goto done;
 	}
 
+	mutex_lock(req->ns->subsys->lock);
 	nvmet_ns_revalidate(req->ns);
+	mutex_unlock(req->ns->subsys->lock);
+
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
-- 
2.35.1


