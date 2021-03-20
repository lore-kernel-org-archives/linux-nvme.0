Return-Path: <SRS0=Wzp6=IS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A4C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Mar 2021 20:35:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F245D61580
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Mar 2021 20:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F245D61580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vW4aMAods6xbDgV4Pe41EwGxPv+PIyY6FlBfOaqkdl0=; b=bbtahTDQzv/ilt7DIn4T/sNG49
	/Xp1sUCvZL9iNXBUxY/vzoaPaOMgLiXqejSsLy58VCp5LsRibFVl9rQwJDI5AB69OBVnSLclBzdB8
	TPF6jeW+O/YxdVV+5DPD4Lt/ateTM2kMU8Yg/MbszofMgAOoCNugqCXqvyhwuDfeeeDl+vrciwAIv
	3VVi4Xbh68Q+G3/6/RcTKLqrXV1mPWat1pgyxLhOjhAVWcQCIpQxYmMB2cYZMYdD8i+xkmkOfjkI9
	qB7/qlYiQXq/pTcm1crso04qvx4ZOKuhU0dYX9PY/rvvbKgVyPsUltCJNM4VWfSHexb4tJVJ5v5sc
	6U3vGNnA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNiJs-009GvC-Qs; Sat, 20 Mar 2021 20:35:37 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNiJe-009Gun-Jg
 for linux-nvme@lists.infradead.org; Sat, 20 Mar 2021 20:35:24 +0000
Received: by mail-qk1-x72b.google.com with SMTP id q3so6651904qkq.12
 for <linux-nvme@lists.infradead.org>; Sat, 20 Mar 2021 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y2I6x03kMkjNl83YH2pVzq69+m5IQls71xhfE0AcrKw=;
 b=KeHzGqu8/PsfWoeJLkaD3GtodgJrtjUJ8XQVly8ZM67Czca+0DGhguknEVsdnfNTHY
 jeoA1MGoZnEakvwSgD000vnQaRrqp9DV93zNdTl58qH0Aw0LpPR2Vimk8wSC9XoNYUhz
 RF4AeIDWElitAWW52O9sijjKVRwMeu+QR40Ro1+tM7faslS282KVisAzIc2o6ScQMb3j
 vQpxB+v3816PpdVVmcHAr0fF5alBdC4+P4I2+1/FV8JLf3Rmj2NI2UWFqhOkj9uui6TX
 Oqp1ubXaL7rRMNCTD3uuUVNDq+Ob/9qKCGxSCdEaw8nHiICcMUL/bhp9pwcGPaejlV1D
 AEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y2I6x03kMkjNl83YH2pVzq69+m5IQls71xhfE0AcrKw=;
 b=Ybre5axXw/hH6sbduheXIaCrkS7l/OMEf4FkgiIt7fdlGutnt6dozjcSP9eVY6mrWn
 Ksqd8JKR8fxBn4yTlZGNwueCBM9EwLGQ0XYlEgStOItNX01pRF68k5Fn16i4wjR1/TG8
 PGZ81zrrYdsKpJ2ijt2aM8+Iq/d1U7pAa1/PUKTiGPxauUGXwl2o5TMc67z44+d70vSE
 tcpcd1NlD5yehZ7q88pyiDj2yIBIHUxL6XAhyD6v3iZKNHvITMwAiNmyCmvSWEFfmO1O
 2k/XErYH/ck5xS1IY2bpxOuRpFRem8nnMJ5O6m6rIr5WrOsjuyuZNVE44eF82lC4CCvX
 ZRsQ==
X-Gm-Message-State: AOAM531gNuKPyOIjovlFKRKTRcY92iuyPYCic/aKhc4vcN5ksBPw1s9c
 f3T7wD5mEz4ZNiLAvpUpeRc=
