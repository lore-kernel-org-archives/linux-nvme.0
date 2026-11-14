Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DE606A898
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YykOINMK;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ZbgSi0ad
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KsxqtEqa+j7cIEzVTIS7e2jle9WDM5wz/EJVL2IR09M=; b=YykOINMKcclalh
	c0ykXcMtlbJoopoWyBF8L1vkiQXfiHFb2lbFbEbxwF1ILwBoM89GUEym+sm2M5Rg2oToM7+77wfuo
	AFg+QYKhU8lKWnJVwPPbN6spRwUpM0nYDGe7e9Qljr929TlNGPTAaHQseePAXFAfFuGjaAl8PHH+F
	tGL6+gBMWV0OmgYvDCV5SBl/xkFeQyjQOeZOQrLzUlS6LSuEyKi+4pHUpNGneALgBuWPvodZBWzuo
	CSd/82G39BpxmbL3D8hi4PmlxWYkkhQNPoI3KLA/+B5QV/KX3MORs5jVmmNBbsbaGx2TbhCUok5lu
	/kXJCz0r2bdm1nITP0IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45k-0000000FAFP-1Ti8;
	Sat, 14 Nov 2026 03:06:12 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45Z-0000000F9w6-12IW
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:06:09 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1a2761c69fbso1079216c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625560; x=1795230360; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsxqtEqa+j7cIEzVTIS7e2jle9WDM5wz/EJVL2IR09M=;
        b=ZbgSi0adK7WT8IB/AHZBnzjCnv3UF1Ru3L3v4IMSstoyFlCvwxX5uBmkbtNnOpADrj
         P8SZFlEOrw9d04NZk9yYwzbGzYuWxFkliotYHAtfpbmxA+hoMHqseAsR46EVwwVfxKN/
         1JmmwaIAGr2A0YamJQQ4MtglTxTcibDRLsNaVa/mEc9dxGnWaJyj8jZt6x1X9n0FjXyj
         vaa4c6jivQv2SgqdshAdr4wDn3I2LRmhzp1cxl9Y61rdRp6KUrs3fWAw1uYxeDbkKncK
         rjqCx0OTn2IjrHQf3W6FH21K3vmzVt1D7Fbc1kuYkINwFSI6/ClW8FGLtxrLNVEk7Iyu
         +3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625560; x=1795230360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsxqtEqa+j7cIEzVTIS7e2jle9WDM5wz/EJVL2IR09M=;
        b=snfXT/UuiXlBKECkTPRAY/779ukYmxMvCUXyxSe0/1OZgDfELwiFbrEpO+5uKLGubN
         Q/Pv+RvklPw1OGvIXagN9dZ9aSXfml8RZo/jC/RsGGv1Ur5thjAttRVKFaoKjY5x431M
         upCv+MffpgZiP8/6FAmPRKzZfaPHwctdFiJFxw6QYBx9jcKJnMrGD0oIdpwWT7VS2xQw
         ks2j34Eips7wu12pEe1D/mLIpJUtGwUm9cNvWY8tXkkW9tssHnbYlJsCzl01J5FYut/A
         b7HraT+gwtJbGSiewPjBz0Bn2XqSG4AeRPh0WQT61QTtDWECq8yAKbjPbPMaAGPS7d77
         GOGA==
X-Forwarded-Encrypted: i=1; AL+hErHNEA+xp941NWEbCWdfOsqtkaXFQyhSmJHjr7yWXbT+oFSOAgJVwehAipvnA0Rn6iBGQkHmhDMZmw2n@lists.infradead.org
X-Gm-Message-State: APuU4Z/FWLCpcJtj/fGRccs8TOpxQudj+Q2eTzFz1GiOB5PZHrC7JcMk
	vm7PmOGK3/75CeIwdwxaR2rMKwLCyKEbuPTsvRcQF4rjQHmcwpx3tvHhlRNp+gjP7cM=
