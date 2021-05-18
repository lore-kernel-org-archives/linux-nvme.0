Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E071C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:06:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF466610FA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF466610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2IzjhBeWxGVWpqlJ4vILPJ7kLxkNGNyoRFemwYego50=; b=ORQlEGiFThlKSqzBA2AteVmbU
	YU15ZNxUhIoSpOSZczVM4qwtrCJ1cHndA8sCwut3UGuv82qNqYXnXW/yz9Rhr6aZo/uJe+X/KFEez
	Zse5TyYggisQrSOtT2DPkYQEb411c9NEFX2crF2DIxd1cnXzeEXVvtk0L0ed8ux1VQ/QZS6zWPvFR
	EedtGKwMq5cV5nkMyXz/nJmfKToAiUGxlmWXivlucgJ5ms9fRVbGd8hWHK3e8tQyEebumlE6ZgOla
	1jYGEyqOg0LfINclpG459CE2PldUbxZsfmjpSL1xl1k1jD8aHvN2Cx+3U3Y2pl/peCbBNiq+5JsJ9
	wM354e7tQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lirvv-00GyIL-66; Tue, 18 May 2021 05:06:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirvn-00GyHv-Or
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 05:06:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hjQ9OjzaMIkJjF94rkaJnpnGD423cHId4yeFtJ4QJ84=; b=BbrIN8re2nPRfHOmQajjFktcA/
 FjQBnfk/fON1ptTf7Qdii9YRCYdQE8bNLe/wQB/jPsc6P4IauKB9ByIhi8ulpZBTQXUA6lMJv0X4M
 rz+qr5fCla9KGNX04hFdxgLYEDqF9KrQPZEUcTi6FPhoPdULuJxBUANeTOzdYVc5wD53ifn5tfInk
 RbaexjG6Lqzdp/PddLMBadT6+fIizNC8RoxEaxNielF4CzUl9bO/cQZUwR765LcGzgi9xSbKeMl9c
 G1XerdykTKRrmOIGn0/esDHoM7WNf8sV6n0h3r/KXUxMe/TCTV7sOUsjqobo9fEucr+sPixQ/imfs
 ExrxDdig==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirvl-00EJbG-A9
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 05:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621314368; x=1652850368;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x/mc4zXZkML1mDzZcclb8JoI5GERyomt+OenQr0kXs4=;
 b=YQNb063g934S50nT3mAOJOA+DLqILx/8DSzsENq395DwUy4pEL7d118Z
 7wGugxqkY/po/acsyF1EkcAMVNXXMMYYZne2iFCTAseRsaaQ/ilNN1QCP
 U47ccvltpbjkv/0zdAGZSTtgnIPZwCWzSSk6RBgC+RV69aLs0Zpta+OMe
 EfCOPxcgs7bhhWclsrIy7VlMPUMS+HMgpqqF38rFPBLNDVUbDyr8SL6JK
 9uCBpkOfQ3N7dZnfsk98KvZp2ZJ73/x/KkVSWg5ro4Y4kYxJmIbj4nl6o
 8rah/E7wBixZK6DueRnWHrgGMXwgWAKjzde6/WNp9DSGXm5eJt2XVAJOl w==;
IronPort-SDR: +FsdYy5QVp0LYSfoHV40QVkdWsMlHJB79z1miRRjuemBdmRMnpF0hM8jhodf4CzK1uWHv3fXCS
 zws2Z6ussJ1j6cgt5BLtmnuImNAXutRownUtc5oKr4t/aIBkl3Uj9qtqmY8MW07KE4oe3r5gz2
 96qpbP+5VGWx056753tKobrNs8HSFr1md6nO0quqD07+bxPWHWJGm5r85awFpPpNqMSGJv5wI6
 P48mtBhiW8EHb/hcTksn6KERxpGEFcg2NHBzkjCmyNfl+yck7HubJu23bikUzWfIliWvmlOgGs
 XEw=
