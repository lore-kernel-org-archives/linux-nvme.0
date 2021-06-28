Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7E3C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:15:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331036195B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331036195B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LMd6f7Pt853HKJloEcbZrzDASUyIMGj5+rSesssh2bo=; b=s6gUDvnPuh/ur5
	25sBCN5lb65IWlX3jaFjxqJTuvyrDyT96igtltwdzpYHUS04H9tk7tQfE0g1jSN0TW8cblvRDU5Bi
	FREUBZWxYPrP9nx3ytQ5ljPRPNsHqju58+pzCmXKS84scISzLt9wl9bz2iiZFl2h+pD0ygBKbI2qQ
	6+KQMOHDpsUPPjvXHA8m0dicc54hJFReTme8YDxTrv8jyA6vv3bH+qO2lC0mI+SDojgvS1jhKF9Ac
	60rdDHjqMWDXPqnp9d8xzbnftpoTM3OZR3RKXJKTgT8ONYjNjy9Hho1WFEMwXXYnBf5fVzyii/CX7
	lEXb5h4BHUqhE1lovKPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjbY-006mdi-0X; Mon, 28 Jun 2021 05:14:44 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjXM-006lee-PK
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:10:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624857024; x=1656393024;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gPvOnY86LofRCHJW3Ce4tkDbCF2sSTxL++x4RYqHNzU=;
 b=g/6Hu+LZqUxTc9sp4hNrGTWF4HH+xQNu6HCrdGp+gl18wpfRFbtoYXAb
 ZNuukfB8LJdH9/x6NmLGFRFnkeb8IhQNCd3Hwtqn+ukGWsT65R29GK+aO
 QPs6u6seLFjNQrNfmONzraLdrz11cQXKnnLqesRi0J3j1gDbvlAPgnSnS
 1CoKmgxKDqV4qXXqR+NdCWFrsMqTa7s77WeejEXIwHND2Y0oFEvxzt2c/
 /iiC9m5hF8m5ZH4NVfTQg0phJ0aAO811cBoF20fOmYq7v0LkGFOYVftQ4
 tqAOWNYgtobQvj5Kmhct8IRIHFzFrqY75lF4Qo3YrJgyZddSwdaxFq1NP Q==;
IronPort-SDR: zEZucKxT5Zj4mJ0XQEwTHkS69j97uhWa+Zs8q6qPRLkEUkQOyCC7eiM+AXT0oQ2NxiDs2MicCg
 oPfCCQau4hHJWGNSpuxpcCoUEHvkJGiTLMEDWIL/LQNjMD85pCyfcnSbkZPWkEBvcp39Nfffsy
 4IpvIxxeVh0QdpCAW4FMvbviO9MSidtQMjgLhvZ7DBCQgsclZqtMnDLJ6zMHMTq0ZeT8G8ehng
 EuBID84QTitgBrGW5GPKTcmiGU/1McJqY5Fz7OXdXVHo487k3teCmvqfC6935QoVoj9iwg9yZd
 9xE=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="172308759"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:10:24 +0800
IronPort-SDR: 94T6p0b+Rk5pA1YOSbEN578wL32u0TTgrHv224EPIUTKYAIN0r7WfJ611b9eD8ZV+05hP7Qzkd
 0mu7r2IdSZ+E9cVgULKCpYVT7t+Hzd/g3Y21Snch1zZ/cBBY5YpbWP/e+PsxGk4v0Af9K0Trx4
 v/zGfnF8KQBl+DOmY/l1oTTGX6/xkhc55vaYeDW162RCy3tn3jR7RLeBJWPYqV9YJa18e8NNM0
 H0xqGuyzd9VLSYEJUk+AU9Mb5Hz6xm7XCwIKIEZl7NojjSrf83+nehwjxri9UmR4oi0ozggSuL
 /ZDQmWEYnedDLNt53Cka3bNE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:47:34 -0700
IronPort-SDR: jUtMMK8Y0d4UfBuhH3wHtyk+vrP07f16hGc6MAgi5e+E51AIiTcbsxI1IQXTWvWlHmaHh6VROa
 JZn0OsA8UDYVUeQJNYrznP8KxzYdC5FhU0WVNlOJfnNqyoMN/14j8EtFRmz+oASypE8hLPjKQj
 /GZU544NHGT7cjdy5Nyp1TVx2JuOsbyB+CgxzTpaCh9/4OToZxBLfNbpc8me0KiWazAIEpOgIq
 o/Y0uhkgxJx8D5fiKTedgOaYEbmT3LnZ72IRFBSLru/xPx8tciUh1/mE7/wOx45Wecz4KoAE4P
 /cs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:10:25 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 12/14] nvmet: remove repeated call for desclist
Date: Sun, 27 Jun 2021 22:08:15 -0700
Message-Id: <20210628050817.19788-13-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_221024_958764_56D04FDC 
X-CRM114-Status: GOOD (  12.63  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Return status from nvmet_execute_identidy_desclist() and complete
the request in nvmet_execute_identify(). This reduces number of
repeated nvmet_req_complete() calls for identify handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 749d7e695fa2..02d28158e9f0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -619,58 +619,54 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 	return 0;
 }
 
-static void nvmet_execute_identify_desclist(struct nvmet_req *req)
+static u16 nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
 	off_t off = 0;
 	u16 status;
 
 	status = nvmet_req_find_ns(req);
 	if (status)
-		goto out;
+		return status;
 
 	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
 						  NVME_NIDT_UUID_LEN,
 						  &req->ns->uuid, &off);
 		if (status)
-			goto out;
+			return status;
 	}
 	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
 						  NVME_NIDT_NGUID_LEN,
 						  &req->ns->nguid, &off);
 		if (status)
-			goto out;
+			return status;
 	}
 
 	status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
 					  NVME_NIDT_CSI_LEN,
 					  &req->ns->csi, &off);
 	if (status)
-		goto out;
+		return status;
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		return NVME_SC_INTERNAL | NVME_SC_DNR;
 
-out:
-	nvmet_req_complete(req, status);
+	return status;
 }
 
-static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
+static u16 nvmet_handle_identify_desclist(struct nvmet_req *req)
 {
 	switch (req->cmd->identify.csi) {
 	case NVME_CSI_NVM:
-		nvmet_execute_identify_desclist(req);
-		return true;
+		return nvmet_execute_identify_desclist(req);
 	case NVME_CSI_ZNS:
-		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			nvmet_execute_identify_desclist(req);
-			return true;
-		}
-		return false;
+		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+			return nvmet_execute_identify_desclist(req);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 	default:
-		return false;
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 	}
 }
 
@@ -728,8 +724,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		}
 		break;
 	case NVME_ID_CNS_NS_DESC_LIST:
-		if (nvmet_handle_identify_desclist(req) == true)
-			return;
+		status = nvmet_handle_identify_desclist(req);
 		break;
 	default:
 		pr_debug("unhandled identify cns %d on qid %d\n",
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
