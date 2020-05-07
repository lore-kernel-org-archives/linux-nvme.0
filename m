Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA8C38A2A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 19:00:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BC82083B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 19:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qqzZ8QDN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="njVHXHug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BC82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yG8DcMBUj8z7ZjoJCZZMSlakIUJ+a+XvPUbaojdXYxY=; b=qqzZ8QDNJzVmOw
	Ty3ol5WiXIEZn781QURWTQKZFQIW7w8Cln0EWQZd++KBTRv+EDr2snBEbV9Gbo+7oZSu4LvqGXzt3
	89AAjvMu+C7h2Um0513DAA5JY5MpfuhWQaHTY652tA1gujn1uT9MR+XfvsOyJGraM1Ts335IYjPnM
	TxHX+IqBvFC7FeFtz7335s2CunB4t3zW14+I6C4NXu+0TSbedPhHDNkGT6ACMqvR25qB/+FzJqWiO
	W4aUu0jXB836Pnl3SEbqCi3DWef3MfypEM/VX6VwSei35XSFbJnYCToQ1F1EmvQLMwMrah50fHaZ3
	TMrMRpjtN9mQxOLYwcxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWllM-0006Y3-Na; Thu, 07 May 2020 19:00:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWll2-0006KT-HG
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 19:00:36 +0000
Received: from embeddedor (unknown [189.207.59.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B29A82083B;
 Thu,  7 May 2020 19:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588878032;
 bh=vqJy/QdKw35OLtNYsWencYwBw6xfJHLkvdoR1KZvG2Y=;
 h=Date:From:To:Cc:Subject:From;
 b=njVHXHugzubO28Cq9yVWXC+p3zNNWfcdhlqsxU7Kj7RN4RhwpOIzMoj0+F3acc6Wz
 bvZ5oSljRbdqy/yQvoaOnmcrVD0qgAvHLrG4UX89b0u1NvCYAfimzyOXPeAWS3VRU4
 Ja5/DwrnsboW5B9geywoVFa4H0dM9WFtAckEkAY0=
Date: Thu, 7 May 2020 14:04:58 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: James Smart <james.smart@broadcom.com>
Subject: [PATCH] nvme-fc: Replace zero-length array with flexible-array
Message-ID: <20200507190458.GA15557@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_120032_591687_18CFAF45 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvme/host/fc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7dfc4a2ecf1e..887537d1243f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -96,7 +96,7 @@ struct nvme_fc_fcp_op {
 struct nvme_fcp_op_w_sgl {
 	struct nvme_fc_fcp_op	op;
 	struct scatterlist	sgl[NVME_INLINE_SG_CNT];
-	uint8_t			priv[0];
+	uint8_t			priv[];
 };
 
 struct nvme_fc_lport {


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
