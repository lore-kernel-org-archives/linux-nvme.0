Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCB2D6EBED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XH6XDVqZvI+X0VUF/mFas401wXQEm1fcdTsqMDpvDLI=; b=oWP8T3U/nYK1GK7MmI1C9RSkXz
	iAhyviotid59Rahzu6ciDfFdtEzf+5I/4gJ0P+PB+mbp1arJ4H2lWH5Ltxg4wTcuH1d314mr+JiUh
	eWFfm/Zolt1UGrhtVXn2/N5sjgOW/c6UXmcCbsa5QfIgtk7NY6nH9zhkk0YKRq1UHe/0X3iB0QC6p
	BPO4yjXfAIsZTU4Az6PXdaISa2fqwgwtu+osgj0jKe0C9RQXC6Lg64d4X151N5mqLFuMYeihqzttn
	BmzCMSOxX55KV0AVgkHuJ0xd6ft1m/H9a9NBGQszUEJuR5ZDrskoK0JIZYtTCGoPp5HwFt3CAS6Mf
	ajdpYwAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGwMi-0000000HByW-38Uu;
	Fri, 29 Nov 2024 08:28:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGwMf-0000000HBy4-2xjF
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 08:28:39 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT3mYfE002984;
	Fri, 29 Nov 2024 08:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XH6XDVqZvI+X0VUF/mFas401wXQEm1fcdTsqMDpvD
	LI=; b=eQAHZUBu9+DeCc60Lj06hpXQKS3ZXKrEGUOHhLcL3zA2j8MpKKQb52ADq
	PSIk2Xgb23YTadwliXXxRJ9QpsVRKuI9hSWT8vEw8sAJ+gPg4Vs+ULU7gAZijDd6
	fYM22l/qhnQob1xGnMLMVRQ4x+LApQt9OzqcFtwF2vewfTjCXbQYAnuoB/F8PwZR
	oo44zOKUx/gVZuH5qnHnornMeXr6B3Sq/vK8TsSCkF9lEz8LlSq8SNYQIzj43uVM
	NRVjVOm2aukzQQp7f7QQWhpwt7mLLJ2AYxEgs14CR4MRSc7e4y6i9RNwxvLkIhVv
	RWUifGv7552W3KVIFHYT461FjHDbQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436tbec4uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:28:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT77mcH011995;
	Fri, 29 Nov 2024 08:28:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43672gu3n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:28:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AT8SRCd17891726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 08:28:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318C72018F;
	Fri, 29 Nov 2024 08:02:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1485D2018E;
	Fri, 29 Nov 2024 08:02:33 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.64.111])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Nov 2024 08:02:32 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
Subject: [PATCH blktests 0/2] add nvme test for creating sleep while atomic kernel BUG
Date: Fri, 29 Nov 2024 13:31:35 +0530
Message-ID: <20241129080231.2994578-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RLLw8FX0OMyh1RR7BS9ADqSG02Zr9rnq
X-Proofpoint-ORIG-GUID: RLLw8FX0OMyh1RR7BS9ADqSG02Zr9rnq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=963 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_002837_757225_6F8077A0 
X-CRM114-Status: GOOD (  13.01  )
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

There're two patches in this series. The first patch is a preparation patch 
for reusing a common function nvmf_wait_for_ns from multiple nvme test scripts. 
The second patch adds a new nvme regression[1] test for commit 505363957fad 
("nvmet: fix nvme status code when namespace is disabled").

For fixing regression, as suggested by Christoph[2], I would send a separate 
patch upstream.

[1] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/   
[2] https://lore.kernel.org/linux-nvme/20241022070252.GA11389@lst.de/

Nilay Shroff (2):
  nvme/052: move nvmf_wait_for_ns() to common/nvme
  nvme: add test for writing to file-ns just after disabling it

 common/nvme        | 26 ++++++++++++++++
 tests/nvme/052     | 30 ++-----------------
 tests/nvme/055     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/055.out |  2 ++
 4 files changed, 105 insertions(+), 28 deletions(-)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

-- 
2.45.2


