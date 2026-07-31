Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A09C54F54
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejnsnGQjYt6RlmcYYoJvGHhqBvF1tF6j1zWOL3wKX9w=; b=EGcdAxJRZgC5BRpPHaiTZQVZec
	xI0SlIKtQhAEOHXgtG7oKogb0g1HqywbgGjE2id5O6E8/v4UttX39aHzFQ99V3E+2P58e5yfajF9R
	gDSGx2YPBbtqmtK4peV68uIvA0dhgKe7AJrZIXrfyjuD5EhAaiYImYFPEtIj93LHUgW2SRl558Y0j
	YZVQtKG7+G1Eh7rZxsoO9BrQraW0O8rLBZ4UDt09vFjj2yfj6h3T27HjijtrB7mGh9ctcGXekqxk3
	2VIpLAiOhEBLaJD7Uo3FN2fzMwi2+pL+m8I2xiThPdAquBAPTGvwz+i5KCtX++EfAHhKURdx+FrTF
	Oac3S3AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wphqW-0000000BydH-0Mep;
	Fri, 31 Jul 2026 07:39:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wphqS-0000000Bycw-3xEE
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 07:39:54 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5HqIo949909;
	Fri, 31 Jul 2026 07:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ejnsnGQjYt6RlmcYY
	oJvGHhqBvF1tF6j1zWOL3wKX9w=; b=aJbPQgT2olyjUOqUX7K2LPFBuH5Bi8lH0
	rds2NpOQBB+xXZDeYTso5qxOvToWZdml5+Hsb1YaCOl6VnnR5ckUHfgbd23gmYDU
	IHfIiYUEW/zVK8HDUrGfRErJl6swkBkAXdur9fVFRc5sbl3jRnQCv4HQBHHU+7Xn
	xqmWUqUmoRcLKpqwrYkL7+WBe9AD7aYJ62757bJ0pZ//quhAtuZSq0f8BNQiVlr3
	8N/0kZka5FE2dna3se01ydqOYN2t1YYYJEAP/Weo6eHYrvCdVoQLHI5OBSmqHrsg
	6/dn3alqDBBxah/6jkoxwwpGfhkBoBOh4ABGkGY7ipnxicQp3v2Qg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y3xcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:39:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V7BKvR022722;
	Fri, 31 Jul 2026 07:39:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgptpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:39:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V7djoL34603494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 07:39:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E02A520043;
	Fri, 31 Jul 2026 07:39:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5395120040;
	Fri, 31 Jul 2026 07:39:41 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.125.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 07:39:41 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RESEND PATCH v2 1/4] net: add helper for device lookup by destination address
Date: Fri, 31 Jul 2026 13:09:05 +0530
Message-ID: <20260731073918.614014-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731073918.614014-1-nilay@linux.ibm.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cObEvtkdqwCc_0dkpF_3Ez-qdRoGKLAe
X-Proofpoint-ORIG-GUID: KxKJtxuH5lH73kElLvtO9YAZwVps6oQd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX5FuL+rDJNgkg
 QKC1l0apuxZFZ/7o6/RR7bvzVGfsxILvtbgZojHEjp3ljChZ1FqAIpckjO/ZP2XjooKJ4Lm92tA
 bvkHzR0i4vOb28vvyAdzz3RNj8SyEG4=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6c5145 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Aj1T1U9x83W24pAq5BMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfXwGcj7VuiopSP
 pAJ/yWY5Be3S7Ph7deFzXVk8gAgtkHkqSzKt/gcPUtAIU5sZtWo2cTd3RXUmuz+vP8Ra8XqLuAm
 g1y005I5ug4zcOMP0/3+R8l9qJCIwDE3itfCagDBllokE/MJoJC7BUsom4mTeT9F1NWrDndnVdE
 nBnCy1yIKMmysI6N1ZT1u1qQOfv8+eJe57r1Le0YSo5B86/uBGYjI1xXLzfzeVfZwujAuvK3boB
 eJolp8+3QcTl3uJKKzblmI2B+uHp9JP0ah9QMCLO+73/ym//Z+mqxMHhgEFVUjz6eS7bkJsHIPM
 2dIdAp3ZNOLYk2rpv0hTOJU8c3pIGCU9t+c7A0a+OFsSXNfYB5FNalcGFJ/BjsD8Ndzfx4l4kYn
 EOcf9xpCKwmJrRdzuh7VFrivEhFupdubewVeiISHGV5mQLJ5PXbYyG837JeRlkOWSqEir/swz9o
 T8pHEvni/n9gYuRrb8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_003952_986637_28F5A3A4 