X-IronPort-AV: E=Sophos;i="5.82,309,1613404800"; d="scan'208";a="168525962"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 13:06:06 +0800
IronPort-SDR: EzixoaBMZleBQMzDdHclo7vPWHYhLHbTG65dYKSUUCu4Tn3CP/fQz+/5AaZc8FvPb+3/DvL29u
 dzZlula2UuZPdivgnMuMOBfiUovxSHn/Qf+TGwgt5zfCd7icMp1qWYydPjNE4Gm/STo+56Eddk
 EnjWbxoWYUgqcL2oLCysXmQ9ksJ/bebf33PVuSdU1v8xif7yX0VGOXWlGEE/pN7XANT5WEKL6e
 LplRMx9HCsCSH/cF7ZenwAOE0v8gRRy7dgG7r6CzGYRT9m8A1K2si2JNGqWrcYfByKAKxijT3/
 vaCgLkEezC7LWh9q/JYWuVJ9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2021 21:44:32 -0700
IronPort-SDR: PsKisVWok2WkrpcQoSNpBUQu40oOGJinpgnCYtz2Rf7F0zFzTIXvnnGCiYANWkFOR8B1maLd7o
 hwK1MPSPL4M9+QA60eyxchXUcsuGzBnTWOPY0fjbVQJEEZRwOhmxLIZIwK7KUZjWscjFuLXDMA
 ZggcTjjGw59zYskGRvf4ERmab2fZegJxmiwOBfw4892iJTHwZ5Lw67BmGozhnQUD0KmEV1Rifs
 CBxVAO/WW10oKWqos3Ve2Ynj8ro+99x4/NanEeJHsHHT+vyhG0t0iPSoEcce1DNsmvyrkIP/xw
 C80=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2021 22:06:07 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/4] nvme: calculate data offset once for ns-desc
Date: Mon, 17 May 2021 22:05:54 -0700
Message-Id: <20210518050557.14961-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
References: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_220609_377676_9D3397E2 
X-CRM114-Status: GOOD (  11.34  )
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

Calculate the data buffer offset only once instead of repeating the
calculation for all the nidt values when processing the ns-desc.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 762125f2905f..f8a3a36eba86 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1302,6 +1302,7 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 {
 	const char *warn_str = "ctrl returned bogus length:";
 	void *data = cur;
+	void *buf = data + sizeof(*cur);
 
 	switch (cur->nidt) {
 	case NVME_NIDT_EUI64:
@@ -1310,7 +1311,7 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		memcpy(ids->eui64, data + sizeof(*cur), NVME_NIDT_EUI64_LEN);
+		memcpy(ids->eui64, buf, NVME_NIDT_EUI64_LEN);
 		return NVME_NIDT_EUI64_LEN;
 	case NVME_NIDT_NGUID:
 		if (cur->nidl != NVME_NIDT_NGUID_LEN) {
@@ -1318,7 +1319,7 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		memcpy(ids->nguid, data + sizeof(*cur), NVME_NIDT_NGUID_LEN);
+		memcpy(ids->nguid, buf, NVME_NIDT_NGUID_LEN);
 		return NVME_NIDT_NGUID_LEN;
 	case NVME_NIDT_UUID:
 		if (cur->nidl != NVME_NIDT_UUID_LEN) {
@@ -1326,7 +1327,7 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		uuid_copy(&ids->uuid, data + sizeof(*cur));
+		uuid_copy(&ids->uuid, buf);
 		return NVME_NIDT_UUID_LEN;
 	case NVME_NIDT_CSI:
 		if (cur->nidl != NVME_NIDT_CSI_LEN) {
@@ -1334,7 +1335,7 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		memcpy(&ids->csi, data + sizeof(*cur), NVME_NIDT_CSI_LEN);
+		memcpy(&ids->csi, buf, NVME_NIDT_CSI_LEN);
 		*csi_seen = true;
 		return NVME_NIDT_CSI_LEN;
 	default:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
