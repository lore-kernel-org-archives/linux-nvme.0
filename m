Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0153C4707F
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:10:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6AF613B6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6AF613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ISq1ANrQaBZyjm6FqB16GSiMTMdA6SmYPCBDt7TilY=; b=MIEYTa+ctB6GYb
	L9Ye5QE33pDWLDXKS361NMZk3J50kppl+hy0RyYz8fBuzgfvKEP7v0plEEm8sFaRu7bqn+cwB4JD+
	cJfJpGXiEzi4N2usf/jr8wI/yj9+kZ+z17dd+SBXoUK/OazYNco03wZ64nq7Q2rnU//LUv6yKDheU
	pGliuNxrOp673YvilOeyXUbtI2GgdY398q+Z59C16/qJF1UcRtLLktexJigs7BEA2BJKDXgRvOydY
	S1VsN8HFQhx72a4YUP4A81x1gQ9tXyxn+WLSDfkKQ/nA8abr9u3xhIGdlDDFhz3i8f7RLh/CbXNwX
	uhZDbNGrAa4J3tabP8rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmQ4x-00AUD9-Rw; Fri, 28 May 2021 00:10:19 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmPwE-00AQ5c-C5
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 00:01:20 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14S014DJ008032; Thu, 27 May 2021 17:01:12 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38sxpmd01u-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 27 May 2021 17:01:11 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 May 2021 17:01:10 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 May 2021 17:01:06 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v6 13/27] qed: Add NVMeTCP Offload IO Level FW and HW HSI
Date: Fri, 28 May 2021 02:58:48 +0300
Message-ID: <20210527235902.2185-14-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210527235902.2185-1-smalin@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: t-vp1blK3GySnK64whd0G1Mmifg7xUvV
X-Proofpoint-GUID: t-vp1blK3GySnK64whd0G1Mmifg7xUvV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-27_13:2021-05-27,
 2021-05-27 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_170118_617738_940BC398 
