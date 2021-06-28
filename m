Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6594C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6716162A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6716162A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IGuVKLvKMEtwm/lzEE22C0UXkPbD6rJiWj9XbrGmuXM=; b=0Io7OVKYWWLeVb
	bFPK5vJNj3K534+gKn2WoRp+oWgttgYsNx+bgsfGWo4NY5VESTIUnqc2Vd3K91ChAu1FyVrybk9h6
	cGh3tJ40FaplWb/CaRSrgU+33xofkV12OZ5yKlnE5i8rA+bcYZsjSTmWDhG51r41Y6nMKjWz3X50k
	9VJZKpKzwmSs31vdrXCKtJlDFIYJduUksZq0LVbHdplEYQyKlfGmlxXeqmMDYXbWSiJarziffuBhp
	Qw+fw7cK0/UkClLNFL/8oSBmqY6DgjWbbLPeDZ/uXEPsofHgDcp0G7cS6ftMGNhl/PxgoD1TLnZ03
	ZeJy8gO870lqNLJiZK1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjY7-006lqp-Rc; Mon, 28 Jun 2021 05:11:11 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjWh-006lTU-Pl
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856984; x=1656392984;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1I/XpesKWtYd1pTVETAZf3nq8+c0evucK7+gN6AzLHg=;
 b=n1eDz6guouGYcmDvvBe6JOuLoi3a6XpaTV5m899KPne+lLntWNuwf9Ia
 uBT9nMIJQAQD49ggxg6ZYkxYZVnvaO0CLruIGXjKTLC12yDTQPGQrSdRQ
 dc6/+FE1P/1yKhD/Ka4atbvGpftGMvZeTmJr/EoPKvdRvcOSM2P4qgDeU
 pSfEtPThyBybSmgO1+gQGEnShwimxuCaKkGq1IUufMElbZTHd1NDEUMsK
 qUb5hc3MXY4Vb/A5Sz/TaLc467dhPwkbaMkTfNJcsqUQYEUnOpXpiNDKl
 4sIBymDHRCse9/FCGauZyuWKsSj2dvdu96wbJpPhi8siibKHeDkQjisv+ Q==;
IronPort-SDR: EuENYCIrsre6dNIwDl4HKWKBTaByIGYpH4PtRDuIOEFt3BuVfugkv1iZcV38/h3b7rtrOO716i
 pZWOKMjAxjbidYn7fr3qlgHbYTePS/5HhdmHELKHRw0jAgE42SqpCzXtC7r4dQhGIi8n9EFSjO
 5paBLo3X4giesQBjgMIkRJu9N0Bi/Gffu/qPIQrlM9QBXFFyL+41h7KUW/TIcz8u00mb+U4lLF
 qczoXicnCIRxBPkya+mfwsnmRb4X3ijNu9KLCuqynZJw7McvvCO5LKvNUhuPVxO1HyGXD/P4wB
 Lm4=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="276851437"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:09:44 +0800
IronPort-SDR: 2wfy6fxhbgrc3XChbcA/TmwRYB13q4cWCwDT2HGlo3lafgTESpG1wvD2/2AkyON3UK0KxcFLe4
 biR0HS4ZSaBaRAaLKCt/7PmRo00uhbhOdeYijSHa1DmYnVhzdVU0HRfCjwlBEfiAFZ+m4sOOWF
 mCZSyBIs6dAvfU+4xvcGISoQkzhVpjoGM7WQ2oSOVYBWlyCym4y0Kq0W2zzaN6UoPvdz1vlv3L
 4bHY6v4LFg4w4bY9r8VRkorxwQsiYaWHXMUoR/3b/O1+2dblV00AIsJrAl0dei5hFREl6ret3+
 Jp8801+Xv4qK5oeJWcdugmsH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:48:12 -0700
IronPort-SDR: 59LlqW2qE4q57Ji5J6Os28u9e7sbDmPxArebBJ0xNzFpqpwKZiTFm7yjIvb75Wg8R5q23gamNI
 VLe3DSn2+Phx0D8SQ5Q72EwPwSWvkXzBE2EPfk8cv7QADF2LseVC40UuqsY7SeGLjtL+AjQODc
 5xBvRHZ5WPUNykiIXRZVvZHteT8ikYBa4wriUeGbuTEMrcYOLqrkQZd0OOjXf+88qKq4XEKzFw
 1vVTvyCcBWxH1PBjrPbza086YX5ALKGNg9QxOefF3wND2DvWhOXnEFqwnNUL6/lY+3ECXJv1jt
 nKM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:09:44 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 08/14] nvmet: add default case for nvmet_execute_identify
Date: Sun, 27 Jun 2021 22:08:11 -0700
Message-Id: <20210628050817.19788-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220943_958272_4BAAEC9F 
X-CRM114-Status: GOOD (  14.05  )
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

Just like on what we have done earlier in the series for the
nvmet_execute_get_log_page() repeat the same pattern for the
nvmet_execute_identify(), add a default case to print the error & move
the request completion call outside of the switch so it can be used by
all the switch cases.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 10 +++++++++-
 drivers/nvme/target/nvmet.h     |  8 --------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4e58dfbfbbd5..28c24c08bd99 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -682,6 +682,8 @@ static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
 
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
+	u16 status;
+
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
 		return;
 
@@ -732,9 +734,15 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		if (nvmet_handle_identify_desclist(req) == true)
 			return;
 		break;
+	default:
+		pr_debug("unhandled identify cns %d on qid %d\n",
+			 req->cmd->identify.cns, req->sq->qid);
+		req->error_loc = offsetof(struct nvme_identify, cns);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		break;
 	}
 
-	nvmet_req_cns_error_complete(req);
+	nvmet_req_complete(req, status);
 }
 
 /*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d719a1cd5dda..2119abc2a9b9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -645,14 +645,6 @@ static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
 	       req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC;
 }
 
-static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
-{
-	pr_debug("unhandled identify cns %d on qid %d\n",
-	       req->cmd->identify.cns, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
-}
-
 static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 {
 	if (bio != &req->b.inline_bio)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
