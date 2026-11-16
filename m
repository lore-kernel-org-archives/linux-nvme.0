Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CD606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EutYrlFY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqG0coew
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=60NXe0aph5ZMdSm2+R+aQQFvNAI/XZMFjJbvfurWO3U=; b=EutYrlFY1+KnPYNOgzd4VruNs2
	pwQARLFDeXsZniSmYI9GUS/YEfVb3rAeiIUat8/l/jEwW2LP/gqkP/qca72pHjU/+FkCLDtG9Yznd
	U2FF8bcViL+15yu8d3eAgtpiN7IwraPvxpPGHF2NrjJZGnyYzPx3MWqd6OqPz5B/Yf84Ou4ulcJ4U
	2ZJ25J7wJDWwYc3/jGwVOjZ/1nuhpEl4+DphfyY3KWrYNJg/C8rqCQW/bwOWRo2XES78mOdshrM5J
	OVgZjjkiSW3yfxpiZnqiRxodb7GsobnRFCFr3o2fuFU/2XXghyKbtdGx/jwCUKc+BLv91vPbIgaZd
	rBu4pp7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSmQ2-00000000w8R-0l1l;
	Mon, 16 Nov 2026 02:26:06 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSmPz-00000000w7U-0a6i
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 02:26:04 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-53669f7b518so41896931cf.2
        for <linux-nvme@lists.infradead.org>; Sun, 15 Nov 2026 18:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794795962; x=1795400762; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=60NXe0aph5ZMdSm2+R+aQQFvNAI/XZMFjJbvfurWO3U=;
        b=fqG0coewA9++YDuIoqIPwXjW4VMKdkzbF5RFHT+3MfwBSJv7UPafq5hYTZTIiTgUN0
         C2Yk4d5aQjMVczGpPgPMGdbwT0+glAbQNxnQv/Yc0Bqx3wUdNobTj//cFpeobbmvM4ZL
         pzW3i3W+xSa2crjqzIIu1SEQgRpvDoshR6d9w4Y7RobbxbEzfywvxoIYXTddCFiX7f4J
         mYC3aoFgkTZwaCPpKotX/If9aMEK+KttBPpbSQzj8E15mZJMgmuGNIgIlFBBPoy9027Y
         sblWD2LK3OdZA6lwdbDvSDKbDJDuF3aAlRjGKsHZMZtRUknJ1tmKvocoeHsLINUBir9o
         582w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794795962; x=1795400762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60NXe0aph5ZMdSm2+R+aQQFvNAI/XZMFjJbvfurWO3U=;
        b=Wy0V2neFqO+HUGaQyZYtI3nNc/BYSwdunpX2z6J3LyRi8JDIbEfh4MEDrontv67vXX
         IiVwJMzYj2/hCB//jSzxBn9GU03pgoiu62Rb8frFTx6xsNZNVwdpa083qd5VwIOsx1kw
         5XdmYjjLpTwM/wHaDevMT06OYPnbjp7LDOZXdHArBuB4nv694Ucncolg18bB5BNebIRO
         vJlobI42STvDuYLoAs/IZDAiFRC0klmZ2/3nmB82tcdStLY/Q1QP8ItMBb4DsqUxObTc
         eQbm/D6tcb0I3O6q6Hjz3iHIpRA3Uxlg1eR+ooqkuFoaYm9lDwpoweGuHCnhQM0CgQRe
         CTyA==
X-Forwarded-Encrypted: i=1; AL+hErGjwzS6YSiFsxI9VzHJgSBc1ONW0l3aTcGE5ieiodL13+9D8JnI9pXdRK1nAz5tzh4aEXYpId8H50qg@lists.infradead.org
X-Gm-Message-State: APuU4Z/SreRwjYIBUCwpV8NCoergRo/FbdTLGkq+Yw8lIGIjx6+pcCwv
	wBQqBx71r/j9ZdCKfopIFH2XG9mj4BtZ+6w6xHbi89CXJkGlXQZvPS5RcW5cBICv
