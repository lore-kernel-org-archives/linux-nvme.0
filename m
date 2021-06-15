Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D1BC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 17:41:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989AD600EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 17:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989AD600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PBQeTBNwsUfHS3VGCWq4BOyo5+PSeXkPVP44bCs4MpU=; b=OMbCbLd1FOfhtv
	WOBwEXwYH5zxs52U5HlB08RIXCd5M0JQQCGdpPQh1F7G0IOmuVsRCkVAq3HBS6yHyYlXWZjRQpsO7
	D7iu74EfoZ1+Syd43phNAz2ujHXkURSsqEydErIeJv4wYHAZXyhlZMsNn70Hg3lKTCRF6Fx+4j45z
	0KLBjphAiqio/cjTGdA25f4QTpDJlfnsWEaDHnPW1pfyhhRG4bd2PDr3bEgT04AqXHZqImuuLMPNQ
	A/xhE2/KDImPpgeZzGvfpxDizn06HFfmXrdZ4/QVwaj1HrQWYrI9aWWotBa56NZZd1i9Pkj7jjSlP
	EO723aoUWZ85R+1Z80Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltD3q-001oWP-9b; Tue, 15 Jun 2021 17:41:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9PT-000DEY-GL
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=a+OhSKxl3seT/lE3OiERlShDxOER7UWykPoLheLv5b0=; b=H+t2HLgTYbgVkzvKl6liG4YPQ2
 2Y1Wtr2Q9VMMk6fBRDB9ybEBz1tI8igDPu1E0f+OI3CDuJZ3TU1Il9D0qP4LL9kXWg8AsMrPsbJn4
 aYSYnu5YPdhhlhKIyJYIzeWQr2E9HkAyMXI05gGJJ2k+AaDo6pq5BwPTWcmKdxevyLdRlmvibceK1
 Rz/wO4n3n/OcHkqh8t7Ck1pws1LOLAA2vzaA7pN3Ypu+WjTs4bS16Zau4zZDHwOYhGN0ESxmVTgwX
 +ATQ/Lb5jj5LmBPcXg/DX5IDSFnnaWsx/PABKEhT7SZTmEMEapgIjZJJWr9hUIU9cICQXpgROczCL
 nr4yuRdw==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsz5u-007H8Z-GS
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 02:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623725195; x=1655261195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EsWbwxTg4VUXaDlYxelGTdhRtwyMwezwkag+PLlp4u0=;
 b=j270ZN6T6UjhTTuNZm/J+jVZbW2mjdwh/eky17O2ZAQl5u+7EPIs+hRI
 zxJ1rflxR10M8wudsv/uij8M0H3wUpy4cen3HjdmYGRawLm/M+6OeZb5U
 jWyAlFzJEH60glO77SzGD85+1g+mifPs8gE2+jWjs8ro62bwzlb+l89ZG
 198Ri7kQ3bRkbWMX9QlB/OTnTmFm6oWXESeUfuCGNyrmWOTV2yA5CXyoV
 Dbeo1tC9Xy6hsC+mD0KRwFPEZir1+38relUrjPu5sDro/7ayxl9QorW4J
 J8HO2JOyyF5BN+1uDbPCXtFg/6M5iUvYXNM/4zsa6PvM8mlfAy5P/sR3m Q==;
IronPort-SDR: ybB6uE/ZHlF3pYcdCxXk/0TjrXnPoeRAN8ZBI8uGuyebKT0pBlMGQWsw+1dPNQgQN7w6r1VS6G
 2L5S/QV3yIwu3OZ/scrrtsDyXrpOTxCgoMvcFhPTnRIDUGkFhEu51shtSB4qocvXIqBZr18lqf
 Rk0wT8xrR+uuX09DsiOBzJE/qeKNZ+zfIYGTZt55+ijgVMThBV8gJ8yjTLMy0tKlFoN/Tq7628
 zRrOoFwfuEmXXw3qxiJ99o/S+nBfVFXVVRViNewNtfHAED4Id+MoXxtjSqNxpMtBhonrl0L/wq
 TUk=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; d="scan'208";a="275688446"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 10:46:31 +0800
IronPort-SDR: S/h6RmQR6UR6tQ3B6MAWEXF46qQf34Rbs44y++JLZfkh+9uvtzljnhOcCQmeFnd5FiPDSVRJ7d
 rQCtkZuatZzNFcJnG1y/1A3juQsexCC/7bx2xaoBpHdBOr4IBaEOo/YCHYY8EMzwD8Mj2yld/g
 47pD/fjpgB1s8755TS08KSF/QorqigUCn3ruMjMkL/iPn5viZld3JNnGKG+vB3XMfb+WWtPq44
 gZsccI1ZxhouGogcOimNuoZZU+3esT5iBYgOREE3TtHip6QwOa9Opb8kWlFH0LZuLVk1SR6Qwt
 mYlwlXqOsm6+J4KW7VZs6fFm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2021 19:25:26 -0700
IronPort-SDR: 994xnqAahXdEtleTDIHnPOp+SZVhfrxrkaBL4YBn8tAA8HlN+2rsqz6ZRw2MaJZ9/fBdwAp3K8
 d/VYGaDAcdZAPFSNQdaE4mSEQUtNCBdnG+XEzUrWEzpMRbWa9fGgulr4q9UGO44unMP4a+hTgp
 RbGf/7bUq/x7eruKutp3hSxLp1YqyLhXbX2W4RrMAsymBhkXBq/Me0dxxjuGYJCqaRHad/w/4V
 ETnCPNHCzJaE1S0yoC23E75DRn8087SSFpygOw188sHKAfbtSvpWSqh3DnVyveSlGGUVlqLqcj
 HBs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jun 2021 19:46:31 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/4] nvme-fabrics: remove memset in connect admin q
Date: Mon, 14 Jun 2021 19:45:53 -0700
Message-Id: <20210615024554.42585-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
References: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_034633_709448_8833E6A2 
X-CRM114-Status: GOOD (  12.13  )
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

Declare and initialize structure variable to the zero values so that we
can get rid of the zeroout memset call.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fabrics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ccec9acedef5..86a1a05de71b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -354,12 +354,11 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
  */
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 {
-	struct nvme_command cmd;
+	struct nvme_command cmd = { };
 	union nvme_result res;
 	struct nvmf_connect_data *data;
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
 	cmd.connect.qid = 0;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
