Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28483C5DF94
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O7a7XwNn4+xBKAfhB/h+dFnKxtAzQAlKLqXIF9+3fG4=; b=y+8IsEVZWYtTSNBmIPiJ1KZQPX
	cp7MJumnCZwMrEF/9ieQHPn3DWTYxJrhdTbHOtNb4GAC907QUvHIPz159y/BD1ncHaNJ9p5pUNkBc
	CD5HqKNcCA7nDrZYCliJ4ztjSAoaK0EHnhr/bRs42GjVWTfv1VIAD6kFvZt4Xfd7wrQPsBO2MWJpP
	Q0YfX8DuDuARu7KH5FnfuRMVqajScJq4ywhN/IVUqAkeo9PMxqDWY1h2BNdcishScQcDLRF/UcRTF
	YJZ6oGYqDyhHest7iOOicU+OKttwumF676b/ckEl0StU/UkwKDCF7hoIJUuA/7InBtyz8yW2pJiYz
	i611Uwpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQTg-0000000DaLA-2nNl;
	Fri, 21 Aug 2026 14:44:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQTg-0000000DaKP-0z8o
	for linux-nvme@bombadil.infradead.org;
	Fri, 21 Aug 2026 14:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O7a7XwNn4+xBKAfhB/h+dFnKxtAzQAlKLqXIF9+3fG4=; b=DX+oJYT80/A9yHL2Zf/o8OFmBm
	Yw7mMnBLVOxexKBG6grp2zZte5PUT6M4uqvuFyjbtEUWPzwVL9aBxnLqd/NijP3PiXBmmxS/T4aCZ
	+fBmBRZ0K60vJKQbuoKMI7oONm45cqgQ5snvHeO6ZaNcn48pWkqmrHQQ8tdWvZ2thn5+llJt4YKdn
	6oqhLRR3V1s+nntSaPeWnflraTNsW+Y7GKF0jzJaTxSZm45/+M/zC8MBWDpKZrXnkzKPabOlri2u4
	hU800q08kQsL0+QIIpXhReXm4T3LR8gIwQGPFHBcrd/c69SxodB1gLiSv80HqgQjsc2tzVMW++CY0
	aLdeL8UA==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wxQTc-00000003r1m-3xJ0
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 14:44:14 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD1Y6f1585716;
	Fri, 21 Aug 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O7a7XwNn4+xBKAfhB
	/h+dFnKxtAzQAlKLqXIF9+3fG4=; b=T1HOEj4LAArRrCwGrBmm/QIJT4dvyNePj
	v7FdS/DDu+S+H0WnHBJxMIAY7JVS9Xxbb44B8uOJWPyJfRbuG4rlRW3HffGAOBC+
	1SYrcOMMrY9N6/Mcbhl1HlLGmZniDapROZXNOZZ/NAV8inWsEbqMsm11yn6z+37c
	S55gnmLY4wC9x6uMzUaUKyVzuNqZ4ATW/2v0PReb0/A8zZ8VXQVMN9nUD/REMQML
	BgBDa2vReRmLUdf4v78aS7z1Vy6QxT1j3MyfYuGyPKdMezO438y4Gw3f0TGOXZc1
	PwE42TWFae4tSsDWJMSrgzxI8mEzHcosUdCy1DA0wN0COzo9g/yOw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0t779-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:44:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LEfVFH018281;
	Fri, 21 Aug 2026 14:44:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twn9hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:44:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LEi01d41484648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 14:44:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D879C2004B;
	Fri, 21 Aug 2026 14:44:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D3820043;
	Fri, 21 Aug 2026 14:43:56 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.26.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 14:43:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 3/3] fabrics: determine --nr-io-queues when not explicitly specified
