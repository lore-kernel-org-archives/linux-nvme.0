Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE71CAC5A7
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 11:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxYN1gmnintatpVMModQbCJegYVSO0Okdz1Xpvze/VQ=; b=FdhX2a5IMsMQAOi9R7aCZJuLFd
	aZC3uTHjCBvJKozzqhXox5owVsQzZZJAqyWN9hUQ5BM+ZqiGf8sMEJZuczG9EXAECuoZJQByZ8ZfU
	OLkQnq1YxmYSO7hwFTZTYVEdWDO4cfibzEN0HN/3JdW7athybchGb83KV0fchG6CchJaFzr72XDT3
	267vU6Q3EZf0g5C5zL7C8QuVTLZajEN9hIYXyrLFd7GjlVk2RVgtwMjxiEQ5C3s7Qp3BWFo8/JX+7
	H3ZsRD+wY+4GEtJmXhF2M0lPQbqlAm+TI4MAj0Mj6zb4+Dl2uPt3praGhFmzb/ZOFyp0e5OF2RgVu
	Hf1LTQQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I0C-00000007MV4-1jki;
	Sun, 21 Sep 2025 11:13:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I09-00000007MRp-3s79
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 11:13:07 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KI0G0k002073;
	Sun, 21 Sep 2025 11:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VxYN1gmnintatpVMM
	odQbCJegYVSO0Okdz1Xpvze/VQ=; b=LDUMJcpTTy1p6Bdc/ixdSf11kPEH+zjcG
	72KVqha3UJsQWWw751zeOppL+1jlwyka/XxOb+sE/S9xnAcdCPJ3g7+ZepqQ//hN
	ML0TLzJvDe+MbRiUVLaC8V2fz70Sbd0lWbVUR2EePSslPtNPxd0uxjNyIL5jGV38
	ysPFLPajNcL5UCEbaeKc1haaqy+QytJC28i355eY80sw1hmONvC/FylFcLFiIQWN
	rTux0Ass0yli0KqejHlMiPoiBgxJA1jgBfcmNT4ho5rvvov1vmhR4N1m86ESq7md
	m8EcrLvWsN1hZOwN8hq7PxtiyPFgcdBpCzwg+2UOHoI0ZP8Hp+8VA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpjwan3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58L8t95d030370;
	Sun, 21 Sep 2025 11:12:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a0s79t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LBCq2Z32309882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 11:12:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43AB120043;
	Sun, 21 Sep 2025 11:12:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA0B20040;
	Sun, 21 Sep 2025 11:12:49 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.7])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 11:12:49 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        hare@suse.de, dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCH 4/5] nvmf-tcp: add support for retrieving adapter link speed
Date: Sun, 21 Sep 2025 16:42:24 +0530
Message-ID: <20250921111234.863853-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921111234.863853-1-nilay@linux.ibm.com>
References: <20250921111234.863853-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68cfddb7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=XeANobVBlFZ_tXfQ0l4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX3OCGNuQhQR27
 ObVIsY1BowKB/9xtEndGKHV9qvdJ8mdw/gDSg4pFFWloGQyoqh1de+gRNWgmMdn+vtSo8CANYWo
 OblH+hjrTKi/0NiRaxCSFq4FYfokrFDyFaAQz1/v+IT39C7/FKK27/oMQvzKBV66APnM9TTUJ1k
 3bklp1/m7ebLr0LHIH9AzbsUAJxveHQ41h5lKGc4s6HtqeSxYkwgHAHdWQNOP7+DCLWNhKBbk1A
 eDAc3H4hmmKQ3iIls7Gu9M+oAuVjx4m1Qj0RzOHvvHAR+Ogt1y4H2dPmSZSc1/yeC+RSsHIFeCi
 2ICHamL+vi0sp2QjTcwvtnXTg614LW7hXbRc2FxgIebFTnOFedFb3daA/9x84uok9+LNOvpOync
 v2e0Qm9K
X-Proofpoint-ORIG-GUID: V8EeDrTFzDIl8GkhO3v27V9uselr5eKn
X-Proofpoint-GUID: V8EeDrTFzDIl8GkhO3v27V9uselr5eKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_041306_081116_A0783994 
X-CRM114-Status: GOOD (  22.49  )
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

