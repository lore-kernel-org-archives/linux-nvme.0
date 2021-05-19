Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6074DC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:20:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE05C6108B
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE05C6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R66lH1zURDc32FvtVgSoQhsDvutwh+4LNm70crznVgI=; b=WDCC8AV1HtWV498QQGKkkXsMF
	nITfUJMyAB74QWshVza+wn+PQwwNdXI8fVs6WRwdjqsUP5gBfIMgJ8Kt6dXi+whx8NDP2nyjuNuAm
	zS42+J4t/So8h+m+xtas1lNCvN3PpXgd+qgchpgsvJcF0CRxIsVQhqnV/gqrAHhvVp5Pw65hZrssY
	K18pgGxZeiXQJtZlh7YW4sOoD+cQ5iFgvAatBPgTzKDuMdlSh+gSlPHEbEA8wEC8CQqEkvpWjUzVG
	nQfhO/anZ2pVsuBe+1xUFTi2zUI4DIrCdhQs2V+AOX+7de68c5zcTo4iO9EYI6u3ix5JtdHN0lrqG
	MXiSrbX+Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljKEs-003k2C-0B; Wed, 19 May 2021 11:19:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKAj-003j7X-Mj
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 11:15:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oIhQ0CplJElJI+hWPbO865bFRagesSaYlCk65tHk/lk=; b=mpl33b9yI2z5fc2g9ZqiSXV1Si
 g1fmmcPho/ZDZyS75GSVHltpUsCwb+Rl++wZ+K15PrLVn2dpB8mh0dbS4V203aWguvGeJUPbTk2cx
 K8rIbEccbnuirgrPjg3H/UwKPAb+UH1B2B5iO355g5nOT+aRNbzuE2fyeiBy+JK6Lc+ihJ/3lmW6R
 IOMOAHBDwyz1/8RuC9zl9RT1GojXozYOGHj4/R6DGTI52aNpqM/eLAXTW7XV7WXmGfYe5TX9walSD
 0G/oRkNM2+1E+e4k7L9dx1+di97tmEOion2I2adrECn0DBZYV4XVVwBVuf/yA9X9nLfM9M/gYjpwR
 FqjAVtLg==;
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKAg-00FOQM-T9
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 11:15:28 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14JB9cXs020124; Wed, 19 May 2021 04:15:23 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 38mqc1hytp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 19 May 2021 04:15:23 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 19 May 2021 04:15:22 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 19 May 2021 04:15:18 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v5 12/27] qed: Add support of HW filter block
Date: Wed, 19 May 2021 14:13:25 +0300
Message-ID: <20210519111340.20613-13-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210519111340.20613-1-smalin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: d8lWgVNtozvfT8zazO1uvzZgkqhNvMn8
X-Proofpoint-ORIG-GUID: d8lWgVNtozvfT8zazO1uvzZgkqhNvMn8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-19_04:2021-05-19,
 2021-05-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_041526_975585_DD15F865 
X-CRM114-Status: GOOD (  16.05  )
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

From: Prabhakar Kushwaha <pkushwaha@marvell.com>

This patch introduces the functionality of HW filter block.
It adds and removes filters based on source and target TCP port.

It also add functionality to clear all filters at once.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/net/ethernet/qlogic/qed/qed.h         |  10 ++
 drivers/net/ethernet/qlogic/qed/qed_dev.c     | 107 ++++++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c |   5 +
 include/linux/qed/qed_nvmetcp_if.h            |  24 ++++
 4 files changed, 146 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index bc9bdb9d1bb9..e5b974a3bc40 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -49,6 +49,8 @@ extern const struct qed_common_ops qed_common_ops_pass;
 #define QED_MIN_WIDS		(4)
 #define QED_PF_DEMS_SIZE        (4)
 