X-CRM114-Status: GOOD (  13.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch introduces the NVMeTCP Offload FW and HW  HSI in order
to initialize the IO level configuration into a per IO HW
resource ("task") as part of the IO path flow.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
---
 include/linux/qed/nvmetcp_common.h | 335 ++++++++++++++++++++++++++++-
 include/linux/qed/qed_nvmetcp_if.h |  31 +++
 2 files changed, 365 insertions(+), 1 deletion(-)

diff --git a/include/linux/qed/nvmetcp_common.h b/include/linux/qed/nvmetcp_common.h
index c8836b71b866..ad745a9c2264 100644
--- a/include/linux/qed/nvmetcp_common.h
+++ b/include/linux/qed/nvmetcp_common.h
@@ -7,6 +7,7 @@
 #include "tcp_common.h"
 
 #define NVMETCP_SLOW_PATH_LAYER_CODE (6)
+#define NVMETCP_WQE_NUM_SGES_SLOWIO (0xf)
 
 /* NVMeTCP firmware function init parameters */
 struct nvmetcp_spe_func_init {
@@ -194,4 +195,336 @@ struct nvmetcp_wqe {
 #define NVMETCP_WQE_CDB_SIZE_OR_NVMETCP_CMD_SHIFT 24
 };
 
-#endif /* __NVMETCP_COMMON__ */
+struct nvmetcp_host_cccid_itid_entry {
+	__le16 itid;
+};
+
+struct nvmetcp_connect_done_results {
+	__le16 icid;
+	__le16 conn_id;
+	struct tcp_ulp_connect_done_params params;
+};
+
+struct nvmetcp_eqe_data {
+	__le16 icid;
+	__le16 conn_id;
+	__le16 reserved;
+	u8 error_code;
+	u8 error_pdu_opcode_reserved;
+#define NVMETCP_EQE_DATA_ERROR_PDU_OPCODE_MASK 0x3F
+#define NVMETCP_EQE_DATA_ERROR_PDU_OPCODE_SHIFT  0
+#define NVMETCP_EQE_DATA_ERROR_PDU_OPCODE_VALID_MASK  0x1
+#define NVMETCP_EQE_DATA_ERROR_PDU_OPCODE_VALID_SHIFT  6
+#define NVMETCP_EQE_DATA_RESERVED0_MASK 0x1
+#define NVMETCP_EQE_DATA_RESERVED0_SHIFT 7
+};
+
+enum nvmetcp_task_type {
+	NVMETCP_TASK_TYPE_HOST_WRITE,
+	NVMETCP_TASK_TYPE_HOST_READ,
+	NVMETCP_TASK_TYPE_INIT_CONN_REQUEST,
+	NVMETCP_TASK_TYPE_RESERVED0,
+	NVMETCP_TASK_TYPE_CLEANUP,
+	NVMETCP_TASK_TYPE_HOST_READ_NO_CQE,
+	MAX_NVMETCP_TASK_TYPE
+};
+
+struct nvmetcp_db_data {
+	u8 params;
+#define NVMETCP_DB_DATA_DEST_MASK 0x3 /* destination of doorbell (use enum db_dest) */
+#define NVMETCP_DB_DATA_DEST_SHIFT 0
+#define NVMETCP_DB_DATA_AGG_CMD_MASK 0x3 /* aggregative command to CM (use enum db_agg_cmd_sel) */
+#define NVMETCP_DB_DATA_AGG_CMD_SHIFT 2
+#define NVMETCP_DB_DATA_BYPASS_EN_MASK 0x1 /* enable QM bypass */
+#define NVMETCP_DB_DATA_BYPASS_EN_SHIFT 4
+#define NVMETCP_DB_DATA_RESERVED_MASK 0x1
+#define NVMETCP_DB_DATA_RESERVED_SHIFT 5
+#define NVMETCP_DB_DATA_AGG_VAL_SEL_MASK 0x3 /* aggregative value selection */
+#define NVMETCP_DB_DATA_AGG_VAL_SEL_SHIFT 6
+	u8 agg_flags; /* bit for every DQ counter flags in CM context that DQ can increment */
+	__le16 sq_prod;
+};
+
+struct nvmetcp_fw_nvmf_cqe {
+	__le32 reserved[4];
+};
+
+struct nvmetcp_icresp_mdata {
+	u8  digest;
+	u8  cpda;
+	__le16  pfv;
+	__le32 maxdata;
+	__le16 rsvd[4];
+};
+
+union nvmetcp_fw_cqe_data {
+	struct nvmetcp_fw_nvmf_cqe nvme_cqe;
+	struct nvmetcp_icresp_mdata icresp_mdata;
+};
+
+struct nvmetcp_fw_cqe {
+	__le16 conn_id;
+	u8 cqe_type;
+	u8 cqe_error_status_bits;
+#define CQE_ERROR_BITMAP_DIF_ERR_BITS_MASK 0x7
+#define CQE_ERROR_BITMAP_DIF_ERR_BITS_SHIFT 0
+#define CQE_ERROR_BITMAP_DATA_DIGEST_ERR_MASK 0x1
+#define CQE_ERROR_BITMAP_DATA_DIGEST_ERR_SHIFT 3
+#define CQE_ERROR_BITMAP_RCV_ON_INVALID_CONN_MASK 0x1
+#define CQE_ERROR_BITMAP_RCV_ON_INVALID_CONN_SHIFT 4
+	__le16 itid;
+	u8 task_type;
+	u8 fw_dbg_field;
+	u8 caused_conn_err;
+	u8 reserved0[3];
+	__le32 reserved1;
+	union nvmetcp_fw_cqe_data cqe_data;
+	struct regpair task_opaque;
+	__le32 reserved[6];
+};
+
+enum nvmetcp_fw_cqes_type {
+	NVMETCP_FW_CQE_TYPE_NORMAL = 1,
+	NVMETCP_FW_CQE_TYPE_RESERVED0,
+	NVMETCP_FW_CQE_TYPE_RESERVED1,
+	NVMETCP_FW_CQE_TYPE_CLEANUP,
+	NVMETCP_FW_CQE_TYPE_DUMMY,
+	MAX_NVMETCP_FW_CQES_TYPE
+};
+
+struct ystorm_nvmetcp_task_state {
+	struct scsi_cached_sges data_desc;
+	struct scsi_sgl_params sgl_params;
+	__le32 resrved0;
+	__le32 buffer_offset;
+	__le16 cccid;
+	struct nvmetcp_dif_flags dif_flags;
+	u8 flags;
+#define YSTORM_NVMETCP_TASK_STATE_LOCAL_COMP_MASK 0x1
+#define YSTORM_NVMETCP_TASK_STATE_LOCAL_COMP_SHIFT 0
+#define YSTORM_NVMETCP_TASK_STATE_SLOW_IO_MASK 0x1
+#define YSTORM_NVMETCP_TASK_STATE_SLOW_IO_SHIFT 1
+#define YSTORM_NVMETCP_TASK_STATE_SET_DIF_OFFSET_MASK 0x1
+#define YSTORM_NVMETCP_TASK_STATE_SET_DIF_OFFSET_SHIFT 2
+#define YSTORM_NVMETCP_TASK_STATE_SEND_W_RSP_MASK 0x1
+#define YSTORM_NVMETCP_TASK_STATE_SEND_W_RSP_SHIFT 3
+};
+
+struct ystorm_nvmetcp_task_rxmit_opt {
+	__le32 reserved[4];
+};
+
+struct nvmetcp_task_hdr {
+	__le32 reg[18];
+};
+
+struct nvmetcp_task_hdr_aligned {
+	struct nvmetcp_task_hdr task_hdr;
+	__le32 reserved[2];	/* HSI_COMMENT: Align to QREG */
+};
+
+struct e5_tdif_task_context {
+	__le32 reserved[16];
+};
+
+struct e5_rdif_task_context {
+	__le32 reserved[12];
+};
+
+struct ystorm_nvmetcp_task_st_ctx {
+	struct ystorm_nvmetcp_task_state state;
+	struct ystorm_nvmetcp_task_rxmit_opt rxmit_opt;
+	struct nvmetcp_task_hdr_aligned pdu_hdr;
+};
+
+struct mstorm_nvmetcp_task_st_ctx {
+	struct scsi_cached_sges data_desc;
+	struct scsi_sgl_params sgl_params;
+	__le32 rem_task_size;
+	__le32 data_buffer_offset;
+	u8 task_type;
+	struct nvmetcp_dif_flags dif_flags;
+	__le16 dif_task_icid;
+	struct regpair reserved0;
+	__le32 expected_itt;
+	__le32 reserved1;
+};
+
+struct ustorm_nvmetcp_task_st_ctx {
+	__le32 rem_rcv_len;
+	__le32 exp_data_transfer_len;
+	__le32 exp_data_sn;
+	struct regpair reserved0;
+	__le32 reg1_map;
+#define REG1_NUM_SGES_MASK 0xF
+#define REG1_NUM_SGES_SHIFT 0
+#define REG1_RESERVED1_MASK 0xFFFFFFF
+#define REG1_RESERVED1_SHIFT 4
+	u8 flags2;
+#define USTORM_NVMETCP_TASK_ST_CTX_AHS_EXIST_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_AHS_EXIST_SHIFT 0
+#define USTORM_NVMETCP_TASK_ST_CTX_RESERVED1_MASK 0x7F
+#define USTORM_NVMETCP_TASK_ST_CTX_RESERVED1_SHIFT 1
+	struct nvmetcp_dif_flags dif_flags;
+	__le16 reserved3;
+	__le16 tqe_opaque[2];
+	__le32 reserved5;
+	__le32 nvme_tcp_opaque_lo;
+	__le32 nvme_tcp_opaque_hi;
+	u8 task_type;
+	u8 error_flags;
+#define USTORM_NVMETCP_TASK_ST_CTX_DATA_DIGEST_ERROR_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_DATA_DIGEST_ERROR_SHIFT 0
+#define USTORM_NVMETCP_TASK_ST_CTX_DATA_TRUNCATED_ERROR_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_DATA_TRUNCATED_ERROR_SHIFT 1
+#define USTORM_NVMETCP_TASK_ST_CTX_UNDER_RUN_ERROR_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_UNDER_RUN_ERROR_SHIFT 2
+#define USTORM_NVMETCP_TASK_ST_CTX_NVME_TCP_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_NVME_TCP_SHIFT 3
+	u8 flags;
+#define USTORM_NVMETCP_TASK_ST_CTX_CQE_WRITE_MASK 0x3
+#define USTORM_NVMETCP_TASK_ST_CTX_CQE_WRITE_SHIFT 0
+#define USTORM_NVMETCP_TASK_ST_CTX_LOCAL_COMP_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_LOCAL_COMP_SHIFT 2
+#define USTORM_NVMETCP_TASK_ST_CTX_Q0_R2TQE_WRITE_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_Q0_R2TQE_WRITE_SHIFT 3
+#define USTORM_NVMETCP_TASK_ST_CTX_TOTAL_DATA_ACKED_DONE_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_TOTAL_DATA_ACKED_DONE_SHIFT 4
+#define USTORM_NVMETCP_TASK_ST_CTX_HQ_SCANNED_DONE_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_HQ_SCANNED_DONE_SHIFT 5
+#define USTORM_NVMETCP_TASK_ST_CTX_R2T2RECV_DONE_MASK 0x1
+#define USTORM_NVMETCP_TASK_ST_CTX_R2T2RECV_DONE_SHIFT 6
+	u8 cq_rss_number;
+};
+
+struct e5_ystorm_nvmetcp_task_ag_ctx {
+	u8 reserved /* cdu_validation */;
+	u8 byte1 /* state_and_core_id */;
+	__le16 word0 /* icid */;
+	u8 flags0;
+	u8 flags1;
+	u8 flags2;
+	u8 flags3;
+	__le32 TTT;
+	u8 byte2;
+	u8 byte3;
+	u8 byte4;
+	u8 e4_reserved7;
+};
+
+struct e5_mstorm_nvmetcp_task_ag_ctx {
+	u8 cdu_validation;
+	u8 byte1;
+	__le16 task_cid;
+	u8 flags0;
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CONNECTION_TYPE_MASK 0xF
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CONNECTION_TYPE_SHIFT 0
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_EXIST_IN_QM0_MASK 0x1
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_EXIST_IN_QM0_SHIFT 4
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CONN_CLEAR_SQ_FLAG_MASK 0x1
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CONN_CLEAR_SQ_FLAG_SHIFT 5
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_VALID_MASK 0x1
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_VALID_SHIFT 6
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_TASK_CLEANUP_FLAG_MASK 0x1
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_TASK_CLEANUP_FLAG_SHIFT 7
+	u8 flags1;
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_TASK_CLEANUP_CF_MASK 0x3
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_TASK_CLEANUP_CF_SHIFT 0
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CF1_MASK 0x3
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CF1_SHIFT 2
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CF2_MASK 0x3
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CF2_SHIFT 4
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_TASK_CLEANUP_CF_EN_MASK 0x1
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_TASK_CLEANUP_CF_EN_SHIFT 6
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CF1EN_MASK 0x1
+#define E5_MSTORM_NVMETCP_TASK_AG_CTX_CF1EN_SHIFT 7
+	u8 flags2;
+	u8 flags3;
+	__le32 reg0;
+	u8 byte2;
+	u8 byte3;
+	u8 byte4;
+	u8 e4_reserved7;
+};
+
+struct e5_ustorm_nvmetcp_task_ag_ctx {
+	u8 reserved;
+	u8 state_and_core_id;
+	__le16 icid;
+	u8 flags0;
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CONNECTION_TYPE_MASK 0xF
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CONNECTION_TYPE_SHIFT 0
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_EXIST_IN_QM0_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_EXIST_IN_QM0_SHIFT 4
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CONN_CLEAR_SQ_FLAG_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CONN_CLEAR_SQ_FLAG_SHIFT 5
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_HQ_SCANNED_CF_MASK 0x3
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_HQ_SCANNED_CF_SHIFT 6
+	u8 flags1;
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_RESERVED1_MASK 0x3
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_RESERVED1_SHIFT 0
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_R2T2RECV_MASK 0x3
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_R2T2RECV_SHIFT 2
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CF3_MASK 0x3
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CF3_SHIFT 4
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_DIF_ERROR_CF_MASK 0x3
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_DIF_ERROR_CF_SHIFT 6
+	u8 flags2;
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_HQ_SCANNED_CF_EN_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_HQ_SCANNED_CF_EN_SHIFT 0
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_DISABLE_DATA_ACKED_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_DISABLE_DATA_ACKED_SHIFT 1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_R2T2RECV_EN_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_R2T2RECV_EN_SHIFT 2
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CF3EN_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CF3EN_SHIFT 3
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_DIF_ERROR_CF_EN_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_DIF_ERROR_CF_EN_SHIFT 4
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CMP_DATA_TOTAL_EXP_EN_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CMP_DATA_TOTAL_EXP_EN_SHIFT 5
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_RULE1EN_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_RULE1EN_SHIFT 6
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CMP_CONT_RCV_EXP_EN_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_CMP_CONT_RCV_EXP_EN_SHIFT 7
+	u8 flags3;
+	u8 flags4;
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_E4_RESERVED5_MASK 0x3
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_E4_RESERVED5_SHIFT 0
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_E4_RESERVED6_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_E4_RESERVED6_SHIFT 2
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_E4_RESERVED7_MASK 0x1
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_E4_RESERVED7_SHIFT 3
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_DIF_ERROR_TYPE_MASK 0xF
+#define E5_USTORM_NVMETCP_TASK_AG_CTX_DIF_ERROR_TYPE_SHIFT 4
+	u8 byte2;
+	u8 byte3;
+	u8 e4_reserved8;
+	__le32 dif_err_intervals;
+	__le32 dif_error_1st_interval;
+	__le32 rcv_cont_len;
+	__le32 exp_cont_len;
+	__le32 total_data_acked;
+	__le32 exp_data_acked;
+	__le16 word1;
+	__le16 next_tid;
+	__le32 hdr_residual_count;
+	__le32 exp_r2t_sn;
+};
+
+struct e5_nvmetcp_task_context {
+	struct ystorm_nvmetcp_task_st_ctx ystorm_st_context;
+	struct e5_ystorm_nvmetcp_task_ag_ctx ystorm_ag_context;
+	struct regpair ystorm_ag_padding[2];
+	struct e5_tdif_task_context tdif_context;
+	struct e5_mstorm_nvmetcp_task_ag_ctx mstorm_ag_context;
+	struct regpair mstorm_ag_padding[2];
+	struct e5_ustorm_nvmetcp_task_ag_ctx ustorm_ag_context;
+	struct regpair ustorm_ag_padding[2];
+	struct mstorm_nvmetcp_task_st_ctx mstorm_st_context;
+	struct regpair mstorm_st_padding[2];
+	struct ustorm_nvmetcp_task_st_ctx ustorm_st_context;
+	struct regpair ustorm_st_padding[2];
+	struct e5_rdif_task_context rdif_context;
+};
+
+#endif /* __NVMETCP_COMMON__*/
diff --git a/include/linux/qed/qed_nvmetcp_if.h b/include/linux/qed/qed_nvmetcp_if.h
index 686f924238e3..4cca00e7a09a 100644
--- a/include/linux/qed/qed_nvmetcp_if.h
+++ b/include/linux/qed/qed_nvmetcp_if.h
@@ -5,6 +5,8 @@
 #define _QED_NVMETCP_IF_H
 #include <linux/types.h>
 #include <linux/qed/qed_if.h>
+#include <linux/qed/storage_common.h>
+#include <linux/qed/nvmetcp_common.h>
 
 #define QED_NVMETCP_MAX_IO_SIZE	0x800000
 
@@ -73,6 +75,35 @@ struct qed_nvmetcp_cb_ops {
 	struct qed_common_cb_ops common;
 };
 
+struct nvmetcp_sge {
+	struct regpair sge_addr; /* SGE address */
+	__le32 sge_len; /* SGE length */
+	__le32 reserved;
+};
+
+/* IO path HSI function SGL params */
+struct storage_sgl_task_params {
+	struct nvmetcp_sge *sgl;
+	struct regpair sgl_phys_addr;
+	u32 total_buffer_size;
+	u16 num_sges;
+	bool small_mid_sge;
+};
+
+/* IO path HSI function FW task context params */
+struct nvmetcp_task_params {
+	void *context; /* Output parameter - set/filled by the HSI function */
+	struct nvmetcp_wqe *sqe;
+	u32 tx_io_size; /* in bytes (Without DIF, if exists) */
+	u32 rx_io_size; /* in bytes (Without DIF, if exists) */
+	u16 conn_icid;
+	u16 itid;
+	struct regpair opq; /* qedn_task_ctx address */
+	u16 host_cccid;
+	u8 cq_rss_number;
+	bool send_write_incapsule;
+};
+
 /**
  * struct qed_nvmetcp_ops - qed NVMeTCP operations.
  * @common:		common operations pointer
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
