Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBB8C53209
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UI9Xlgh0IAGkETkHx1I7NY+YH+UU9tLNGDpv+pGgMzs=; b=j8EGqobngw/jD+lEYHWbnQGnQN
	FgGf24xpGtLtqRy5ddVYPdPV02v2onaI4YhtN984BwRYKMz9D0z8DIz20SViyz7hnweqBNiTA6Vth
	rcu/9oo2mI3Fi0tXikHMW+jOxzAz18xpLAIwN7AMYxghM1lbT0UfzihgrMKLgFTGSEXJSEtOsN98N
	Nwdih8NsXAi1vfjFYCDVsuJZ8uqOAmYrqKg+GaQ08azKPy4PHImYLLWMV9zinmQkmiA43vvUtmZ3L
	egvZvPI1vSidj+OJNSvBhJdAE9MWn5yY/51RdfPFfiazc15y6ITi1Mb1wgcv5oVKBXTOC5TODIzFu
	zVU/U6sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN5E-000000038rm-0mm0;
	Mon, 27 Jul 2026 15:17:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN5A-000000038qM-3mp5
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 15:17:34 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnGWF2291930;
	Mon, 27 Jul 2026 15:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UI9Xlgh0IAGkETkHx
	1I7NY+YH+UU9tLNGDpv+pGgMzs=; b=atEjkTglJDpYSOvpw22s+3uLrMzdpLzqr
	vk46xU5EGRV+rZesKYC176fNJwG78BuJnUYJtl7hehk/sB2aiCW/vm0kGv5sonV/
	5xZXLlysHIspgx6K1c7BtsumwrL0pG3yN3CLFi4p0soGFFmCIyyawJgDp76Kf84/
	ApEPORNfuWbes7bznpBBVHTcMYXDuB4fG6ei7jgHrtDiY1Wpvqf8suFibnjoAb5H
	KUmY+zaPgjbsyFkXfbSyYch8HfTvKrT+6lmWd0OlTXxWC3frXN/QU0uvKxRQFb2D
	17FdqwHwBCun69sKCrKo8HDu7dlySSgTV1c4gLxbukzmW6tojKB2g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ng8mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:17:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFBJ6G001672;
	Mon, 27 Jul 2026 15:17:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg5p5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:17:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RFHLt916712130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:17:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E01D8200E0;
	Mon, 27 Jul 2026 15:17:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C77B20085;
	Mon, 27 Jul 2026 15:17:17 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.97.190])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:17:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org
Subject: [PATCH v2 1/4] net: add helper for device lookup by destination address
Date: Mon, 27 Jul 2026 20:46:44 +0530
Message-ID: <20260727151652.3660476-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727151652.3660476-1-nilay@linux.ibm.com>
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX5zYZv3bi0Ijb
 aO3pWPuFsixWKP28DeNMcO2OFrR/6paK+xpNMUOJzMRpYW+dtyScFvb9aA9nL77imRIKQOS4yuL
 mxbrVEVQ9gegWvi1WjK4e8u7+QAsYI0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX34F6RiZWIWBV
 X53RJDBVDQajSYVteHgQuTzvle0XBcdwm1FfsubXyYGImwZNpz/d5i5pD5GhR5TmfHhUXMEoqgI
 hd60DLhhO3fdDu9bRl235NVEVdvCNoSKw4Y7orn33cEneKX28e7j6uhjQOKBfJG+L5LC2fWSOAB
 9OSsesqJtuC07MI8cJUWdWiilWAvDxMAVAPN/qguqu4893RopbmY9KE1iBjqH+bozyGXt7DkjrZ
 dABkPladecpdP3FiXNTzJvOxdx2dg8d+gTAX+FxHNPEoSPc9fRmpqQMH2DnyishSWqTQm6COC/P
 17nz98CmWYMbTayx+KU1rjMlc5ilVFPwmWRLHikSgMQJOE6aE8NACqa4vEgfNKFay+DulyER08w
 H6ZvDq8in+a96L7axrFoK6O9n/6RO2CFJRfAgTg+0PNxy+dZyxX3wNocpv2vWhnFOmXRJ4tBwxc
 4XV8vn6SxRjCx5Rfd5A==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a677686 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=1_uPL4OANAtoORD1zUkA:9
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: S-Rik2n8-L9oDcmUSwM9CEgUlnpOU-mO
X-Proofpoint-ORIG-GUID: tLxCO4ILLM8EvPpaiA4FLZsGBh-RhEY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_081733_059921_C8427D6D 
X-CRM114-Status: GOOD (  20.58  )
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

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
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


