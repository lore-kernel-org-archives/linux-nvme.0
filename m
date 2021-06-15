Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B7FC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:26 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EC06162E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EC06162E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=btHEENXx7ijLnjbTxT/3gWtCvBeaXmMnsZYLITyw2y8=; b=G8kn8Bh1pjei7z
	GvnC8r2nbLGFYP8kdlVSfUhEq8k2rTDj56w23tq9CLIye3qwJ8mS3SKK07e+te2WH9VqiUjeOgzpE
	7yKP1FCGmHj77WRL0UZJXSO1sU6DcM+y5z8fyKV+kQt2vjTIdBm1UkSy21kwb6nFjDwfxv5CHjkh6
	gAsypSpDxzRaSQlk2RB+QKmzoVW3W9S1In/7Qnrlt8F/amBk5G3VqZRj2Dq6khuBmTayG4VNaKxzr
	PWfmO13sRe6F3yhS6SlfQDFaJgLmJXRZv1R9YVM0TJhCm0QdKBBonlRRJq7GbumQOjOHQEKSHUH5i
	ck4PWNLO9kYpb6noFYSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltBlx-001IVl-BE; Tue, 15 Jun 2021 16:18:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9PR-000E8e-Sm
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ow6Uluf+3MT7+75fIBfjJu1UnjR6Ca8r9xlnqQze3bU=; b=kFEHshMeNH4dLlfss2sl4supIH
 b54jS5jLAgBKqape6BOPtTW0hoE1L0kEA4cqzC9qDG42BQg6lgMFHpWpyPgic1O3L2Arnqh3EPeIN
 m6DVBMX5G/B/nVknosrxgwQteVMAkadhk2JBq+KJ9aopLuq3AE0aoXyMD57vlzjB+apzjZisFFGID
 I3yy9BePW148JzHnF16SOxML1QnD0FN21CjRWTggqolTrX+X2uCKxgzVYD806HrJ1nllkqifLYG0D
 vB/W8picrN7pBlnDCqzDHcmRRgqZyuAsevfTxg30727XPTHhSk5sjaFVrsNSw5itWt945M+qu6H0M
 MYSs3F6Q==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsz6A-007H9k-6G
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 02:46:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623725208; x=1655261208;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QAshtrWs8bmvVxaQC8ERrzp2gRK+U6dAMmlfGAHLeWw=;
 b=Gpm/vCaWg5VbpKzlGaoMHJWKeNozHXvzV48ZFeQn1Psb+wZQPsfZ99rZ
 MhNDd+i4Z2zB3+tO4IUQCwfBHlYHf4hUNGJKOm6ikq6nsie5wNyS02sni
 FOK6A7qwxEgJ0+cVqLbPG3bllfOvWmYKeALfJA80PBI8gpKroDc1t0gk1
 AUzV/CQHgEmzvHp0S7w3ppM8bgcrkcQaQAX52zHwjwoHKTcA68QdQVzju
 qnQhdeZweGFcamFFXlfPrbhKNVXggXZbMATN4DxeIAGIVtTrk11G73pPA
 AdnZdq+5boB8eZKQ4coOdSe8oIUgZHFuW2nSqXpctNJTWLhiT1ojOKWiD A==;
IronPort-SDR: ovMqQgyvfSdrFIiuwU1t1yPT9IQghREysnYKD2vC6hwPM5z+U28vK1uk4AFIZYYVIq3BBpVGHc
 NBJv2ugzXdwWcjSoDYrWy1KSZBmcpGbj9tMWqWD+J8iC9fn7hGUPLnJTQkihgOHU8LZv3h3/RK
 EOdWDIkR9L42a2dPQZPfUaN2cBekBZOStxuE6+IxgHIAw/suiy2/IrZGCJugFXXtI+Cr9k5Xbd
 TCr2DIZTYe7jvav9qDBGuc9QGWiThs4LKEBiZA659Ji4tBXo2Wn3fmvD826YG+PDTa/zGb9xQb
 X/A=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; d="scan'208";a="171905957"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 10:46:17 +0800
IronPort-SDR: OYSmEgYGq357JhVwKnt3UQRsvdES34vGewZF6JjYtzeM6PxvUkUoWCdGQ0lhvh+R34V7AE9Eec
 TepdBIzPpDW1CQpZeXYRSTQbbgUKzVnCfHF1l2AT6J9NFYeKxnqYbdwiZDn36XQPqHkE70exCe
 jzWdOcUHRlUJEDuCckWwNBFriD4DjI9m/VswJzVcAmpuGLyEIQ0GSlJCssW+/S7NryAbXkneVf
 jaGgDGD00Xx2Cs8qEP0whd1jN3lAUYcIXiPWSpPAdjpeJ2yRhP1MeOsJoR3vgpDHgx+EdAwBZG
 8FirapqzTZdlS4pfDR8/FveK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2021 19:25:13 -0700
IronPort-SDR: VOcCO5ONgJhIjkXzoko0drLXpT4wog799bRC9/QBnFkwm0tbyv1Gf0DM7ejkqwExcoIrfF9M5L
 6OqimMXGjpVA95Gi4erZVo8Qbq1Yefi+IbHxiNGj4EOEaMvlqQDuVUobRVbV9itw+ar6VyJOkt
 +tCnJZZTF/SbS/e6KyzmAhu0GXHSfaX/whnGogFfleYHMYWv6ROnjn0ZThfiSq1GQwre0jtxUa
 6yM9yWyTdwnGyHbr7brW2bX2e6lhWAlUsAwyUfX/oPbpXE2GCQ3bEvDzclTzEHK39oGk95oFTd
 c5k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jun 2021 19:46:18 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/4] nvme-fabrics: remove memset in nvmf_reg_write32()
Date: Mon, 14 Jun 2021 19:45:52 -0700
Message-Id: <20210615024554.42585-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
References: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_034649_616850_9CA3BB11 
X-CRM114-Status: GOOD (  11.68  )
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
index 506bb976251b..ccec9acedef5 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -231,10 +231,9 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
  */
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 {
-	struct nvme_command cmd;
+	struct nvme_command cmd = { };
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.prop_set.opcode = nvme_fabrics_command;
 	cmd.prop_set.fctype = nvme_fabrics_type_property_set;
 	cmd.prop_set.attrib = 0;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
