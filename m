Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F43D6DDDB
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YQPyex0bJfNxoqNLhhDYmIY7JYJjX/+VF6K867de6e4=; b=EhLsoptPbm/YPsp+roANOoimk9
	SIVNzUbIXCHASW+TD7fqD59Em4mbF2SkrUgfOWT4AFk83A4XTArIbnWSxzqv2/pv/cJvjLSRDD0aE
	ppsuVT5VtBFr8FlDVg3EJ4QyJ0MNaZPvQmh5oM/NjMAu99EyCAd2GTOHNdkSXkl58rUxwJO6brdQm
	ryx/AksLeqh8S61fuNu+bWirdZvC9Llzd690MNCUceNr2rCrDel6z2aBMLXPYwKQ1QosJFnMxpecJ
	UdcVYrtBT2T0XrwPi1CdKmpC2/vX1Qz+j2JIXUdqh+T8nhRX5MIC41LOuGX+vS5ILQH7zdspvj2N3
	ATueunAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBrH7-00000001yjC-1cdf;
	Fri, 15 Nov 2024 08:01:53 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBrH5-00000001yii-0Rfz
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 08:01:52 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1162183a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 00:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657710; x=1732262510; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQPyex0bJfNxoqNLhhDYmIY7JYJjX/+VF6K867de6e4=;
        b=mFWKqlQQl7S7nHaEZHowAJO/RTkblmybDIO9WX6agMJ1pWdczsm8c21zroOj1JIxFs
         7J+WqBmLprWLgtSAYeQ1pIpxz6HjrUXaECXebUPM7zHP0Zi0JSaUBwWY5D3ZpWpBALMP
         RfswclG629ZwscCZhw1l2D2W4TPriQvPHhykoTNNgMpy+2jWajn3El5r/p1PSGnTWwUT
         IIGGHxdhM7BBWMjPyorpSCjUYU97az8guLet+jJ6XIwYTrW+bMI38YtAzTL1KOVFBdcD
         TFJYPVDQmcpRIKafsCRZIHG7wFNM2O1LTvKGcjn5nUEe/0xRwuSpwcyZ7dixOcH4pvga
         U2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657710; x=1732262510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQPyex0bJfNxoqNLhhDYmIY7JYJjX/+VF6K867de6e4=;
        b=QPlcB0hZXdDCGJrB+F+sN2xfObW6Q9ttJ1rSo3OkqZ5ppEoUb3jswSWxMjKbTe7fLa
         Ggwey+jDZmmb22tta6nzPvxNIIbd1KOEzvo5wsQG7vE2iuE0AGM0bB4XjO17hoUH9Fpg
         CN/YatdYDAw1X1mo/lektpvN/lx1RlKhAaQsEqY1Dz66eXzhsrcuQnE0em5XdBNNjvXe
         M+YKfcuZp7j0YdLfk1+mplOik5VHnS3nASZoEfZRILjvoCFAViq3hWffuXMoMAIU/Eo8
         P95EdiSNEJpmZ9G5w8GXREFsX8aIVIOuCrzFARVYJWOnH5NPIBlHBob2XebPVnztqOj1
         hLAQ==
X-Gm-Message-State: AOJu0YyxeomCW9jKWTwBytTVZGUOCJQ/VRyLoiNTmSohEa7RCr78SyWL
	wsfc5d4ffzzGg8D4GarlZEwQfHASEgezvzG8MbjV/eFF4ihHFtxD
X-Google-Smtp-Source: AGHT+IGlhh57+NslnLvNLqxVjyA+6H7jQH044HGNOiok6gSn8PT1nNDQvtUE2sWpcRVgeOAlla5AXA==
X-Received: by 2002:a05:6a20:6a1a:b0:1d9:239b:a125 with SMTP id adf61e73a8af0-1dc90b1cd64mr2503739637.15.1731657710079;
        Fri, 15 Nov 2024 00:01:50 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eefe7sm788871b3a.31.2024.11.15.00.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:01:49 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-core: auto add the new ns while UUID changed
Date: Fri, 15 Nov 2024 16:37:27 +0800
Message-Id: <20241115083727.30005-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_000151_145062_4B0C03CF 
X-CRM114-Status: GOOD (  17.64  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now spdk will change UUID of ns while restarted if we have not
specified one. At this time, while host try to reconnected to target,
as UUID have changed, we will remove the old ns, but not add the ns
with the new UUID. As a result ctrl with no ns, and we need to
disconnect and connect to get the new ns. Here try to add ns with the
new UUID automatically.

Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 45 ++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

V2: Add missed reporter

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 855b42c92284..425f59fc80d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3991,28 +3991,6 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
-{
-	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
-
-	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
-		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out;
-	}
-
-	ret = nvme_update_ns_info(ns, info);
-out:
-	/*
-	 * Only remove the namespace if we got a fatal error back from the
-	 * device, otherwise ignore the error and just move on.
-	 *
-	 * TODO: we should probably schedule a delayed retry here.
-	 */
-	if (ret > 0 && (ret & NVME_STATUS_DNR))
-		nvme_ns_remove(ns);
-}
-
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
@@ -4051,11 +4029,28 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		nvme_validate_ns(ns, &info);
+		if (!nvme_ns_ids_equal(&ns->head->ids, &info.ids)) {
+			dev_err(ns->ctrl->device,
+				"identifiers changed for nsid %d\n", ns->head->ns_id);
+			nvme_ns_remove(ns);
+			nvme_put_ns(ns);
+			goto alloc;
+		}
+
+		ret = nvme_update_ns_info(ns, &info);
+		/*
+		 * Only remove the namespace if we got a fatal error back from the
+		 * device, otherwise ignore the error and just move on.
+		 *
+		 * TODO: we should probably schedule a delayed retry here.
+		 */
+		if (ret > 0 && (ret & NVME_STATUS_DNR))
+			nvme_ns_remove(ns);
 		nvme_put_ns(ns);
-	} else {
-		nvme_alloc_ns(ctrl, &info);
+		return;
 	}
+ alloc:
+	nvme_alloc_ns(ctrl, &info);
 }
 
 /**
-- 
2.25.1


