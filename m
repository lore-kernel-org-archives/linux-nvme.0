Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4BAC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A169264DFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A169264DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BJQfD1ET8Bn6bcB2y4rRsFn9hX8e9RgcUqZf4ZpuCJw=; b=SDwFMvMTlmQ181nfgLCMK5Bii
	PIEtgM31hJoKt+aY/1THBjWLJkgknRPJii2djdcg05uDTDV/V9z9UnQvWL9x3iSRDETpkiXTsqU7J
	mhBCMZJqCiTDEAOTEfqFAHUlyvSKWv6Myif0ou0qQJ3ro5z7T5dELbonpSR5O7ENAdVZm1i8idYnZ
	A81b5ftoHQ1ACuUcgUm0Kcv1csg5qvUBdkQb+ntKuwJgbNH8GUnbGwSfXZYEF1Af9USM/DNblf2oC
	FElx4pvb1VoQHZLf3TsQJZb3gNcb1hP6f6qq4QemYIPk44P73MMSfQOv3NwMdIl/buU6R1jBGeohe
	jPe4mLrmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAR2-0007cz-0k; Wed, 17 Feb 2021 00:11:16 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAQy-0007bz-Ub
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520673; x=1645056673;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rnKSpX1kE8vrRAWSCMUaL5MglhL2py3C/yDNjtOLKYs=;
 b=KnQTO8ORQbytwdOR28KICHXOoari4KeZweZNJAXj5KVKslMdHCah6Xrf
 aG8S5I6wLKrdkm2RFHpIElQSyKE9ZvE5EUBODmAh/Dt/vvYT1OU/h+Ra7
 O62S/6st5jG+O9sV6f/DS7KQGFKUfNbHnTPA0G1pmS5NN6OTychnhG83X
 dzlulywxLuw3+0d4+BaxaAvvDbV0ROMt77THL6v8KQinpQY5bwBaco/E7
 PcwOH8krsTv32OTg+8N/3p0rQROvDN0O7Gb4AVNY02v2l86G2paz89Fmz
 QmMrJqz2V9elryShv92SHN2cdlpT3hYxCfZJouVrZ8K1kkPMxcbSfxZg0 Q==;
IronPort-SDR: 8nVjgc8Ue0O0Zk0ASMrtQALBJQjYU4fOamyXTaCIC3BQCug/oiijVjp6wWisf4Xq+L8rB/cXTH
 7+9ujJAB56UDYP+mLSIB1rLrnE9sIUZQxbfI01fA4Qm69DABv/yjJdCvt7bStPEOBnh/7qdKY5
 KzJRzZiYGmETR3DvzhixRjBTPdZDTWJg6G0B2BXx4XdeeD13zIQeLhwVTZktWHTSCQ0LpeK+U2
 PO//kMJT8z+Psh/76n24TO0srIn3qrriyNzAUVBgNaGNgxY/qsn906uG8ayuSmAmtPxcvOUG8w
 JZs=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="161280036"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:11:12 +0800
IronPort-SDR: OU8kQyiVDYgu7DoECA9vd/bmzu6GQaXU9Xumc4f0dfWbJlHlRwcIpNWjGt97imb1HkRR481yeH
 ObFtFlHIp6Lq5auGSIelPjs+/Ah9q029Gvy+EdXaCC9nDurJ6Ua98wZM0Mvh+d6XTKdJniuprp
 Dntq3QK4Ls7YjYr9n+YxqA/jtcaFr/o9PlWOqbBnYnwnOk3UV+5uPcxMoVuPDuSXmhhR+7amHS
 FpEEbNgFVGW3qiCfBnbgoTl0GzLS19dRhVGDHL5bcobeUG4W1eqkfKg/22MlpMTVuXS/BWTplB
 CqFVR4ZrPSZ8hLxbla4NuI9i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:52:56 -0800
