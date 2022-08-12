Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316B7C25B06
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 03:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZyczEM+yogtv1ZdiWTfza4Gc6NbUc3uJi5Ic4cWWdrg=; b=RZwIwiQFuo/ic38Nk1GcagQtwp
	VVioNL72poQgofLmgIdpMbOjiS5JAqJThMeD8mCITCgGIBE/QYDorEQUOWenuJZQ9XbutiZ9I+mA/
	enMciO85i0gX/vbWECScvXC40NsDzyJQM021t7AJ91akpz5owLiXnXUhuqjdy8KnwQkrsUtwgepXi
	yEQ54uYRXUJtjrNMLC05XMT7Unmz8bQJaVGKMNw12T8ZXcOgreIW/g3OkuHAsf2m0MH8fhxaSmkQ8
	EGsHVxg+md8Gv9dOGcWUst6qwWJtpSgqDAUV6EhSeLukdQIWaJ6FYRPWObyyzGPgoZACtQZ0vk4jY
	k/X8EwNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oML6q-00BseR-KS; Fri, 12 Aug 2022 03:13:16 +0000
Received: from out2.migadu.com ([2001:41d0:2:aacc::])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oML6i-00Br5e-J9
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 03:13:10 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1660273979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZyczEM+yogtv1ZdiWTfza4Gc6NbUc3uJi5Ic4cWWdrg=;
	b=T8H1sgNoM5QHKDPJOud2xDCQteDlJvM4WHdkVfRnshCEcCOpXAzazZP0nD9XZ1LzN8AFYR
	zN4HLkwZXubvWvV8UfDVIJ1bclMaPYbyCVHkd29t4Mi9lLkFeVqZIS+w9mRdaO3KsjBCmC
	X1lTmfQ3Z6JcV4TuL12vsEkGlsw6/jE=
From: Jackie Liu <liu.yun@linux.dev>
To: sagi@grimberg.me
Cc: hch@lst.de,
	hare@suse.de,
	linux-nvme@lists.infradead.org,
	kch@nvidia.com,
	liu.yun@linux.dev
Subject: [PATCH 1/2] nvmet-auth: clean up with done_kfree
Date: Fri, 12 Aug 2022 11:12:30 +0800
Message-Id: <20220812031231.3386953-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_201309_363236_EB1081DE 
X-CRM114-Status: UNSURE (   7.29  )
X-CRM114-Notice: Please train this message.
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

From: Jackie Liu <liuyun01@kylinos.cn>

Jump directly to done_kfree to release d, which is consistent with the
code style behind.

Reported-by: Genjian Zhang <zhanggenjian@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index c851814d6cb0..17c19614b929 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -229,10 +229,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	}
 
 	status = nvmet_copy_from_sgl(req, 0, d, tl);
-	if (status) {
-		kfree(d);
-		goto done;
-	}
+	if (status)
+		goto done_kfree;
 
 	data = d;
 	pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
-- 
2.25.1


