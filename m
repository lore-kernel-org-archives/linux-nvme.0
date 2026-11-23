Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03781606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YeirQqjQ;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NnQHUzil
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0yzbSXb4DaEiFTK+YYTI3MlfmnN2SG6H45hvvbA27do=; b=YeirQqjQv2OS70
	qgANLfCUCSYjdu+OAnpkRidoT9MLz3nR28SP/iJDY+5c2m2+izOJnxsgtYqzXLxDR01nnfcWB9gpz
	lRM3Am1NCsTDAbrlps4PULlNqDNYgHlM2u5J2vOxC/isw/v+xMqSqNRguLoIM8sc9DLOgk0F+gXW7
	NquZvX5TCQqqG3x9vpW0JpDt7Ub/AXlResIDMZA7cLaBz8F4PbU/PMgfKKsrPwI5CT6WcYnRibodX
	hKL2TZiP++EmJEFMuNzmpSlqZpFmJE1BXJ9zMp9uAVsTSmnmFqXHL0k4WfOWIROnLYr9gnn6y8q/m
	QTIrH1hmUOT0icoFNSqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXzb-00000004OH5-1esV;
	Mon, 23 Nov 2026 17:38:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXzW-00000004OEt-3Wqm
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:38:12 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGYWua4112012;
	Mon, 23 Nov 2026 17:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0yzbSXb4DaEiFTK+Y
	YTI3MlfmnN2SG6H45hvvbA27do=; b=NnQHUzilvmQ0cTjMCxgivjbOl4wmuvCcx
	4jgcY+N5+TZpRG4YR6ix6dQv45DiscreafF/X6OQUV0MQrx+hORHI8F1mRS73kwu
	qepPGJNmWDGFbOZAf1zhraOXgmg0veDymXPKreTNztxZVMpi3Mt/HXVJHpd0drKu
	Hn3Ms8o9RA9XirWXFk1Ow1jMpUDZ5o8BYMVjTE9VnMIFwiP8WkIv1YWERDiUZcBw
	ibMZO9sGXsrFpexFu+tLpKFGXNlAklU5vWTfvY58BxqBDU5ria0Joh9o9TPw+fyG
	A9vs8ASKIflizNyVkBi5cuV+86dT/pAOfZ09UBac++jqfkAO3moIw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkcc4q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 17:37:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGJgQH1000887;
	Mon, 23 Nov 2026 17:37:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufqghf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 17:37:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANHbmmJ50594168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 17:37:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A8172004B;
	Mon, 23 Nov 2026 17:37:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5164520043;
	Mon, 23 Nov 2026 17:37:44 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.173.125])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 17:37:43 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, dwagner@suse.de, hch@lst.de, hare@suse.de,
        sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 1/2] nvme-tcp: expose per-queue socket addresses via sysfs
Date: Mon, 23 Nov 2026 23:07:23 +0530
Message-ID: <20261123173727.2022020-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173727.2022020-1-nilay@linux.ibm.com>
References: <20261123173727.2022020-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX5qOWSUnfgGF1
 CSEF15wxMtvJSrlWG1Q6OY2I+/Vty8v5ar2idegPYrBtLYJD57JWVgIcvmOd3EDNs8QHhr3+/BT
 QJonE6poULP+8/+vlocZcDXdMXa0GR1npNE2hXFDIavDaDPHt6Q+AmrD+0buKf45vxCHTqDG76x
 +cTH+G/FEAV5OpCYD391OTw6HFDvfBUGRGTq6aRYpp/v9CFwDnQftdmYlAr2IAd0vlSHCk5Ze2/
 YtOPlQowadtChyEXO5MQp4pvCm9L2EFA6+SbZROKN/eGcPY6fbkX+DnzlQyLfqqvHrZbNRyafPZ
 ceNzJkGI27OAyIKse8RQj6isNVFmBX8oMO8Fd9l1P4KN4jTgKNzJtMNB6yD0ZxZcn9B32n2RpL6
 GXfHwSUEq7NzDYHvNg5aleNi35mOy/kC1rTsuF+Oe3JIHMKAvGI7qs8Q8SursE0nDQgyGCXYwqU
 PS7NcMrUwmepAHjkt1A==