+#define QED_LLH_DONT_CARE 0
+
 /* cau states */
 enum qed_coalescing_mode {
 	QED_COAL_MODE_DISABLE,
@@ -1005,4 +1007,12 @@ int qed_mfw_fill_tlv_data(struct qed_hwfn *hwfn,
 void qed_hw_info_set_offload_tc(struct qed_hw_info *p_info, u8 tc);
 
 void qed_periodic_db_rec_start(struct qed_hwfn *p_hwfn);
+
+int qed_llh_add_src_tcp_port_filter(struct qed_dev *cdev, u16 src_port);
+int qed_llh_add_dst_tcp_port_filter(struct qed_dev *cdev, u16 dest_port);
+
+void qed_llh_remove_src_tcp_port_filter(struct qed_dev *cdev, u16 src_port);
+void qed_llh_remove_dst_tcp_port_filter(struct qed_dev *cdev, u16 src_port);
+
+void qed_llh_clear_all_filters(struct qed_dev *cdev);
 #endif /* _QED_H */
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 932b892f1ef1..2ed9a8ab9dce 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -5362,3 +5362,110 @@ void qed_set_fw_mac_addr(__le16 *fw_msb,
 	((u8 *)fw_lsb)[0] = mac[5];
 	((u8 *)fw_lsb)[1] = mac[4];
 }
+
+static int qed_llh_shadow_remove_all_filters(struct qed_dev *cdev, u8 ppfid)
+{
+	struct qed_llh_info *p_llh_info = cdev->p_llh_info;
+	struct qed_llh_filter_info *p_filters;
+	int rc;
+
+	rc = qed_llh_shadow_sanity(cdev, ppfid, 0, "remove_all");
+	if (rc)
+		return rc;
+
+	p_filters = p_llh_info->pp_filters[ppfid];
+	memset(p_filters, 0, NIG_REG_LLH_FUNC_FILTER_EN_SIZE *
+	       sizeof(*p_filters));
+
+	return 0;
+}
+
+int qed_abs_ppfid(struct qed_dev *cdev, u8 rel_ppfid, u8 *p_abs_ppfid)
+{
+	struct qed_llh_info *p_llh_info = cdev->p_llh_info;
+
+	if (rel_ppfid >= p_llh_info->num_ppfid) {
+		DP_NOTICE(cdev,
+			  "rel_ppfid %d is not valid, available indices are 0..%hhu\n",
+			  rel_ppfid, p_llh_info->num_ppfid - 1);
+
+		return -EINVAL;
+	}
+
+	*p_abs_ppfid = p_llh_info->ppfid_array[rel_ppfid];
+
+	return 0;
+}
+
+void qed_llh_clear_ppfid_filters(struct qed_dev *cdev, u8 ppfid)
+{
+	struct qed_hwfn *p_hwfn = QED_LEADING_HWFN(cdev);
+	struct qed_ptt *p_ptt = qed_ptt_acquire(p_hwfn);
+	u8 filter_idx, abs_ppfid;
+	int rc = 0;
+
+	if (!p_ptt)
+		return;
+
+	if (!test_bit(QED_MF_LLH_PROTO_CLSS, &cdev->mf_bits) &&
+	    !test_bit(QED_MF_LLH_MAC_CLSS, &cdev->mf_bits))
+		goto out;
+
+	rc = qed_abs_ppfid(cdev, ppfid, &abs_ppfid);
+	if (rc)
+		goto out;
+
+	rc = qed_llh_shadow_remove_all_filters(cdev, ppfid);
+	if (rc)
+		goto out;
+
+	for (filter_idx = 0; filter_idx < NIG_REG_LLH_FUNC_FILTER_EN_SIZE;
+	     filter_idx++) {
+		rc = qed_llh_remove_filter(p_hwfn, p_ptt,
+					   abs_ppfid, filter_idx);
+		if (rc)
+			goto out;
+	}
+out:
+	qed_ptt_release(p_hwfn, p_ptt);
+}
+
+int qed_llh_add_src_tcp_port_filter(struct qed_dev *cdev, u16 src_port)
+{
+	return qed_llh_add_protocol_filter(cdev, 0,
+					   QED_LLH_FILTER_TCP_SRC_PORT,
+					   src_port, QED_LLH_DONT_CARE);
+}
+
+void qed_llh_remove_src_tcp_port_filter(struct qed_dev *cdev, u16 src_port)
+{
+	qed_llh_remove_protocol_filter(cdev, 0,
+				       QED_LLH_FILTER_TCP_SRC_PORT,
+				       src_port, QED_LLH_DONT_CARE);
+}
+
+int qed_llh_add_dst_tcp_port_filter(struct qed_dev *cdev, u16 dest_port)
+{
+	return qed_llh_add_protocol_filter(cdev, 0,
+					   QED_LLH_FILTER_TCP_DEST_PORT,
+					   QED_LLH_DONT_CARE, dest_port);
+}
+
+void qed_llh_remove_dst_tcp_port_filter(struct qed_dev *cdev, u16 dest_port)
+{
+	qed_llh_remove_protocol_filter(cdev, 0,
+				       QED_LLH_FILTER_TCP_DEST_PORT,
+				       QED_LLH_DONT_CARE, dest_port);
+}
+
+void qed_llh_clear_all_filters(struct qed_dev *cdev)
+{
+	u8 ppfid;
+
+	if (!test_bit(QED_MF_LLH_PROTO_CLSS, &cdev->mf_bits) &&
+	    !test_bit(QED_MF_LLH_MAC_CLSS, &cdev->mf_bits))
+		return;
+
+	for (ppfid = 0; ppfid < cdev->p_llh_info->num_ppfid; ppfid++)
+		qed_llh_clear_ppfid_filters(cdev, ppfid);
+}
diff --git a/drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c b/drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
index c485026321be..93f36e324a30 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
@@ -846,6 +846,11 @@ static const struct qed_nvmetcp_ops qed_nvmetcp_ops_pass = {
 	.update_conn = &qed_nvmetcp_update_conn,
 	.destroy_conn = &qed_nvmetcp_destroy_conn,
 	.clear_sq = &qed_nvmetcp_clear_conn_sq,
+	.add_src_tcp_port_filter = &qed_llh_add_src_tcp_port_filter,
+	.remove_src_tcp_port_filter = &qed_llh_remove_src_tcp_port_filter,
+	.add_dst_tcp_port_filter = &qed_llh_add_dst_tcp_port_filter,
+	.remove_dst_tcp_port_filter = &qed_llh_remove_dst_tcp_port_filter,
+	.clear_all_filters = &qed_llh_clear_all_filters
 };
 
 const struct qed_nvmetcp_ops *qed_get_nvmetcp_ops(void)
diff --git a/include/linux/qed/qed_nvmetcp_if.h b/include/linux/qed/qed_nvmetcp_if.h
index 96263e3cfa1e..686f924238e3 100644
--- a/include/linux/qed/qed_nvmetcp_if.h
+++ b/include/linux/qed/qed_nvmetcp_if.h
@@ -124,6 +124,20 @@ struct qed_nvmetcp_cb_ops {
  *			@param cdev
  *			@param handle - the connection handle.
  *			@return 0 on success, otherwise error value.
+ * @add_src_tcp_port_filter: Add source tcp port filter
+ *			@param cdev
+ *			@param src_port
+ * @remove_src_tcp_port_filter: Remove source tcp port filter
+ *			@param cdev
+ *			@param src_port
+ * @add_dst_tcp_port_filter: Add destination tcp port filter
+ *			@param cdev
+ *			@param dest_port
+ * @remove_dst_tcp_port_filter: Remove destination tcp port filter
+ *			@param cdev
+ *			@param dest_port
+ * @clear_all_filters: Clear all filters.
+ *			@param cdev
  */
 struct qed_nvmetcp_ops {
 	const struct qed_common_ops *common;
@@ -159,6 +173,16 @@ struct qed_nvmetcp_ops {
 	int (*destroy_conn)(struct qed_dev *cdev, u32 handle, u8 abrt_conn);
 
 	int (*clear_sq)(struct qed_dev *cdev, u32 handle);
+
+	int (*add_src_tcp_port_filter)(struct qed_dev *cdev, u16 src_port);
+
+	void (*remove_src_tcp_port_filter)(struct qed_dev *cdev, u16 src_port);
+
+	int (*add_dst_tcp_port_filter)(struct qed_dev *cdev, u16 dest_port);
+
+	void (*remove_dst_tcp_port_filter)(struct qed_dev *cdev, u16 dest_port);
+
+	void (*clear_all_filters)(struct qed_dev *cdev);
 };
 
 const struct qed_nvmetcp_ops *qed_get_nvmetcp_ops(void);
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