Add support for retrieving the negotiated NIC link speed (in Mbps).
This value can be factored into path scoring for the adaptive I/O
policy. For visibility and debugging, a new sysfs attribute "speed"
is also added under the NVMe path block device.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 11 ++++++
 drivers/nvme/host/nvme.h      |  3 ++
 drivers/nvme/host/sysfs.c     |  5 +++
 drivers/nvme/host/tcp.c       | 66 +++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 84c64605d05c..bcceb0fceb94 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -548,6 +548,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 			clear_bit(NVME_NS_READY, &ns->flags);
 
 		nvme_mpath_reset_current_stat(ns);
+		if (ns->ctrl->ops->get_link_speed)
+			ns->speed = ns->ctrl->ops->get_link_speed(ns->ctrl);
 	}
 	srcu_read_unlock(&head->srcu, srcu_idx);
 
@@ -1566,6 +1568,15 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t speed_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", ns->speed);
+}
+DEVICE_ATTR_RO(speed);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22445cf4f5d5..665f4a4cb52b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -548,6 +548,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	u32 speed;		/* path link speed (in Mbps) for fabrics */
 	atomic64_t slat_ns[2];	/* path smoothed (EWMA) latency in nanosconds */
 	struct nvme_path_stat __percpu *cpu_stat;
 #endif
@@ -593,6 +594,7 @@ struct nvme_ctrl_ops {
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	u32 (*get_link_speed)(struct nvme_ctrl *ctrl);
 	void (*print_device_info)(struct nvme_ctrl *ctrl);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
 };
@@ -1012,6 +1014,7 @@ extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_adp_stat;
 extern struct device_attribute dev_attr_delayed_removal_secs;
+extern struct device_attribute dev_attr_speed;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index cb04539e2e2c..5858c2426efd 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -262,6 +262,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_adp_stat.attr,
 	&dev_attr_delayed_removal_secs.attr,
+	&dev_attr_speed.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -308,6 +309,10 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_speed.attr) {
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
+			return 0;
+	}
 #endif
 	return a->mode;
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c0fe8cfb7229..694f8cbe080d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -11,6 +11,8 @@
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
+#include <linux/ethtool.h>
+#include <net/ip6_route.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
@@ -2825,6 +2827,69 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return len;
 }
 
+static u32 nvme_tcp_get_link_speed(struct nvme_ctrl *ctrl)
+{
+	struct net *net;
+	struct sock *sk;
+	struct dst_entry *dst;
+	struct ethtool_link_ksettings cmd;
+	struct nvme_tcp_queue *queue = &to_tcp_ctrl(ctrl)->queues[0];
+	u32 speed = 0;
+
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		return 0;
+
+	rtnl_lock();
+	sk = queue->sock->sk;
+	/*
+	 * First try to get cached dst entry, if it's not available then
+	 * fallback to route lookup.
+	 */
+	dst = sk_dst_get(sk);
+	if (likely(dst)) {
+		if (!__ethtool_get_link_ksettings(dst->dev, &cmd))
+			speed = cmd.base.speed;
+		dst_release(dst);
+	} else {
+		net = sock_net(sk);
+
+		if (sk->sk_family == AF_INET) {
+			struct rtable *rt;
+			struct flowi4 fl4;
+			struct inet_sock *inet = inet_sk(sk);
+
+			inet_sk_init_flowi4(inet, &fl4);
+			rt = ip_route_output_flow(net, &fl4, sk);
+			if (IS_ERR(rt))
+				goto out;
+			if (!__ethtool_get_link_ksettings(rt->dst.dev, &cmd))
+				speed = cmd.base.speed;
+			ip_rt_put(rt);
+		}
+#if (IS_ENABLED(CONFIG_IPV6))
+		else if (sk->sk_family == AF_INET6) {
+			struct flowi6 fl6;
+			struct ipv6_pinfo *np = inet6_sk(sk);
+
+			fl6.saddr = np->saddr;
+			fl6.daddr = sk->sk_v6_daddr;
+			fl6.flowi6_oif = sk->sk_bound_dev_if;
+			fl6.flowi6_proto = sk->sk_protocol;
+
+			dst = ip6_route_output(net, sk, &fl6);
+			if (dst->error)
+				goto out;
+			if (!__ethtool_get_link_ksettings(dst->dev, &cmd))
+				speed = cmd.base.speed;
+			dst_release(dst);
+		}
+#endif
+	}
+out:
+	rtnl_unlock();
+	return speed;
+}
+
 static const struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.commit_rqs	= nvme_tcp_commit_rqs,
@@ -2858,6 +2923,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
 	.get_address		= nvme_tcp_get_address,
+	.get_link_speed		= nvme_tcp_get_link_speed,
 	.stop_ctrl		= nvme_tcp_stop_ctrl,
 };
 
-- 
2.51.0


