Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1BDC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 15:13:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DCB23A6C
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 15:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DCB23A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lXoROS2i/wzPS43ikal24vgnIADgon9pb81NVRuWOIE=; b=QuhsMIaIFwW8VcXFrZbR4zjFH
	0Pofm9ztWlj5UdZYWtLrzeueXe6S2Nzxi8W9Ahf0J0RiZEUWrA/JLaLHEckVVn0fFvG/kBBDpGjIc
	i4/ZGGEo5CVttxvcwOe0kuyJ91VUhPwW6GKMGmaS8P+cqoI/vZdPC3oDOgQaL0WOBW97pH9foH67d
	G9IOxWeLEM/DhaHtVL2ZFLYxx33agK3wgbuSka9CM4BoD2KNLCqmEEFHBjt9bNySwcX2vvn0JOOsi
	n4r7ljcJ4Ub2GC7Z7jV8G+O9g13LB7AUAQubHiHUW74fcS5OQp3wlE6a9fokjsI8OyhJftby9PuJM
	cO03apt5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l04IT-0001Pt-FA; Thu, 14 Jan 2021 15:12:25 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l04Gy-0000gH-Vm
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 15:11:11 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 14 Jan 2021 17:10:44 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 10EFAh0A000835;
 Thu, 14 Jan 2021 17:10:44 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, dsahern@gmail.com,
 smalin@marvell.com
Subject: [PATCH v2 net-next 10/21] net/mlx5: Header file changes for nvme-tcp
 offload
Date: Thu, 14 Jan 2021 17:10:22 +0200
Message-Id: <20210114151033.13020-11-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210114151033.13020-1-borisp@mellanox.com>
References: <20210114151033.13020-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_101053_650071_EDD54EF8 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
 ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ben Ben-ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:

- Add nvmeocp_en + nvmeotcp_crc_en bit to the TIR for identify NVMEoTCP offload flow
  And tag_buffer_id that will be used by the connected nvmeotcp_queues
- Add new CQE field that will be used to pass scattered data information to SW
- Add new capability to HCA_CAP that represnts the NVMEoTCP offload ability

Signed-off-by: Ben Ben-ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 include/linux/mlx5/device.h   |   8 +++
 include/linux/mlx5/mlx5_ifc.h | 101 +++++++++++++++++++++++++++++++++-
 include/linux/mlx5/qp.h       |   1 +
 3 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 00057eae89ab..4433ff213d32 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -263,6 +263,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -1171,6 +1172,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	/* NUM OF CAP Types */
 	MLX5_CAP_NUM
 };
@@ -1391,6 +1393,12 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_IPSEC(mdev, cap)\
 	MLX5_GET(ipsec_cap, (mdev)->caps.hca_cur[MLX5_CAP_IPSEC], cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, mdev->caps.hca_cur[MLX5_CAP_DEV_NVMEOTCP], cap)
+
+#define MLX5_CAP64_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, mdev->caps.hca_cur[MLX5_CAP_DEV_NVMEOTCP], cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index ec0d01e26b3e..923f8961d50d 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1271,7 +1271,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         log_max_srq_sz[0x8];
 	u8         log_max_qp_sz[0x8];
 	u8         event_cap[0x1];
-	u8         reserved_at_91[0x7];
+	u8         reserved_at_91[0x5];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3020,6 +3022,21 @@ struct mlx5_ifc_roce_addr_layout_bits {
 	u8         reserved_at_e0[0x20];
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+
+	u8    reserved_at_40[0x7c0];
+};
+
 union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_cmd_hca_cap_bits cmd_hca_cap;
 	struct mlx5_ifc_odp_cap_bits odp_cap;
@@ -3036,6 +3053,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_tls_cap_bits tls_cap;
 	struct mlx5_ifc_device_mem_cap_bits device_mem_cap;
 	struct mlx5_ifc_virtio_emulation_cap_bits virtio_emulation_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3230,7 +3248,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3261,7 +3281,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -10716,12 +10737,14 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 };
 
 enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21
 };
 
 enum {
@@ -10823,6 +10846,20 @@ struct mlx5_ifc_create_sampler_obj_in_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_20[0x20];
+
+	u8    reserved_at_40[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -10833,6 +10870,18 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_TYPE_IPSEC = 0x2,
 };
 
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_XTS               = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
+};
+
 struct mlx5_ifc_tls_static_params_bits {
 	u8         const_2[0x2];
 	u8         tls_version[0x4];
@@ -10873,4 +10922,50 @@ enum {
 	MLX5_MTT_PERM_RW	= MLX5_MTT_PERM_READ | MLX5_MTT_PERM_WRITE,
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_64[0xc];
+	u8    cccid_ttag[0x10];
+};
+
+struct mlx5_ifc_transport_static_params_bits {
+	u8    const_2[0x2];
+	u8    tls_version[0x4];
+	u8    const_1[0x2];
+	u8    reserved_at_8[0x14];
+	u8    acc_type[0x4];
+
+	u8    reserved_at_20[0x20];
+
+	u8    initial_record_number[0x40];
+
+	u8    resync_tcp_sn[0x20];
+
+	u8    gcm_iv[0x20];
+
+	u8    implicit_iv[0x40];
+
+	u8    reserved_at_100[0x8];
+	u8    dek_index[0x18];
+
+	u8    reserved_at_120[0x14];
+	u8    const1[0x1];
+	u8    ti[0x1];
+	u8    zero_copy_en[0x1];
+	u8    ddgst_offload_en[0x1];
+	u8    hdgst_offload_en[0x1];
+	u8    ddgst_en[0x1];
+	u8    hddgst_en[0x1];
+	u8    pda[0x5];
+
+	u8    nvme_resync_tcp_sn[0x20];
+
+	u8    reserved_at_160[0xa0];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index d75ef8aa8fac..5fa8b82c9edb 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -220,6 +220,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
