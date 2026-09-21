Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F600C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5zYeFcIAWHXUtPm7GGc71e+2EMWQ7LatMexM40xraU=; b=xjex9tjEZSrlzeCYQ+hvlmWZOE
	5LxPKfWckIpvaxlS+3zLVuagDF4DVLfFitB8qardeAkBT7nzZLK5K6oTZq7GdMnx7ktiSPOhUvJ6l
	CteqNIwghXfZHTP1yi8rMoO0Mi/82qrGqpsEg8mpzTUEvgs3ysBCG14N7byCXrM+KLElxNMQTDcvx
	d0Ft4dRUHEg0/AhZMHcN6tc6kQ7XREuFe8WmU99iGqAq8LhY8nyvIxA6nihUsLspX5LHrzwHNd4Sv
	+sU2jG23Njn9EBdXVgKxAEuXq05Asvtmz21Mfeb0DG4G7pbVTo4Q3UkricdUmJm40UCsxe1nvUdSl
	SUYgJcEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsX-00000001HAg-3fKq;
	Mon, 21 Sep 2026 07:55:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsV-00000001H8F-13WL
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:55:56 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7Zc3O3856876;
	Mon, 21 Sep 2026 07:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v5zYeFcIAWHXUtPm7
	GGc71e+2EMWQ7LatMexM40xraU=; b=PI/L69uO8fQx7uuhmjiJMY/GkwcQ0cWWj
	YAXH1b+9C95TM84MD4PcIyEH3ZdcvRzvK7N4lbmQ8M8PB6ru1Nj2+n/67qK5DjSz
	5VeTPZaCWEyZ7y1LvpKVbJv6z7okwLLtGfTYmr+CCW+CdvsVKQGyp2PdR1YVrhAo
	atgLNXrJkHe51N3kJ2oUQ7rPU/0Cok11mDU8HxArFI6FkV73SbtT6B6SmZAtAzCM
	s5mP5hkmEY6n5L+jKvJOyFkD7t1XEpb+m11mfNb70rtWyaoY7XRi6D6a22RXQbRn
	luYLba7FcM1S4cH4jjD0rbzhLusS3hpYLHJv4TTxZvE89d8DVVKPw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq76py-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HVB7924416;
	Mon, 21 Sep 2026 07:55:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq4g9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L7tlrW50266396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 07:55:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16D212004B;
	Mon, 21 Sep 2026 07:55:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B3D220043;
	Mon, 21 Sep 2026 07:55:42 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.138.180])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 07:55:41 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, sagi@grimberg.me, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 4/4] fabrics: determine --nr-io-queues when not explicitly specified
Date: Mon, 21 Sep 2026 13:25:02 +0530
Message-ID: <20260921075511.2108561-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921075511.2108561-1-nilay@linux.ibm.com>
References: <20260921075511.2108561-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab0e307 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4Zvwdy8uwoTmSW9LlBgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX0ltnqZQO/R1Y
 3zaJWQhMu2J4HoNnusOqQkRJtFpDu6Xdo/mejCO/J2V52h7Dh6VnhOyebf+2mGyNSJKU6agjaYA
 FT9d4KLHh8J8o0+s0/XWmadTbdCnGaIodIkWNjqdFz/IyjHWCbfJI1zGY8YNwDWaBIln4y5mKZU
 7iIZ+nay8Xk254OCUQHBOyNfqXhINuA/+VbtClXxcOEtHQjUHSoM8LJk0PXfjGgS2wHIutu01rJ
 9jY8XS2atLl0AFIyJFROK1lBJEanLT2fl02HmWmYa8UoYp1VbVhL+hpYN/lwewwiXoM/N9zIAvZ
 ohaK44CjC+PEIF3iVMYFFa48YcXQTXx0Gzxl3lEbUW61g9B7rOFOjAsbCLKLt5vKkfsrbaTzNV+
 KfrjCqneG5JZKqx6wa7ZpEsNqG1jmivHmO28AdXGKD4PN2XyacVUA8rpqAg7iZElSwrFGL46Wrk
 1WZghPZ79+eKw4nzL/g==
X-Proofpoint-ORIG-GUID: 4iXzHWWHj3yu_AAYos7-iuelhOxBdSCK
X-Proofpoint-GUID: 4iXzHWWHj3yu_AAYos7-iuelhOxBdSCK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX4pUfi9B1QAH0
 TFZFC+SdEtQ54OHE72Skpra8sEz1T3cADBjneZ8bCyglm5jGIrQd8H55qt7ZvSe8mNSlJ2qDfJz
 iW5fIY/LJWRHB+lGuZ0qArbFkaV17GI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_005555_405199_1EC214E7 
X-CRM114-Status: GOOD (  24.97  )
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

When performing an NVMe/TCP connect operation, if the user does not
explicitly specify --nr-io-queues, determine the default value using:

	if (nr_hw_queues > 1)
		min(nr_hw_queues, num_online_cpus)

Here, nr_hw_queues represents the number of hardware queues currently
configured on the NIC used for the NVMe/TCP connection. If nr_hw_queues
cannot be retrieved, or the NIC only supports one hardware queue, do
not calculate nr-io-queues and let the host determine the value.

