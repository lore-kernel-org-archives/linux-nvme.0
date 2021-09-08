Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE56C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:34:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EF1610E9
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92EF1610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LQZy3d9MO0Po3bGQYL3NZ0A8n74UWZ3Ymg/OQntfiP8=; b=FDsLP1gZqpfl7/
	C5qwhjnoPFrlwuIO/5e8dQcdCmJkdm5ZlsJ8KdUr0Xksl0AKGVD9DFXjY7JPg4E89wg4AJBih+VK0
	JWQJqly1vJofcv+p7sradwquPq98jtojYeLgTMpK+Igv88V8MqAeiRNssjGYGkhjzBj+5L8QlbWrG
	gTsHT167q0ZeJPt0m1CZV4Q6OOCYyCY27AP8DNKByJphoeF/BSkwsHmkQBv6oS6sh0PXZxZuwbBNX
	E2Md0+H6n7meZ/rIHXXhl+QNM40IlK/QXe7IHrClXaomkBZD253juxaPp3JmKtk8kPs8QNjnbYxpv
	+pmYfCaBXC3bk+hgltfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNs6S-005vOg-59; Wed, 08 Sep 2021 07:34:40 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNs1p-005tSU-HN
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 07:29:55 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1883PnUf016052; 
 Wed, 8 Sep 2021 00:29:53 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 3axcm7tfny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 08 Sep 2021 00:29:53 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 8 Sep 2021 00:29:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 00:29:51 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id 7217C3F705B;
 Wed,  8 Sep 2021 00:29:51 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1887Tkux010058;
 Wed, 8 Sep 2021 00:29:51 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1887TXAr010057;
 Wed, 8 Sep 2021 00:29:33 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
 <djeffery@redhat.com>, <loberman@redhat.com>
Subject: [PATCH 01/10] qla2xxx: Add support for mailbox passthru
Date: Wed, 8 Sep 2021 00:28:37 -0700
Message-ID: <20210908072846.10011-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210908072846.10011-1-njavali@marvell.com>
References: <20210908072846.10011-1-njavali@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: tidUbBvaIY7_KwK66qeoXNN924gm8JW5
X-Proofpoint-ORIG-GUID: tidUbBvaIY7_KwK66qeoXNN924gm8JW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_02,2021-09-07_02,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_002953_658943_62CAE08D 
X-CRM114-Status: GOOD (  17.53  )
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

From: Bikash Hazarika <bhazarika@marvell.com>

This interface will allow user space application(s) to send a mailbox
command to the FW.

Signed-off-by: Bikash Hazarika <bhazarika@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 48 ++++++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_bsg.h |  7 +++++
 drivers/scsi/qla2xxx/qla_gbl.h |  4 +++
 drivers/scsi/qla2xxx/qla_mbx.c | 33 +++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 4b5d28d89d69..0c33fb0de21a 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -2877,6 +2877,9 @@ qla2x00_process_vendor_specific(struct scsi_qla_host *vha, struct bsg_job *bsg_j
 	case QL_VND_MANAGE_HOST_PORT:
 		return qla2x00_manage_host_port(bsg_job);
 
+	case QL_VND_MBX_PASSTHRU:
+		return qla2x00_mailbox_passthru(bsg_job);
+
 	default:
 		return -ENOSYS;
 	}
@@ -3013,3 +3016,48 @@ qla24xx_bsg_timeout(struct bsg_job *bsg_job)
 	sp->free(sp);
 	return 0;
 }
