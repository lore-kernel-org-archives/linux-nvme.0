Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5066FE63F04
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Feb 2026 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2j4O/A9VuSzp41A2WFtD0kkgwUil1V2tb3mxkLq1Xg0=; b=S+s/k8rTVzvI6oJJIO8eeewI8n
	0CXWdwjX8S+LWpSB+30g/MgR/kLbd9lPo5aZcuP3bS26+zFEZnvhlLZYMO2zzQflclChxmlzT/ib4
	Ac1CH2y0++P6PjKEiUDltEVfL1JtxWFwC1ERZWq1uiXNlqUkXN+rZ24+YT97MermXOHBOqFBr1pBA
	p2tOrmQLstpp5UD79UZI1g3C481wgbZGJg5iOW0R0sZ7nlwFG1wFEmDIdgtFoF07vpC2bnthhHKwU
	IlEd5Uk0Bz/+imOecZZ/mUUkxHWDub0+RMMd/J5ILSCxdAyGrJpccQLlmofffXcQ+NuWM3GMK8Fv4
	ed57BZ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrfaL-00000005XQG-3tty;
	Sun, 15 Feb 2026 17:07:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrfaE-00000005XPu-2Q8D
	for linux-nvme@lists.infradead.org;
	Sun, 15 Feb 2026 17:06:59 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61F4wLKA1628461;
	Sun, 15 Feb 2026 17:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=2j4O/A9VuSzp41A2WFtD0kkgwUil
	1V2tb3mxkLq1Xg0=; b=BZy8I8gomQUaJyE2PbRbk5e2EUwibis+UNWW0leR+hmi
	E4ZErglGLUbhiL3ueMJPXUM8MXo216PKBVcZWNt2tXbYEZFRule86jRBYfB2/H0Y
	+Awp2S5+ZdJiRJ7qnTXvdhC6Eb02gXTaLGflB4GDkMOKXfbI1Qc9zGeTMmAM4j0v
	88LVxNPrpDeRoJvo3rmXKV+jT+6SRepMc3nS7g4cMEYy6HWkM1EH15eNpakYFs7g
	cG8ZWhsynsY4+ItZ0OUDZvCVoRT5MWwZ2bFTeWvV3kubnhmNxNAiriFMmciW+z/O
	jeYSio97tHuw2BnYwq0BlaTy8cU/UV/VYbm/+NNwHA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rmfvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Feb 2026 17:06:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61FF5paI029055;
	Sun, 15 Feb 2026 17:06:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb63122dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Feb 2026 17:06:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61FH6hwM30999224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Feb 2026 17:06:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4AF5580F1;
	Sun, 15 Feb 2026 17:06:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D38DA580F5;
	Sun, 15 Feb 2026 17:06:40 +0000 (GMT)
Received: from [9.87.129.147] (unknown [9.87.129.147])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Feb 2026 17:06:40 +0000 (GMT)
Message-ID: <5db8ce78-0dfa-4dcb-bf71-5fb9c8f463e5@linux.ibm.com>
Date: Sun, 15 Feb 2026 22:36:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc <lsf-pc@lists.linux-foundation.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
From: Nilay Shroff <nilay@linux.ibm.com>
Subject: [LSF/MM/BPF TOPIC] Topology-Aware NVMe-TCP I/O Queue Scaling and
 Worker Efficiency
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6991fd24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yGjGUCt0QYB_whSCIRwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gzIvEL1N9LwI8Flq2u_mDsXdzf3DO8jg
X-Proofpoint-ORIG-GUID: gzIvEL1N9LwI8Flq2u_mDsXdzf3DO8jg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDEzOSBTYWx0ZWRfXw+D5cTQId2Ia
 qTbJASFphwGOm2ZCU+PF6NabHaraqPVrJiNr7Fabi9ZSpf+dRoSCMxLHuRvw+/lE+3NiUdxbmi7
 JytbFXWTPusORRpzSpGRd7PTjoZKjatIxR4UzLL2TbuymUxSG3zG1BG1hKL2s5sfqy15WZFBw6h
 ZcHlmP9dFbw8aUFJAiz8SpcYubpVcV5/kf3dvy5IwqAPZfO9opIqpqdfa9hycV2Eqi0KmGzAdfT
 U+c1v44GsxOpqQyHFBijjAxj+hgiXT1SR05NR8jg9y5X20r68mF28pCH1l0eTyk5bl+h9BQZJY2
 H3JspHkRxzPbc4xCKmhzGGCHhMW5cKpINqQZ+4WRS9BOjbWYohNvNqgvRTO7bO+DIUgdAa9seX9
 p74CmyUK4SN5pByPzSy4peJGoLTSudvVg/fj+bLOsEkT3JlIr8EewUrfhbLgN1LtuiJC25lUQGx
 +uJpivXR6Os2buTjt3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_06,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_090658_633724_3A8D7887 
X-CRM114-Status: GOOD (  10.94  )
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

The NVMe-TCP host driver currently provisions I/O queues primarily based on CPU
availability rather than the capabilities and topology of the underlying network
interface. On modern systems with many CPUs but fewer NIC hardware queues, this
can lead to multiple NVMe-TCP I/O queues contending for the same transmit/receive
queue, increasing lock contention, cacheline bouncing, and tail latency.

This session explores making NVMe-TCP queue provisioning and execution more
network-aware. We propose aligning the number of NVMe-TCP I/O queues with the
number of NIC hardware TX/RX queues, and binding each I/O queue to CPUs that are
already affine to the corresponding NIC interrupt vectors. This aims to improve
cache locality and reduce cross-CPU wakeups in high-IOPS deployments.

We also examine the behavior of the NVMe-TCP I/O worker thread, which currently
operates under a fixed time budget (~1ms). In some workloads, the worker may
relinquish the CPU even when additional transmit/receive work is immediately
available. We propose exposing observability data such as per-worker I/O processing
counts, relinquish events, and CPU placement to better understand and potentially
tune this budget.

We plan to implement a proof-of-concept for these ideas ahead of the conference
and and submit RFC, if feasible, demonstrate the impact live using fio workloads
on a real system.This session seeks feedback on whether the NVMe-TCP host should
consider NIC topology when provisioning I/O queues, how tightly queue placement
should follow interrupt affinity, and whether additional observability or tunable
budgets for I/O workers would be useful. We also discuss potential interfaces
between networking and storage subsystems to support topology-aware queue scaling.

Thanks,
--Nilay