X-CRM114-Status: GOOD (  19.63  )
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

Add netdev_get_by_addr(), a helper that looks up the routing table to
retrieve the network device associated with a destination address. The
helper also supports netdev reference tracking.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 include/linux/netdevice.h |  5 +++
 net/core/dev.c            | 84 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..f43c3aa8486c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3487,6 +3487,11 @@ struct net_device *netdev_get_by_index(struct net *net, int ifindex,
 struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
 struct net_device *netdev_get_by_name(struct net *net, const char *name,
 				      netdevice_tracker *tracker, gfp_t gfp);
+struct net_device *netdev_get_by_addr(struct net *net,
+				      struct sockaddr_storage *src,
+				      struct sockaddr_storage *dest,
+				      netdevice_tracker *tracker,
+				      gfp_t gfp);
 struct net_device *netdev_get_by_flags_rcu(struct net *net, netdevice_tracker *tracker,
 					   unsigned short flags, unsigned short mask);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab09e..fd8afcd26de4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -163,6 +163,8 @@
 #include <net/page_pool/memory_provider.h>
 #include <net/rps.h>
 #include <linux/phy_link_topology.h>
+#include <net/route.h>
+#include <net/ip6_route.h>
 
 #include "dev.h"
 #include "devmem.h"
@@ -944,6 +946,88 @@ struct net_device *netdev_get_by_name(struct net *net, const char *name,
 }
 EXPORT_SYMBOL(netdev_get_by_name);
 
+/**
+ *	netdev_get_by_addr() - find an egress device by destination address
+ *	@net: the applicable net namespace
+ *	@src: optional source address
+ *	@dest: destination address
+ *	@tracker: tracking onject for the acquired reference
+ *	@gfp: allocation flag for the tracker
+ *
+ *	Find an interface by looking up route table entry based on dest address
+ *	and an optional src address. The returned handle has the usage count
+ *	incremented and the caller must use netdev_put() to release it when it
+ *	is no longer needed. %NULL is returned if dest is not specified, or src
+ *	and dest belong to different address families, or no matching device is
+ *	found.
+ */
+struct net_device *netdev_get_by_addr(struct net *net,
+				      struct sockaddr_storage *src,
+				      struct sockaddr_storage *dest,
+				      netdevice_tracker *tracker,
+				      gfp_t gfp)
+{
+	struct net_device *dev = NULL;
+
+	if (!dest)
+		return NULL;
+
+	if (src && src->ss_family != dest->ss_family)
+		return NULL;
+
+	if (dest->ss_family == AF_INET) {
+		struct rtable *rt;
+		struct flowi4 fl4 = {};
+
+		fl4.daddr = ((struct sockaddr_in *)dest)->sin_addr.s_addr;
+		if (src)
+			fl4.saddr = ((struct sockaddr_in *)src)->sin_addr.s_addr;
+
+		rt = ip_route_output_key(net, &fl4);
+		if (IS_ERR(rt))
+			return NULL;
+
+		dev = dst_dev(&rt->dst);
+		/*
+		 * Get reference to netdev as ip_rt_put() will release netdev
+		 * reference.
+		 */
+		if (dev)
+			netdev_hold(dev, tracker, gfp);
+
+		ip_rt_put(rt);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (dest->ss_family == AF_INET6) {
+		struct dst_entry *dst;
+		struct flowi6 fl6 = {};
+
+		fl6.daddr = ((struct sockaddr_in6 *)dest)->sin6_addr;
+		if (src)
+			fl6.saddr = ((struct sockaddr_in6 *)src)->sin6_addr;
+
+		dst = ip6_route_output(net, NULL, &fl6);
+		if (dst->error) {
+			dst_release(dst);
+			return NULL;
+		}
+
+		dev = dst_dev(dst);
+		/*
+		 * Get reference to netdev as dst_release() will
+		 * release the netdev reference.
+		 */
+		if (dev)
+			netdev_hold(dev, tracker, gfp);
+
+		dst_release(dst);
+#endif
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(netdev_get_by_addr);
+
 /**
  *	__dev_get_by_index - find a device by its ifindex
  *	@net: the applicable net namespace
-- 
2.53.0


