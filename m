Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525B7E77179
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f9BR1f56qQpQp9HptUV3ZPnmYmN8vAT9Be3tMTrAlE4=; b=oLj/2+ie+nE43bbwR8KYsQsdnx
	tsuDaLkXOnQBgDAc6ypu3y1DganZmUsY0cQyy1g89tlUk0FOGkC0n3jvw/kKZ42z1NU1OwTn4iaol
	T72lUoZolL6aYnSisarrjJrj5i71yD2JcYtlE8i/1qK/icjE0eSPLG9dKPXQNiwiXFfFsW1tmYy9w
	kKpIBKTrMrb1K8LsY7w1+guhuFPo4lohLrnPVMajej+vUSBVQrEXqMV/4ApbbBsojmjkReP7h0PEd
	HpPylSSeLk3GKDQAfGyjI8y2CACAp56ux7PEeLt7EyY98yob8BoEX2rU0mSNiyh9mSMdHfVJEUgOe
	FIQe12Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJWLy-00000001QX8-0uVI;
	Fri, 06 Dec 2024 11:18:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJWLv-00000001QVZ-0Gu6
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 11:18:32 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67UPhl000585;
	Fri, 6 Dec 2024 11:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=f9BR1f56qQpQp9HptUV3ZPnmYmN8vAT9Be3tMTrAl
	E4=; b=oGDeONQefEMhJsSrCO0ubb6KPaLeMR7L5oAbuSzBfPxiJsWa3UXB4EMti
	Jvcjq8fq3PZjT7rGjsPANMUKeiSEmZ871DPiA0y0s23w8HicHDEzTPtEFxfm12lH
	8HsJDEe0wfEmbrgAGKVKKzW+NZxYIIDvFCFiNygBfEkUzOlpFTGpBDxMqk6/tVxb
	vfTcTWZrcD2B3ENcSIN14HYkwNSKCWSLHwWOmcbmnrpoa4/cHPxEt1PjifdaAwww
	Vtr3IeMNBfOq+ySitnP+nJGLfidPrMND7vd6Jasn2RBn3a09jTnZ77tgkdJlaqqU
	9Z80JDiC2MjIlLfvXAPtuoTyNzhCw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxkrwar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:18:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67WHlD005226;
	Fri, 6 Dec 2024 11:18:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxw33x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:18:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6BIFYZ28639996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 11:18:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 470762004B;
	Fri,  6 Dec 2024 11:18:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3223920040;
	Fri,  6 Dec 2024 11:18:13 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.0.162])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 11:18:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, dwagner@suse.de,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        gjoyce@linux.ibm.com
Subject: [PATCHv3 0/2] add nvme test for creating sleep while atomic kernel BUG
Date: Fri,  6 Dec 2024 16:48:06 +0530
Message-ID: <20241206111812.489140-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ouwMdldnhn_SgWZJb1vWC94m_qHcWGAD
X-Proofpoint-ORIG-GUID: ouwMdldnhn_SgWZJb1vWC94m_qHcWGAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=840 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_031831_226968_7DC5DB76 
X-CRM114-Status: GOOD (  15.62  )
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

Changes from v2:
    - Update the comment in second pacth to highlight the fact that this 
      test doesn't depend on udev rules to recreate the regression
      (Shinichiro Kawasaki)
    - Instead of creating source/data file using mktemp, use /dev/urandom
      as data file to nvme write command (Shinichiro Kawasaki)

Changes from v1:
    - Update the second patch in the series so that we can trigger the
      regression 100% of time when we run the test (Chaitanya Kulkarni)


Nilay Shroff (2):
  nvme/052: move nvmf_wait_for_ns() to common/nvme
  nvme: add test for writing to file-ns just after disabling it

 common/nvme        |  26 ++++++++++
 tests/nvme/052     |  30 +-----------
 tests/nvme/055     | 117 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/055.out |   2 +
 4 files changed, 147 insertions(+), 28 deletions(-)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

-- 
2.45.2


