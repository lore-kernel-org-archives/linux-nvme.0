Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C00C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:13:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A5C64EEB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A5C64EEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zOwP4bXM+98KsPCqQF5GzH1pcbTju+J/rpCAtebvmpg=; b=GS6jILLWSinkQnfU9wLUejiay
	+j8h+/MCMuAuWZyk4oU3dOCiwZ1UJtwF0+0aJlCY36L8vTFNZ2XhK0jVoCQ1zkIOyLhgM3cRVsM2k
	6SxL4aL6NW7wS3/6IxjHDqtlX9duDSJYsG0rrBJ7ev89OzODlFFsjcX6/SWQqNucm0yFzEuJAZbIo
	zN2w6gzC32ks//uEPedh+YspCGG3B5yiljReQAOGyz9PKOgxwTrTa28sYRpbCQ4xxK6WpnxmSGxdi
	0LaxcxwpXOA4eFc3dxGv3kZkJh3qN2VIcuERUHZuAiSMPTiF1GHXDDnVgvg8/A+XYuUtpk/WkVxHu
	joo01K/TA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHVzU-005y7H-Ir; Wed, 03 Mar 2021 18:12:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSz6-005GbV-TS
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:00:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=ueF9Vjl6Kuvfd0ThzHW3RHP0mgBsnoqbyugZfwdplWw=; b=cgBUykPWmvw0iBmqIIl8SHiwsE
 ACscc25thAC61eWgqpk+xO3PAmn5tr+Zq2vDA0HloXd2nYRzttIhxF0FKajJj3P6ZOkbyDSmi3znV
 wRVad5Jfbvkudv0059NKXr5rjlvAwzxzI2GITmK/PJ88oJ7p4Ie5jG4fZSgtXPgvBdJsfPCGBderc
 1M2uMPbGiZhkNjeeIHeJ+ZQ7t/hmaKL8FyqMnd0uHEcI+UlIlvjlOJV2TIuO+1Bu5iIRJS1MUDRn5
 EPHO+hXeS6G0yzp7xEbZG+MlFQekgTveWYWXc/WXxYzurBi5v52NfUUFTVlduqsICG/gEyzY8Adqv
 EfxxQzwA==;
Received: from mailout2.samsung.com ([203.254.224.25])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lH7bG-00HPmC-Ng
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 16:10:24 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210302161007epoutp02d2bb9d6c19cb3568bf7c8ec41f6f6338~okmAXPfPa2098220982epoutp02f
 for <linux-nvme@lists.infradead.org>; Tue,  2 Mar 2021 16:10:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210302161007epoutp02d2bb9d6c19cb3568bf7c8ec41f6f6338~okmAXPfPa2098220982epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1614701407;
 bh=ueF9Vjl6Kuvfd0ThzHW3RHP0mgBsnoqbyugZfwdplWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qCX3XcAb9VK5SZZ5ZAJtOyK5KOtRnu6aJwpyB4b1kH9uIE3v6gC47iK0o4f3gUTqf
 wuT7xrGc7cHq/oTlPi7rq2aGiH1V/6h+nYI1ikrEsv/eNdbX7rYdIsWne0d75V2w0/
 4s644XpfUvJvWFoM9Y5Ic7yJk+RC7CXGaxkw8x38=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210302161006epcas5p4721768b00c9c9a3d5dca503a4e899bcb~okl-MgfwU1776717767epcas5p4b;
 Tue,  2 Mar 2021 16:10:06 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 0E.70.33964.E536E306; Wed,  3 Mar 2021 01:10:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc~okl_qw5jt2043920439epcas5p2w;
 Tue,  2 Mar 2021 16:10:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210302161005epsmtrp200cb86cf0bf20a2c41890781415b7146~okl_qA5YV0582505825epsmtrp2H;
 Tue,  2 Mar 2021 16:10:05 +0000 (GMT)
X-AuditID: b6c32a4b-eb7ff700000184ac-39-603e635e85f7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 C8.5D.08745.D536E306; Wed,  3 Mar 2021 01:10:05 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210302161004epsmtip11271edbdab490ce062b3e6f58ebcf447~okl9VPwiT1292312923epsmtip1S;
 Tue,  2 Mar 2021 16:10:04 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, Kanchan Joshi
 <joshi.k@samsung.com>
