Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80C606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WMV9KZ5E;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D8R8lEeG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=EyRgYOFVImnebIcWSNF86vkRsvFfWCH+VI7OFr+Ov3o=; b=WMV9KZ5EUgv8Sqa2cIQRqevmVl
	hjZPi30V5YhkEOacDvkKfTr/whMPeDE+mqKsqlPhslfBv4PiHwYOW0JrDwzVUluTYsD/UyZ4+J7Zk
	jJj5rqhdt0lEvFjWnGBX59catvjwEhGb3n/GfH0D/R/vu9d7SUZ+fnSGbdyX/vb5zWZI0y/f0GSmG
	ZKjEdCYHUmtiv6zJtc9/bJ/rtjPMQPL5HRcc9kVKNK+dBzkKQ+m4G4DeFCukBJYHOZJqnfwtBTewq
	wq8bj7SRU9jugwHjjRhlYeYXNSguGnLxMgyy6Ch0CXdGkLXC0+ll7UNQ4DQhVuxN5KT+VyC+2vBLv
	MbPLm6kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXzZ-00000004OG9-0QQw;
	Mon, 23 Nov 2026 17:38:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXzV-00000004OEa-3HDW
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:38:11 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGYg1F4069030;
	Mon, 23 Nov 2026 17:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EyRgYOFVImnebIcWSNF86vkRsvFfWCH+VI7OFr+Ov
	3o=; b=D8R8lEeGH39lBCrezFYYdnpVMOI3uaBJAAJOHnGDMnvSQwDvDhkm0cubZ
	Apou1Dvltg93TvwljQSvFpj8y5GH40iP0Tl3fQqGTGz7rZeKeVi4L6rkBOQF0woj
	akNWuQr8YFktnEEIZ6v2Xe6QKr7dzkwschTcl8rSSU4ik4VYb+QjNPDEpUvMgGZ6
	TpFGZSedJHqRXG7bgJrp+B9LzsYoS+dmXtEOhoVf/OInjLteBUrm4KOLBUskF4sx
	mi5y31YlGmi8uNDhwkDCSBTkupSZ4CpIAPECjxOLY8VLrg59O5Va7wB8tac5wqz0
	Z+XNWhUoi5RdB+gLnD1oYKhbqA+yQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv42cn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 17:37:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGJuY53225873;
	Mon, 23 Nov 2026 17:37:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h7mdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 17:37:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANHbhq950856444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 17:37:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A3752004B;
	Mon, 23 Nov 2026 17:37:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72C1420043;
	Mon, 23 Nov 2026 17:37:39 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.173.125])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 17:37:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, dwagner@suse.de, hch@lst.de, hare@suse.de,
        sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 0/2] nvme-tcp: NIC topology aware I/O queue scaling and queue info export
Date: Mon, 23 Nov 2026 23:07:22 +0530
Message-ID: <20261123173727.2022020-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b0479ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=6zI6yM-bqozbs1XlkEoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfXwC0bJVZAdM8W
 8NK6yQZQa50Mx9oJqkqLu7AzL8dlJbEdIqAANhyQ+/uXaq2s9eDHVbvKA+NXWVMIJgPIbWygymX
 j3DJMZwVhJv2/8YoVe+XKd61fH5Pvf0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX+k8hiHiLgTJg
 2ZeXDD9EwWlDNGEnsx2jISHnnPiq+GGmcBL5rQcQS9OGvBJ9NkTDIfig8j0qRtE7dSx3evZGpld
 gPjHh68GiYL/G9z5Sk/drPi8oC9MgQidHT/cDy2/gShl2y4Ly76s1ki7COJ2RNP7k5uwhEVBsAY
 n2OmROvuXF9+NA3+Slqd1HmyHcrQ87jro469HM9pLpLEj1MnwE6a7l8EW11k8DxBcYISsLa7hd6
 nTrpvWgctIxSNlsriqr1CFu9Hu/doUJViMWFqxzzFFtCDGRFjrKAt0x+XI0Md3NE4hZuzAnWgba
 qOzSUyht1BqKey8dhEo2h9fJExDbb0ulfnY+ohOK99EcXo9zK3oxwQQZzStzDvKMDYLARdGMJ0j
 eb7RvO0etTnnxcJEwTnaDamBpl+KEoDexzwHv/5/v9KCBcyrpzW80yN/XPT4GbGmWG4Hbb2PN7R
 4MJYYomuuGNjk6iotew==
X-Proofpoint-ORIG-GUID: 2fK3ol9aZICDi34dLQDLuWFZ1y1HuU8D
X-Proofpoint-GUID: 2fK3ol9aZICDi34dLQDLuWFZ1y1HuU8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_093809_936030_20F0BC88 
X-CRM114-Status: GOOD (  16.25  )
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series has been revised based on feedback from the netdev
community [1].

Following the feedback, the logic for determining the number of fabric I/O
queues (nr-io-queues) has been now moved to userspace in nvme-cli [2]. As a
result, the first two patches from the earlier series v2, which implemented
this logic in the kernel driver, have been dropped in series v3. 

Based on further feedback received on v3, this revision also moves the
export of NVMe/TCP I/O queue information from debugfs to sysfs, making
it easier for userspace tools to access the information and configure
host-side network tuning.

The first patch exports the socket endpoint addresses of each NVMe/TCP
I/O queue through a new per-queue sysfs attribute named address.
This provides the TCP flow information (source/destination IP addresses
and ports) for each I/O queue. The associated CPU assignment can be
retrieved through the existing io_cpu attribute.

Together, these attributes provide userspace tools with the information
needed to configure:
   - IRQ affinity
   - RPS/XPS
   - ntuple steering
   - or any other scaling as deemed feasible

Together with tunning, these changes allow better alignment of:
   flow -> NIC queue -> IRQ -> CPU -> NVMe/TCP I/O worker

Improving this alignment can enhance flow-to-CPU locality, potentially
improving performance and reducing I/O latency. Performance evaluation
results comparing the baseline with the tuned configuration are
available in [3].

Thanks!

[1]: https://lore.kernel.org/all/20260807160904.2eb1b3d1@kernel.org/
[2]: https://github.com/linux-nvme/nvme-cli/pull/4140
[3]: https://lore.kernel.org/all/20260731073918.614014-1-nilay@linux.ibm.com/

Changes from v3
  - Moved per-queue tcp flow information from debugfs to sysfs
    (Daniel Wagner, Hannes Reinecke)
Link to v3: https://lore.kernel.org/all/20261026123411.1988949-4-nilay@linux.ibm.com/   
  
Changes from v2
  - Dropped patch #1 and #2 from v2
  - Added new debugfs attribute parameter "is_visible" which could be useful
    to hide the attribute for certain configuration or transport. 
Link to v2: https://lore.kernel.org/all/20260731073918.614014-1-nilay@linux.ibm.com/

Nilay Shroff (2):
  nvme-tcp: expose per-queue socket addresses via sysfs
  nvme: document NVMe/TCP per-queue address sysfs attribute

 Documentation/ABI/stable/sysfs-nvme | 18 +++++++++++
 drivers/nvme/host/tcp.c             | 50 +++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.53.0


