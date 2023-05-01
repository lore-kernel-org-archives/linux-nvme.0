Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200D2C77B61
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHhwOOQJhYG1zhAhvZ6TNtxRY+Z65siR69ZTkVbLHsk=; b=H5JnUzbuyzEs9BxFRovkNnup/+
	REf6fekus120aT+Mqn2MTTh4ojKGBzaPzzsudDS/nrH6PQ8JOJPaDiiIo4d5W3AzkfUqUQ9zX3y0y
	2vyJF3o1dNWTtQSBPw6SVlndxiCr1bZz5FkkHn9W6644BO9+6/fOkR3tQzaW5U0vQ92cLA2X2FU6S
	XlbalGAo+d6JxSzMfyOMECa07o2MVheljxwkUUJVv6lSdz17lB3q69Me6TRyKYwLo/vUtAuAb6dBC
	iLRDR0CHqkKBb9YRQfqavO1xZ/79NJzch6XpMvNHFNjVKz+gBfnzHyUjUpAgr4lKumfHWLOwHkSk0
	Co2tCuvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptSpv-00G0XK-25;
	Mon, 01 May 2023 12:40:59 +0000
Received: from smtp-25.smtpout.orange.fr ([80.12.242.25] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptSpo-00G0Rm-0D
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 12:40:56 +0000
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id tSpZpM6hwpwRItSplpInbJ; Mon, 01 May 2023 14:40:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1682944849;
	bh=EHhwOOQJhYG1zhAhvZ6TNtxRY+Z65siR69ZTkVbLHsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8VtBR0KIkrJ450/GNdjOJGydw0hy4+xO//IkaI1yGpXbnf3Tovs0FaycrPclQVBI
	 Mcj/QX4e2oQwrnLtNZmgRtP2IfUpq4SZukQvd1zR8+uqWaRmy9ktr/n02SaBnf9VIO
	 WAqCN8Kpm97D/BtiSkfSdDbnwb/6GwquDKI7oREPAUSFkSKUT7VEcom3dB2LMvTl3K
	 R2xRIO+dBG8xlk6G/KW1YoBKABK2sQBVxl/xJZPdEh1allWpmA4y7OglEMcGP0bKjw
	 Cgi027/7+vx6zKr9fR/yhImPxy4nbRJ7JoXMaLpNtMQtDa8rOTho5LFg+CdDLk9bqH
	 EbpX3PWvO7PQQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 May 2023 14:40:49 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/5] nvmet: Reorder fields in 'struct nvme_dhchap_queue_context'
Date: Mon,  1 May 2023 14:40:28 +0200
Message-Id: <829091a6a1d5e20112f8e6b0b3d44b384dc7ae98.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_054052_238550_3F1D4608 
X-CRM114-Status: GOOD (  12.41  )
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

Group some variables based on their sizes to reduce holes.
On x86_64, this shrinks the size of 'struct nvme_dhchap_queue_context' from
416 to 400 bytes.

This structure is kvcalloc()'ed in nvme_auth_init_ctrl(), so it is likely
that the allocation can be relatively big. Saving 16 bytes per structure
may might a slight difference.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct nvme_dhchap_queue_context {
	struct list_head           entry;                /*     0    16 */
	struct work_struct         auth_work;            /*    16    80 */
	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
	struct nvme_ctrl *         ctrl;                 /*    96     8 */
	struct crypto_shash *      shash_tfm;            /*   104     8 */
	struct crypto_kpp *        dh_tfm;               /*   112     8 */
	void *                     buf;                  /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	int                        qid;                  /*   128     4 */
	int                        error;                /*   132     4 */
	u32                        s1;                   /*   136     4 */
	u32                        s2;                   /*   140     4 */
	u16                        transaction;          /*   144     2 */
	u8                         status;               /*   146     1 */
	u8                         hash_id;              /*   147     1 */

	/* XXX 4 bytes hole, try to pack */

	size_t                     hash_len;             /*   152     8 */
	u8                         dhgroup_id;           /*   160     1 */
	u8                         c1[64];               /*   161    64 */
	/* --- cacheline 3 boundary (192 bytes) was 33 bytes ago --- */
	u8                         c2[64];               /*   225    64 */
	/* --- cacheline 4 boundary (256 bytes) was 33 bytes ago --- */
	u8                         response[64];         /*   289    64 */

	/* XXX 7 bytes hole, try to pack */

	/* --- cacheline 5 boundary (320 bytes) was 40 bytes ago --- */
	u8 *                       host_response;        /*   360     8 */
	u8 *                       ctrl_key;             /*   368     8 */
	int                        ctrl_key_len;         /*   376     4 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 6 boundary (384 bytes) --- */
	u8 *                       host_key;             /*   384     8 */
	int                        host_key_len;         /*   392     4 */

	/* XXX 4 bytes hole, try to pack */

	u8 *                       sess_key;             /*   400     8 */
	int                        sess_key_len;         /*   408     4 */

	/* size: 416, cachelines: 7, members: 25 */
	/* sum members: 393, holes: 4, sum holes: 19 */
	/* padding: 4 */
	/* last cacheline: 32 bytes */
};


After:
=====
struct nvme_dhchap_queue_context {
	struct list_head           entry;                /*     0    16 */
	struct work_struct         auth_work;            /*    16    80 */
	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
	struct nvme_ctrl *         ctrl;                 /*    96     8 */
	struct crypto_shash *      shash_tfm;            /*   104     8 */
	struct crypto_kpp *        dh_tfm;               /*   112     8 */
	void *                     buf;                  /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	int                        qid;                  /*   128     4 */
	int                        error;                /*   132     4 */
	u32                        s1;                   /*   136     4 */
	u32                        s2;                   /*   140     4 */
	u16                        transaction;          /*   144     2 */
	u8                         status;               /*   146     1 */
	u8                         dhgroup_id;           /*   147     1 */
	u8                         hash_id;              /*   148     1 */

	/* XXX 3 bytes hole, try to pack */

	size_t                     hash_len;             /*   152     8 */
	u8                         c1[64];               /*   160    64 */
	/* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
	u8                         c2[64];               /*   224    64 */
	/* --- cacheline 4 boundary (256 bytes) was 32 bytes ago --- */
	u8                         response[64];         /*   288    64 */
	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
	u8 *                       host_response;        /*   352     8 */
	u8 *                       ctrl_key;             /*   360     8 */
	u8 *                       host_key;             /*   368     8 */
	u8 *                       sess_key;             /*   376     8 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	int                        ctrl_key_len;         /*   384     4 */
	int                        host_key_len;         /*   388     4 */
	int                        sess_key_len;         /*   392     4 */

	/* size: 400, cachelines: 7, members: 25 */
	/* sum members: 393, holes: 1, sum holes: 3 */
	/* padding: 4 */
	/* last cacheline: 16 bytes */
};
---
 drivers/nvme/host/auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index ea16a0aba679..daf5d144a8ea 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -30,18 +30,18 @@ struct nvme_dhchap_queue_context {
 	u32 s2;
 	u16 transaction;
 	u8 status;
+	u8 dhgroup_id;
 	u8 hash_id;
 	size_t hash_len;
-	u8 dhgroup_id;
 	u8 c1[64];
 	u8 c2[64];
 	u8 response[64];
 	u8 *host_response;
 	u8 *ctrl_key;
-	int ctrl_key_len;
 	u8 *host_key;
-	int host_key_len;
 	u8 *sess_key;
+	int ctrl_key_len;
+	int host_key_len;
 	int sess_key_len;
 };
 
-- 
2.34.1