X-Gm-Gg: AYBFou0gToi3XVktfLzauq8vn+yms4vwlxNKO7h2l0LTaCBOIe4KEYWulGpCiHSdTYw
	PmuBEq0qxprTCRutZHhB0KJk70eTHZQ7XIww9NRnUgDQ+4Xuun8C0/a8OoaQbZw0xWA3Ksqyi73
	SF5N2pbX/PUrhIW4xmx8do8E4gpEbhPHIJE3gaoimmlrrkJ+OeRgk+oZJWj6gtALlhv/NzyrtC4
	m6oKOsRjPHhn7sd3H5AWiqxRZoI/ww0U8+pk7aDGSwzo/gGokB9+u/+t2dnqVSX5bcbKr3oX1PC
	b9136q72+EKq2RJVYilA5f2PE7TG2UiHN/H/AU2CYqI3vbct9lxXbnkpPRFAVY+ZgU+3z/uZiLV
	UCqxICj+9JE9HuCX2STzD+0HO4lu6VEB1DuYn6F/XiQknmj4X6ofeoQnxByXkZhPzkHcZ8Aqz9S
	3dBGZAF9usOduQ8bvhtlKl6Dvu02khTP8bUjrrlXz7tdz1J705rIU4Mkhfi5bjkjyPQeNxO/W28
	E9XM6ZelBwAQ1pdrDLujC6oHSPZ2uBXvaobJ43203qVpmOFgaR0suLiP6q97WoAJFD0A5K3Ytzs
	6ACVfxuHGgNfuBG8+jNAhD5hvtbTdtjy82se/8Xp2fUkMvG4nodS
X-Received: by 2002:a05:7022:ed02:b0:1b2:4378:3545 with SMTP id a92af1059eb24-1b5031753eamr3862160c88.21.1794625559780;
        Fri, 13 Nov 2026 19:05:59 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:59 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/17] nvme-tcp: Use CCR to recover controller that hits an error
Date: Fri, 13 Nov 2026 19:04:24 -0800
Message-ID: <20261114030454.2836543-11-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190601_384751_E16508DE 
X-CRM114-Status: GOOD (  17.24  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A LIVE controller that hits an error now moves to FENCING instead of
RESETTING. ctrl->fencing_work attempts CCR to terminate inflight IOs.
Regardless of the success or failure of the CCR operation, the
controller then moves to RESETTING to continue error recovery.

A request that times out while the controller is FENCING is not
completed. Its timer is rearmed, since inflight requests must not be
retried before the fence is over. nvme_tcp_stop_ctrl() flushes
fencing_work, so deleting a controller that is fencing waits for the
fence to finish.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7ecc6c007f8d..244c6c50cf99 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -195,6 +195,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -651,6 +652,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 {
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->device, "starting controller fencing\n");
+		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
+		return;
+	}
+
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
@@ -2767,6 +2774,22 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_tcp_fencing_work(struct work_struct *work)
+{
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
+			struct nvme_tcp_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
@@ -2842,6 +2865,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
 	flush_work(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 }
@@ -2944,17 +2968,19 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_command *cmd = &pdu->cmd;
 	int qid = nvme_tcp_queue_id(req->queue);
+	enum nvme_ctrl_state state;
 
 	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+	state = nvme_ctrl_state(ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
 		/*
-		 * If we are resetting, connecting or deleting we should
-		 * complete immediately because we may block controller
-		 * teardown or setup sequence
+		 * If fencing has finished or we are resetting, connecting,
+		 * or deleting we should complete immediately because we may
+		 * block controller teardown or setup sequence
 		 * - ctrl disable/shutdown fabrics requests
 		 * - connect requests
 		 * - initialization admin requests
@@ -2970,7 +2996,9 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 
 	/*
 	 * LIVE state should trigger the normal error recovery which will
-	 * handle completing this request.
+	 * handle completing this request. In FENCING state the request must
+	 * not be completed before fencing has finished, so just rearm the
+	 * timer and let the error recovery pick it up.
 	 */
 	nvme_tcp_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
@@ -3209,6 +3237,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.56.0


