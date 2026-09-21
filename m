Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18AEC982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=POmwUgmTDjFFH/SwQLQEld+3wE4pujNaFKDOrKjj3HA=; b=dSBMMSoGBXXz8p2UWJrdS1quI2
	mshEncrV26KyTz2+WXpUM+DxMTXlgyxyQRThXbCgb/pXOG7KbD8f179TbZyffHeMgqHdXjBjFp+PB
	Xx1IOVKU9sA+Gh8U4UUTxCjm/qgABBd29XtRgaGdA8FvewONzxrl4x5ZqKnHZCePU5awepA1IrGDe
	ibp9Ax8tXos1o4YLVquXHlXotec9htbl/sNTvn9nbXWuyZjxaF3omAmU0A+mikONtK1Q9WgCJWVdh
	h/PRjiB1ggf1qqaohhiZWCYIesdyLSfKpSudfWn3ulZ5On1uusZNnj4B5aAXEIwfADxtaC8yKyGtZ
	t8LOBbyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsO-00000001H46-2EYc;
	Mon, 21 Sep 2026 07:55:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsM-00000001H3A-41IE
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:55:48 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZYkM818981;
	Mon, 21 Sep 2026 07:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=POmwUgmTDjFFH/SwQ
	LQEld+3wE4pujNaFKDOrKjj3HA=; b=eg2D0M5f5UZMSvXPe3pCLRPqwOqfho7fx
	08iPibidYH9XUOgk83HdI534YbnxXOyBuX2BsbSpILNgV+Fa4wY1t6CDWFghAvV0
	u93yesolCwdn2FE08GFoqJou5iiGGynNujb1BlTO5tDS47JNVb9AwhdHyUZirEJ4
	+TZH5L7IXPS1JZH5gyoSwXenVYE2CKd8oS1gXxPl3Oh+xgeU1qKQMeN3yQgrTqiR
	8+yg8Ym1IIJCLXPOGsufg8AQuwhvWjSWT4Hb+CRySy/vT/2r1xhIx1rcgmJHp0YA
	YsK2+NYUyGCnCzsSoGk5/OSTKvpvt7RyTB5TpRq5GW7oKmQdYIsEw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg27d3v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HnUG887490;
	Mon, 21 Sep 2026 07:55:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gm9vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L7tZrr33816980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 07:55:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A504320043;
	Mon, 21 Sep 2026 07:55:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 889CB20040;
	Mon, 21 Sep 2026 07:55:30 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.138.180])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 07:55:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, sagi@grimberg.me, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 2/4] shared/net-util-linux: add support for retrieving NIC h/w queues
Date: Mon, 21 Sep 2026 13:25:00 +0530
Message-ID: <20260921075511.2108561-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921075511.2108561-1-nilay@linux.ibm.com>
References: <20260921075511.2108561-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7mhfuF9wJUZi0mlpCKPA_E6lUfPcfaGJ
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab0e2fc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VfOP8DvaSo2KLmbhT-sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX+2OKZWPK3y1P
 1qeCpmjsluyu+Q4JYWCRGjTbE0I8g+l8gZQwObkcK5VPI187u0LnQXmWgnGRrSnSyhk56VpJm0i
 0DyNS8Ye4c0aEZARwODB0fSDlWx1bP4FXF8Ns+k02iXrF2I1cSfi3lSWCxY61MnLwevdCnGCcL7
 QKb187i3pF1UL3pfbh2pNnzmkcuYuUwSFgdA2jpMhpqj0GglRUVdfPq5pfhDPLfU7RRfqCu2a9E
 4DTToB+hCX+lTn9pUl6Gnm49EpGd/hanVnmG7BExp+/dLCA0QPgZrBOXYfvnk4oT6IosqmRxw/Y
 8uFopr2VlL2Hz5PgUZZHyx9Y1oMwQVeBRlDndeWA48ARqxuWjO4MYMYmzrSiBdR/2SaJw+LFL4J
 OqL0x2yx/Nfu+pBCo74IWrIK/TG8XDUWybHbk0hiHOyYByITlqGdDKOsNVU4qOOB3jA4GVckEEK
 uP40S37sAJCfp0CgFDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX5s0Qb4DSn8xA
 fWegA6qKcTzE3gX2rYui1d7eQ9bqSEQgIYIJhur/Qnp7Vs4rEo7tJod6RsqqjBlWftxJ9TKCawP
 1b7I60QtGUge0o4zM2CBbuGn3m2SZ98=