X-Google-Smtp-Source: ABdhPJyeeaRivoONc8OlG409EoWt/iHNzEQclWyasxayI8KLLuwiDEMw5Fda9Y4CTwjei+kmS9uEDA==
X-Received: by 2002:a37:6889:: with SMTP id d131mr4269172qkc.264.1616272521223; 
 Sat, 20 Mar 2021 13:35:21 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
 by smtp.gmail.com with ESMTPSA id i6sm7404702qkk.31.2021.03.20.13.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Mar 2021 13:35:20 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: james.smart@broadcom.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: rdunlap@infradead.org,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] nvme-fc: Few trivial spelling fixes
Date: Sun, 21 Mar 2021 02:00:03 +0530
Message-Id: <20210320203002.13902-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_203522_767246_58432654 
X-CRM114-Status: GOOD (  14.83  )
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


s/boundarys/boundaries/ ..... two different places
s/assocated/associated/
s/compeletion/completion/
s/tranferred/transferred/
s/subsytem/subsystem/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/nvme-fc-driver.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 2a38f2b477a5..8624b0c6aace 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -441,7 +441,7 @@ struct nvme_fc_remote_port {
  * @dma_boundary:  indicates the dma address boundary where dma mappings
  *       will be split across.
  *       Value is Mandatory. Typical value is 0xFFFFFFFF to split across
- *       4Gig address boundarys
+ *       4Gig address boundaries
  *
  * @local_priv_sz: The LLDD sets this field to the amount of additional
  *       memory that it would like fc nvme layer to allocate on the LLDD's
@@ -608,7 +608,7 @@ enum {
  *
  * Structure used between LLDD and nvmet-fc layer to represent the exchange
  * context for a FC-NVME FCP I/O operation (e.g. a nvme sqe, the sqe-related
- * memory transfers, and its assocated cqe transfer).
+ * memory transfers, and its associated cqe transfer).
  *
  * The structure is allocated by the LLDD whenever a FCP CMD IU is received
  * from the FC link. The address of the structure is passed to the nvmet-fc
@@ -631,7 +631,7 @@ enum {
  *   When the structure is used for an FCP target operation, the nvmet-fc
  *     layer will fully set the fields in order to specify the scattergather
  *     list, the transfer length, as well as the done routine to be called
- *     upon compeletion of the operation.  The nvmet-fc layer will also set a
+ *     upon completion of the operation.  The nvmet-fc layer will also set a
  *     private pointer for its own use in the done routine.
  *
  * Values set by the NVMET-FC layer prior to calling the LLDD fcp_op
@@ -640,7 +640,7 @@ enum {
  * @hwqid:    Specifies the hw queue index (0..N-1, where N is the
  *            max_hw_queues value from the LLD's nvmet_fc_target_template)
  *            that the operation is to use.
- * @offset:   Indicates the DATA_OUT/DATA_IN payload offset to be tranferred.
+ * @offset:   Indicates the DATA_OUT/DATA_IN payload offset to be transferred.
  *            Field is only valid on WRITEDATA, READDATA, or READDATA_RSP ops.
  * @timeout:  amount of time, in seconds, to wait for a response from the NVME
  *            host. A value of 0 is an infinite wait.
@@ -718,7 +718,7 @@ enum {
  *
  * Fields with static values for the port. Initialized by the
  * port_info struct supplied to the registration call.
- * @port_num:  NVME-FC transport subsytem port number
+ * @port_num:  NVME-FC transport subsystem port number
  * @node_name: FC WWNN for the port
  * @port_name: FC WWPN for the port
  * @private:   pointer to memory allocated alongside the local port
@@ -919,7 +919,7 @@ struct nvmet_fc_target_port {
  * @dma_boundary:  indicates the dma address boundary where dma mappings
  *       will be split across.
  *       Value is Mandatory. Typical value is 0xFFFFFFFF to split across
- *       4Gig address boundarys
+ *       4Gig address boundaries
  *
  * @target_features: The LLDD sets bits in this field to correspond to
  *       optional features that are supported by the LLDD.
--
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