IronPort-SDR: xaxWf/dm0y1yEQUr1MXSZIa624xoeQF4r4C5tn1MewVWeoVfPL15RI7r0nVn8kZWOCmNpz+JQk
 fclZrhalDOGjHAkTLJ3vzEfn4XaVEb+rY/kYsxMDntePchJSDacx8uNVxi9GLe671G01u6wxn9
 ehTkSM8dbk43YNp8uSS3YyOwKAFti9XOsFennXvyPtqIOjpGsTIZJb1OcALLpa1Ew9dhvNJOuQ
 C6+xMQOnntUbqrYAMu1gaZ6riEHrqtxgz1FZ+jjxb1UIVaundRIbP7R6d6Z5rxcT4rg6crEWj4
 nWc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:11:12 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 05/14] nvme-core: add helper to init ctrl transport attr
Date: Tue, 16 Feb 2021 16:10:23 -0800
Message-Id: <20210217001032.25741-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191113_171444_AB49C39E 
X-CRM114-Status: GOOD (  18.28  )
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

The function nvme_init_identify() has grown over the period of time about
~200 lines given the size of nvme id_ctrl data structure.

Just like the tail of the function it has small helpers to initialize
the independent fields that needs some extra checking, add a new helper
nvme_init_identify_transport() to initialize transport-related fields.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 71 ++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 840c32c755b2..f5b8f8e0ee18 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3057,6 +3057,43 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 	return 0;
 }
 
+static int nvme_init_identify_transport(struct nvme_ctrl *ctrl,
+		struct nvme_id_ctrl *id)
+{
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
+		ctrl->icdoff = le16_to_cpu(id->icdoff);
+		ctrl->ioccsz = le32_to_cpu(id->ioccsz);
+		ctrl->iorcsz = le32_to_cpu(id->iorcsz);
+		ctrl->maxcmd = le16_to_cpu(id->maxcmd);
+
+		/*
+		 * In fabrics we need to verify the cntlid matches the
+		 * admin connect
+		 */
+		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
+			dev_err(ctrl->device,
+				"Mismatching cntlid: Connect %u vs Identify "
+				"%u, rejecting\n",
+				ctrl->cntlid, le16_to_cpu(id->cntlid));
+			return -EINVAL;
+		}
+
+		if (!nvme_discovery_ctrl(ctrl) && !ctrl->kas) {
+			dev_err(ctrl->device,
+				"keep-alive support is mandatory for fabrics\n");
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	ctrl->hmpre = le32_to_cpu(id->hmpre);
+	ctrl->hmmin = le32_to_cpu(id->hmmin);
+	ctrl->hmminds = le32_to_cpu(id->hmminds);
+	ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
+
+	return 0;
+}
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -3176,37 +3213,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 	memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
 
-	if (ctrl->ops->flags & NVME_F_FABRICS) {
-		ctrl->icdoff = le16_to_cpu(id->icdoff);
-		ctrl->ioccsz = le32_to_cpu(id->ioccsz);
-		ctrl->iorcsz = le32_to_cpu(id->iorcsz);
-		ctrl->maxcmd = le16_to_cpu(id->maxcmd);
-
-		/*
-		 * In fabrics we need to verify the cntlid matches the
-		 * admin connect
-		 */
-		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
-			dev_err(ctrl->device,
-				"Mismatching cntlid: Connect %u vs Identify "
-				"%u, rejecting\n",
-				ctrl->cntlid, le16_to_cpu(id->cntlid));
-			ret = -EINVAL;
-			goto out_free;
-		}
-
-		if (!nvme_discovery_ctrl(ctrl) && !ctrl->kas) {
-			dev_err(ctrl->device,
-				"keep-alive support is mandatory for fabrics\n");
-			ret = -EINVAL;
-			goto out_free;
-		}
-	} else {
-		ctrl->hmpre = le32_to_cpu(id->hmpre);
-		ctrl->hmmin = le32_to_cpu(id->hmmin);
-		ctrl->hmminds = le32_to_cpu(id->hmminds);
-		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
-	}
+	ret = nvme_init_identify_transport(ctrl, id);
+	if (ret < 0)
+		goto out_free;
 
 	ret = nvme_mpath_init(ctrl, id);
 	if (ret < 0)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
