Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96210EC1EAD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDKu+7FnAFsMUWxKCHHHCWicR64t+7zb/zqvbXEKUPo=; b=n/bOT/X8XVjVn5NUGzODDmT4cx
	92+1mSagrMJ9nNGw5w3jF4ZUXhOmcc38MfGITEcJURLtMKSykhoaRrzSDh41tsKG6B1EjqkP9OXPy
	NVJtclhBvkrcO8S0wnmxftF6kPcfvXrD8Y2Dd9kywjZs1GDBKqB/Y9MypwZDbRcLIYANOVAbsGu9L
	eGwhvp67N43Nno2nfPUtzvlovWtUF28yG59JqDXxH1FCfQmFuj8XDIY+d3iUoy4zrXyFogYW4nYQH
	dy6LMyTeJK7vlItDoIiTyKuQ/j6lqMp0GebcfPJQDqZvkjPqs0Eff+eD7+GvX6C+Hp03DQxM3TOjx
	tkIqxblQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymz-00000009tmh-44ds;
	Thu, 05 Feb 2026 12:48:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnymv-00000009tjo-1Xce
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 12:48:51 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 61591xcO027015;
	Thu, 5 Feb 2026 12:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nDKu+7FnAFsMUWxKC
	HHHCWicR64t+7zb/zqvbXEKUPo=; b=BZaaos1ZcgBuFf8t66LTUVqkjlIfgLdhr
	7jlDEZsb34Hni2xfRjbOwBCeXcqlHwANN5G44gTzfhJUoZBpM2pCuW0rS0C7W34c
	ZGKBCjrIzGMRx1/YvboiAt2z1UF0HGNnggl+mQsd4iXyab8t6aXqHSP6pyhYvUSX
	wGq5BwlQIEs5kDEzUDpgR8Lv5U4x8Medhlg7Wx7kiQpCwT++8I9kpEk/QxC8p+fo
	WTsIClvZRX34hRmjq2mNkPdh4H+TDr5IwrBewoMFrB/KvZ6DzQed6pX6EyogUWlb
	hEp4g3b6PcjYEBRMWbZyiOAUc2RklFhMkDvSmZjqG9lIEX/IesAGA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cwbtce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615Aw2bv015355;
	Thu, 5 Feb 2026 12:48:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c4gsgt3vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 12:48:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615CmdPJ8585698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 12:48:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 625BC20043;
	Thu,  5 Feb 2026 12:48:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 799A420040;
	Thu,  5 Feb 2026 12:48:37 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Feb 2026 12:48:37 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 7/7] nvme: export controller reconnect event count via sysfs
Date: Thu,  5 Feb 2026 18:18:06 +0530
Message-ID: <20260205124810.682559-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205124810.682559-1-nilay@linux.ibm.com>
References: <20260205124810.682559-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MiBTYWx0ZWRfX+0Wovv/9aWQd
 BFzvwnAVwbdgVVnLjkmzZNRVijq0XVDEvrVhl9EtdQP7GWBMmM5UlZQ9DziGSoiRxv+B3AdfFLD
 l6g1wHBe9ftC68UCjQEXpHLw8Hwd19C2WNRfqUZgQHkEuC3p5QX9c21waxvvZbaVFr3u0Jjg7lq
 Q8cDs75Kxkdcd/ZeGNF5X8KhfBoGKjBkV1jnTd8CG9CMYKpdRrsT64RmKQpU6mpKvZpyeqYBanQ
 34KBtpv62Jw0GfGywtQP6z0TbKWn1W7yNuEN1ZKWHarfURaaPOt5rjRYPNpGB3ZddEXAofzg3If
 omuk3p9nA2msDGHjDRSvzW3ifdKkCd25FLsWMIO04Lj1zaQGXJcwxzYIoR+jCx+Znm7Ea3j2fjP
 vnFIemPSpIeLRX9ohy56WJtYHA8TOqgVYLvcvPpgoWR3r0fkjgYjx/SuHMsSZIjKFBh5sPvRZ5C
 qyXHhp8GQz5I0xgJP5w==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=698491ac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=_zDqL9rT-HGf_AL4Qh0A:9
X-Proofpoint-ORIG-GUID: YUv6e0MTv7r-BwlgU7tI77DUdGj3alqk
X-Proofpoint-GUID: YUv6e0MTv7r-BwlgU7tI77DUdGj3alqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_044850_036862_DB6631E7 
X-CRM114-Status: GOOD (  15.25  )
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

When an NVMe-oF link goes down, the driver attempts to recover the
connection by repeatedly reconnecting to the remote controller at
configured intervals. A maximum number of reconnect attempts is also
configured, after which recovery stops and the controller is removed
if the connection cannot be re-established.

The driver maintains a counter, nr_reconnects, which is incremented on
each reconnect attempt. Currently, this counter is only reported via
kernel log messages and is not exposed to userspace. Since dmesg is a
circular buffer, this information may be lost over time.

Expose the nr_reconnects counter via a new sysfs attribute, reconnect_
events, to provide persistent visibility into the number of reconnect
attempts made by the host. This information can help users diagnose
unstable links or connectivity issues.

This counter can also be consumed by monitoring tools such as nvme-top
to improve controller-level observability.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 7958fe998139..0b3fdd55ba30 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -667,6 +667,15 @@ static ssize_t reset_events_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(reset_events);
 
+static ssize_t reconnect_events_show(struct device *dev,
+		   struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", ctrl->nr_reconnects);
+}
+static DEVICE_ATTR_RO(reconnect_events);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -815,6 +824,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	&dev_attr_adm_errors.attr,
 	&dev_attr_reset_events.attr,
+	&dev_attr_reconnect_events.attr,
 	NULL
 };
 
-- 
2.52.0


