Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D466F36C5F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7ix14ylNVNq9xk8RS/lbmHp9KuIaAEFqi9oYH/LwuI=; b=anJ90OY+lV4VyKMZCdW2MmdsI7
	p3ZfGu31ig3Hpd1D3kHT1HYKK2+jDqt9X7DtBwghaN/+S1ubD+woFiimOEBIl8+o44OhcZG8i8Czn
	+QsY2d2USwNBovZh17wmTd11bTsjQFLIsDL3QdUHSBKQtbaDxAfEFiHymwvCA27WIdlBRGWkSIu1L
	++Jv16PT9mf2XEGpQ1nK7n4Dc8E4jSP51X+ezhj1K/L2Vkn4iL67bJTdTMwso2tayK8xYtUOzSB0P
	onRMWpicvv9laUqu515tXEVp2eADixhDam1DZepjpScd50RSXfgI9FKvT11y01SEWy4fGf7Id5q4P
	D/30ET1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnG8-00000006pUq-0gPD;
	Mon, 20 Apr 2026 11:57:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnG4-00000006pSO-0Bny
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 11:57:46 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JJndch2843024;
	Mon, 20 Apr 2026 11:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S7ix14ylNVNq9xk8R
	S/lbmHp9KuIaAEFqi9oYH/LwuI=; b=aQWHJOnjdlGUphJCdEYq24w8Ob8NVADps
	Jeo8enfXTEmgQalXZHVQugNY/G/vvA6AhH2djD3IHIpQoM12QmmwYPydFR91vPlR
	8hsc5pRgHUFkMPymZJr+VyI4Yp73Q0U4ur8CJJ+uTEKdC7JX4I3wC8C0Z41rx66M
	Go6w/kYGfYrf1M9WbYK0O6zR102DzwgHoPXAuQTeSVR+VZYEDLt+YRZj/XxYlUp2
	ufpwXHcv1zZ5jxdxUOLkEVIDzJDPiKZst17CnWmfyFrqG/mBAwqFXBkh8vbCaXa7
	1eaCy6KVvSWpjxUDatUOXkS23liBY7BUPLKXFV/Pe1WPuUIbwjDEA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6exrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KBoIL5000721;
	Mon, 20 Apr 2026 11:57:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvmq72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KBvPPN16384266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 11:57:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 170252004E;
	Mon, 20 Apr 2026 11:57:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C6C720049;
	Mon, 20 Apr 2026 11:57:23 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 11:57:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RFC PATCH 1/4] nvme-tcp: optionally limit I/O queue count based on NIC queues
Date: Mon, 20 Apr 2026 17:19:33 +0530
Message-ID: <20260420115716.3071293-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420115716.3071293-1-nilay@linux.ibm.com>
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e614a9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=PsUxD5LqhZwaP4J9xUUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfX8kZCgnec7pkN
 1CjxWq2bOr6C3xzmlXLfMbovpHtqNsY8I3w8Fmy3VUzJdzNHlJjby4CptwUl2s3GOXWTvoS+/au
 2BIT9QyHjApoFp7F0uNQ6A6fwCTLlzUe21jry7Rhll/breXklX17kYyAcDzNa54kSrEGXF2V8wY
 gF7iAfT2uaQ3Hy4v00nJ6+8Q+vaAcU4c3wYreu2MC36yjq21lBANjZKBkjfZcrDJ2NMcj7fV+CT
 joL612zJYzHLZ4gMkZ6B6QmG3kvoWGE1d7/hznxY+jUqAhWJXsZMfLvV63MmBqeXLm48lBWevNV
 OXkNR4PgB+gOQffqTXTZoM4dGbM6ouho6zwtvFnlgpNd3UjTKYRjY2uJY3FWI/ITTX1q/+Wnjsj
 sMBFH5DLVicJf8czMYrO+SPUAXEiroXnmu6xBACxETmBlsgo2F1LKKWamrfJEYwnO1xMV8QXAUj
 4pLnJvAdeX8XygWbavA==
X-Proofpoint-GUID: wx4XAc7ZXylLuVPTV_k5Q48xcPDJfULh
X-Proofpoint-ORIG-GUID: wx4XAc7ZXylLuVPTV_k5Q48xcPDJfULh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_045744_239967_396584F9 
X-CRM114-Status: GOOD (  24.00  )
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

NVMe-TCP currently provisions I/O queues primarily based on CPU
availability. On systems where the number of CPUs significantly exceeds
the number of NIC hardware queues, this can lead to multiple I/O queues
sharing the same NIC TX/RX queues, resulting in increased lock
contention, cacheline bouncing, and inter-processor interrupts (IPIs).

In such configurations, limiting the number of NVMe-TCP I/O queues to
the number of NIC hardware queues can improve performance by reducing
contention and improving locality. Aligning NVMe-TCP worker threads with
NIC queue topology may also help reduce tail latency.

Add a new transport option "match_hw_queues" to allow users to
optionally limit the number of NVMe-TCP I/O queues to the number of NIC
TX/RX queues. When enabled, the number of I/O queues is set to:

    min(num_online_cpus, num_nic_queues)

