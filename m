Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF23C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C43rYffzeLeuYm1ltXsP0tciLDt8iNhANcYULlPeETQ=; b=OOR7W3MEDR1ltsRuvsn81WC/Oh
	QTC1ZQ4+x4l4VPbz5AHUWFpfMquHaYig/sDA9PPX/NO3BIHCOoTYnRPDbU4NEKeZNLSwccJ39g8v3
	psJXLHphsyuSqRCxxbm5g7Hy90ccEiSQe0z1O+hBetz4We+wMuQhSSMwQXGHmFVtu9eSLF02JpbNW
	+AfchW76GCrxcJM1wkGguY/osWFT/Zfi3HoOcrq9w0vIRpmhrpAxp+uBlQQicee/j8Fapdg+WvnST
	u5Kd1bnxXUPsuzVW6Zdyw6TXbTGzpFElJW/2ORzWAA+Nhy00E6ngiiL9pg9gz4PuR5q8vJNKC+4Qe
	s7Sq87eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptSpu-00G0We-2Y;
	Mon, 01 May 2023 12:40:58 +0000
Received: from smtp-26.smtpout.orange.fr ([80.12.242.26] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptSpo-00G0RX-0e
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 12:40:56 +0000
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id tSpZpM6hwpwRItSpkpInb8; Mon, 01 May 2023 14:40:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1682944848;
	bh=C43rYffzeLeuYm1ltXsP0tciLDt8iNhANcYULlPeETQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HQrssG6wByiAUvHE7mEaJaHjVvUhQyZjXSRSr4ruDx1SRpgEeS8XnMp4o3mQtwDFB
	 KBfkH5y4ndSsmdjLjCbZsmYtbNSo92JROIcT3t1JDN/lzbvQC8E5vKYIDcVFWWY8Iw
	 PoVzohoIiYtWqWty3vNTklmwKjjQ8az2XcWOko1YmtnGhnm1DK9MpkZNY03oeSOcxw
	 EXEDzNN6NLRG1TPmP7dgPyi+IepdqHula80oVmG46HUajJ9HxmWhicjgBE84/UfgI0
	 87Lp0fqqmz1Jg+vL1H3Ro9U+9Oxr/51Xi1nBJu0mDvC4fT3RnDIDETcmx9R+i+PoK6
	 IWRKvy1z4HYzw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 May 2023 14:40:48 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/5] nvmet: Reorder fields in 'struct nvmf_ctrl_options'
Date: Mon,  1 May 2023 14:40:27 +0200
Message-Id: <78d06714ee7db7d977c390514b3bcfc71a07916f.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_054052_378167_486F49AE 
X-CRM114-Status: GOOD (  14.68  )
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
On x86_64, this shrinks the size of 'struct nvmf_ctrl_options' from 136 to
128 bytes.

When such a structure is allocated in nvmf_create_ctrl(), because of the
way memory allocation works, when 136 bytes were requested, 192 bytes were
allocated.

So this saves 64 bytes per allocation, 1 cache line to hold the whole
structure and a few cycles when zeroing the memory in nvmf_create_ctrl().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct nvmf_ctrl_options {
	unsigned int               mask;                 /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     transport;            /*     8     8 */
	char *                     subsysnqn;            /*    16     8 */
	char *                     traddr;               /*    24     8 */
	char *                     trsvcid;              /*    32     8 */
	char *                     host_traddr;          /*    40     8 */
	char *                     host_iface;           /*    48     8 */
	size_t                     queue_size;           /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               nr_io_queues;         /*    64     4 */
	unsigned int               reconnect_delay;      /*    68     4 */
	bool                       discovery_nqn;        /*    72     1 */
	bool                       duplicate_connect;    /*    73     1 */

	/* XXX 2 bytes hole, try to pack */

	unsigned int               kato;                 /*    76     4 */
	struct nvmf_host *         host;                 /*    80     8 */
	int                        max_reconnects;       /*    88     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     dhchap_secret;        /*    96     8 */
	char *                     dhchap_ctrl_secret;   /*   104     8 */
	bool                       disable_sqflow;       /*   112     1 */
	bool                       hdr_digest;           /*   113     1 */
	bool                       data_digest;          /*   114     1 */

	/* XXX 1 byte hole, try to pack */

	unsigned int               nr_write_queues;      /*   116     4 */
	unsigned int               nr_poll_queues;       /*   120     4 */
	int                        tos;                  /*   124     4 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	int                        fast_io_fail_tmo;     /*   128     4 */

	/* size: 136, cachelines: 3, members: 24 */
	/* sum members: 121, holes: 4, sum holes: 11 */
	/* padding: 4 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct nvmf_ctrl_options {
	unsigned int               mask;                 /*     0     4 */
	int                        max_reconnects;       /*     4     4 */
	char *                     transport;            /*     8     8 */
	char *                     subsysnqn;            /*    16     8 */
	char *                     traddr;               /*    24     8 */
	char *                     trsvcid;              /*    32     8 */
	char *                     host_traddr;          /*    40     8 */
	char *                     host_iface;           /*    48     8 */
	size_t                     queue_size;           /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               nr_io_queues;         /*    64     4 */
	unsigned int               reconnect_delay;      /*    68     4 */
	bool                       discovery_nqn;        /*    72     1 */
	bool                       duplicate_connect;    /*    73     1 */

	/* XXX 2 bytes hole, try to pack */

	unsigned int               kato;                 /*    76     4 */
	struct nvmf_host *         host;                 /*    80     8 */
	char *                     dhchap_secret;        /*    88     8 */
	char *                     dhchap_ctrl_secret;   /*    96     8 */
	bool                       disable_sqflow;       /*   104     1 */
	bool                       hdr_digest;           /*   105     1 */
	bool                       data_digest;          /*   106     1 */

	/* XXX 1 byte hole, try to pack */

	unsigned int               nr_write_queues;      /*   108     4 */
	unsigned int               nr_poll_queues;       /*   112     4 */
	int                        tos;                  /*   116     4 */
	int                        fast_io_fail_tmo;     /*   120     4 */

	/* size: 128, cachelines: 2, members: 24 */
	/* sum members: 121, holes: 2, sum holes: 3 */
	/* padding: 4 */
};
---
 drivers/nvme/host/fabrics.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..1bc57fb75825 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -77,6 +77,9 @@ enum {
  *			      with the parsing opts enum.
  * @mask:	Used by the fabrics library to parse through sysfs options
  *		on adding a NVMe controller.
+ * @max_reconnects: maximum number of allowed reconnect attempts before removing
+ *		the controller, (-1) means reconnect forever, zero means remove
+ *		immediately;
  * @transport:	Holds the fabric transport "technology name" (for a lack of
  *		better description) that will be used by an NVMe controller
  *		being added.
@@ -96,9 +99,6 @@ enum {
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
  * @kato:	Keep-alive timeout.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
- * @max_reconnects: maximum number of allowed reconnect attempts before removing
- *              the controller, (-1) means reconnect forever, zero means remove
- *              immediately;
  * @dhchap_secret: DH-HMAC-CHAP secret
  * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
  *              authentication
@@ -112,6 +112,7 @@ enum {
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
+	int			max_reconnects;
 	char			*transport;
 	char			*subsysnqn;
 	char			*traddr;
@@ -125,7 +126,6 @@ struct nvmf_ctrl_options {
 	bool			duplicate_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
-	int			max_reconnects;
 	char			*dhchap_secret;
 	char			*dhchap_ctrl_secret;
 	bool			disable_sqflow;
-- 
2.34.1


