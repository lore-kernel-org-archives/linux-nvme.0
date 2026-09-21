Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E52AC982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LjI1FZnFR3BcKoK/btjziYAe8QlZN6Q59I3Lq8drzQY=; b=WLDY7TzT6gfrTfQim2Gdv0TO0V
	sUX6NJ17tzva9PqziCLK+QvLNjVlFzfJTqpMwzR7kJvMzZGHxkdzhAK3Qci8n1EHnTFpFaxTSQdwb
	9Dl8dF5fS8e0xtFVl3cKKDX2er3Vb4tLJAJA8kbLYV37xiBHYEkokXu5ZEoH2pl+tyIpU0EHV1vPc
	48AZXU6fabj68XflYh6MsXfpt1ddplKmpI4VnNdle5FuFY6EhBiYF68/iBEkZ89b50dhYBAiJgooc
	sNl/yOv4KLZPAUrQKPpvvAdp9rYR3/UKp7AX/XaQ2TyqhiF+LUzB3WQK5R2aN4eSkMvtzpBdDtrDi
	IsmT8uIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsI-00000001H0L-0c40;
	Mon, 21 Sep 2026 07:55:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsF-00000001Gzg-1e9z
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:55:40 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZPEd818896;
	Mon, 21 Sep 2026 07:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LjI1FZnFR3BcKoK/b
	tjziYAe8QlZN6Q59I3Lq8drzQY=; b=hOJz+FW6f2ea332vlXiCp75C7+NglCQRd
	3sXQmWu+iLIJd98cxpLMUot0zDITF3KpLv11wBUofYO017DC1xmBgUeeOP3sJfc5
	Tqn2t9Rwjk+3YyBg1XBBRwyVIUpBV2TbcPO78dr/aTYSkjNWF4ynWX2NPP6pDj1k
	wdTVAm/DXYYbzESdh4Z3V8YgEK+Fm073pAMbA5WQNHjG+0fUI/4ywYDLpGzgjlJ2
	qglZ5miBzHDRGvJooZihGxkNy8VdEmKGLayUNEZSBf0ERWanw85ja6Urx4yP2EEb
	nRTNgZMoUa5xNuNNQ2TupnaGAMzPUnq7GCbp6chxezyPHeXgBLJgg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg27d3r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HVB4924416;
	Mon, 21 Sep 2026 07:55:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq4g8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L7tTTk47907234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 07:55:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A59E020043;
	Mon, 21 Sep 2026 07:55:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B5B20040;
	Mon, 21 Sep 2026 07:55:22 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.138.180])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 07:55:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, sagi@grimberg.me, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 1/4] shared/net-util-linux: add support for retrieving egress netdev
Date: Mon, 21 Sep 2026 13:24:59 +0530
Message-ID: <20260921075511.2108561-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921075511.2108561-1-nilay@linux.ibm.com>
References: <20260921075511.2108561-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a0PBlfQYe0ql4AgMrJ6bojV_MnOySUIr
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab0e2f6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=2subW7uFDnwX7hpnYt0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfXz1jEGmLDTT4J
 MhdFsNVI7hfRSucYTZjhZde1/DD2Ytqs/ogEBlqDJx7ZcRXdvHo9/mhf7UK7CLa3wWxYfi5XCA8
 oua/F1/3eseRQI2rc7qeqCsvuEmswaJX02J9C/htdA7GU+EW8Tnu2jhE4U7W0luQo2gFjncadgo
 u9EIpWVobZqNuAqhUVyhyGIIOf68hcOxgYuwo/J1Fwynxd3m52pUfa5pi/zkD3fkaqbfRy/glrH
 vxcEeKhgA8ncDKXhfbWKz87eeIU7qY0681fZWQJhHz6HhappZHDAvfaTGhKZ+Ywazw1/hsMXmJR
 4vF9dLqG4Dsy+y7XlJgza/40BmEzZbaxAan4nujWY7bun54jGOXBMAc2OAeCRQ2mDujOsPsSYLP
 uqy+x/G49tL5XRM4+R+G8t8ji5fu8655V2nTGDRr95YeKQcbjBBc/6mXbKdzTyPlgna1/9pHDqT
 CUDUSj11AEP8UXBlbJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfXzq6MpuD/3b5x
 ostJBocBMNLsCPHytuPoapI/zCxpjop51wncPt+yb+38Dh/gHtK68s9FRrVaMxyiSSnBjVj+xjn
 zAOjUfpXUyGaBOW0gFlAs/i8CMblwCo=
X-Proofpoint-GUID: a0PBlfQYe0ql4AgMrJ6bojV_MnOySUIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_005539_437554_F491F3A2 
X-CRM114-Status: GOOD (  24.58  )
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

Add a new shared helper, shr_route_get_egress_iface(), which performs
a route lookup and retrieves the egress netdev for a given destination
IPv4/IPv6 address and, optionally, source IPv4/IPv6 address.

