Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AEDC982DA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iLjgYPxddNtuBGrPgnvvpKAUKmcAkKJxdPmq3t2sEQQ=; b=Y9ZiaLV3xnAxR8ICPtJ5JueWQ9
	yWHRZtTgvFszQv2UY7m4hIeBkvZrc6S0T3vZp4bDYsE7lif7kssL49iTqnCUGTpFWcZpzsWb7gecA
	rQJNxscH7ejjnYrOLxOMnMXzaOoJKJNI87ZSxZe3ClFm/ushyo2aijagz//+s1nFVRNTrYwrvDAI3
	uP1AeFV2p173Xe8WLP9WWwFWeESv6w6XjR6soYdpctXWy9iw7oTOqGjEEvzlxJlQzJhc7+VXeLyU9
	Vett3twfyDDFWc7daqzIUXxVHMQL51HM/u+WCF3AQyRFR6BvWk5c2f5BYOwppQZZTt2qSLuuIhCFO
	2nLbWXpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7bRX-0000000F1U8-4BPO;
	Fri, 18 Sep 2026 16:28:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7bRV-0000000F1Td-3t2x
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 16:28:07 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDW1XJ217949;
	Fri, 18 Sep 2026 16:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iLjgYPxddNtuBGrPgnvvpKAUKmcAkKJxdPmq3t2sE
	QQ=; b=ZZND4UWlGxT/PRFM1rdp8KD92tmlaXjt8oyVVpRw4Fn8SLtFNr0VJOiP9
	lb+USctXZ6RY0LW8aaWJNtOfy3YQc7G1Qx4rH6p4cxPWTa+pv+1zzgawVtUJOwsU
	k4qTESOy1PLupCd0I9UKk1KcXIoa0cAsKKuAmKWmXWAmKW03kv3TIhoAOvjAJOX7
	p1cnhrOBvBiVQnEhzywiYbuB+6t77dY6Pm6bZef3m+9tbl8ncRz4Ir91FxaM9akt
	so7IZdEhIJKcfDvND9ooor48raD9sahg2DGJTjKgMUv68a99BpMOnvpxZtwTb7Cb
	xOyC5nxdfuCq0jkt3/f83RmWIfUrg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5egpay-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 16:27:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNq2o739423;
	Fri, 18 Sep 2026 16:27:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q8x75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 16:27:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IGRrLV47841640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 16:27:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D30B20040;
	Fri, 18 Sep 2026 16:27:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F53820043;
	Fri, 18 Sep 2026 16:27:49 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.58.220])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 16:27:49 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 0/2] nvmet: fix subtle race in I/O processing and ns configuration 
Date: Fri, 18 Sep 2026 21:57:29 +0530
Message-ID: <20260918162736.802665-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX3acdlFbCz79e
 v1JivbGRlXV/vbPVouw4rdtYWJU1gf6Z44anIWtMTYACe1iWoHDbbN+YvQBG0ilb/7thPcj2oP+
 OpeFlKhlrY0OdszgpQZ8vjKI3VhdLacElO/RYFqekuFvQS2dWQgMXUyCDSZHEjR3vXPk3uRnA30
 G1by77QXEWNq5mbGLuOEncq2NfQzWO3Vn5ZZe1GvYOmCe3q3zjEFYbi8deQjMug1z3xRBEcH54c
 Hdc1q5eqXWcOaXlgn9aE9wIc7GA15wgptwej5tIRHq+J9UKDCPTEZDEkMyU2HegnCKj1inpsGDh
 O4XyqCfI+RV0h3dhXBhUTmz8158E4X6SwVihQVwlTzli7yepOT5gdqsdwt0URBFZZ6dNzNc+XTO
 3fnOrkmDrGYUniEIefGtfIEsLxZDH0P6DfijJS3wUrWkU2mG0XpW996CctobEPPYq6y01499TCf
 +BcZz/jgbG3hAcVtwwg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad668e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=fAA4TpzF4eqHYy8hkuwA:9
X-Proofpoint-ORIG-GUID: E0dEO139w3rWVlbV47TIA2S68gkpZPe3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX28zyyaqt7fT9
 JW+KPLC/TMYd378m6xH9U+LPMwJkcrDl17Q/Aw1Rm7xVPTk0dLQKqzrcSxiaMDwa6j8DrkQdiHA
 4bpeUBAH+zoV4U7ECfTcaiXX9IAweGo=
X-Proofpoint-GUID: E0dEO139w3rWVlbV47TIA2S68gkpZPe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180229
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_092806_082902_06125E74 
X-CRM114-Status: GOOD (  12.86  )
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

This series addresses two race conditions in the nvmet core code that
handles I/O submission and namespace configuration.

The first patch addresses a race where target namespace attributes
could be changed while I/O is in progress. The second patch addresses
a subtle race that could allow I/O to be admitted even after the
percpu reference count has been killed or marked dead.

As usual, feedback, comments, and suggestions are most welcome!

Thanks!

Changes from v1:
  - Replace the XArray mark used to determine whether I/O should be
    admitted with an atomic bit. Using an XArray mark would touch
    significantly more cache lines in the I/O hot path than a simple
    bit test (hch)
  - Introduce the NVMET_NS_IO_LIVE namespace flag to address the cache
    line overhead of using an XArray mark.

Nilay Shroff (2):
  nvmet: defer setting ns->enabled to false in nvmet_ns_disable()
  nvmet: don't allow I/O admission after percpu ns reference is killed

 drivers/nvme/target/core.c  | 28 ++++++++++++++++++----------
 drivers/nvme/target/nvmet.h |  2 ++
 2 files changed, 20 insertions(+), 10 deletions(-)

-- 
2.53.0


