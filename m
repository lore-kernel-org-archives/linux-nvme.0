Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BA3C3600D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W6Wnjgzz56HnBbkJ6SJPZSc5/41nMiz9G+GyxhD8CSQ=; b=TiBOzoi8AuZwvfQ0iVL3f+Qh8d
	kv+mFbPoCccrR3wkE7Kdi9tCjP9xrJD8CmKq9SFbEXrEsEEpek8xGsugXIBHva9kNaGFQLG5/fbBO
	qaaQjO8ZeqN09/NdMwaUxg0N0aI7rlEGRvp3xX5OisEUCQLWQgga/Hv7mvWvy0//L5M/l+aEIdszB
	WS3yadI7FnzTK93rBVGPE/QhU6XjjIa+IEntCkgRznglWRmMR7ZAKa7RApteVUHZStK8We/eph9e3
	pYh5Wj4ChvTQiZfAZ8f+WWad5ImaLjOv0ICYckg1v48n5v6H5Rb7Ia60fwAl/JA3+yvJqmJgigGY6
	cg1NcIAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twgbH-000000031ST-1hzN;
	Mon, 24 Mar 2025 12:08:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twgbE-000000031Qg-3rvN
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 12:08:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1EB155C5F17;
	Mon, 24 Mar 2025 12:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47B5C4CEE9;
	Mon, 24 Mar 2025 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742818091;
	bh=C2XCpY3/qQ09F5paYDzzuRlhy0cJivYvdQwEXeEVWOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZDChiOHZujBnlf+IRJC/ofdiGpttxnijSwB1RPzx+zHQZpYesLEjDKulJ8T1KFgTG
	 UEfeLq84e4CRqc8YbyflCsicnI47vkAMIx64RTJBNXBd5A8YhU/yr1fH4fv4FLSgzZ
	 M6sbYuHGOs1jT3X3MUEjrZJCjgdJsZ9whq9y4qTeVGnSIA2AkZUAHvBuzBunUXS/Rs
	 FY/7FLGY3cSTpo0gBSKQJOHQ+I27SGuG/5BjUxlAD+l59JWpJBf+EisrNMAsgcSlOA
	 U3uTA4S8/3lkXYy648PHp4u3bzemcFQVv7C7okcPL0szDRZz5TB2bzgjxultYKhB5J
	 w6z3zDmr4zFkA==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 24 Mar 2025 13:07:57 +0100
Subject: [PATCH RFC 2/3] nvme: store cqt value into nvme ctrl object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-tp4129-v1-2-95a747b4c33b@kernel.org>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
In-Reply-To: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_050813_024854_260C0C17 
X-CRM114-Status: UNSURE (   9.57  )
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

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40046770f1bf0b98261d8b80e21aa0cc04ebb7a0..135045528ea1c79eac0d6d47d5f7f05a7c98acc4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3380,6 +3380,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
+	ctrl->cqt = le16_to_cpu(id->cqt);
 
 	ctrl->cntrltype = id->cntrltype;
 	ctrl->dctype = id->dctype;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e950c3faa764514daf3808009e223..7563332b5b7b76fc6165ec8c6f2d144737d4fe85 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -344,6 +344,7 @@ struct nvme_ctrl {
 	u32 oaes;
 	u32 aen_result;
 	u32 ctratt;
+	u16 cqt;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;

-- 
2.48.1


