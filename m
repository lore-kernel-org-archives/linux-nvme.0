Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A87CC982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=740a4tfkRqtAJLO7JWdBAbGZvmVDgDhA3PLN/FA/1NY=; b=LC4HNFEZZJWmrVEOXNqICgAbD0
	uwWRtvMKpAbLeyQrLXVWia4bVjkT/HJ0hMb7WuKqhHNm6ngFDpOmQXtJHSIyYK5ZO8KN+n9GXejHf
	EBuPor9oJSSe6qBGiq9yYKKqZHdQTy9DzlsllnFuOu8g4KbcghZLmMy2VP2NJDXwoifRJfY3Mab2C
	Ex0Ec2odMrmR7H4OkWAsCkOblkR/2q64Bb3lYI7HL6RY2s6Milz21URmVAUqlcDbtAfwZkOEGgaes
	ofKWCmA5cCDgOAPizt8qLGAkplo30TMY4sCfLw9+72punMJ+WA2XJqb3LS4s05HHmuDLApOozknPx
	s235Ok1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsH-00000001H09-0AEj;
	Mon, 21 Sep 2026 07:55:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YsD-00000001GzL-3jF2
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:55:39 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZU733153824;
	Mon, 21 Sep 2026 07:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=740a4tfkRqtAJLO7JWdBAbGZvmVDgDhA3PLN/FA/1
	NY=; b=N2NXfWHFfcZnIe5Lcg+6/DGvSj5g3NBlACrTRIQ0Xo0aA91kQoZwoiZjy
	5CbMNCgtrkOadPEYSIQvp2GcPJHlBKw7r8zu8KqFmMwsuS3SsyxHyXPvPI13rMqP
	RmiuHdW+6+8jI4v8n12plHvLJGUwFYx+vcGAxi03tIhqMIxiLDzWBKjrmwFtsKBQ
	ZMlsb5+JyRWlhLrzDzvzi2LIoxPGYG0NnnRx0lWKso0sM0xG1Y840G25Es1b6eOW
	s1USU3xU0q7YfLl9/t0s8e0d0jlkq1hvHLFC+0ELSw2ULVbGKjuv/1AclDCjsfYK
	0ra4DbPMfYEfwYrLnmJoR6obNWOeQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fd9j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HdFj867852;
	Mon, 21 Sep 2026 07:55:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vcf83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:55:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L7tJvv45154572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 07:55:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D9220043;
	Mon, 21 Sep 2026 07:55:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC7720040;
	Mon, 21 Sep 2026 07:55:14 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.138.180])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 07:55:13 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, sagi@grimberg.me, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 0/4] nvme-cli: NIC topology aware I/O queue scaling
Date: Mon, 21 Sep 2026 13:24:58 +0530
Message-ID: <20260921075511.2108561-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q_M0V0v9ezYG2hbKnjOWmmrStZoTGBiB
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab0e2ec cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HUNFkZ5j2-5L5FLJlG8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfXzRH6P8Jdk6PD
 OiLIFJ5gxN19GQH0on6Scj/PYW0g2nu6E+whf1lCfT1/RtJehHxo5CqLWpAPfm39VJcPowaXyup
 MYwTVMkAhds35lbAkhp5/p6AAErTxuQ=
X-Proofpoint-GUID: q_M0V0v9ezYG2hbKnjOWmmrStZoTGBiB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX01wsYkbz75FD
 5lGuQ7yASlJBpa/La5Rj/nV696z6e6sA+ZY5RlUEis18Yf+4wSwRYHKIgxknHh5M1xydfQDLiF9
 GBdwtkWQI0sqXzX3GyZNK7yZuvIUWqFsOyFuaFz/QON5z87KUKtCwJETg8TqVLqqFDbnNet4ydz
 B73NCxtTtoz1KcZiqKEuPcRTU60uXNBcgi3RHfYOEt6DV0rclLBinJ+VDGnVtAUk3A52Q4eYvvz
 JpcjstSJ5LUIhqsjDzqdOLE37I5K6xhHunDIJeND3lTFFk848tlSlhsD2ZzP/N87XJvbXqOyfJN
 u4jlMLWPIpWYEonfUC1EI3cguOLciQei1Q4iqMCbjxoKGhRJqEW0SwkcWOOkIpo2kFb2gDVIa5T
 KD0ppQEczj8gZ8Z+ql4Sbx2q9ChUjrlKFX93pbY5FeGMTHyOfcz3Tc+Y9f+Vh0gndOWXDzpmHFw
 h3yRiIWkj9ivzjMddAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_005538_045460_6B72EEC7 
X-CRM114-Status: GOOD (  15.91  )
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

If nr_hw_queues cannot be retrieved, or the NIC only supports one
hardware queue, do not calculate nr-io-queues and let the host
determine the value.

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

Changes since v1:
  - Added new patch 3/4 for covering unit test cases for 
    shr_route_get_egress_iface() and shr_netdev_get_hw_queues()
    helpers (Daniel Wagner)
  - If nr_hw_queues cannot be retrieved, or the NIC only supports
    one hardware queue, do not calculate nr-io-queues and let the
    host determine the value.

Nilay Shroff (4):
  shared/net-util-linux: add support for retrieving egress netdev
  shared/net-util-linux: add support for retrieving NIC h/w queues
  shared: add more test coverage for net-util
  fabrics: determine --nr-io-queues when not explicitly specified

 shared/net-util-linux.c      | 265 +++++++++++++++++++++++++++++++++++
 shared/net-util.h            |  32 +++++
 shared/tests/test-net-util.c | 117 ++++++++++++++++
 src/fabrics.c                |  79 ++++++++++-
 4 files changed, 490 insertions(+), 3 deletions(-)

-- 
2.53.0


