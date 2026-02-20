Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B16C5516E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xj/xd6tAqBLay8N1CXR5mTvgUAwc28j36xVrP4YnkeU=; b=Cu71ekS3vviShyYAQsOFM/MIej
	CVVtX1aDiFZ9cwDFeMcC7qpFqxifTXaLRMEQ5KyV5T6pcO/3YVA+1dxx8UjuAFGcadsv2rK4nS+Ao
	XvqWXU0ZMPadrUReAERDP+ICh94647aixyfVK/XWeJhmJtu7q8j9NFqV+FCBPOCO0F5QJ6O6Xsjy6
	kFvKqQqbogRma8xINUIF7IOhVe/VaK/FTOXmg/z+01uKB2rA9pJKpavqD2D9gK/SMl9D+xT46LKgZ
	C5k6dztg2/+AUZJZPIrI1oUceZkWrBF2SQX3rMhSkWoF7NYlyXnpd95ELbrihJKnSFIkKOUrnJf6R
	5/gBBIJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtNC3-0000000DgTr-0pVd;
	Fri, 20 Feb 2026 09:53:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtNC0-0000000DgST-3yzH
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 09:53:02 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JNTOhi1261190;
	Fri, 20 Feb 2026 09:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=xj/xd6tAqBLay8N1CXR5mTvgUAwc
	28j36xVrP4YnkeU=; b=BwtdtriPBc93jgHGgHM6C302mRz1VuW+U0VIL3UNGwaX
	bUjT2Fha4DZpSofPd3jfM/15ZZCLFPerl5vWP67YB16GdhrKNAGtdQvjAolE5xQe
	YAQKfEs/lwXoVPjZyaiy/WwvEuRXZ8ZF55vn2Ty205KjvfR9SaSG+I5M+UMPMgUE
	ikRiyOIgxWsdCZPyJ1KEufYjq9iW/CTMFLfPXXed05aBvSuZcy3XftkvljgyJRZJ
	VQnO3lRowOSpCjrgnuN7JzG3+gWCy4kuIOa3uB+9rVgv9WbcNR44NDgrPqUuYDia
	SeiUeQm/n2XInZOY9KB1r/BAs6H7LK5HEZ2vaVSd9w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6sad8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 09:52:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K9A5YW017792;
	Fri, 20 Feb 2026 09:52:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28qw7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 09:52:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K9qjcJ28967578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 09:52:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A81C358063;
	Fri, 20 Feb 2026 09:52:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450E258052;
	Fri, 20 Feb 2026 09:52:42 +0000 (GMT)
Received: from [9.111.50.5] (unknown [9.111.50.5])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 09:52:41 +0000 (GMT)
Message-ID: <966a3992-b86f-40a3-b0ea-927de4634efb@linux.ibm.com>
Date: Fri, 20 Feb 2026 15:22:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
Subject: [LSF/MM/BPF TOPIC] Adaptive NVMe Multipath I/O Policy: Latency
 Measurement and Path Scoring Design
To: lsf-pc <lsf-pc@lists.linux-foundation.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69982eef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iC2A9ROifm8SyQuNW6QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oMuNubd4YP6woOqSLu10hMYtsSqVz_5O
X-Proofpoint-ORIG-GUID: oMuNubd4YP6woOqSLu10hMYtsSqVz_5O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA4NCBTYWx0ZWRfXzWCXZG117DBu
 aCaJzi5Ne4iDnkDO09ZzhaAGpsRnoUEG8BNuyzCIlc4rcciTCWSyVhmR7At7tUlDATr1e8Jt0tX
 lRcTgVR9QPnfxyY4yQCkbOZR/EnHHQgQmczfC/dy2YA1aqtNpI10beehFmaSD56YAFkRmISNpKg
 W3NO3aJW65kUrVE3VpAJws7ibSiOXqAYSOa6dit5DeO4QA0v62n0VTpxqUnKJhNsimo7Z6iseib
 0CE9R+0aS9TYD81RxDmTqY3jxMldiGaclisqYb587Dj8bq5k+5BHLAfym4a1qAPHd+p//gD8ZLR
 K6nSiwL4txBjJTznfFLQyLQPIwXB2kj2L2wEEmDuxY0FGxYhIaY/dn8wy+btwerpAwLNXQsH0Ng
 fijyi2jWoQBVLgxGcE+vzOFW48Yh0+s8z1vjpChtraTetje4oFsMp68JTNYBdu3qjCfQJcZWgRN
 xPkaIzSbXZqg5Vwf19Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_015301_002325_156B3E47 
X-CRM114-Status: GOOD (  11.16  )
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

I posted an RFC [1], back in sept-2025, proposing a new NVMe multipath I/O
policy called adaptive I/O. The series is currently at v5 [2] and has received
valuable feedback from the community, which has been incorporated into subsequent
revisions. The policy dynamically measures I/O latency for each active NVMe
path and derives a weight/score per path based on observed latency. I/O is
then distributed proportionally across paths: lower-latency paths receive more
I/O while higher-latency paths receive less.

Initial experiments show clear performance benefits, particularly for NVMe-oF
deployments where path characteristics can differ due to fabric bottlenecks
or heterogeneous links. In such environments, static or round-robin policies
may underperform, whereas a latency-aware policy can better utilize available
bandwidth and improve overall throughput and tail latency.

While there is general agreement on the usefulness of a latency-aware policy,
there is not yet consensus on how latency should be measured and how path
scores should be derived. The original proposal measured latency per-CPU, but
concerns were raised about mixed I/O workloads and potential noise from
scheduler effects. In response, additional approaches were explored, including
I/O-size buckets and NUMA-aware measurements.

##Discussion
At this point, four possible approaches are under discussion:

1. Per-CPU latency scoring:
   Measure latency per CPU and derive per-CPU path scores. Use the current
   CPU’s score to choose the path when dispatching I/O.

2. Per-CPU with I/O-size buckets:
   Measure latency per CPU and maintain separate path scores per I/O-size bucket.
   Dispatch decisions use the score corresponding to the current CPU and I/O size.

3. Per-NUMA latency scoring:
   Measure latency per NUMA node and derive per-NUMA path scores. Dispatch decisions
   use the score associated with the NUMA node where the I/O originates.

4. Per-NUMA with I/O-size buckets:
   Measure latency per NUMA node and maintain per-NUMA, per-I/O-size path scores.
   Dispatch decisions consider both NUMA locality and I/O size.

We have not yet reached consensus on which of these approaches provides the best
balance between accuracy, stability, and implementation complexity. An in-person
discussion at LSFMM would help bring stakeholders together to evaluate trade-offs,
share data, and converge on a direction so we can move the adaptive I/O policy
toward upstream acceptance.

[1] https://lore.kernel.org/all/20250921111234.863853-1-nilay@linux.ibm.com/
[2] https://lore.kernel.org/all/20251105103347.86059-1-nilay@linux.ibm.com/

Thanks,
--Nilay


