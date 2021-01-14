Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A61DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:34:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1F9235FF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1F9235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hg5XzUpRyA3aS/8cnooYlOzVode/ITkd26AbydlWjH4=; b=1frtTv1i9J5nYaO8jawztcxUj
	IeuFzUnHfUrvBXjXy0bbmzE4OppUwAKcX0/lTvN2qmOFNSNooxqKpBXaa4FFb8vILVm+aEuADCoDX
	6b0Cllng543sGNDkCE+LNdCrhzPeSQ64k17YST2/8lLqmUSalDbo6OubRbDJ1cDuNm02yX05UtHtX
	CDLJIcrm6WmuT2Yy59NrQ3Jn2LxnkUzUx1t7ao5pGCJApCUk9yvkQXBS0P5hCPk163dh9QR5wcLpu
	w3WJBVIQWID+IHYnO4N5JOSE6TQ07Mq8ouDVIHwiqrwH36Pv6pla+Uthsx157uWv7ThSaWDxa+D3Z
	2OW37Iu6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzrWu-0006lh-E9; Thu, 14 Jan 2021 01:34:28 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzrWq-0006jm-Kd
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610588065; x=1642124065;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wLJaCZAjsmL+7hRFn06VytdlyloIr2caxNxuDNz1i64=;
 b=NTYCOd4Qus1JPrMrBQjTT9d4pmdbkYXY5SS3IJyilgULLMbszwRLp5b8
 QwUvrx8qoHUTcq6xZzkbI0evY4XYt5L4iT8gFSNIhtRz4fZA/OTYy7rMG
 vhmavCFbsrAl7ddEt/gxBGbdjNuaLqfkQbGX6YyTxlVBNOTsbGXSmO9AC
 iriDc9C7wersryFcnGg+jChApBfcOkxJyYUaNV9VzxcBY73TOCXOKHTfl
 ggbrKhCp7dPAw641ZYKAXJWxXodVmhVhd3jD5UAt0DCroImWAmIEa6YQo
 qzfQOsLAphgblBl1/+c+PmYAaXE3IIbrcM1MgKot/zBP7VgQVfGZLkPGn g==;
IronPort-SDR: QdV28JZH+gWR3rZVfjtKP/yi6V+oauwuBQM9p9SeVZY6Hhgk9z/6CQXafotzzyiZ45Zdudw2WZ
 O1sK5IJUOxeLOjHQgv4pYPp9pyPt6cL7Y887cLUBvTqex2BuaHEgZBfNwx6TsZZvcws71+V8ar
 TjvJjztlioRrfBXmBJ19g+sGtvtMlvnkQAtTFJbU+sfFyWIHm7X3Sp2KMxustHyhcPaRzLsCaS
 aiJZHWE3VCZbWJf1OeuUYVQLnx7owotxGDSD4h0Ox7f+hbYN0WQkSo5vX7ewicYP0LEtrztDa/
 WRA=
X-IronPort-AV: E=Sophos;i="5.79,345,1602518400"; d="scan'208";a="158553636"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 09:34:22 +0800
IronPort-SDR: VoZ/XA0mgwKZlfpuxRnm8hzOB3w0UD4OPhSmgkdAjld3mdQrX/FPri79AAXJYle/VioDx2ai1K
 wsU/mftovWlda6GLgsaQK38PHFeNpqep8YgDVnWYGmelHMafECPE4zF/T4tmmo8/MdhAVpdZrL
 EA1J59TPIOIFvWeTwXsuz/xPV2ft9zzmJTtejKvfWleRTgzQ17iEopHMP3RlyEG+1JkXhxDhD3
 3kb52i7+VQdN2E/Y4Nk2zY87zN/u1GT3G5fpStNMeBihWV9PLj1q6lVwM6W298ad5zCI7kzBk8
 PKRBEuNJuvRXgc4fXxscY5G7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 17:19:04 -0800
IronPort-SDR: J2y6v+51BMPN0EPnMLAob+6FyFHXEJgcnt43MrsSNAW9pAlLO3AAxkn2UTVrLwtI52X/J77CSw
 NgHbHWV0cBElfVAL+06nUO0sTNujSXhytLrFu5p6WLTVf9R9xTyLMZu452FqowpbA18/M8qScS
 PK2IDhES1kQ/SwlYnEA+2G655g2qi5hfKYxcjijxRuCdLZlmKUhWJBvCxyWFQzg+QsIPBdCfkv
 yvpSW6aL+bAhaDc0aFn8xJKbhoBDYJ/bjfvOEzouH0qgvlAIEIypLOV/S6rrrQCckvAuFEajQd
 4uc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jan 2021 17:34:21 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 3/4] nvmet: remove extra variable in id-desclist
Date: Wed, 13 Jan 2021 17:33:53 -0800
Message-Id: <20210114013354.33946-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_203424_832120_F3224FF2 
X-CRM114-Status: GOOD (  14.60  )
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

We remove the extra local variable struct nvmet_ns in
nvmet_execute_identify_desclist() since req already has ns member that
can be reused, this also eliminates the explicit call to
nvmet_put_namespace() which is already present in the request
completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index de804d9762dd..1cc61ca42a7d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -605,37 +605,35 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
-	struct nvmet_ns *ns;
 	u16 status = 0;
 	off_t off = 0;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
 
-	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
+	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
 						  NVME_NIDT_UUID_LEN,
-						  &ns->uuid, &off);
+						  &req->ns->uuid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
-	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
+	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
 						  NVME_NIDT_NGUID_LEN,
-						  &ns->nguid, &off);
+						  &req->ns->nguid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
-out_put_ns:
-	nvmet_put_namespace(ns);
+
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
