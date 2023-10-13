Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7698AC41513
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjcvHnJiyzpcF2Qs6RaXGnQYr+vhPGf833ujIMcqIHw=; b=yvbX2V5yGNzSf9laGcYZfUEJvW
	qscIm8jtZIeC2pI0HP5eq+MPCef3QguwNXI/kAeG9diwWFDONkbw7r6v4/bCTYl3xTE+jsUebX7NB
	RMQjXTrMsTtI+TBQ/TnP19+l4lxxj7EK1KS3zEbJj2OlpCCwaCdVyMRhb2ErcjZr5QFvZsIvSq/e6
	1Hv5AOGGzrjLDw6qjeb2lIZR44ettJJ4RNcq3wG57kDDETChNUgZqQriFD8O7lt3JCp/LPzvRytqw
	s2LCwdxaAsYNt3A7NuJsqoQ8J8mfKVQzsCLrQT6owygqjAfwHtuPSEkTeelBCvy2/+DQVW9afH3FC
	y9TEopeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrOmV-004Dyu-2p;
	Fri, 13 Oct 2023 20:29:11 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrOmS-004Dx1-0y
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 20:29:09 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E754F240101
	for <linux-nvme@lists.infradead.org>; Fri, 13 Oct 2023 22:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697228946; bh=wCPxNhXED6Xa4hXVL029+O8olAaVDn+KVg7XUvMNVA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=r4Mv6xj6s4WvRdlyFusviQwZdz5Q3xiXOeWvD9414/2icW11p8V8DYOyW59t3B6EL
	 J0cnfnPl/Q60lYoa9rLu+ppf794woXsCn05OdtHiNvicY+nP6k6StA9Vcwjb8eYVCx
	 5K2r26N0WUQyYm2zlJb8nBhxxSowWwtSCxL8xF1YKVsxNw7yrFR0VYbE+tr7La/PfX
	 FYnVqjhPwZ141LYkpBQf/gPu6I+MtvbkkqP74o+V9aBoZuUlU2moVhMJvO3/74yDcu
	 GeD+lblR8rm041SqMMGUYrW/CAOgnfv2ZTFnMwyg94GmeMX+oLsZuqcGGYro7VU5LR
	 3WHPbBEtMbpDw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S6dQ93TzBz9rxM;
	Fri, 13 Oct 2023 22:29:05 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>,
	Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH 1/2] nvme-auth: use transformed key size to create resp
Date: Fri, 13 Oct 2023 20:28:26 +0000
Message-Id: <20231013202827.2262708-2-shiftee@posteo.net>
In-Reply-To: <20231013202827.2262708-1-shiftee@posteo.net>
References: <20231013202827.2262708-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_132908_487046_FB681E7B 
X-CRM114-Status: GOOD (  10.48  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This does not change current behaviour as the driver currently
verifies that the secret size is the same size as the length of
the transformation hash.

Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/host/auth.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..e7d478d17b06 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -418,6 +418,14 @@ static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
 	return size;
 }
 
+static int nvme_auth_dhchap_transformed_key_len(struct nvme_dhchap_key *key)
+{
+	if (key->hash)
+		return nvme_auth_hmac_hash_len(key->hash);
+
+	return key->len;
+}
+
 static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
@@ -442,7 +450,8 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			chap->host_response, ctrl->host_key->len);
+			chap->host_response,
+			nvme_auth_dhchap_transformed_key_len(ctrl->host_key));
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
-- 
2.39.2