Date: Fri, 21 Aug 2026 20:13:14 +0530
Message-ID: <20260821144329.3620389-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821144329.3620389-1-nilay@linux.ibm.com>
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a886436 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4Zvwdy8uwoTmSW9LlBgA:9
X-Proofpoint-ORIG-GUID: UxKt1I-Uv4VhVTgzIyZckSu4rF4b49bH
X-Proofpoint-GUID: UxKt1I-Uv4VhVTgzIyZckSu4rF4b49bH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfX66kIcyHV49ZK
 hIpiZNvlXzCzi6KVyOUsgIMUnmy3eD6fEMMTdEdHKrhvkCtqGxj7zOF0E2Cermx/UphGlqACJCD
 DTu0dpSRIX3GsHPaU1BuOzjp51x0pAQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfXx3ksdyba94mA
 66QJQXf+iIiI1nRoisc7wHneZRQ8vT/hy1GYAa6xKA+O9e7KEmsAz7yNnDd9yXbE3/9C4zzZB9N
 XIlaDKJD7zGaQcNAvg7gTTjrVjdTyataCmRKNmVpx2fMS4O3sKZK2sUzl4teqRMxVfQxiBful7r
 8RLcd0lJT2AKApeHqwqqTQhLQfT4Z2ZmBkWLYsWb4wnuQiW0SrQ6yBuz2+mAj8sCHUaY4ly+C+7
 fGo1V5k+p9X1wIwa0XulfrhclDxekb8oB2MXSudOOJIEkZ/nEdUk/wFZ96swabOCm+VaAFelnlg
 D5NHzElGXVl6nZTC4V82CKnMlj50HLwtsNDd5PHLD5bwnLtU59LKlNthuoWbk8UG3b4K4zo+Bv9
 uRruju5HA+8Qm3UIyCbZRiSAcThSRi6Fb6HzEXND/+5vVxNWC6VgC5ClVceqSkOECuDp/0HdrWg
 svOpB3rYdoQ7F/+lxEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_154413_465416_1B496B01 
X-CRM114-Status: GOOD (  21.99  )
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

	min(nr_hw_queues, num_online_cpus)

Here, nr_hw_queues represents the number of hardware queues currently
configured on the NIC used for the NVMe/TCP connection. Use the
shr_route_get_egress_iface() and shr_netdev_get_hw_queues() helpers to
determine the egress netdev and retrieve its hardware queue count.
Use get_nprocs() to determine the number of online CPUs.

Apply the same logic when connecting to the target using a config INI
file.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 src/fabrics.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/src/fabrics.c b/src/fabrics.c
index ad98c0e38..a640929b6 100644
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
@@ -424,6 +428,48 @@ static int build_conn_tid(const struct libnvmf_config_conn *conn,
 			hostnqn, hostid, tid);
 }
 
+/*
+ * On success returns num of I/O queues and returns 0 on failure or when it's
+ * not possible to determine the I/O queues.
+ */
+static int fabrics_connect_nr_io_queues(const char *transport,
+					const char *traddr,
+					const char *host_traddr,
+					const char *host_iface)
+{
+	uint32_t combined_count, tx_count, rx_count;
+	char ifname[IF_NAMESIZE] = {};
+	int nr_cpus, nr_hw_queues;
+
+	if (strcmp(transport, "tcp"))
+		return 0;
+
+	nr_cpus = get_nprocs();
+	if (nr_cpus <= 0)
+		return 0;
+
+	if (host_iface) {
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
+	else
+		return 0;
+
+	return min(nr_cpus, nr_hw_queues);
+}
+
 /* libnvmf_config_conn_for_each() callback: settle addressing/identity,
  * check exclusion, then discover or connect.
  */
@@ -435,6 +481,8 @@ static void consume_conn(const struct libnvmf_config_conn *conn,
 	struct hook_fabrics_data hfd = { .flags = st->flags, .raw = st->raw };
 	__cleanup_nvmf_context struct libnvmf_context *fctx = NULL;
 	__cleanup_nvmf_tid struct libnvmf_tid *tid = NULL;
+	const struct libnvmf_params *params;
+	const char *key = "nr-io-queues";
 	int err;
 
 	if (st->mode == CONSUME_ROLE_BASED && !is_dc && !st->connect)
@@ -460,9 +508,29 @@ static void consume_conn(const struct libnvmf_config_conn *conn,
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
 
@@ -1059,6 +1127,9 @@ int fabrics_connect(const char *desc, int argc, char **argv)
 	if (ret)
 		return ret;
 
+	if (!fa.nr_io_queues)
+		fa.nr_io_queues = fabrics_connect_nr_io_queues(fa.transport,
+				      fa.traddr, fa.host_traddr, fa.host_iface);
 do_connect:
 	ret = nvme_create_global_ctx_hostnqn(&ctx,
 		fa.hostnqn, fa.hostid, &hnqn, &hid);
-- 
2.53.0


