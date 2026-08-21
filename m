Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015B7C5DF89
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BjaZ9Ryy7DmRGtS0w/NBoN2Vw3jn/Mj8bMEnb7kBKmI=; b=Z+EWc8+yrMz07nn/q3nVLWLcLP
	OxujypuelfmXEr0OVRn7bE2/RMgurzAfaUP1PEc524TSa8ix99QIq8De3/ki7qOo1mcsQrpA3qrdO
	uAPk8Kqny6crye5u1ls/DamHHlG/Rnx8voIoZJd1IHMbPE4MTUhl3JMN1LTqZbB37EKVvpjcdtH+N
	QQlGVGW/a5xvNvt35Figd7RDNIPO+tM7/dfDmxnZWoXYvRiFqfDuGAl7vjXyNkkR8CMjAcA5At4Yb
	UId5xb5msYHu0Rfm4GYLiXrEwhR4GEI56+u6N7pLxZVdr7XOeq2RDmtS8cdSFRMeSP/9o3tkoHJfW
	cQusxrbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQTf-0000000DaKL-2AH3;
	Fri, 21 Aug 2026 14:44:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQTd-0000000DaIi-1dek
	for linux-nvme@bombadil.infradead.org;
	Fri, 21 Aug 2026 14:44:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BjaZ9Ryy7DmRGtS0w/NBoN2Vw3jn/Mj8bMEnb7kBKmI=; b=ODHGvOZycyorutvL2cjxYiuaEM
	fOdCSyNnX4thmUodx4cyKvA0AE2HgWG/MJMeT8BnVwm9/dbwfMD5bFw+Ocx//m+NPGRkFC8yG7bhh
	7sO5nb+P7qXBu38FL5xGqBkxh3rNIMvrsVqssFvfdu2BZY2x7xDM7OTOhbx5TGm6V89P7Kthe+PXn
	XEPlYKQzWbVZYG+qi9A+7doWzD9yEdxOtdRQIfId9zLDiWM3Cz/UtnbwoetZztUGPZWZ7jPup5qn9
	skpuL7lLS5YS8RAv8O+pFs8br3APKbmqJGy6vUAerbLZPsRLY0l3yTISDZRza/kFbo9cLr0U3xlJV
	4xTXw/qA==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wxQTa-00000003r1R-1LV0
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 14:44:12 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD1Z7v1585730;
	Fri, 21 Aug 2026 14:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BjaZ9Ryy7DmRGtS0w
	/NBoN2Vw3jn/Mj8bMEnb7kBKmI=; b=N+fnJXHVwjfaDuGKrpGJV8rby9gAwghUu
	uq9TAKhGqH1dseZ/iWAzKmJlO3ewQXeBnXCWiyWBVFcCdQfQHi9Ssvj2WLEn69TN
	8m7gCSjL9zu1I+iGkFfAS5ln24Z7If2673k3MhgHOkhkPO2RswZc9GAF5BUSHKbM
	N7cwVWtHby5mEBM0/eC8rP38IaixPYil0ppH8YsPz3OKV57IEesJgaBYBa7W8cfp
	I3o8VLKjAZAxTaUe3OLb9WGYwaMK4lBRJBSsAVO8ZcA9ZzbeZdLkMzv68YMF1eDd
	FM6zq3PEqtvrNksk6H5zWUvDI+Ib+C0Z0aaOgkrDyacqbYxQ3v6gQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0t766-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:44:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LEfE80030652;
	Fri, 21 Aug 2026 14:43:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngvyv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:43:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LEhtl640567216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 14:43:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB4F2004B;
	Fri, 21 Aug 2026 14:43:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3A4320043;
	Fri, 21 Aug 2026 14:43:51 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.26.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 14:43:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/3] shared/net-util-linux: add support for retrieving NIC h/w queues
Date: Fri, 21 Aug 2026 20:13:13 +0530
Message-ID: <20260821144329.3620389-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821144329.3620389-1-nilay@linux.ibm.com>
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a886430 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VfOP8DvaSo2KLmbhT-sA:9
X-Proofpoint-ORIG-GUID: uFpm0qmsoNEnO5oqWIkbpf-nuPZiCLLI
X-Proofpoint-GUID: uFpm0qmsoNEnO5oqWIkbpf-nuPZiCLLI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfXwoyDZvKdnFte
 6X/8CcsPTKz0VJIe70lHa2P45yTOpH1ad6s4MTuC2efsWPsVBGWVq1vVg4IQ/6y2m2O6qHMaE79
 jrWjMjCuU5i4nhVHL4B2G/NJpNID1co=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfX6OhSn/HU/1Ay
 dgrYjXh1irqYAwmOB6NFmNsb11OjyIvd2VlnnAhn35QmQASzuHW3JsrDTCgK92qDRpZZY1AHOOb
 VqRZBx1dr5h4T0Rp7cmYN0efujMCDqd3qEVl1DmKownQ/z4Rv7JQZANmtOXW1hHwY7WHMX89vP5
 V4dO8GUP23pPwDnx464KrYS5bLHFHw0JTs2Et5NjKeUd9NsGRhKFArCXMCq/OvCkT2XPSNM+FAO
 ah5k5tcCAQqeA/uFUotN8Za2pwtlR5FFRSFRMI//SsaqcWpvpmxFojoOBPxjrUSVl2GN6PnwnM5
 ohrH0+sXUhdYvyw4rPsaNiQmezBgmE6BWcWS+bHOsuYDDQmC2sKZRRUMWe7m3jEhGw1QUOqVaIJ
 jK3gKZrYiD3ISsNHmXmikbU3EaP/imW9R+5mpg18m9hPekPF3FJ8j9xpB3ZIOj18V4X7JHG5gXG
 h6iPKYFKyW7ozoP0zhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_154410_832820_F4EB3D3B 
X-CRM114-Status: GOOD (  15.42  )
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
index 887755ce9..7517fccbe 100644
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