Use the shr_route_get_egress_iface() and shr_netdev_get_hw_queues()
helpers to determine the egress netdev and retrieve its hardware
queue count. Use get_nprocs() to determine the number of online CPUs.

Apply the same logic when connecting to the target using a config INI
file.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/fabrics.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/src/fabrics.c b/src/fabrics.c
index f5f1327ad..f5e71fdb8 100644
--- a/src/fabrics.c
+++ b/src/fabrics.c
@@ -19,17 +19,20 @@
  * Fabrics specification standard.
  */
 
+#include <ccan/minmax/minmax.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <getopt.h>
 #include <inttypes.h>
 #include <libgen.h>
+#include <net/if.h>
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/stat.h>
+#include <sys/sysinfo.h>
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
@@ -49,6 +52,7 @@
 #include <ccan/endian/endian.h>
 #include <ccan/str/str.h>
 #include <shared/io-util.h>
+#include <shared/net-util.h>
 #include <shared/sig-util.h>
 
 #include "cleanup.h"
@@ -424,6 +428,50 @@ static int build_conn_tid(const struct libnvmf_config_conn *conn,
 			hostnqn, hostid, tid);
 }
 
+/*
+ * Return the number of I/O queues on success. Return 0 if the number
+ * cannot be determined or the NIC has only one hardware queue, in
+ * which case the host should determine the number of I/O queues.
+ */
+static int fabrics_connect_nr_io_queues(const char *transport,
+					const char *traddr,
+					const char *host_traddr,
+					const char *host_iface)
+{
+	uint32_t combined_count, tx_count, rx_count;
+	char ifname[IF_NAMESIZE] = {};
+	int nr_cpus, nr_hw_queues = 0;
+
+	if (strcmp(transport, "tcp"))
+		return 0;
+
+	nr_cpus = get_nprocs();
+	if (nr_cpus <= 0)
+		return 0;
+
+	if (host_iface && host_iface[0]) {
+		strncpy(ifname, host_iface, IF_NAMESIZE - 1);
+	} else {
+		if (shr_route_get_egress_iface(host_traddr, traddr,
+				ifname, IF_NAMESIZE))
+			return 0;
+	}
+
+	if (shr_netdev_get_hw_queues(ifname, &combined_count,
+			&tx_count, &rx_count))
+		return 0;
+
+	if (combined_count)
+		nr_hw_queues = combined_count;
+	else if (tx_count && rx_count)
+		nr_hw_queues = min(tx_count, rx_count);
+
+	if (nr_hw_queues <= 1)
+		return 0;
+
+	return min(nr_cpus, nr_hw_queues);
+}
+
 /* libnvmf_config_conn_for_each() callback: settle addressing/identity,
  * check exclusion, then discover or connect.
  */
@@ -435,6 +483,8 @@ static void consume_conn(const struct libnvmf_config_conn *conn,
 	struct hook_fabrics_data hfd = { .flags = st->flags, .raw = st->raw };
 	__cleanup_nvmf_context struct libnvmf_context *fctx = NULL;
 	__cleanup_nvmf_tid struct libnvmf_tid *tid = NULL;
+	const struct libnvmf_params *params;
+	const char *key = "nr-io-queues";
 	int err;
 
 	if (st->mode == CONSUME_ROLE_BASED && !is_dc && !st->connect)
@@ -460,9 +510,29 @@ static void consume_conn(const struct libnvmf_config_conn *conn,
 		goto record_err;
 
 	err = libnvmf_context_set_connection_from_tid(fctx, tid);
-	if (!err)
-		err = libnvmf_context_apply_params(fctx,
-				libnvmf_config_conn_get_params(conn));
+	if (err)
+		goto record_err;
+
+	params = libnvmf_config_conn_get_params(conn);
+	if (!libnvmf_params_get(params, key)) {
+		int nr_io_queues;
+
+		nr_io_queues = fabrics_connect_nr_io_queues(
+				libnvmf_config_conn_get_transport(conn),
+				libnvmf_config_conn_get_traddr(conn),
+				libnvmf_config_conn_get_host_traddr(conn),
+				libnvmf_config_conn_get_host_iface(conn));
+
+		if (nr_io_queues) {
+			char val[32];
+
+			snprintf(val, sizeof(val), "%d", nr_io_queues);
+			libnvmf_params_set((struct libnvmf_params *)params,
+					key, val);
+		}
+	}
+
+	err = libnvmf_context_apply_params(fctx, params);
 	if (err)
 		goto record_err;
 
@@ -1064,6 +1134,9 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 		return ret;
 	fa.traddr = resolved_traddr;
 
+	if (!fa.nr_io_queues)
+		fa.nr_io_queues = fabrics_connect_nr_io_queues(fa.transport,
+				      fa.traddr, fa.host_traddr, fa.host_iface);
 do_connect:
 	ret = nvme_create_global_ctx_hostnqn(&ctx,
 		fa.hostnqn, fa.hostid, &hnqn, &hid);
-- 
2.53.0


