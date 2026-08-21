Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC83C5DF93
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Na/5RcdBHtgRvVRGRdYpcSZaScKfBAt7mDK202DY32w=; b=blvWbzyXi4xZL79gMd0GQ4MiBn
	/azTZJtHdao1AsbPT+4LB+o1ipZPmHvHgVkZv+AxKW0u9+lAnpZIf921eCipqCi/muxMYHADjuSI/
	+RBFVA1IiLeLXb7s4v900E7jPVonLIGmDWz0D73JklMLqBDH7A3Tp9/y/WB1ghQGYwljM2d093RPB
	99GEoWXbIeESV36O8jrIbFWNmS79ZK9WWSXuTtNvXlWsPgxLT9rtWkwbq5+ReqGtNX84POg9gIjKO
	Jln0Rd06N01ujTgBU63U7fEiZzKHDzYjAGuo17m8PtN/sp81NSjOpu2pZ3cgJmcfM6KclLJrln4Pc
	DN01LoYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQTW-0000000DaGD-0Y7J;
	Fri, 21 Aug 2026 14:44:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQTT-0000000DaFh-1rBq
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 14:44:04 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD1kRL1606043;
	Fri, 21 Aug 2026 14:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Na/5RcdBHtgRvVRGRdYpcSZaScKfBAt7mDK202DY3
	2w=; b=r2LregMmj/4YXwU8k1Y/Hqmjd1RVWEUmtw2dWGbcr6OxzRv8JmCGiK3Iz
	/Q0qJ+XocexWLh0LxP76Ass5AxpJuWzhYYP6ums0cTJLknQZf3mMjdBitr1/UqL6
	cyK3QE779UnltMOyHcbabLTZQ+jpgAMT1bml/v5kQ0c+rOMBEhU2WvFK0/uMd4bD
	3p0fSuW9nmbMOej2hMlpdOwdFA7aaonGM5crpWdXqoVO7RI1r8lmI/vcYOKesIvk
	B20jqGGevRJ11VoK4l/ljhOlMMKgTeVSNhqa811HQK6IcVAqLeyzw06e0omwTjn7
	34ZzqqDaAkE5SD3e6oNv0naoeiaUw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4hx5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:43:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LEfTj8031189;
	Fri, 21 Aug 2026 14:43:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngvytc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:43:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LEhksR42467604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 14:43:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B6B12004B;
	Fri, 21 Aug 2026 14:43:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B193220043;
	Fri, 21 Aug 2026 14:43:41 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.26.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 14:43:41 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
Date: Fri, 21 Aug 2026 20:13:11 +0530
Message-ID: <20260821144329.3620389-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a886426 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5ev34OjKPCeWdWCyFbcA:9
X-Proofpoint-ORIG-GUID: UITw3qmrMJcSunSYb-ifSbQitsad1uS4
X-Proofpoint-GUID: UITw3qmrMJcSunSYb-ifSbQitsad1uS4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfX0/GXST13zKFc
 c0A55Eppx1ZNrb2HZhjsk4PPU0CVAtAhRb2UJHVAD7bs4uIoJUb7PsCSwacwBHILDbNDezeYArG
 fMG85qSmhV6XmLyttheU0dlFbXZU88s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExMiBTYWx0ZWRfXxkkHn/XR6Hvy
 2r6110hKjMwyeKBn6XmnRH+gAdc3sN2Gyt+qRCjY/YXtm4rmOniuD+SixxOQfoO1qvAVECC/sWd
 yWfb+eYZqO2PfjBLWCXermLvQ4sgCstQO13SGNYtLxu2pjVmwUCPd1HkvdqrZNbbhhMaLrFF38Y
 rd6KHRJ4S2Dqc+UOXoDpFOuX+QC183uv+Rxm32qSOMQ9Vx9dsUfncVX00801dcOkVxwSyONqgEt
 eN7l8lkcGCRFzuLjTw82YWSZuPbRVf7MkfDA8SnmhYN+W96jx5uvZsN8zT8cQ4qrk0V7c6XKEXI
 b3fjxfDgaTaEETtF4M9bNpWXhuw8kZqS6rSeMnjqKnxj5O6SiMZy7Fqz5Qi9pseXRujgMRosU0O
 9uYxmQSBSlApNQaWlgkcjC1ontAdR7Tr+FS57Ff8lviBOg40Bcn8Wfttvo1sxe0SSZdCx5RxWqa
 bnIkjjPTLC3stijrkEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_074403_609973_C30CDD45 
X-CRM114-Status: GOOD (  14.40  )
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

Hi,

This series is a rework of the earlier patchset[1]. The main
difference is that --nr-io-queues is now calculated in nvme-cli
instead of in the kernel when establishing an NVMe/TCP connection.

This rework is based on the feedback received[2] from the netdev
maintainers.

The original patchset determined the number of NVMe/TCP I/O queues
based on the number of online CPUs and the number of hardware queues
available on the NIC in kernel driver. This series moves that logic
to nvme-cli.

When --nr-io-queues is not explicitly specified, nvme-cli determines
the egress netdev for the NVMe/TCP connection, retrieves its current
hardware queue count, and calculates the default as:

	min(nr_hw_queues, num_online_cpus)

The remaining patches from the original series, which expose NVMe/TCP
queue and flow information through debugfs, are still useful for
subsequent CPU/NIC topology tuning. I will send those changes as a
separate patchset.

The two patchsets are independent and can be reviewed and merged
separately.

As usual, comments, feedback, and suggestions are most welcome!

Thanks!

[1] https://lore.kernel.org/all/20260731073918.614014-1-nilay@linux.ibm.com/
[2] https://lore.kernel.org/all/20260807160904.2eb1b3d1@kernel.org/

Nilay Shroff (3):
  shared/net-util-linux: add support for retrieving egress netdev
  shared/net-util-linux: add support for retrieving NIC h/w queues
  fabrics: determine --nr-io-queues when not explicitly specified

 shared/net-util-linux.c | 265 ++++++++++++++++++++++++++++++++++++++++
 shared/net-util.h       |  32 +++++
 src/fabrics.c           |  77 +++++++++++-
 3 files changed, 371 insertions(+), 3 deletions(-)

-- 
2.53.0


