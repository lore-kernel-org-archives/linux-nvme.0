Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8A5C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:42:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB373613AF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB373613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Twp+t0WhWIxi/m9Vl1bklgyuOuWdc7kZ9D+ISdglWow=; b=oTa9KMYLkEOSrFGWiXIi/MRUNm
	bjwOEgUwQ8gpfR+WcL0nrt6Lw6byXorvuf7nM5ndnRWCvff7ylFv4g0yoWi+wE3i0ZJ5zgtEdvKnX
	GIU9ZD8d1FWy1Wp8rt3uwIQ1uvXewzqkVwjD1+sq1PfI8E3ipskVSqW3BSBEhatrz8X8jejMM8iz7
	3eRWmZ6/8Y8rzTdnYNLED7UHZtSwykpVbXtpx2LDy/IXw5O5GXcqYuqhR3VuwAay56SxY9AdHIp/a
	0jlAIp7VAFzebWKJoauB45tksOWF9OvGEAJpmOBFjhXFtClORACG4gqowAPOZKmNwHqJNZSNDuhKW
	euiKtwzA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDqj-001Gtq-HF; Fri, 21 May 2021 22:42:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDqP-001Grs-Fj
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2dYM0L4WfLfmWXgwkKiwMIMvpuHJA5WuR0xiaT1BRJs=; b=qRge6oP1yzmPbYTcgw/E7pV6yl
 rDJPe2ADiucGmsbS65uD6qLy4EKiLIn6N8jR/Rlx2wSRHNXti7h+OmeI2+5owRT7vwcIm/6cdXFDy
 GZ1D40RknxJOowyXUTaM8f+i1/vBtN5u24hzPO8g3TZAetGMFWooFQVLB1s6+RNA2qQSCR3iPc1FQ
 Ng4myQRshh1xH30eHzlwUVhoRh/0ttN5sdB5l/PJzF/MxwNHRX1iR6FctpCBcvnE1gWHLx+VWqDCB
 PAXy69wPXlLdUsTZCWopvSrhid70wD9d0UDSGdWlxh/fd+1WFsKoYbl372w6Ydj2E2XQISHJcxijK
 X1oV2lUQ==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDqM-00HTfb-WE
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621636931; x=1653172931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+Q4v0KUTddCS1F0YqdXkUbHNpHV8RX3LbkFm+zoNuUs=;
 b=i54fFfFgPsKmdgS2itAV6wSTr8rh9EaiHnOGFb3qg3CMPs5eeWoUs6hq
 zxLTWDs30nMqAswxRq4jaM5cnzcYicBpykMOswnw2ICMTHY1iyaucO9bJ
 B1Ik5RPNZq/Q0W6m3YBpcLRTF2YUThUemxGLd2jLAwYYlwnai9q73I7ag
 sujicYUfCsm6rAwAZMWdlV3fKSXg+6UhNGoAKqpjq2ETvOWB2fjXG4dbB
 BA8ZIjlciS9nuhfLmgVkFhil1Z4x+7k53V6e7pAyBe+Wlu2tI1w1g0ePs
 Q8kISB/SWTXISXQ9NeTL725n5Y21gOuP3iX6AJflZkUS3mb7hVe4uCm/Z A==;
IronPort-SDR: tnuFDzbY6R9XiLL0md+SW9iC7YZfHbD3+5fyxupp8dhoQvbR54fIe+1L0qyPlJpRTfRAl7cPjS
 o3129qDMJHXWa3iCUhjiz0lo9JC+r+XUNecRD6/4frn02QfdygcKZgZwVNhSQB6z7i0hU5E6r1
 EyhHUS/blG6qxdwEuEBTeorOlIpopQcIUONDy+ZQD+cGhw93VZBlGLMMT8GxM3smt0EEut/+lm
 ATm/K7NscQiUTUlCQabSLd0uGmSBaGeA4nO8mufXTH+k0LspKGjZKHuEiZnrQFH+/nvT9YtpbI
 yhg=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; d="scan'208";a="169598955"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 06:42:11 +0800
IronPort-SDR: 8dHi7C9n9YxhW1Uh21SQsMCU8PRkIqjh6FB9M7iWDM9Tp4E4gXPwq+xRcYkzR7xrvNlCKuAChU
 oE7X12AIRk+MKFF1PEBiA8fd3jetv6DVnx+Aioxlj9OeyIuw6H3I5yYblWMu21zDGb4HTo1tDR
 lKtHVDF1Lkbfdua7IgeYR122plZne8kEG+66B8Ai2uvoOhMdFSsnC1RgCrmfW5leNAWy/ZxqZk
 1VEj2c1TP8Cv4FHm/FFUmpSEzpiMjL4eB8jSbKcJeNggzU38XoZeQE/+NkZCRSU8S0hJ4iOcQr
 bTsIJv6PS21Kmb4XPgtv/dIU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 15:20:32 -0700
IronPort-SDR: sJdAaALD/IcjrBMkk3WiXm5pS04DSvriSxB4aovgSm9gMOkSDPnK+rPBKM+N4bL9QKzFGCf1Zv
 Ew2UnmaG8XG+zu06vapxBJ74FnVR09cltdBczkcBbgyFKVkgbzpamLdtbj3c5gYcOBgqJZhO63
 fliVcepa9Z5u5TplG9/DHKiTCdElW7LA5gH3fMwBxMCqLKv+lDfhUGvNuqrH1BhU1djhvkSt6D
 dgy4IvWjoal3XyyZbOigp3s9tiJOvgz1P3XYJGZGycpmzFmyq4e0HSDpe+ti0NhXRy8aJRtZnk
 5wk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 May 2021 15:42:11 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/4] nvme-fabrics: fix comment nvmf_log_connect_error()
Date: Fri, 21 May 2021 15:41:57 -0700
Message-Id: <20210521224200.7380-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
References: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_154211_114821_7B0375CE 
X-CRM114-Status: GOOD (  13.86  )
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

Fix the comment style that matches existing code.

No functionality change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fabrics.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a2bb7fc63a73..5a1b8a1bb145 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -254,19 +254,15 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 EXPORT_SYMBOL_GPL(nvmf_reg_write32);
 
 /**
- * nvmf_log_connect_error() - Error-parsing-diagnostic print
- * out function for connect() errors.
- *
- * @ctrl: the specific /dev/nvmeX device that had the error.
- *
- * @errval: Error code to be decoded in a more human-friendly
- *	    printout.
- *
- * @offset: For use with the NVMe error code NVME_SC_CONNECT_INVALID_PARAM.
- *
- * @cmd: This is the SQE portion of a submission capsule.
- *
- * @data: This is the "Data" portion of a submission capsule.
+ * nvmf_log_connect_error() - Error-parsing-diagnostic print out function for
+ * 				connect() errors.
+ * @ctrl:	The specific /dev/nvmeX device that had the error.
+ * @errval:	Error code to be decoded in a more human-friendly
+ * 		printout.
+ * @offset:	For use with the NVMe error code
+ * 		NVME_SC_CONNECT_INVALID_PARAM.
+ * @cmd:	This is the SQE portion of a submission capsule.
+ * @data:	This is the "Data" portion of a submission capsule.
  */
 static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 		int errval, int offset, struct nvme_command *cmd,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
