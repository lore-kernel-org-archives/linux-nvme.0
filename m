Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D17FC982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yORkPv23ZTTojjsGJViX8+7IzLoDTwBN/g5/FVlVz7M=; b=JClJGGxPJ0e6x146o3k2nrhE11
	5CTrmFMYmVN7jTDdBjByAxsTrccnbJI7+TNTHFMOVFXkYcnycHeHvHRL2x1tW1djUh8ye2x7VmIyK
	nIqoxDSW+wavFRP6VqLplMSacauvKC3QM5hLuRZlCbQEO+jdchQ1Ibo7dxEWzZGqTqD5XrPTOCUx/
	mqPF4QSXGJO1wguR/YGJvNzKseoLDUj/FvufyczgjYJc10/EgM2FwXFpBsLAxIsVwzQ1hymAAQKsX
	Psv8ndP4M+ajoH55n6WyL9n6SMt0aETlpTygkIJA1MFXoBGx3jL4zh+U7RvJhtKuErL7hfsWq2BAF
	GcHwVZ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsV-00000001H8n-35Nb;
	Mon, 21 Sep 2026 07:55:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsT-00000001H6l-0IlE
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:55:54 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZbS3863245;
	Mon, 21 Sep 2026 07:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yORkPv23ZTTojjsGJ
	ViX8+7IzLoDTwBN/g5/FVlVz7M=; b=mcZTI3c4XnecvJx7RlZyA3yDU/rBN5xHI
	Zxjq/+fhismODGYzjQEPIa+oLGToKjD/XQrhUFuTkysp8LPdvGqTYZndPNzfiYBn
	kzhs1Zej617bzDOiqd3AjyiWiXyWfuBpbKcKclkRJafe5fBc3qMq75lOeyT3Cdln
	pcPw1LXZNF8j9iVMhOSdU2N53bVrxtLEpbGBEjEW1MTO5FJVYNplPXUKZxj5Tj5q
	EemhfEfUFYcXhjfMfQJ9B3ggIxj9CQuzFKXvuTyYK11ignl2vJRjbND1UZILQF2z
	4Dw4kt5gi/vWjQiJ5otCjRofIdT4GvbfIFAPrW+b/EdhJWp/7skiw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduy89m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HwEd844286;
	Mon, 21 Sep 2026 07:55:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjmba8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L7tfpV14549502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 07:55:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 803C420043;
	Mon, 21 Sep 2026 07:55:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BE4020040;
	Mon, 21 Sep 2026 07:55:36 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.138.180])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 07:55:35 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, sagi@grimberg.me, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 3/4] shared: add more test coverage for net-util
Date: Mon, 21 Sep 2026 13:25:01 +0530
Message-ID: <20260921075511.2108561-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921075511.2108561-1-nilay@linux.ibm.com>
References: <20260921075511.2108561-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xk-mAwy3NlO6EuN42l2dStyXGgdmVgNR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX1kI9QvJtrDR5
 yM7pxBai/6uy6wlHJ0tqhEuxlH+SLoRoWXdNfKAjkzlTtix0Mr3TFe5KvpbN9x6d/oRkmXFv7pq
 IuowTgmVzUPlkeQeNGgf8AW1br8JqjE=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0e302 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=d4-a_fHTn4INfz5tyfYA:9
X-Proofpoint-GUID: xk-mAwy3NlO6EuN42l2dStyXGgdmVgNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX0K5pJsQDWQQk
 y8ToMTuLHqvSidVlQkzO4uZ0QP2FhYounQNOwoFPmOihcqyJvAal1w4NbtP27l0dkyjWsBek+tU
 0qT/GRpOkopdbKbRpNnQT11FOlstTwZQPMTcwwp3q80d4gB1IXRRPAIH/Dflf8H706tQixq71UZ
 i1ymkRMP5GSRlqzps7ePLFYnAmATr0tW9caF9tVu5KC3JtBKIknzlPNmNJi9GiBX0xEgIa8EKg1
 1awh0Qxq0izJw10kN8VhmNxeMRgf38raH961MjBhivceLlxLKqx17UH2O+Ery4zLrbqfnzz9TV5
 PztWsjeyXcoKT7XPwICJOGKS8ykV5cL44xRawKT8XsZzZmIGESwM4zoBfF8zjBbHNlm6ylKgzGf
 UOYELmb8TNGa3limX4y5s8e3sKiEfq6qWhxabuIhhUHIwyxwPhhssLyQjKngoClgqoDUWBg/XIh
 b9ElVPtALOBhMPEJz8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_005553_228880_2E9F05D9 
X-CRM114-Status: GOOD (  14.21  )
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

Add test covergare for shr_route_get_egress_iface()
and shr_netdev_get_hw_queues().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 shared/tests/test-net-util.c | 117 +++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/shared/tests/test-net-util.c b/shared/tests/test-net-util.c
index e1ec62e5f..e7ffc5e68 100644
--- a/shared/tests/test-net-util.c
+++ b/shared/tests/test-net-util.c
@@ -7,7 +7,9 @@
  */
 
 #include <arpa/inet.h>
+#include <errno.h>
 #include <ifaddrs.h>
+#include <net/if.h>
 #include <netinet/in.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -42,6 +44,17 @@ static bool check_str(const char *name, const char *got, const char *want)
 	return false;
 }
 