X-Gm-Gg: AYBFou3NHltP7kgOvIpk7CQ1hb9nNF2152KLTfGJ/ZaT4bBChVaGgC8UhfwuEIRycMe
	Uw37chbErV6caPvOjhVNTmIsOaZy309zwuGpeLMcGbHIE7zsdrP0vO1g2XiLLC3RkL2etqLGJ1P
	TQLhvAYuHE3coeSo5YwpJnX+GWDeezEXMEt7JULUws3453EYipPL30ppX8ttB4m4J5r+Sj/G8AI
	QjEfV3pX3x0/iU1S7QJXxF0CGKPYXHYDlhWTQVjN/ETxVgpQc00C8XVdXkJ71SfQj5U3P8s/aCl
	3RW+CzEodcjTAplCvfZ4YaR2X/DsfZfoxKZQlQAq3jSIFVdU01uoIPvmVlRGwRt0jPML+harJNe
	XE/8h6a35ALKX8pqMX7Hy/bo2Yg8pwqX31ma30VTrw1l9H/RQkgKEbBIsITh1PC93rOS9blxQQF
	JMuxIErSvKXb9MtLLE3vBrnFQ1D49bFOe4tzw4HuFhUs9BlMuP+qIZQaDwevZ3kyDZ52WZQYTqS
	IDyWVwfI+OxR6z8ZuUvyiur46N43bmTJimewkkYzI/qjp1iQzObhm54zTYhVLkP3lS+15Falu03
	uxGCOT6U2me01WykniUTfFuj3ZZ2MJ6qJ/s+8A5aEE8078BgAfKXCjWu6aarfzPZawxIEi17HUg
	=
X-Received: by 2002:a05:622a:5793:b0:54f:863d:92c7 with SMTP id d75a77b69052e-55ac786019emr156129861cf.41.1794795961766;
        Sun, 15 Nov 2026 18:26:01 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d34f869dfsm21962901cf.6.2026.11.15.18.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 18:26:01 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Stephen Bates <sbates@raithlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] nvmet: look up the P2P device under rcu_read_lock()
Date: Sun, 15 Nov 2026 21:25:58 -0500
Message-ID: <20261116022558.560013-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_182603_184634_CFA33C55 
X-CRM114-Status: GOOD (  11.41  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_req_find_p2p_dev() looks up ctrl->p2p_ns_map in the I/O path
without subsys->lock and outside an RCU read-side critical section.
nvmet_ns_disable() can meanwhile delete an entry from the same radix
tree, and radix_tree_delete() frees the nodes that become empty with
call_rcu(). With preemptible RCU, the grace period can end while the
lookup still walks such a node, and the lookup reads freed memory.

radix_tree_lookup() without the tree lock must be called under
rcu_read_lock(). Take it around the lookup.

Fixes: c6925093d0b2 ("nvmet: Optionally use PCI P2P memory")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig plus NVME_TARGET_RDMA,
PCI_P2PDMA and W=1.

 drivers/nvme/target/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e31d65228c11..1b34fc5549f6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1341,10 +1341,17 @@ static int nvmet_req_alloc_p2pmem_sgls(struct pci_dev *p2p_dev,
 
 static struct pci_dev *nvmet_req_find_p2p_dev(struct nvmet_req *req)
 {
+	struct pci_dev *p2p_dev;
+
 	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) ||
 	    !req->sq->ctrl || !req->sq->qid || !req->ns)
 		return NULL;
-	return radix_tree_lookup(&req->sq->ctrl->p2p_ns_map, req->ns->nsid);
+
+	rcu_read_lock();
+	p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map, req->ns->nsid);
+	rcu_read_unlock();
+
+	return p2p_dev;
 }
 
 int nvmet_req_alloc_sgls(struct nvmet_req *req)

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0