Use netlink to perform the route lookup.

This is a preparatory patch. A subsequent patch will use this helper
to determine the egress netdev when calculating the default
--nr-io-queues value for NVMe/TCP connections.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 shared/net-util-linux.c | 228 ++++++++++++++++++++++++++++++++++++++++
 shared/net-util.h       |  16 +++
 2 files changed, 244 insertions(+)

diff --git a/shared/net-util-linux.c b/shared/net-util-linux.c
index 57c025b05..b44430f38 100644
--- a/shared/net-util-linux.c
+++ b/shared/net-util-linux.c
@@ -7,15 +7,23 @@
  */
 
 #include <arpa/inet.h>
+#include <asm/types.h>
 #include <errno.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
 #include <net/if.h>
 #include <netinet/in.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/socket.h>
+#include <unistd.h>
 
 #include "net-util.h"
 
+#define NETLINK_BUFFER_SIZE	4096
+#define NETLINK_SEQ_NUM	1
+
 /*
  * Parse @addr (IPv4, or IPv6 with an optional "%scope" suffix on a
  * link-local address) into @ss. @addr is never a hostname -- resolving one
@@ -181,3 +189,223 @@ bool shr_iface_primary_addr_matches(const struct ifaddrs *iface_list,
 
 	return match_found;
 }
+
+static int rtattr_append(struct nlmsghdr *nlh, char *buf, size_t buflen,
+		unsigned short type, void *attrval, int attrlen)
+{
+	struct rtattr *rta;
+	int nlen = NLMSG_ALIGN(nlh->nlmsg_len);
+	int rlen = RTA_LENGTH(attrlen);
+
+	if (nlen + rlen >= buflen)
+		return -ENOSPC;
+
+	rta = (struct rtattr *)(buf + nlen);
+	rta->rta_type = type;
+	rta->rta_len = rlen;
+	memcpy(RTA_DATA(rta), attrval, attrlen);
+
+	nlh->nlmsg_len = nlen + rlen;
+
+	return 0;
+}
+
+int shr_route_get_egress_iface(const char *saddr, const char *daddr,
+		char *ifname, size_t iflen)
+{
+	struct sockaddr_nl nl = {.nl_family = AF_NETLINK};
+	struct sockaddr_storage ss_src, ss_dst;
+	char buf[NETLINK_BUFFER_SIZE] = {};
+	struct sockaddr_in6 *src6, *dst6;
+	struct sockaddr_in *src, *dst;
+	struct msghdr msg = {};
+	struct nlmsghdr *nlh;
+	struct rtmsg *rtmsg;
+	struct rtattr *rta;
+	int nlen, attrlen;
+	struct iovec iov;
+	int fd, ret = 0;
+
+	if (!daddr)
+		return -EINVAL;
+
+	ret = parse_numeric_addr(daddr, &ss_dst);
+	if (ret < 0) {
+		fprintf(stderr, "Invalid dest address\n");
+		return ret;
+	}
+
+	if (saddr) {
+		ret = parse_numeric_addr(saddr, &ss_src);
+		if (ret < 0) {
+			fprintf(stderr, "Invalid src address\n");
+			return ret;
+		}
+
+		if (ss_src.ss_family != ss_dst.ss_family) {
+			fprintf(stderr, "src/dst address family doesn't match\n");
+			return -EINVAL;
+		}
+	}
+
+	if (iflen < IF_NAMESIZE) {
+		fprintf(stderr, "Invalid ifname length\n");
+		return -EINVAL;
+	}
+
+	fd = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
+	if (fd < 0) {
+		fprintf(stderr, "Opening netlink socket failed\n");
+		return -errno;
+	}
+
+	/* encode nlmsghdr */
+	nlh = (struct nlmsghdr *)buf;
+
+	nlh->nlmsg_type = RTM_GETROUTE;
+	nlh->nlmsg_flags = NLM_F_REQUEST;
+	nlh->nlmsg_pid = 0; /* to kernel */
+	nlh->nlmsg_seq = NETLINK_SEQ_NUM;
+	nlh->nlmsg_len = sizeof(struct nlmsghdr);
+
+	/* append rtmsg */
+	nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len);
+
+	rtmsg = (struct rtmsg *)(buf + nlh->nlmsg_len);
+	rtmsg->rtm_family = ss_dst.ss_family;
+	rtmsg->rtm_dst_len = (ss_dst.ss_family == AF_INET) ? 32 : 128;
+
+	nlh->nlmsg_len += sizeof(struct rtmsg);
+
+	/* append attribute RTA_DST */
+	if (ss_dst.ss_family == AF_INET) {
+		dst = (struct sockaddr_in *)&ss_dst;
+
+		ret = rtattr_append(nlh, buf, sizeof(buf), RTA_DST,
+				&dst->sin_addr, sizeof(struct in_addr));
+		if (ret)
+			goto out;
+	} else {
+		dst6 = (struct sockaddr_in6 *)&ss_dst;
+
+		ret = rtattr_append(nlh, buf, sizeof(buf), RTA_DST,
+				&dst6->sin6_addr, sizeof(struct in6_addr));
+		if (ret)
+			goto out;
+	}
+
+	if (saddr) {
+		/* append attribute RTA_SRC */
+		if (ss_src.ss_family == AF_INET) {
+			src = (struct sockaddr_in *)&ss_src;
+
+			ret = rtattr_append(nlh, buf, sizeof(buf), RTA_SRC,
+				&src->sin_addr, sizeof(struct in_addr));
+			if (ret)
+				goto out;
+		} else {
+			src6 = (struct sockaddr_in6 *)&ss_src;
+
+			ret = rtattr_append(nlh, buf, sizeof(buf), RTA_SRC,
+				&src6->sin6_addr, sizeof(struct in6_addr));
+			if (ret)
+				goto out;
+		}
+	}
+
+	/* construct sendmsg and send to kernel */
+	iov.iov_base = buf;
+	iov.iov_len = nlh->nlmsg_len;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_name = &nl;
+	msg.msg_namelen = sizeof(nl);
+
+	if (sendmsg(fd, &msg, 0) < 0) {
+		fprintf(stderr, "Sendmsg to kernel failed\n");
+		ret = -errno;
+		goto out;
+	}
+
+	/* construct recvmsg buffer and wait for the response from kernel */
+	memset(&msg, 0, sizeof(msg));
+	memset(buf, 0, sizeof(buf));
+
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_name = &nl;
+	msg.msg_namelen = sizeof(nl);
+
+	nlen = recvmsg(fd, &msg, 0);
+	if (nlen < 0) {
+		fprintf(stderr, "Recvmsg from kernel failed\n");
+		ret = -errno;
+		goto out;
+	}
+	close(fd);
+
+	nlh = msg.msg_iov->iov_base;
+
+	for (; NLMSG_OK(nlh, nlen); nlh = NLMSG_NEXT(nlh, nlen)) {
+
+		if (nlh->nlmsg_type == NLMSG_ERROR) {
+			struct nlmsgerr *err = NLMSG_DATA(nlh);
+
+			/*
+			 * Netlink error message is sent as an ack when user
+			 * explicitly requested for it and in which case
+			 * err->error is set to zero.
+			 */
+			if (!err->error)
+				continue;
+
+			fprintf(stderr, "Received nlmsg error: %s\n",
+					strerror(-err->error));
+			break;
+		}
+
+		if (nlh->nlmsg_type == NLMSG_DONE)
+			break;
+
+		/*
+		 * RTM_GETROUTE reply is expected to be of type RTM_NEWROUTE.
+		 */
+		if (nlh->nlmsg_type != RTM_NEWROUTE)
+			continue;
+
+		if (nlh->nlmsg_seq != NETLINK_SEQ_NUM)
+			continue;
+
+		/* parse and decode received netlink message */
+		rtmsg = NLMSG_DATA(nlh);
+		rta = RTM_RTA(rtmsg);
+		attrlen = RTM_PAYLOAD(nlh);
+
+		for (; RTA_OK(rta, attrlen); rta = RTA_NEXT(rta, attrlen)) {
+
+			switch (rta->rta_type) {
+			case RTA_OIF: {
+				int ifindex;
+
+				ifindex = *((int *)RTA_DATA(rta));
+				if (!if_indextoname(ifindex, ifname)) {
+					fprintf(stderr, "if_indextoname failed\n");
+					ret = -errno;
+				}
+				return ret;
+			}
+			default:
+				break;
+			}
+		}
+	}
+
+	return -ENOENT;
+out:
+	close(fd);
+	return ret;
+}
diff --git a/shared/net-util.h b/shared/net-util.h
index 577e582f6..0208923e5 100644
--- a/shared/net-util.h
+++ b/shared/net-util.h
@@ -48,3 +48,19 @@ const char *shr_iface_matching_addr(const struct ifaddrs *iface_list,
  */
 bool shr_iface_primary_addr_matches(const struct ifaddrs *iface_list,
 		const char *iface, const char *addr);
+
+/*
+ * shr_route_get_egress_iface - Lookup route table and find egress inerface
+ *
+ * @saddr: optional source address
+ * @daddr: destintion address
+ * @ifname: buffer to hold the matching iface name
+ * @iflen: length of ifname buffer (must be greater or equal to IF_NAMESIZE)
+ *
+ * Lookup route table using specified saddr and daddr and find the egress
+ * interface. The saddr is optional however daddr is mandatory.
+ *
+ * Return: 0 on success and negative errno on failure.
+ */
+int shr_route_get_egress_iface(const char *saddr, const char *daddr,
+		char *ifname, size_t iflen);
-- 
2.53.0