This behavior is opt-in and does not change existing defaults.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/fabrics.c |   4 ++
 drivers/nvme/host/fabrics.h |   3 +
 drivers/nvme/host/tcp.c     | 120 +++++++++++++++++++++++++++++++++++-
 3 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..62ae998825e1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -709,6 +709,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TLS,			"tls"			},
 	{ NVMF_OPT_CONCAT,		"concat"		},
 #endif
+	{ NVMF_OPT_MATCH_HW_QUEUES,	"match_hw_queues"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -1064,6 +1065,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->concat = true;
 			break;
+		case NVMF_OPT_MATCH_HW_QUEUES:
+			opts->match_hw_queues = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index caf5503d0833..e8e3a2672832 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,6 +67,7 @@ enum {
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
 	NVMF_OPT_CONCAT		= 1 << 28,
+	NVMF_OPT_MATCH_HW_QUEUES = 1 << 29,
 };
 
 /**
@@ -106,6 +107,7 @@ enum {
  * @disable_sqflow: disable controller sq flow control
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
+ * @match_hw_queues: limit controller IO queue count based on NIC queues (TCP)
  * @nr_write_queues: number of queues for write I/O
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
@@ -136,6 +138,7 @@ struct nvmf_ctrl_options {
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
+	bool			match_hw_queues;
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc8..7102a7a54d78 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -16,6 +16,8 @@
 #include <net/tls.h>
 #include <net/tls_prot.h>
 #include <net/handshake.h>
+#include <net/ip6_route.h>
+#include <linux/in6.h>
 #include <linux/blk-mq.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
@@ -1762,6 +1764,103 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl)
+{
+	struct net_device *dev = NULL;
+
+	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
+		dev = dev_get_by_name(&init_net, ctrl->opts->host_iface);
+	else {
+		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
+
+		if (tctrl->addr.ss_family == AF_INET) {
+			struct rtable *rt;
+			struct flowi4 fl4 = {};
+			struct sockaddr_in *addr =
+					(struct sockaddr_in *)&tctrl->addr;
+
+			fl4.daddr = addr->sin_addr.s_addr;
+			if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
+				addr = (struct sockaddr_in *)&tctrl->src_addr;
+				fl4.saddr = addr->sin_addr.s_addr;
+			}
+			fl4.flowi4_proto = IPPROTO_TCP;
+
+			rt = ip_route_output_key(&init_net, &fl4);
+			if (IS_ERR(rt))
+				return NULL;
+
+			dev = dst_dev(&rt->dst);
+			/*
+			 * Get reference to netdev as ip_rt_put() will
+			 * release the netdev reference.
+			 */
+			if (dev)
+				dev_hold(dev);
+
+			ip_rt_put(rt);
+
+		} else if (tctrl->addr.ss_family == AF_INET6) {
+			struct dst_entry *dst;
+			struct flowi6 fl6 = {};
+			struct sockaddr_in6 *addr6 =
+					(struct sockaddr_in6 *)&tctrl->addr;
+
+			fl6.daddr = addr6->sin6_addr;
+			if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
+				addr6 = (struct sockaddr_in6 *)&tctrl->src_addr;
+				fl6.saddr = addr6->sin6_addr;
+			}
+			fl6.flowi6_proto = IPPROTO_TCP;
+
+			dst = ip6_route_output(&init_net, NULL, &fl6);
+			if (dst->error) {
+				dst_release(dst);
+				return NULL;
+			}
+
+			dev = dst_dev(dst);
+			/*
+			 * Get reference to netdev as dst_release() will
+			 * release the netdev reference.
+			 */
+			if (dev)
+				dev_hold(dev);
+
+			dst_release(dst);
+		}
+	}
+
+	return dev;
+}
+
+static void nvme_tcp_put_netdev(struct net_device *dev)
+{
+	if (dev)
+		dev_put(dev);
+}
+
+/*
+ * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
+ * be determined.
+ */
+static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
+{
+	struct net_device *dev;
+	int tx_queues, rx_queues;
+
+	dev = nvme_tcp_get_netdev(ctrl);
+	if (!dev)
+		return 0;
+
+	tx_queues = dev->real_num_tx_queues;
+	rx_queues = dev->real_num_rx_queues;
+
+	nvme_tcp_put_netdev(dev);
+
+	return min(tx_queues, rx_queues);
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -2144,6 +2243,24 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;
 
+	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES) &&
+			(ctrl->opts->mask & NVMF_OPT_MATCH_HW_QUEUES)) {
+		int nr_hw_queues;
+
+		nr_hw_queues = nvme_tcp_get_netdev_current_queue_count(ctrl);
+		if (nr_hw_queues <= 0)
+			goto init_queue;
+
+		ctrl->opts->nr_io_queues = min(nr_hw_queues, num_online_cpus());
+
+		if (ctrl->opts->nr_io_queues < num_online_cpus())
+			dev_info(ctrl->device,
+				"limiting I/O queues to %u (NIC queues %d, CPUs %u)\n",
+				ctrl->opts->nr_io_queues, nr_hw_queues,
+				num_online_cpus());
+	}
+
+init_queue:
 	nr_io_queues = nvmf_nr_io_queues(ctrl->opts);
 	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
 	if (ret)
@@ -3019,7 +3136,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
-			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
+			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY |
+			  NVMF_OPT_CONCAT | NVMF_OPT_MATCH_HW_QUEUES,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.53.0


