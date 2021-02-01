Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57AEC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F61164E2A
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F61164E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Oy/BRANXhVDjjj1G1EhqPa5K7QSeTt5yxnnNUA7ovWg=; b=ILGi95HCwKX5u6ATqUZCmOyB4
	/2Ydix7wxdaJGtjRJlA4WQTmV7UcUTc/5cYDWfB8XyeiKW6R/PUO6I3itZiyFVskHFkcA00sd88C/
	lenH7es7wVvMPeP39EmCpJPHm9KHoXLFgl5LI16qmsO7IR5KSFcXtfeyt6TUuAEKVQI+pP2oRRlOF
	WfVud/wh4Y8Koe3qB8tGwRUot3mbpLwWq7qRQ5g6qpieuF2iWdhJSV9jh+gWYQZl0H9cDDv8tcidO
	K4Sz4w/g1k8yeGvikddMF6tIjdRn3u415l3F+JtbdeFysfyM4NpAZflHLAnclydT17Ax5NF22Rnqt
	3ELIP2X5A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6RyH-0004oB-GV; Mon, 01 Feb 2021 05:41:57 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6RyE-0004nh-E9
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:41:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158114; x=1643694114;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NkesTLfxRqztjZW5jY05mwEoA0OjfHro8b+Y1vcpyKE=;
 b=G0hySbiSTHXXKZiIbAb5T1PYMg0y7DBmKl/x5JqKIhbHST3vED9MEE3E
 J0YOlQ24mFZd0aFPNEBu9ug+DF3A1QGVLz4U4jmrRih2xGvnvNBgbBHjm
 IaCjCnMP3JC/ZZ6osE8BnFxdu4mZYNKvEhcR2hIBXBjcIQEvhtzyCQCEb
 oJ0JAZ5sMzKO6TsE58CHH6FP+Ym7CTfQaezGO4GQuRp6d+JnH5SJLvG/D
 CGBDaar0ANf3wLuN0W2x6hYX9v2tXAKLsyrKzMjQWKCsGRwummhARk5JD
 53+DIV6cEH/FUxflK5A0IZpUJ5kk4DuSmI3u90U/lC+hyduj9nJDA2cwn g==;
IronPort-SDR: raNiJlca7TCl54gL948qHhMCJzPgtzKHot3FF4aenFGfgjDlcqsH2vjvIG+Sj+C6r6Hemd8a7P
 tzd3Le36u8WsZaMqmC6HJXHcLsVFidXbS1mnvlW5qjKlYdU373+dYmiQUEtW2mLy45Q782Ec/1
 2QqQRloTvnT0I5Hm4ooZO3kc2X5g9ar/JqzQUyjh13SMvgcRXpeKhU3xb2gi0xNwgLm6W5GTju
 D7lNerganZEles2WVH7+bMMoHwSIAzHyCbXBQZqKDagqJHb8obEMv7KAt4fAz2PlHBjNqlXACh
 kz8=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="269194320"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:41:52 +0800
IronPort-SDR: 89j6nc0yXq+5Zj2i5KtdsereHGm2pxCI0kXSWD7mu4gJXHIEcDBUVZi6pisfH9K1k5+mzJHBYB
 5plUGGgejOaUSZU/Ohd/SRkpG0IG1DTZ3YSEw9SdKNMos7C/pOaEjRGftUV9PVp/d+S1zmn0wl
 DOjFudqMFHgHlzszo+Gc4LGjTIFdmwQlc+JKXraVhPMb7Wlw88bM55r7h2tXMB1oY2dmMF5rda
 eoiSUwV7I83qO4Pwc+8x726daGz0apImKU9nelyVoFkH8yIy7KyY54t8F2Xt7Svi/W9jwceNdz
 zrgEmSAFBsWren26Vk09cbb1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:24:02 -0800
IronPort-SDR: 8/7U/TqYEOhalebIBBh6tiebFbcRoSLKq0g9qG2qZrf9DanFSMi6TLH8i82il//VZ0jhqaaP+i
 hjId0DKZGCq4gLw37m7U70BZj/pSyncofv/Jf+yoYoNXAqbInD/Hm2e9CGXtKr3hbiPbyBTNIj
 srd1pUDpvYufCeixWi4vrnnFqf/ua8G8S4Iai7eParbULY5GpksH6aGbEu/XKtYJ7agY81lrID
 KiJEBf6hmRdEM6UxVr19lhrPtP0hpbf9BAkPrxvczwU23wrJhvJnucVXR8tlkgOzMDrFI6j6h3
 nrY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:41:53 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 01/10] nvmet: zeroout id-ns buffer for invalid nsid
Date: Sun, 31 Jan 2021 21:41:29 -0800
Message-Id: <20210201054138.34324-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004154_653020_1D6AABA5 
X-CRM114-Status: GOOD (  16.34  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

According to spec :-
"5.15.2.7 Identify Namespace data structure for an Allocated Namespace
ID (CNS 11h) The Identify Namespace data structure (refer to Figure 245)
is returned to the host for the namespace specified in the Namespace
Identifier (NSID) field if it is an allocated NSID. If the specified
namespace is an unallocated NSID then the controller returns a zero
filled data structure."

Move call to nvmet_find_namespace() in nvmet_execute_identify_ns()
above the id-ns buffer allocation since there is no point in allocating
a buffer if namespace doesn't exist. Call nvmet_zero_sgl() when call to
nvmet_find_namespace() fails and add an explicit comment to specify the
reason for zeroing the buffer which is not common for the NVMe commands.
Remove the done label and we can directly jump to out label from
nvmet_find_namespace() error case.

Fixes: bffcd507780e ("nvmet: set right status on error in id-ns handler")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 613a4d8feac1..8cc7bb25d10d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -476,19 +476,25 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto out;
 	}
 
+	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
+		status = NVME_SC_INVALID_NS;
+		/*
+		 * According to spec : If the specified namespace is
+		 * an unallocated NSID then the controller returns a zero filled
+		 * data structure. Also don't override the error status as invalid
+		 * namespace takes priority over the failed zeroout buffer case.
+		 */
+		nvmet_zero_sgl(req, 0, sizeof(*id));
+		goto out;
+	}
+
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
 		goto out;
 	}
 
-	/* return an all zeroed buffer if we can't find an active namespace */
-	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!req->ns) {
-		status = NVME_SC_INVALID_NS;
-		goto done;
-	}
-
 	nvmet_ns_revalidate(req->ns);
 
 	/*
@@ -539,7 +545,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	if (req->ns->readonly)
 		id->nsattr |= (1 << 0);
-done:
+
 	if (!status)
 		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