+static bool check_ret(const char *name, int got, int want)
+{
+	if (got == want) {
+		printf(" - %s [PASS]\n", name);
+		return true;
+	}
+
+	printf(" - %s: got %d, want %d [FAIL]\n", name, got, want);
+	return false;
+}
+
 static bool test_ipaddrs_eq(void)
 {
 	/*
@@ -178,6 +191,108 @@ static bool test_iface_primary_addr_matches(void)
 	return pass;
 }
 
+static bool test_route_get_egress_iface(void)
+{
+	char ifname[IF_NAMESIZE];
+	char small_buf[8];
+	bool pass = true;
+	int ret;
+
+	printf("test_route_get_egress_iface:\n");
+
+	/* Invalid arguments */
+	pass &= check_ret("NULL daddr fails with -EINVAL",
+			  shr_route_get_egress_iface(NULL, NULL, ifname,
+					  sizeof(ifname)),
+			  -EINVAL);
+	pass &= check_ret("invalid daddr string fails with -EINVAL",
+			  shr_route_get_egress_iface(NULL, "invalid_ip",
+					  ifname, sizeof(ifname)),
+			  -EINVAL);
+	pass &= check_ret("invalid saddr string fails with -EINVAL",
+			  shr_route_get_egress_iface("invalid_ip", "127.0.0.1",
+					  ifname, sizeof(ifname)),
+			  -EINVAL);
+	pass &= check_ret("mismatched saddr IPv4 and daddr IPv6 families fails with -EINVAL",
+			  shr_route_get_egress_iface("127.0.0.1", "::1",
+					  ifname, sizeof(ifname)),
+			  -EINVAL);
+	pass &= check_ret("mismatched saddr IPv6 and daddr IPv4 families fails with -EINVAL",
+			  shr_route_get_egress_iface("::1", "127.0.0.1",
+					  ifname, sizeof(ifname)),
+			  -EINVAL);
+	pass &= check_ret("buffer smaller than IF_NAMESIZE fails with -EINVAL",
+			  shr_route_get_egress_iface(NULL, "127.0.0.1",
+					  small_buf, sizeof(small_buf)),
+			  -EINVAL);
+
+	/* Valid lookups (loopback routes always present) */
+	memset(ifname, 0, sizeof(ifname));
+	ret = shr_route_get_egress_iface(NULL, "127.0.0.1", ifname,
+			sizeof(ifname));
+	pass &= check_ret("IPv4 loopback destination lookup returns 0", ret, 0);
+	pass &= check_str("IPv4 loopback egress interface is lo", ifname, "lo");
+
+	memset(ifname, 0, sizeof(ifname));
+	ret = shr_route_get_egress_iface("127.0.0.1", "127.0.0.1", ifname,
+			sizeof(ifname));
+	pass &= check_ret("IPv4 loopback src and dst lookup returns 0", ret, 0);
+	pass &= check_str("IPv4 loopback src/dst egress interface is lo",
+			ifname, "lo");
+
+	memset(ifname, 0, sizeof(ifname));
+	ret = shr_route_get_egress_iface(NULL, "::1", ifname, sizeof(ifname));
+	pass &= check_ret("IPv6 loopback destination lookup returns 0", ret, 0);
+	pass &= check_str("IPv6 loopback egress interface is lo", ifname, "lo");
+
+	memset(ifname, 0, sizeof(ifname));
+	ret = shr_route_get_egress_iface("::1", "::1", ifname, sizeof(ifname));
+	pass &= check_ret("IPv6 loopback src and dst lookup returns 0", ret, 0);
+	pass &= check_str("IPv6 loopback src/dst egress interface is lo",
+			ifname, "lo");
+
+	return pass;
+}
+
+static bool test_netdev_get_hw_queues(void)
+{
+	uint32_t combined, tx, rx;
+	bool pass = true;
+	int ret;
+
+	printf("test_netdev_get_hw_queues:\n");
+
+	/* Invalid arguments */
+	pass &= check_ret("NULL ifname fails with -EINVAL",
+			  shr_netdev_get_hw_queues(NULL, &combined, &tx, &rx),
+			  -EINVAL);
+	pass &= check_ret("NULL combined_count fails with -EINVAL",
+			  shr_netdev_get_hw_queues("lo", NULL, &tx, &rx),
+			  -EINVAL);
+	pass &= check_ret("NULL tx_count fails with -EINVAL",
+			  shr_netdev_get_hw_queues("lo", &combined, NULL, &rx),
+			  -EINVAL);
+	pass &= check_ret("NULL rx_count fails with -EINVAL",
+			  shr_netdev_get_hw_queues("lo", &combined, &tx, NULL),
+			  -EINVAL);
+
+	/* Non-existent interface */
+	pass &= check_ret("non-existent interface fails with -ENODEV",
+			  shr_netdev_get_hw_queues("nonexistent99", &combined,
+					  &tx, &rx),
+			  -ENODEV);
+
+	/*
+	 * Querying loopback interface ("lo") or an interface without ethtool
+	 * channel support typically returns -EOPNOTSUPP (or 0 if supported).
+	 */
+	ret = shr_netdev_get_hw_queues("lo", &combined, &tx, &rx);
+	pass &= check_bool("querying loopback interface returns 0 or -EOPNOTSUPP",
+			   (ret == 0 || ret == -EOPNOTSUPP), true);
+
+	return pass;
+}
+
 int main(void)
 {
 	bool pass = true;
@@ -185,6 +300,8 @@ int main(void)
 	pass &= test_ipaddrs_eq();
 	pass &= test_iface_matching_addr();
 	pass &= test_iface_primary_addr_matches();
+	pass &= test_route_get_egress_iface();
+	pass &= test_netdev_get_hw_queues();
 
 	fflush(stdout);
 	exit(pass ? EXIT_SUCCESS : EXIT_FAILURE);
-- 
2.53.0