Subject: [RFC 2/3] nvme: passthrough helper with callback
Date: Tue,  2 Mar 2021 21:37:33 +0530
Message-Id: <20210302160734.99610-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302160734.99610-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7bCmlm5csl2CQdc2OYumCX+ZLVbf7Wez
 WLn6KJPFu9ZzLBaP73xmtzj6/y2bxaRD1xgt5i97ym5xZcoiZgdOj8tnSz02repk89i8pN5j
 980GNo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKWN/5j7XgMFfFkwWnGRsYP3F0MXJySAiY
 SDw4up4FxBYS2M0oMXeXWRcjF5D9iVHiy/qHzBDOZ0aJzfvfscJ0/H65hAUisYtRovnJdxa4
 ql9zVjJ1MXJwsAloSlyYXArSICJgJLH/00lWkBpmgSmMEucuHmYCSQgLWEoc2weygpODRUBV
 4k7jYVaQXl4BC4lVN/UhlslLzLz0nR0kzAlUfmuvGkiYV0BQ4uTMJ2BXMwOVNG+dDXaohMBf
 dokDd/4zQfS6SLR1rYCyhSVeHd/CDmFLSXx+t5cNwi6W+HXnKFRzB6PE9YaZLBAJe4mLe/6C
 /cIM9Mv6XfoQy/gken8/AQtLCPBKdLQJQVQrStyb9BQaPuISD2csgbI9JE5cXMwICZ4eRonj
 az6zTWCUn4Xkh1lIfpiFsG0BI/MqRsnUguLc9NRi0wLjvNRyveLE3OLSvHS95PzcTYzghKPl
 vYPx0YMPeocYmTgYDzFKcDArifCKv7RNEOJNSaysSi3Kjy8qzUktPsQozcGiJM67w+BBvJBA
 emJJanZqakFqEUyWiYNTqoHJMHvD5W9y736n/Jt4b4lJRET0x1NqhQu7LnSvffvYZZY/ewtL
 7z7Vz3Un2+0nuXBvNRIOKfL3ffveWUHbbIV5w7r6OP+FP2byX1tupxAt+au9ZP3ctZtzlZRP
 3a9redjSLylm+6rJ85D21Ca7E46/rv2PYWVi2p/WN2/phqR5Ji5lu6uanrb0yqyeHfCzKsS8
 g0eu8BjXnQXbDs/XMb3hd//whvUr1gb8OxNw8k1UagzjAh/B2Kfy9/omv/7NHTVNmc+8ZbIf
 20pb3e8Flw/qVhle8DN20nF0XWQkJuHQ0L/ukZ33oYWcs9e0T50as/9wIZP+melqX3rPxp90
 5q4WZ3S3yQzuqjHSfe/KfVqJpTgj0VCLuag4EQCgSOA1pwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnG5ssl2Cwf2VZhZNE/4yW6y+289m
 sXL1USaLd63nWCwe3/nMbnH0/1s2i0mHrjFazF/2lN3iypRFzA6cHpfPlnpsWtXJ5rF5Sb3H
 7psNbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVsb7zH2vBYa6KJwtOMzYwfuLoYuTkkBAw
 kfj9cglLFyMXh5DADkaJhff+skMkxCWar/2AsoUlVv57zg5R9JFRYsfOTsYuRg4ONgFNiQuT
 S0FqRATMJJYeXsMCYjMLzGCU2LAsHcQWFrCUOLbvITOIzSKgKnGn8TArSCuvgIXEqpv6EOPl
 JWZe+s4OEuYEKr+1Vw0kLARUMXndf1YQm1dAUOLkzCdQ0+UlmrfOZp7AKDALSWoWktQCRqZV
 jJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBoa6ltYNxz6oPeocYmTgYDzFKcDArifCK
 v7RNEOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFJt5eN
 0dZFbKfFjmu5H/Zt/Xdz/Y7ul2ZLXvOWX7rYqdPlt0jSVEWmfcuasldPTA/4syQW3r3XaSX/
 1ut6LpeVZhjr96jg+V0Ny56H3ViQJvHWoM2f/eSOks1bGzcyB6So/nHuTP9dq5on0Pl0ywzW
 F927DFPCl1o7Z7+POpl3z7vj8DPecwLb7Pc4GHhEVa2V9z1x+VvpqvMvpC4dlq9fsuPV++l6
 6QVXK7weqz/OlzGVTV0ZUu1cXbPw9k7zhW0bRbl55r055/zzW+eilZ8/JEYb6hhur67Znvpw
 YiPnfaWoqD9bmd69mfJ9SnClzWZvm7K4TGWjaq94Ja7THtMWHkpfedGwxtV5c+mPuU1KLMUZ
 iYZazEXFiQDdz4Jc5AIAAA==
X-CMS-MailID: 20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_161024_538600_B6CB7FE9 
X-CRM114-Status: GOOD (  12.02  )
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

This is a prep patch, so that ioctl completion can be decoupled from
submission.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..15c9490b593f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1126,7 +1126,8 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	}
 }
 
-void nvme_execute_passthru_rq(struct request *rq)
+void nvme_execute_passthru_rq_common(struct request *rq,
+			rq_end_io_fn *done)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
@@ -1135,9 +1136,17 @@ void nvme_execute_passthru_rq(struct request *rq)
 	u32 effects;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	blk_execute_rq(disk, rq, 0);
+	if (!done)
+		blk_execute_rq(disk, rq, 0);
+	else
+		blk_execute_rq_nowait(disk, rq, 0, done);
 	nvme_passthru_end(ctrl, effects);
 }
+
+void nvme_execute_passthru_rq(struct request *rq)
+{
+	return nvme_execute_passthru_rq_common(rq, NULL);
+}
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
 static int nvme_submit_user_cmd(struct request_queue *q,
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
