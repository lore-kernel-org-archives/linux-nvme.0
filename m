Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F65EC49EAB
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CAD6161C
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CAD6161C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3QC6nkVJ6cYBdEYMHgASHVMMWOCn0hJ7zeoU6HCH4os=; b=aeNbJ6A7ZTeZYx
	/YDkQbnymk2Vq1i+QnZVMozpusRj7ymIDr8G95/n5v+soC40lniCclk0WmCmDNJCsWdX3v9qMcnHx
	Fy6IzXTTh9G4FAaWKM42mK5CmSIVzv87wTi4k7zGwc9/f29t2b/H3IHs16gfI/kXA5Ooiec3QfQ6U
	Hx/5MGv9IkhsmGJHp0DmdiStC+LaLJLMMA7fd+KGB9N+02R5evyWji5JAixSfoXPXEp+YC1deHp9u
	HHH/OTo0HtzFcKOMzhBn/FiHbsC2HIviiiYAQ1I9KkbJThvWVzQ9LkGxjZNcK4oKZv/laAbbd/ODq
	waeyVg3mYsfIcW4kJAmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjW8-006lHq-0o; Mon, 28 Jun 2021 05:09:08 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjVs-006lFF-R7
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:08:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856931; x=1656392931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fKPEPsCmyXru3rKMolJIy0O3ketdTNfzTf7gwRVmen4=;
 b=E1vNkcuP2CPMbxlC1QfYBr05tBDhNAINSCouyp8HMWWHyTVOF0ayGm+D
 QCwfEt7pIGU61PkHwngTVhcIZILUeeMpNo0zhDyols7/hdFZxJ3rwgxeJ
 k2CZSIN68cf42vlOtbRMR6eyDO3IAgqmsYOvAh4ri7D8+sq7KvaY+Gfq2
 YCp9h0a/71bMv66lIJ2zN1OwC2wTt5jVubushxoEbFjWq+kJccmTU4bGL
 guStoZB4icRRNyk574CZDE7N6+3FTuenBujf1oBo60lsXrKEbfWi3YxiE
 Z1EYiaiEbshJov7heyrLU9mJKEsYOwXgvQEPfrJTDN5dj723xheyYaz6c w==;
IronPort-SDR: QMohgoByzeLJA4hvq5JqgNkCq6UOEJ+9xuEViVga+ICdU2D7Gmi5cbXczZTP+ZyaGxIYiTBMvD
 n0Y0urKqCp+LgiUf/6lckSiVb1HsEXiwWv0P7FBehtEz1thhv29Rtuz+xh6h5RkA12BPdmaant
 O/Lxb6Ukbrbl8svQxV2uAa299/EkOPxvRXiGmT0vp4FXE5U5Legt+kSNZ3/YqPnMD/zB1Z44Ou
 0e2XsRJ6iWBSNfcajDQ51dhVajo9/K+Su4Y5uhOxQ99ulqNanqkGrAzgWiZercpIUqFQGqR+CH
 NiE=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="177847677"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:08:51 +0800
IronPort-SDR: jYkzMVVRMY2EAcBDhn0IQFsba33Byl45PrIG0OEJjG5tbAU2iTUPa99JG7SJsjDPvl6ZscFE6B
 nGJGam3+G78M0GJSi4eBAGNhMyZmQk1CW9LhTKGeQAr+lZ2sLQf/XJqY+r1PO2Msi95frLNTm3
 rp9q+TrM/h4gkXh/AjdfwNOlkJ2Ijqnkyw03CwDzAJT8GeQunF+wWnq7VZbAY/zeiTlryF3rvI
 7LvPSbXHCAXDScf+YxqU9zuOWLuvImqH5bbzYbtWNxgmEVIIwEj+CdTsUBaZxg9FKQnlc32Yg2
 MhPNxkOIhposk2JRSfb09PEP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:47:21 -0700
IronPort-SDR: 6R6W1CuIyOk0H2OXq9+uIeH2gSImCcAmYVFsmEH3wEiNjPj5165OUenUXPWrvnHeZXPx4g4Zth
 s7KvrkN8cOChcCcOeYilPereQ0RMjWMJqY6YXOmNcgo3EvyxCIEQsFH5E/cZnv2umeEWh14y9s
 ZNgWq6ekwtaNxfeIOgy2P0p/vNn33puxOTyVGarDZyasGAvKtkI6h9Ps7wvYQRDeCnaf1ObsPY
 Ui/ezD59zVVgojQi+Mj9mL4Hhw/5Fu1y9qPo8gg4ax9dBsZdRu0Fe5fMKpCDmzQOyPNox6Nv2B
 ekk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:08:53 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 03/14] nvmet: remove repeated call for smart log page
Date: Sun, 27 Jun 2021 22:08:06 -0700
Message-Id: <20210628050817.19788-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220852_907016_7ABC788B 
X-CRM114-Status: GOOD (  13.90  )
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

Return status from nvmet_execute_get_log_page_smart() and complete the
request in nvmet_execute_get_log_page(). This reduces number of
repeated nvmet_req_complete() calls for log page handlers.

Also, this allows us to remove the goto out label.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 66bb5b649ffd..079fe04d0ee6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -130,18 +130,18 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 	return NVME_SC_SUCCESS;
 }
 
-static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 {
 	struct nvme_smart_log *log;
 	u16 status = NVME_SC_INTERNAL;
 	unsigned long flags;
 
 	if (req->transfer_len != sizeof(*log))
-		goto out;
+		return status;
 
 	log = kzalloc(sizeof(*log), GFP_KERNEL);
 	if (!log)
-		goto out;
+		return status;
 
 	if (req->cmd->get_log_page.nsid == cpu_to_le32(NVME_NSID_ALL))
 		status = nvmet_get_smart_log_all(req, log);
@@ -158,8 +158,8 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 out_free_log:
 	kfree(log);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
@@ -324,7 +324,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		status = nvmet_execute_get_log_page_error(req);
 		break;
 	case NVME_LOG_SMART:
-		return nvmet_execute_get_log_page_smart(req);
+		status = nvmet_execute_get_log_page_smart(req);
+		break;
 	case NVME_LOG_FW_SLOT:
 		/*
 		 * We only support a single firmware slot which always is
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
