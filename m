Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B911BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D6464DE1
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D6464DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nENUwIuhUD50wRhvFXFfRnGhY/ZJ+kXAwGmp1ku6WK4=; b=Ll9bgnqujcG/90ek2Y4ggQP6z
	PKsXxd8uWTDeFpbJfIVeAHXCfrferwr1TnEyH25Ss9Zkqj39EpTD4Fp7upJyorQk9Qi4FKrnHFQt8
	nIGMiMyEqocp/g9P7wJoEi0aK58/C14/1Ah4Jy31TUBfHHrJ754aphKx8fPOEqSxYmZvlzQ1JEEL4
	rBjDbgfjUUjn7myWOeGtzoR7bZW4DnPEuY9dvl2fjreXwNusAZcfOgnTr2iJrOvYYI321mNyQOtgG
	lYvSVvzTIxcNjf7CzOZg2Mcagb4PyZLUCyHLo+lMx3fjOcEIwGekaLJXG8g7uiWddfpVd9LJ7nRqg
	FSUflb0PQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iN6-0006zY-BZ; Wed, 10 Feb 2021 05:49:04 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iN2-0006y1-KQ
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936704; x=1644472704;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=622s1k8h3rZaxUl+ImtLrqjV0H+uclrC8JFnzWr06EQ=;
 b=P6u7CvNQ9e+0Xz1rl7qMitmS0a+ziq5o1prSsBXvLvghMd/T+tA1/fVm
 tQAwDlfdOKCKETblEVZt6afT3q0rl5mi4ePl9jgNi6iRjKLcXIltyp1Oe
 WO/i3rvNP8Qy2MJTY7DG6wnDtGlopKRgBeNnoD2c/H1Ba9dFaoaQ2HPNK
 5FQzwsAoyfHPfyMM3XAxmFXFPutJNx89vm8QYe0CAGrYGLagIadHurTki
 CEIGKDIpPiv8QT/zs192ES3CF+8ltunwjLff62H+Y3HWgMmGgVyjHqSXf
 4FKDAxsLzuRkthJmpUkFNgO6r+jksjrCs6VgXkKDqkhAp6kH0LXv8YeO6 A==;
IronPort-SDR: KSU0xCQVJXOf/Is0e5mA9q97ph8fR+fxM1oxV6714e+QTH0QCtlb5hct1PgWjx7zwyQNGdDdUw
 di4BNK+HOYyszhoiyvtwh2GlvwU48v2UKhhRE7TP0aQTEEIwVn4pg6K0HO/qYFACyokuhYAVKN
 WGzdGGmohA5EB0gEVruqB7hBzd4SoHJhJcNDLchKRCNfBwZQicupfl5zDk4DFD1n040VjEVggR
 nGUyyaiJylbC7mHVn3QIAWV+6wGNQuprP/e+XMGpbH+s8DWeAnTlseMJzPFv4SSLYfsr82RU/W
 O1c=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="263725185"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:58:22 +0800
IronPort-SDR: TT+ZQyQPPLdX8SPJ51HkSPN7ZZJW6ua2GFwYxd1nz2KW0ytQCRBVjwuMPyLMQSIYbLUiAmNS0X
 VWnxb2pDFH3IP1Rs56wWCKfaIYyTNDTt40D1sD5DLzHi5ZJtK/tz6h77X5go3YBig6j/176b4v
 oIkrjDD8xeu/Nl6lNQjSUY2d5+f1GislC78nT36+FqCFTes9ZlKy0xg/D23k1vV3E7L2N8XyLO
 I7ImabgITCIqE45LbvyAz3jondckAeLzidmS0knjKrTrQEv+lui8f0i5Sr/6Jf6djqu9V8PaxS
 K2Jw9Ip2KK7a/mHsD+IPlGlQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:30:53 -0800
IronPort-SDR: yxfV8r7i+YXHv0aMXUXjDF9hoTbWJY5GeP3bf08cyG2mo+KSK8KWjeup0+VHnbSrbDIVWWMUBO
 /SeVlqPO68IP+A9lXht79n0zdMgQjl6zkROHAb9Y56C1xb1tK5qlMMfCN7oBWelK3z4h8UKbpV
 VBrO/LuGqmYLJ6oRxRNXJadM8XgEfTTi1WDR5MmA1On1PKVx4M5ZAyAx0iesWK4ZsgYJd3I484
 r13frsLEr7xBaV4xchN8XK74GwOgVSooaWgbI+Xu5qnFDk5t5kazAuCgwOPeQ+K1eK8GaOwLId
 NyQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:48:59 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 07/11] nvmet: use invalid cmd opcode helper
Date: Tue,  9 Feb 2021 21:47:58 -0800
Message-Id: <20210210054802.34269-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004900_879748_5FAC02AE 
X-CRM114-Status: GOOD (  13.37  )
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

In the NVMeOF block device backend, file backend, and passthru backend
we reject and report the commands if opcode is not handled.

Use the previously introduced helper in the passthru backend to make the
error message uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index cbc88acdd233..3b22f4a868f4 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -494,7 +494,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		return nvmet_setup_passthru_command(req);
 	default:
 		/* Reject commands not in the allowlist above */
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return nvmet_report_invalid_opcode(req);
 	}
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