X-Proofpoint-GUID: 7mhfuF9wJUZi0mlpCKPA_E6lUfPcfaGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_005547_007678_E8AE5E80 
X-CRM114-Status: GOOD (  16.51  )
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

Add a new shared helper, shr_netdev_get_hw_queues(), which retrieves the
NIC h/w queue details using ethtool ioctl ETHTOOL_GCHANNELS.

This is a preparatory patch. A subsequent patch will use this helper
to determine the h/w queue details when calculating the default
--nr-io-queues value for NVMe/TCP connections.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 shared/net-util-linux.c | 37 +++++++++++++++++++++++++++++++++++++
 shared/net-util.h       | 16 ++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/shared/net-util-linux.c b/shared/net-util-linux.c
index b44430f38..110c01c13 100644
--- a/shared/net-util-linux.c
+++ b/shared/net-util-linux.c
@@ -9,13 +9,16 @@
 #include <arpa/inet.h>
 #include <asm/types.h>
 #include <errno.h>
+#include <linux/ethtool.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
+#include <linux/sockios.h>
 #include <net/if.h>
 #include <netinet/in.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <unistd.h>
 
@@ -409,3 +412,37 @@ out:
 	close(fd);
 	return ret;
 }
+
+int shr_netdev_get_hw_queues(const char *ifname, uint32_t *combined_count,
+		uint32_t *tx_count, uint32_t *rx_count)
+{
+	struct ethtool_channels chan = {};
+	struct ifreq ifr = {};
+	int fd, ret = 0;
+
+	if (!ifname || !combined_count || !tx_count || !rx_count)
+		return -EINVAL;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		fprintf(stderr, "opening socket failed\n");
+		return -errno;
+	}
+
+	chan.cmd = ETHTOOL_GCHANNELS;
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
+	ifr.ifr_data = (void *)&chan;
+
+	if (ioctl(fd, SIOCETHTOOL, &ifr) < 0) {
+		fprintf(stderr, "SIOCETHTOOL failed\n");
+		ret = -errno;
+		goto out;
+	}
+
+	*combined_count = chan.combined_count;
+	*tx_count = chan.tx_count;
+	*rx_count = chan.rx_count;
+out:
+	close(fd);
+	return ret;
+}
diff --git a/shared/net-util.h b/shared/net-util.h
index 0208923e5..59d201210 100644
--- a/shared/net-util.h
+++ b/shared/net-util.h
@@ -8,6 +8,7 @@
 #pragma once
 
 #include <ifaddrs.h>
+#include <inttypes.h>
 #include <stdbool.h>
 
 /*
@@ -64,3 +65,18 @@ bool shr_iface_primary_addr_matches(const struct ifaddrs *iface_list,
  */
 int shr_route_get_egress_iface(const char *saddr, const char *daddr,
 		char *ifname, size_t iflen);
+
+/*
+ * shr_netdev_get_hw_queues - Get h/w queues details for a netdevice
+ *
+ * @ifname: Name of network interface
+ * @combined_count: combined h/w queue count
+ * @tx_count: tx queue count
+ * @rx_count: rx queue count
+ *
+ * Retrieves the NIC h/w queue details.
+ *
+ * Return: 0 on success and negative errno on failure.
+ */
+int shr_netdev_get_hw_queues(const char *ifname, uint32_t *combined_count,
+		uint32_t *tx_count, uint32_t *rx_count);
-- 
2.53.0