+
+int qla2x00_mailbox_passthru(struct bsg_job *bsg_job)
+{
+	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
+	int ret = -EINVAL;
+	int ptsize = sizeof(struct qla_mbx_passthru);
+	struct qla_mbx_passthru *req_data = NULL;
+	uint32_t req_data_len;
+
+	req_data_len = bsg_job->request_payload.payload_len;
+	if (req_data_len != ptsize) {
+		ql_log(ql_log_warn, vha, 0xf0a3, "req_data_len invalid.\n");
+		return -EIO;
+	}
+	req_data = kzalloc(ptsize, GFP_KERNEL);
+	if (!req_data) {
+		ql_log(ql_log_warn, vha, 0xf0a4,
+		       "req_data memory allocation failure.\n");
+		return -ENOMEM;
+	}
+
+	/* Copy the request buffer in req_data */
+	sg_copy_to_buffer(bsg_job->request_payload.sg_list,
+			  bsg_job->request_payload.sg_cnt, req_data, ptsize);
+	ret = qla_mailbox_passthru(vha, req_data->mbx_in, req_data->mbx_out);
+
+	/* Copy the req_data in  request buffer */
+	sg_copy_from_buffer(bsg_job->reply_payload.sg_list,
+			    bsg_job->reply_payload.sg_cnt, req_data, ptsize);
+
+	bsg_reply->reply_payload_rcv_len = ptsize;
+	if (ret == QLA_SUCCESS)
+		bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = EXT_STATUS_OK;
+	else
+		bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = EXT_STATUS_ERR;
+
+	bsg_job->reply_len = sizeof(*bsg_job->reply);
+	bsg_reply->result = DID_OK << 16;
+	bsg_job_done(bsg_job, bsg_reply->result, bsg_reply->reply_payload_rcv_len);
+
+	kfree(req_data);
+
+	return ret;
+}
diff --git a/drivers/scsi/qla2xxx/qla_bsg.h b/drivers/scsi/qla2xxx/qla_bsg.h
index dd793cf8bc1e..0f8a4c7e52a2 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.h
+++ b/drivers/scsi/qla2xxx/qla_bsg.h
@@ -36,6 +36,7 @@
 #define QL_VND_GET_HOST_STATS		0x24
 #define QL_VND_GET_TGT_STATS		0x25
 #define QL_VND_MANAGE_HOST_PORT		0x26
+#define QL_VND_MBX_PASSTHRU		0x2B
 
 /* BSG Vendor specific subcode returns */
 #define EXT_STATUS_OK			0
@@ -187,6 +188,12 @@ struct qla_port_param {
 	uint16_t speed;
 } __attribute__ ((packed));
 
+struct qla_mbx_passthru {
+	uint16_t reserved1[2];
+	uint16_t mbx_in[32];
+	uint16_t mbx_out[32];
+	uint32_t reserved2[16];
+} __packed;
 
 /* FRU VPD */
 
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 1c3f055d41b8..8aadcdeca6cb 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -662,9 +662,13 @@ extern int qla2xxx_get_vpd_field(scsi_qla_host_t *, char *, char *, size_t);
 
 extern void qla2xxx_flash_npiv_conf(scsi_qla_host_t *);
 extern int qla24xx_read_fcp_prio_cfg(scsi_qla_host_t *);
+extern int qla2x00_mailbox_passthru(struct bsg_job *bsg_job);
 int __qla_copy_purex_to_buffer(struct scsi_qla_host *vha, void **pkt,
 	struct rsp_que **rsp, u8 *buf, u32 buf_len);
 
+int qla_mailbox_passthru(scsi_qla_host_t *vha, uint16_t *mbx_in,
+			 uint16_t *mbx_out);
+
 /*
  * Global Function Prototypes in qla_dbg.c source file.
  */
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 7811c4952035..9eb41dd39043 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -7011,3 +7011,36 @@ void qla_no_op_mb(struct scsi_qla_host *vha)
 			"Failed %s %x\n", __func__, rval);
 	}
 }
+
+int qla_mailbox_passthru(scsi_qla_host_t *vha,
+			 uint16_t *mbx_in, uint16_t *mbx_out)
+{
+	mbx_cmd_t mc;
+	mbx_cmd_t *mcp = &mc;
+	int rval = -EINVAL;
+
+	memset(&mc, 0, sizeof(mc));
+	/* Receiving all 32 register's contents */
+	memcpy(&mcp->mb, (char *)mbx_in, (32 * sizeof(uint16_t)));
+
+	mcp->out_mb = 0xFFFFFFFF;
+	mcp->in_mb = 0xFFFFFFFF;
+
+	mcp->tov = MBX_TOV_SECONDS;
+	mcp->flags = 0;
+	mcp->bufp = NULL;
+
+	rval = qla2x00_mailbox_command(vha, mcp);
+
+	if (rval != QLA_SUCCESS) {
+		ql_dbg(ql_dbg_mbx, vha, 0xf0a2,
+			"Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
+	} else {
+		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0xf0a3, "Done %s.\n",
+		       __func__);
+		/* passing all 32 register's contents */
+		memcpy(mbx_out, &mcp->mb, 32 * sizeof(uint16_t));
+	}
+
+	return rval;
+}
-- 
2.19.0.rc0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
