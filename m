Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A5C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:13:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC746162A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC746162A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pNgWdOMthEY0qw+PRIA/vx1HEnTUUfgMMh+wpsm6M+o=; b=gepoVnDD9J7waM
	9YQRHKRUSYFfy1tyE9fKgaOfglkcQWt4kYoPbscr9nz4qVsdxHwbvqi4tKfL1CN/rCE8E9cceE6XP
	6QZnop5gdSWUgcDO842Ci9gK9V/37D+m8ZMUYiLPqv1mQpChgX8EjP3bn1So6NfG2nKACKx+5wxIw
	BkSPsfK272ZkuI6IiB6dagKuNyl/D4uNVXX2Csf3s9QjZY/sCEu6HWfAHwBftOIfXo1XvO4zik0hA
	RRPGw9HDjPK/Uo/1MCyM9ibXNHDKYuKljzsDbnUYWrhmhMepCWzwcC0qJvwTFkSSSbMwUMcJCu82o
	McBGVyv1AxsSPGUX2iCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjaO-006mP6-Jw; Mon, 28 Jun 2021 05:13:32 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjXD-006lby-Cl
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:10:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624857015; x=1656393015;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p/+eVCc6vCV7bUhRqel7i60l/uOrC73hxIV9GpbRMmA=;
 b=cKzHhNOjofuANK/wNbsrbGPeUbiSRSG+5aMyAGU4Fq9x05GEfUTw0LAz
 XFmGBXBlCMnFdY4bXDgHMEX2SfNb8PbO0ykN/C/6lulUKycpKIeK5YggE
 u34guNkb3M2cQTNZ1dffSIDvndO2NjBO0C6CgJ4zybDEjaZWzNELdR28L
 toMtNkOqTl3vjgavxTEXpo7jVZ7r5T2DEzOb0c2/ea7G9RAv/0yeSsqaJ
 ZYnypRqO2zEOB95JYtvXNHaFT3SbNh3EzmPj0fXpY0Pf3aGYiJl+LlrM8
 M0qIib846ztgnCO5In3q+9KanaV7Xpk7FfFlt37nCrWIPeqKOgILAWW7a g==;
IronPort-SDR: g3wc/nDr6zmZXFUjx2D8bMqF3mzGPC+TCTOmoo5iLwTyL24l6cixjA4rA/39Ujh63iBk41YBUl
 EBzu2nB7Zejf0DYkzoidjarMxgChOB4gFyhHuyVWypf3FDswhjqdBu5A/2PwX35y+xudDQB65O
 RQD1NyuW1yKM7B/ql6MmSSuGaQ7h1DnGmFLly9j/3U6FMQAiQm32pVIAj3rDbm/1ZwuNghUwW6
 AQQ3gYxH7zbsVE6MyJMNXdMUuF3JHUv7cEXUPxkh4qftoISTZzrzQ9tGhMZwvOM8Kf6U3H7uvi
 Rpw=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="284548747"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:10:13 +0800
IronPort-SDR: 2MRSgtay7Q+rL67JEHA7rsfSqgW38XOfvofWRwe2yuEAP9uOXNfor9dO5sZ0/P/i3/0levwYKK
 RNcnuBnyYYX91I8xb9bhZBy1KpzTDeVhh5beh6bAmLulL6FBgPGL4AijDfEODdWJUfsUwTbHBv
 Dpd1AUpm+IGGs8i5u23DcK5/Wt5p7ilGl4OYSbIQ277Ru+ypiw5SiBTMRkhsHf27gyXZSOEkuG
 Vgr0apc8abnAXaJohTXDXIketStEpx1NUsToLWOcs5rnw63w2EcTkRMwat5YKYrtkSFmeHdwwi
 Z+MmwYdpjwC44u6NzoAdHA8V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:48:43 -0700
IronPort-SDR: DsLTAwvafeFnBGdO/dVOO6YImgnyBoI4/bl4AXensdFYfkrwbPFoxqarMNhdttltOHr40Yrn16
 3qhw6GGUaYDxgwRNZ0wATkpq6idAlKH/m9Rx8as6JNqBmI6qqyn3q0gc8fbeY94GWDAFbDdH69
 klV5RdAzmlqvwXjayDejKZDNEhB/bV71SMl9kmY2CkmmIFYOKPLL7544B+9U9LF+mITzyFPQVX
 iuA/8fZy2fr9lgp8Z6YGkR/BlXXtJdmhZuuB3RqCA8XlJTEun1U3zYNFfuj/DV+o9sI/OM7Ujy
 Z9k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:10:14 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 11/14] nvmet: remove repeated call for nslist
Date: Sun, 27 Jun 2021 22:08:14 -0700
Message-Id: <20210628050817.19788-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_221015_518933_FC56D683 
X-CRM114-Status: GOOD (  13.03  )
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

Return status from nvmet_execute_identidy_nslist() and complete the
request in nvmet_execute_identify(). This reduces number of repeated
nvmet_req_complete() calls for identify handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e625a33d0861..749d7e695fa2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -567,7 +567,7 @@ static u16 nvmet_execute_identify_ns(struct nvmet_req *req)
 	return status;
 }
 
-static void nvmet_execute_identify_nslist(struct nvmet_req *req)
+static u16 nvmet_execute_identify_nslist(struct nvmet_req *req)
 {
 	static const int buf_size = NVME_IDENTIFY_DATA_SIZE;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -575,14 +575,12 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	unsigned long idx;
 	u32 min_nsid = le32_to_cpu(req->cmd->identify.nsid);
 	__le32 *list;
-	u16 status = 0;
+	u16 status;
 	int i = 0;
 
 	list = kzalloc(buf_size, GFP_KERNEL);
-	if (!list) {
-		status = NVME_SC_INTERNAL;
-		goto out;
-	}
+	if (!list)
+		return NVME_SC_INTERNAL;
 
 	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
@@ -595,8 +593,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, list, buf_size);
 
 	kfree(list);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
@@ -723,7 +721,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
-			return nvmet_execute_identify_nslist(req);
+			status = nvmet_execute_identify_nslist(req);
+			break;
 		default:
 			break;
 		}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
