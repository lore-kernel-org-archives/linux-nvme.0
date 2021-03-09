Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D52C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 04:59:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737C8652A4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 04:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737C8652A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hpFam5D+JobqxF6lWGbx3SOQ8Rd0SgIK9StV/IocHNE=; b=TbiWPnD33cO0HoaGJEU4vpodY
	dBLCqeB+99yMauoug3Icg1gIphPnas9QlSkELJi5Mc+DNsJpUHRxJRgYHQjU5tmtw+WAgDWdAuNgb
	FI/MGpRLkWaI+LJrNhaOmurOrHLc0qaBrIlVl4aATgdlWF2T5qom/klxUqT3ZfZ09ETa7Zb7Glb/h
	ul1qNsqd2Vkh8Vbf/uuP6M/9umGTEqpo9PZVeBRGH8Km2JA58/B+WmLjrL4HnP0TTfXY/mGgZOE6A
	ltSVWbDUmWAUt5R8AGcgCVozLARA4O9I0BL9fCLSNEfNLUpyvVLffI50QKNANBKN0I3cHIKicpFlQ
	DTb0u/8ew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJUSO-003lD7-T9; Tue, 09 Mar 2021 04:58:57 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJUS5-003lAx-NO
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 04:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615265917; x=1646801917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QJK7dRAcPZSxVpalUK5eLrT7ctVMgzTPMj51iCsiwm4=;
 b=H0bH0KDszD68G2EcN8B9oVgQq8EK+hc2mWz1wOAqwpmtFfUUHzMPPxxs
 w0UidDnYjpX5H1feSGtzdjPvKQWu28ICqz8JZfJTp3WGR6ldbHznxBkir
 68RMaT36qkKaP9FL304qc5BldUWXkbiG1dmJdvWgR9jmdN/vYArHQ/Vi5
 uTkGKPwMJh8nfykmwJNogWSnWGS3+NG/hZq1PwN/yUfLfnwCJwfNIKRSM
 y2YVFgeJbLkShXInrqc7sMg3z6TZs+5NYuAUFPh21zjFfzcqpu+4D9YKT
 2q7uoVlkUEKrN96DJEaQEvNgDQ3Vb+PX7G+4urTL4yrvGnbsrTJkWwqq8 Q==;
IronPort-SDR: x+drjLp5D64XqdbF6gMCzWmWaUeBhr+OFexXlXFXH7hTwa20JMQCLhCmcCLYkzjzEPNs7zATwK
 RJvToBoEFQEp46h5ZBOe1s3gYPzB8wf6EljZKda918WDliOenffj/1LQkJIn4pnIpstf7L1DFY
 n+EFuwfCTOg2x9PbYOtxvBy62XIWLg9FS8okstK1tY0awcljGSsPAqqSpWLKXakRGOazKZLfx1
 6oKtCZETORcBchR9urRLWJwFO0oSODQRTq8ZVM2yVA5FkafnLB5k0W0KasTen474c5HvjGiSjq
 Dbs=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; d="scan'208";a="161695732"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 12:58:34 +0800
IronPort-SDR: 7bPHwRUHCtkNM3sDvo4StTICgVBLBUxbraI+7bZkAZ1bWF55V5jXmZ2qFm9CM+eV+hOtVxsqZO
 2MYfLJ4aHnqJKWi3DZ/stQAymscQydpxq9v2gbRYzMSXZAd1GsdSj0DCG5GsuDHRdzJZJP6u53
 WbIlqowzyU+4UmJ1SJSAD/iCTbXCjI3g15mE7/+FzIYMYVoUXtwhUtmjGIi8SYqAEv7qRBZLqd
 AhIaJYI98paTBo5xbHQiPBqE/COEzUZXiPmF2HUQL+1JKlVZ9mhBsCPQ3QYE4EJPq6JJZcTuoe
 OIXu3hAG4JuZg88Ez1PeStTu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 20:39:32 -0800
IronPort-SDR: cM4pOICATZkbqYetH7WvZVOZHXr8DXt/Gd09D4w8DNQwJ73fAyOIjZbelH55wh8yRz6R2z1y+H
 rgeDkUbfSHZtJ4EDz+ySzT/PlgVKx/qv518agr1QiXu5m9DvMFP0cT5LJETMuWHx+TAkve7mVk
 irwn3VbM+3Ohut0k+R172PtWLU+aK827tuMNcM/cVKt+QJr9/qxX87YVB9LGpY5n+07J2m2Z3A
 CY6aKJYCBEjrMBE3bm6JFNX7flGlsX+4DnPCf0roiMwd5oM7u2bBlphOWsVTzcPGFJvx3mtR3o
 DOg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Mar 2021 20:58:34 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
Date: Mon,  8 Mar 2021 20:58:16 -0800
Message-Id: <20210309045823.18545-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_045838_196921_DB3B037A 
X-CRM114-Status: GOOD (  12.25  )
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

The function nvmet_copy_ns_identifier() takes type length and pointer
to the actual id. These parameters can be derived from other parameters
such id can be derived from req->ns->XXXid and len can be derived
from type since it has 1:1 mapping.

Remove the len and id arguments and derived those from type and
req->ns->XXXid respectively.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 36 ++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index fe6b8aa90b53..e6caa35db4d5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -589,24 +589,36 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
-				    void *id, off_t *off)
+static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, off_t *off)
 {
-	struct nvme_ns_id_desc desc = {
-		.nidt = type,
-		.nidl = len,
-	};
+	struct nvme_ns_id_desc desc = { };
+	void *id;
 	u16 status;
 
+	switch (type) {
+	case NVME_NIDT_UUID:
+		desc.nidl = NVME_NIDT_UUID_LEN;
+		desc.nidt = NVME_NIDT_UUID;
+		id = &req->ns->uuid;
+		break;
+	case NVME_NIDT_NGUID:
+		desc.nidl = NVME_NIDT_NGUID_LEN;
+		desc.nidt = NVME_NIDT_NGUID;
+		id = &req->ns->nguid;
+		break;
+	default:
+		return NVME_SC_INTERNAL;
+	}
+
 	status = nvmet_copy_to_sgl(req, *off, &desc, sizeof(desc));
 	if (status)
 		return status;
 	*off += sizeof(desc);
 
-	status = nvmet_copy_to_sgl(req, *off, id, len);
+	status = nvmet_copy_to_sgl(req, *off, id, desc.nidl);
 	if (status)
 		return status;
-	*off += len;
+	*off += desc.nidl;
 
 	return 0;
 }
@@ -621,16 +633,12 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 		goto out;
 
 	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
-		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
-						  NVME_NIDT_UUID_LEN,
-						  &req->ns->uuid, &off);
+		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID, &off);
 		if (status)
 			goto out;
 	}
 	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
-		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
-						  NVME_NIDT_NGUID_LEN,
-						  &req->ns->nguid, &off);
+		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID, &off);
 		if (status)
 			goto out;
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
