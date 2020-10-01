Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0B3C4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 18:55:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7D620872
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nJUtutPX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dkp3dc4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7D620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7ECKSf99iR30eyYAiaJrl3mSnJ40OBUzGt3M7bO/0d4=; b=nJUtutPXiCbelOPB05+6888TP
	7aN8P4cRacGQCl/DsNSpcFA3V5KG4cNJnPSg+1pVKAT24w0pDSOqGCeU9QW3xUCSkzpExuA+9oGBX
	d4eT+CfMa9x/cj2Gs7evQzzML5cs4QxIRk/nXs3UIfLzM0ZhPH6plA57aI0rj+W1+sxKWtbuY84y2
	MZmazFAQhrP8DModsUH/iF/kvJ7T+UTUPve4qP2H//9wyP/BPigJbaKuBpzBPpaB3VcZrvX0dMIz5
	zbrf9n5i1xkT3x0yyRZQW8ZqHlM9t/JUgCkc5yygX0vUA3CcbKjJtfetnzyGAcQChSMLlxxJWkCtY
	rah0mJAeQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO3jI-0007Z7-U6; Thu, 01 Oct 2020 18:55:00 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO3jF-0007Yc-S5
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 18:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601578497; x=1633114497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VCqrRAwEL5eQ04u4O7LsHnrtzhGG8MX1F+io7xQnpC4=;
 b=Dkp3dc4s3+X5EDf4kINYLE1ye33nWKqjlUYhBaGod9FBKUng2sgrEgLh
 0cmjeP8jOaQqfsBrnBmhVQ2cS6YXzSzWyhFZJw3opfkgtKfJobKN/q55n
 CjQZuA1gz+jO5MzWbZwiWXCT+Q6iBhpHMQD5tKp9gZc1MeJdski2rFdIE
 R/mhOxCOy6DNs1XZwctKCqChijQAtLUXOeI/D8a/R6FBKOfZIju7/8hxQ
 gsv2HtcStdOFYfJS5tkwS8yNmqdDV3APWAxBAjJs43ege83pIak6AW2DS
 Gxn0m9j/OINhJrr0ygyVQIHo7Fvhyh8Z7SKTfYRyYBSaV1c22U7pGf5pm Q==;
IronPort-SDR: wiWD0Q9boVL+xM5mP3YKQgdaJCNsaQiepRsVTmhbeuEpkZJeo9BuIDpRNc9z4MHw9w/FJK4hWH
 QgF1P8d4LoitYXCpI9nEiHv8UdQs0fyVmutqTdAVjhgweEQuRTSmhskd/2k3Zrs2A+AmYxVrPa
 acFfNZ3XF+x6etqi8Y4qTF8gVgmenjYmTWMen8I4h0ZChycAQ04rUp2t9B3XV3137HLlan0CQA
 2T/aKkF0CmnNH8idHSg5ONxcT2AkfrIC9poRl7FrY2VPIZnZW5HFUtacvtDuyZ5omaP3Al8Hn7
 q80=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; d="scan'208";a="148872195"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:54:57 +0800
IronPort-SDR: 9jECVowylWYoKd6oStKr4cutqfjpEuZt1OUEPXdwwz/6klvg1zhvgVoEQx2IC9LHGUhZ34LHfE
 B+GX67Slg1fA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 11:41:48 -0700
IronPort-SDR: 0TJY5K1ZhDLbZjeEhvmXfTYavpKJ1qY3o/QIoj4uAlcwgaPnZTGh+9LOhXFRvRMT3Ue+iW37X6
 fuEF9V0iorNA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Oct 2020 11:54:57 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] nvme-core: remove extra condition for vwc
Date: Thu,  1 Oct 2020 11:54:32 -0700
Message-Id: <20201001185432.5464-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201001185432.5464-1-chaitanya.kulkarni@wdc.com>
References: <20201001185432.5464-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_145458_055231_514D6809 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme_set_queue_limits() we initialize vwc to false and later add
a condition to set vwc true. The value of the vwc can be declare
initialized which makes all the blk_queue_XXX() calls uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9a565096e072..c20ce8eabe82 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1970,7 +1970,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		struct request_queue *q)
 {
-	bool vwc = false;
+	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;
 
 	if (ctrl->max_hw_sectors) {
 		u32 max_segments =
@@ -1982,8 +1982,6 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	}
 	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 7);
-	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
-		vwc = true;
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
