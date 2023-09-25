Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00C5CE7AA5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Sep 2023 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/qJlMfAUnugYlgXrPORaaeDoS7R8ILhrfGp6LCAONk=; b=mQwRIhlfykEHnrxULddume6mXt
	Mwu1RO2ln2XG/Br1MAr9Oj7Oj8o2skvynwU3ky/VRHLWaHir38J1p1aUA/gE6++66NWZW7aedv5XU
	VbB0wvOftncQ6tlIrMH3pKvKepdfDXSiz0Tnge7WHAuRBjgQchs7prBjjrLgFHlnxIicce9MXcTD1
	1CZn+8DAfgkgRPBZxLqM6XIksZJeBBGxhvx50mVCLwSGpoHwFdd6POCNUO4fYvEAqfXT3fBT2KfGF
	wV5ukNNL1uCwLlOzKGoCJXZYujJLFLx0+mhZV++CLIh5/uJgacIPn0kmeoN6z+wNb1H6RhBUEGiAs
	j4cEWw8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkoWB-00EfSr-2m;
	Mon, 25 Sep 2023 16:33:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkoW6-00EfR6-2t
	for linux-nvme@lists.infradead.org;
	Mon, 25 Sep 2023 16:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695659581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/qJlMfAUnugYlgXrPORaaeDoS7R8ILhrfGp6LCAONk=;
	b=b6SvsZJhs74OcZFsbFXRm7OR+hRMeQ5FHNCZS8lrNsugE/VXm17j+NZNjwTccMY938I32f
	upMBWQoxYbbLx7smaM5kp+txEDt/Khektjl/0w3e563RwiB3AFjgqBxH8n+/9Pt7bv/r4Q
	frSj7PGCXv0h+68Un840XiDu11zpr2o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-CoGm6vw0N7S510alnTnWTw-1; Mon, 25 Sep 2023 12:31:25 -0400
X-MC-Unique: CoGm6vw0N7S510alnTnWTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0CA029AB400;
	Mon, 25 Sep 2023 16:31:24 +0000 (UTC)
Received: from emilne.bos.redhat.com (unknown [10.18.25.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5ADC15BB8;
	Mon, 25 Sep 2023 16:31:24 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com,
	jmeneghi@redhat.com,
	mlombard@redhat.com
Subject: [PATCH 3/3] nvme-multipath: add "use_nonoptimized" module option
Date: Mon, 25 Sep 2023 12:31:23 -0400
Message-Id: <20230925163123.16042-4-emilne@redhat.com>
In-Reply-To: <20230925163123.16042-1-emilne@redhat.com>
References: <20230925163123.16042-1-emilne@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_093303_021891_CE98D3ED 
X-CRM114-Status: GOOD (  15.41  )
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

Setting nvme_core.use_nonoptimized=true will cause the path
selector to treat optimized and nonoptimized paths equally.

This is because although an NVMe fabrics target device may report
an unoptimized ANA state, it is possible that other factors such
as fabric latency are a large factor in the I/O service time.  And,
throughput may improve overall if nonoptimized ports are also used.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/multipath.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index deea7fd4aa95..f640b8ad934b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -13,6 +13,10 @@ bool multipath = true;
 module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
+bool use_nonoptimized = false;
+module_param(use_nonoptimized, bool, 0644);
+MODULE_PARM_DESC(use_nonoptimized,
+	"Use ANA nonoptimized paths as well as optimized paths for I/O");
 
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
@@ -272,7 +276,10 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		}
 	}
 
-	if (!found)
+	/*
+	 * If fallback_distance was set, fallback must also be set
+	 */
+	if (!found || (use_nonoptimized && (fallback_distance < found_distance)))
 		found = fallback;
 	if (found)
 		rcu_assign_pointer(head->current_path[node], found);
@@ -310,8 +317,12 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 			found = ns;
 			goto out;
 		}
-		if (ns->ana_state == NVME_ANA_NONOPTIMIZED)
+		if (ns->ana_state == NVME_ANA_NONOPTIMIZED) {
 			found = ns;
+			if (use_nonoptimized)
+				goto out;
+		}
+
 	}
 
 	/*
@@ -321,7 +332,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	 *  - no other usable path found and current is usable.
 	 */
 	if (!nvme_path_is_disabled(old) &&
-	    (old->ana_state == NVME_ANA_OPTIMIZED ||
+	    (old->ana_state == NVME_ANA_OPTIMIZED || use_nonoptimized ||
 	     (!found && old->ana_state == NVME_ANA_NONOPTIMIZED)))
 		return old;
 
@@ -364,6 +375,11 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head,
 		}
 	}
 
+	/*
+	 * If min_depth_nonopt was set, best_nonopt must also be set
+	 */
+	if (use_nonoptimized && (min_depth_nonopt < min_depth_opt))
+		return best_nonopt;
 	return best_opt ? best_opt : best_nonopt;
 }
 
-- 
2.20.1