X-Proofpoint-ORIG-GUID: 4Ixa7W0zfj9hDuQ_I9lI4FEWo3Qwh01a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX/iy9OFG2rkrT
 URoHlfUZ/XD6M8X7rdpL9q7Z3VAhRI05MxV0B3x3+36t7AaG7oQqPFf2GtV5e80ISpHJEDNKQK3
 xx/i8EpcHmg7bxF38tVvRvqW/SqQpmQ=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b0479f0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=DDAwuWw7pe0VjTk75GEA:9
X-Proofpoint-GUID: 4Ixa7W0zfj9hDuQ_I9lI4FEWo3Qwh01a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_093810_902272_A24C7630 
X-CRM114-Status: GOOD (  17.11  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a read-only per-queue sysfs attribute named "address" to expose
the socket addresses associated with each NVMe/TCP I/O queue.

The attribute reports the socket's peer and local endpoint information
using the following fields:

- traddr: Peer transport address
- trsvcid: Peer transport service identifier
- host_traddr: Host transport address
- host_trsvcid: Host transport service identifier

The attribute is available at:
    /sys/class/nvme/nvmeX/queues/&lt;qid&gt;/address

Together with the existing per-queue "io_cpu" attribute, this
information helps correlate NVMe/TCP I/O queues with network stack
components and tune their interaction, including IRQ affinity,
RPS/RFS, XPS and NIC flow steering (ntuple).

No changes to I/O behavior are expected.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f1d29d9f75cc..c7e736df71d2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2123,14 +2123,64 @@ static ssize_t managed_show(struct kobject *kobj, struct kobj_attribute *attr,
 			  !test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags));
 }
 
+static ssize_t address_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *buf)
+{
+	struct nvme_tcp_queue *queue = nvme_queue_info_data(kobj);
+	struct sockaddr_storage src, dst;
+	int ret = 0;
+
+	mutex_lock(&queue->queue_lock);
+
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		goto out;
+
+	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src);
+	if (ret <= 0)
+		goto out;
+
+	ret = kernel_getpeername(queue->sock, (struct sockaddr *)&dst);
+	if (ret <= 0)
+		goto out;
+
+	if (src.ss_family != dst.ss_family) {
+		ret = -EAFNOSUPPORT;
+		goto out;
+	}
+
+	if (src.ss_family == AF_INET) {
+		struct sockaddr_in *sip = (struct sockaddr_in *)&src;
+		struct sockaddr_in *dip = (struct sockaddr_in *)&dst;
+
+		ret = sysfs_emit(buf, "traddr=%pI4,trsvcid=%hu,host_traddr=%pI4,host_trsvcid=%hu\n",
+				&dip->sin_addr.s_addr, ntohs(dip->sin_port),
+				&sip->sin_addr.s_addr, ntohs(sip->sin_port));
+	} else if (src.ss_family == AF_INET6) {
+		struct sockaddr_in6 *sip6 = (struct sockaddr_in6 *)&src;
+		struct sockaddr_in6 *dip6 = (struct sockaddr_in6 *)&dst;
+
+		ret = sysfs_emit(buf, "traddr=%pI6c,trsvcid=%hu,host_traddr=%pI6c,host_trsvcid=%hu\n",
+				&dip6->sin6_addr, ntohs(dip6->sin6_port),
+				&sip6->sin6_addr, ntohs(sip6->sin6_port));
+	} else {
+		ret = -EAFNOSUPPORT;
+	}
+out:
+	mutex_unlock(&queue->queue_lock);
+	return ret;
+}
+
 static struct kobj_attribute nvme_tcp_io_cpu_attr =
 	__ATTR(io_cpu, 0644, io_cpu_show, io_cpu_store);
 static struct kobj_attribute nvme_tcp_managed_attr =
 	__ATTR_RO(managed);
+static struct kobj_attribute nvme_tcp_address_attr =
+	__ATTR_RO(address);
 
 static struct attribute *nvme_tcp_queue_attrs[] = {
 	&nvme_tcp_io_cpu_attr.attr,
 	&nvme_tcp_managed_attr.attr,
+	&nvme_tcp_address_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(nvme_tcp_queue);
-- 
2.53.0


