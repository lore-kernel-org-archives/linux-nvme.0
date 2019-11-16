Return-Path: <SRS0=76sU=ZI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD1BC432C3
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2019 15:42:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D573620803
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2019 15:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VnXwWvhV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHe3//EQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D573620803
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gqr1oWG1e210vPsob4C6Z1NSEZJ4UQ3cVIlAtBZw9fA=; b=VnXwWvhVQu1EEp
	SqowDogcfdNaMODzL1xNWW/VmAys4mBZbOLMvDgfFDOAHqwundK16XM2IpPkTi/3NLzezpJXMatMV
	uzrdCSbssRtIJH52cM+hHwe62gcsLdZM5amHbi5rC71Ty+Gxwl+mUUWW+X6k77tEfGeuemVGxxA9T
	HMEWbaoooP7t+6sSj8+0qt4ivRM4yNhSMh3/TKTwnm8mkh1y2tTvpt4eIFfHP/clVSKr1FXQOvXB3
	x+jckL7LS7PmvER9zpRJbKApniWXED19miLldwgGlS7VuEIePXE8eQwZP1QyQHJW625oECpK4rGud
	srxbIFrTcVNbFDpj5kvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iW0DD-0007VQ-Te; Sat, 16 Nov 2019 15:42:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iW0DB-0007UF-Om
 for linux-nvme@lists.infradead.org; Sat, 16 Nov 2019 15:42:11 +0000
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 29F89207FA;
 Sat, 16 Nov 2019 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573918929;
 bh=bPTlPH2rYRCi56/K0e6IaVB93IuksRjPjxYZGiewy/k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RHe3//EQ/1SNGxor22kzmam5vcOebnSrY53VSA3jDRG98+BywzvSxuexnX2ehur45
 2FGbvA493+wfDfcxBmP8jbjqWPrxN8n4EKZa1M8iSGbjtbLl4/qptficvKyzAkdL5P
 nz+z0hJtmJBogyWb1sVtBG+kkILnkkotpOS/0BFY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 056/237] nvmet: avoid integer overflow in the
 discard code
Date: Sat, 16 Nov 2019 10:38:11 -0500
Message-Id: <20191116154113.7417-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191116_074209_823225_A30AF6B0 
X-CRM114-Status: GOOD (  12.27  )
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 8eacd1bd21d6913ec27e6120e9a8733352e191d3 ]

Although I'm not sure whether it is a good idea to support large discard
commands, I think integer overflow for discard ranges larger than 4 GB
should be avoided. This patch avoids that smatch reports the following:

drivers/nvme/target/io-cmd-file.c:249:1 nvmet_file_execute_discard() warn: should '((range.nlb)) << req->ns->blksize_shift' be a 64 bit type?

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 81a9dc5290a87..39d972e2595f0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -246,7 +246,8 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 
 		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
-		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
+		len = le32_to_cpu(range.nlb);
+		len <<= req->ns->blksize_shift;
 		if (offset + len > req->ns->size) {
 			ret = NVME_SC_LBA_RANGE | NVME_SC_DNR;
 			break;
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
