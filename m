Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF735C5DF94
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FK88t03y6YhpZvL4qdKtc3cvGN/+qTlaj6Gfiim+Wqs=; b=NCIuBQYl7uOnUxXDm3k+iIuN6A
	yzcBOLqJdI/GqarBFd+EMFij5gwcbSt34ldK8/8KthUPhmSvfguQSfmJYGtfUy1usJFybMUfZUOzd
	xeW8XUdUcdUQOfuj+XIbdJEwgwG1AA2v+9C/vwOp8QRwZj1b7yIK6a2Nqj0Ii36iIwZRjHrtJbsKH
	lzEQDsuMkBrcMkqrewL3vPu7+6mRCooC2xf1WqjZ7FALAse99Mj1ATG37f5LNp2eoctF3ICnxaawe
	ijaBCYmOc/N4XtcK5JPTtxY5UPgPCkDaB5JOMoETjrC/N24376suT2rytenKdbOFeYPWpvgl23m21
	KLuTtfbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQTb-0000000DaHt-15mG;
	Fri, 21 Aug 2026 14:44:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQTW-0000000DaGH-3haE
	for linux-nvme@bombadil.infradead.org;
	Fri, 21 Aug 2026 14:44:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FK88t03y6YhpZvL4qdKtc3cvGN/+qTlaj6Gfiim+Wqs=; b=m3pWK7ZMY3lRbK7y8/n2x+cG0D
	uCLG9MsMea8ow6FQrqwHVuXQcH6gcSNf1sxkVlB4CHg013t6Vw5bqHQvjP6wSZOuSk4kfaq/ADfod
	9IIy3MBh9UwhsKsIk4XKcFkKTDxlNe0kTQYnXzafSpUnNWFQnsYaG9KXYq68FyzMkc0FkPk7ieX/X
	enemh/BrvwCC7na1bHxR0RKCM6P2HE/cRMScBMRoVrTmv3AqOmhjrUzof69Gv678o1beOdrm54owT
	DGEVAm6TLj96IxIfYI5KTCduZdvyO1BIiNymYQJSZAtXSK/oSMq8I6ExvHGUOpsedKV6+G/8O2FcM
	L7O2g/mA==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wxQTT-00000003r0e-2xXQ
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 14:44:05 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD1aIT454640;
	Fri, 21 Aug 2026 14:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FK88t03y6YhpZvL4q
	dKtc3cvGN/+qTlaj6Gfiim+Wqs=; b=prE1iwao2UKtstHV5dhF3z1IU6XOZlg7v
	eGPuWvxNVDqpzv7SPYowB5K6Guyxs4ml2CDUHSw2CixxF6kVVQypwjd6EpxT9vtB
	x+350cdGxxakmWZ2khFnnCBLrbdqM5AKn3vv1DkyhYlI790erLkH/gmW3WbMIl1q
	f56glCtTLBULQCglXNSksMxmK/dueo/+NwRtxC9vCCPCNZBRSE7poLrKZZhHJmCo
	4NnjZOE4lmC2AMIwNWIa28Bo9xZlXn0aHy6ar5z7or0JH1+9eb1vWNhmmOpO1plo
	hWh1XIbyWksuVb7cqD2hdRPm+MfIbXhO5VHYykjOMtiWRDQCf8wgw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2j052-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:43:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LEfObF011557;
	Fri, 21 Aug 2026 14:43:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhn6bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:43:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LEhpZR42926558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 14:43:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E56A12004B;
	Fri, 21 Aug 2026 14:43:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDFEB20043;
	Fri, 21 Aug 2026 14:43:46 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.26.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 14:43:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/3] shared/net-util-linux: add support for retrieving egress netdev
Date: Fri, 21 Aug 2026 20:13:12 +0530
Message-ID: <20260821144329.3620389-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821144329.3620389-1-nilay@linux.ibm.com>
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88642b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=2subW7uFDnwX7hpnYt0A:9
X-Proofpoint-GUID: ef861dahG3oyg6SvoHGk_EyupNJyzu4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfX/Jes+l7VI6s+
 RGakMfo2J7ljXGFb1fhFVCTGrgn1SddwOXhHNmdQbpZ5Lq8+Oha8JAgXUIvr459Ux7dxbgTa5SD
 lUcl1V13BMypwb2byr6CH/UwV0uI5C8KbfyT4taJcVRfr+zyB6iT0dHOb2fUiES13QBO7x4uRMM
 J44Og8dVLYtJUNmVTt9GUGQD9f0tMG/zlbnLueVO9VguF/cBs6nVGevLeNjfLk5WmZYRgWQc4Pz
 VYM10B7oyFYcUyr2GLIOzksdz/pe+8v8HJqzRxtfQLnIULHa247DazLsDuHaBW+GqPGwNsa2JqW
 94JXh5iyh1Kzvp5OxABvydNL/D5TtR/MtkXzL5ZZZOPlumkDLgFzaSN23vUHypU3uht8vxQ08l4
 A0EoT0JyXiG54ET/Twrlodb1QNUbU/upjCBaNKOoubAhDGBz/QUOVzr4mKVjE/v6GylhgH8srrz
 9Jum0VfXrK5jM/UuCLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfX0OCDOFtYXggG
 /eCOaCmjWeQYzo6xvsCK7NNvRb3p214iHVQv/fEJfj13zROG5trmEC9xnPy16dOkAOZ5eQVzSoH
 gwvGQllJw7W3u88yOp60BBWQ4vA4D/0=
X-Proofpoint-ORIG-GUID: ef861dahG3oyg6SvoHGk_EyupNJyzu4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_154404_178832_B96E8A79 
X-CRM114-Status: GOOD (  24.01  )
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
index 57c025b05..887755ce9 100644
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
 
+#define NETLINK_BUFFER_SIZE 	4096
+#define NETLINK_SEQ_NUM 	1
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


