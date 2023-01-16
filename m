Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDFBC54EBE
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jan 2023 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T0M3LK5Cnd8R5mzWxL1YZuDFb7B0unu8t51pCt7d2eg=; b=iJlrqsOyvq2pQVdziOyK5IaQuu
	RE5knO4ZXMPsKsSUPCxm8tMg586ZxZ62NQTJB6x6xNQLqSL8i4s6ZBlogwuxVuknLylH4i4Y/gY7+
	Ywr08SeQao/4YAuBkDALgDPvmQdwFofsJc/JwcM1qRlPLJEPwyX9CiMCnYFcTDaCjOlDXpTIHlHj/
	mDu+c8ILwEpIbSXsODOMbywPlYABfUWwZJKS5KV5xZvHUI0kwRYUAgsEr4xclWpsx9XWk4949e745
	Z3r6/pBdMQDj/qTXLDbOlaLjpQausYXgJT2MhtVeOkmbrl7/U5aVlUfFmhD6nQg+I8/0+9DAC4uPt
	r5W0Xq9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPC1-00AHFj-H2; Mon, 16 Jan 2023 13:06:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPBj-00AH80-3m
	for linux-nvme@lists.infradead.org; Mon, 16 Jan 2023 13:06:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 776F660F8C;
	Mon, 16 Jan 2023 13:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDE9C433EF;
	Mon, 16 Jan 2023 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673874369;
	bh=3vqVXUNkAHRx8zvBd2AMUzlpHePNDOP0eQM8jTGqV00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+Ku8TJauHSmodpnxMWblBL/kJGeyDexnWB+oiYm9dRCuEjlso7zxFTrRg0d6jTQg
	 rmfHIM76X4oKr/6gENePgPcHXo05aDmeH1eVo0lGnSCqZ7iqNotTQqd9WjtTSmAWGI
	 baXQE1khBkW58+c72IQllvg0MD1qZBh4p/kFjO//+T53eeao6z7Bg/lLG0nYMCbXDh
	 EETstXcwgprT46aNeJODiKtP5G2c1HNF/gH+Q9yQXur2G56UPf/CnKa7ef1Bwvq0Xh
	 wC9F3wXlGdAAvaLdySmmiFlfOy1fBeELz6QXrn6xhWmMMtcfl0YP5dzFkoPmJYBM5Z
	 bMuaTEw7Cm0og==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Israel Rukshin <israelr@nvidia.com>,
	Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH mlx5-next 01/13] net/mlx5: Introduce crypto IFC bits and structures
Date: Mon, 16 Jan 2023 15:05:48 +0200
Message-Id: <92da0db17a6106230c9a1938bc43071c119b7e7f.1673873422.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673873422.git.leon@kernel.org>
References: <cover.1673873422.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_050611_266204_3681FF53 
X-CRM114-Status: GOOD (  12.53  )
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

From: Israel Rukshin <israelr@nvidia.com>

Add crypto related IFC structs, layouts and enumerations.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 include/linux/mlx5/mlx5_ifc.h | 36 ++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 8bbf15433bb2..170fe1081820 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1331,6 +1331,29 @@ struct mlx5_ifc_macsec_cap_bits {
 	u8    reserved_at_40[0x7c0];
 };
 
+enum {
+	MLX5_CRYPTO_WRAPPED_IMPORT_METHOD_CAP_AES_XTS = 0x4,
+};
+
+struct mlx5_ifc_crypto_cap_bits {
+	u8         wrapped_crypto_operational[0x1];
+	u8         reserved_at_1[0x17];
+	u8         wrapped_import_method[0x8];
+
+	u8         reserved_at_20[0xb];
+	u8         log_max_num_deks[0x5];
+	u8         reserved_at_30[0x3];
+	u8         log_max_num_import_keks[0x5];
+	u8         reserved_at_38[0x3];
+	u8         log_max_num_creds[0x5];
+
+	u8         failed_selftests[0x10];
+	u8         num_nv_import_keks[0x8];
+	u8         num_nv_credentials[0x8];
+
+	u8         reserved_at_60[0x7a0];
+};
+
 enum {
 	MLX5_WQ_TYPE_LINKED_LIST  = 0x0,
 	MLX5_WQ_TYPE_CYCLIC       = 0x1,
@@ -1758,7 +1781,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_3e8[0x2];
 	u8         vhca_state[0x1];
 	u8         log_max_vlan_list[0x5];
-	u8         reserved_at_3f0[0x3];
+	u8         reserved_at_3f0[0x1];
+	u8         aes_xts_single_block_le_tweak[0x1];
+	u8         aes_xts_multi_block_be_tweak[0x1];
 	u8         log_max_current_mc_list[0x5];
 	u8         reserved_at_3f8[0x3];
 	u8         log_max_current_uc_list[0x5];
@@ -1774,7 +1799,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         ats[0x1];
 	u8         reserved_at_462[0x1];
 	u8         log_max_uctx[0x5];
-	u8         reserved_at_468[0x2];
+	u8         aes_xts_multi_block_le_tweak[0x1];
+	u8         crypto[0x1];
 	u8         ipsec_offload[0x1];
 	u8         log_max_umem[0x5];
 	u8         max_num_eqs[0x10];
@@ -3377,6 +3403,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_virtio_emulation_cap_bits virtio_emulation_cap;
 	struct mlx5_ifc_shampo_cap_bits shampo_cap;
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
+	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3995,7 +4022,9 @@ struct mlx5_ifc_mkc_bits {
 	u8         reserved_at_1d9[0x1];
 	u8         log_page_size[0x5];
 
-	u8         reserved_at_1e0[0x20];
+	u8         reserved_at_1e0[0x3];
+	u8         crypto_en[0x2];
+	u8         reserved_at_1e5[0x1b];
 };
 
 struct mlx5_ifc_pkey_bits {
@@ -11978,6 +12007,7 @@ enum {
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_TYPE_TLS = 0x1,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_TYPE_IPSEC = 0x2,
+	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_TYPE_AES_XTS = 0x3,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_TYPE_MACSEC = 0x4,
 };
 
-- 
2.39.0


