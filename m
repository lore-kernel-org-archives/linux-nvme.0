Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59F4C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uWyb1m5f2X+6JFDK/HL+2kWjKi4n1QTlW4WSNRqI008=; b=z7pkyt337M9DCwo43b6jSLRm0t
	BFcXNs1mgmcz0yYho/hEvfkzR5fy9GhI2VpiEzmSaDihfVPwVTRYMI4WUOCa/jC9PIqb6sY572VAr
	j1kJ/areK48iFU0kwNHRy1ZJmq7nrypVYkBDiuuriwqKjkjDvSO5MnDMig/hwgURxSyBAqtUa2mIP
	Wowh/SIaukXrQUHi0r0o/8++0eA8hP4K6n8pNYMd6qxJw7hCBZDV+4RQhwKRvSu543kJ37EEuWUb4
	GctpGRZWiH8nNuZ8JiGY6pnBp7+Y59r8Myt8ib6jTPNg302p1tzlM+SxTuV1CZY/CLd0B5zPZuN5/
	TOk1+Cuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps7az-007MjI-27;
	Thu, 27 Apr 2023 19:48:01 +0000
Received: from smtp-30.smtpout.orange.fr ([80.12.242.30] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps7aw-007Mi0-1p
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 19:48:00 +0000
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id s7akpPtNdcXjrs7akpwwwP; Thu, 27 Apr 2023 21:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1682624869;
	bh=uWyb1m5f2X+6JFDK/HL+2kWjKi4n1QTlW4WSNRqI008=;
	h=From:To:Cc:Subject:Date;
	b=qmgSftFaXDoIy7rJcvHk/NEwLPV7x7AwfqnZ4JDXCWvDFcI22zViC8G4u9voe2XMC
	 DmrhpMpkwIMvZcqbj+VAdoGWSgG13yFpXKrVrIS14WHb2441bwb02mOodFEqX8cGWc
	 TOtKBD3dzDN+X376TuGZhEV4bZCpkXruag3avFeyR4gOkQO2xfv1+xlFePN6HyKJwU
	 g5FGI5/rFQC7aNnZFU+LUaG8jp21KDjWm4HlxaBemF1f/hndmMLRkQoX/kxwqUK+IF
	 FhBLn9/Ahkn/0NAVTUeKRoaa2jCBbgRrPnA+6nIM4VZ8IuepiSTOjO617jyHPvPSGU
	 kTgZrEc9glp7Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 27 Apr 2023 21:47:49 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Date: Thu, 27 Apr 2023 21:47:45 +0200
Message-Id: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_124758_743576_97EAE93F 
X-CRM114-Status: GOOD (  12.39  )
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
On x86_64, this shrinks the size of 'struct nvmet_ns' from 520 to 512
bytes.

When such a structure is allocated in nvmet_ns_alloc(), because of the way
memory allocation works, when 520 bytes were requested, 1024 bytes were
allocated.

So, on x86_64, this change saves 512 bytes per allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
More aggressive grouping could be done to be more future proof, but the
way the struct nvmet_ns is written suggest that some fields should be
kept together. So keep grouping as-is.


Using pahole

Before:
======
struct nvmet_ns {
	struct percpu_ref          ref;                  /*     0    16 */
	struct block_device *      bdev;                 /*    16     8 */
	struct file *              file;                 /*    24     8 */
	bool                       readonly;             /*    32     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        nsid;                 /*    36     4 */
	u32                        blksize_shift;        /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	loff_t                     size;                 /*    48     8 */
	u8                         nguid[16];            /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	uuid_t                     uuid;                 /*    72    16 */
	u32                        anagrpid;             /*    88     4 */
	bool                       buffered_io;          /*    92     1 */
	bool                       enabled;              /*    93     1 */

	/* XXX 2 bytes hole, try to pack */

	struct nvmet_subsys *      subsys;               /*    96     8 */
	const char  *              device_path;          /*   104     8 */
	struct config_group        device_group;         /*   112   136 */
	/* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
	struct config_group        group;                /*   248   136 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	struct completion          disable_done;         /*   384    96 */
	/* --- cacheline 7 boundary (448 bytes) was 32 bytes ago --- */
	mempool_t *                bvec_pool;            /*   480     8 */
	int                        use_p2pmem;           /*   488     4 */

	/* XXX 4 bytes hole, try to pack */

	struct pci_dev *           p2p_dev;              /*   496     8 */
	int                        pi_type;              /*   504     4 */
	int                        metadata_size;        /*   508     4 */
	/* --- cacheline 8 boundary (512 bytes) --- */
	u8                         csi;                  /*   512     1 */

	/* size: 520, cachelines: 9, members: 23 */
	/* sum members: 500, holes: 4, sum holes: 13 */
	/* padding: 7 */
	/* last cacheline: 8 bytes */
};

After:
=====
struct nvmet_ns {
	struct percpu_ref          ref;                  /*     0    16 */
	struct block_device *      bdev;                 /*    16     8 */
	struct file *              file;                 /*    24     8 */
	bool                       readonly;             /*    32     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        nsid;                 /*    36     4 */
	u32                        blksize_shift;        /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	loff_t                     size;                 /*    48     8 */
	u8                         nguid[16];            /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	uuid_t                     uuid;                 /*    72    16 */
	u32                        anagrpid;             /*    88     4 */
	bool                       buffered_io;          /*    92     1 */
	bool                       enabled;              /*    93     1 */

	/* XXX 2 bytes hole, try to pack */

	struct nvmet_subsys *      subsys;               /*    96     8 */
	const char  *              device_path;          /*   104     8 */
	struct config_group        device_group;         /*   112   136 */
	/* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
	struct config_group        group;                /*   248   136 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	struct completion          disable_done;         /*   384    96 */
	/* --- cacheline 7 boundary (448 bytes) was 32 bytes ago --- */
	mempool_t *                bvec_pool;            /*   480     8 */
	struct pci_dev *           p2p_dev;              /*   488     8 */
	int                        use_p2pmem;           /*   496     4 */
	int                        pi_type;              /*   500     4 */
	int                        metadata_size;        /*   504     4 */
	u8                         csi;                  /*   508     1 */

	/* size: 512, cachelines: 8, members: 23 */
	/* sum members: 500, holes: 3, sum holes: 9 */
	/* padding: 3 */
};
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dc60a22646f7..c50146085fb5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -79,8 +79,8 @@ struct nvmet_ns {
 	struct completion	disable_done;
 	mempool_t		*bvec_pool;
 
-	int			use_p2pmem;
 	struct pci_dev		*p2p_dev;
+	int			use_p2pmem;
 	int			pi_type;
 	int			metadata_size;
 	u8			csi;
-- 
2.34.1


