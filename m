Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62D6E7716B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HiFx9ztH3YONmubYFQIQW7MYPVw/KT2DWtF8J5Ub+Bs=; b=MzJej1s69gvczEWmZTAQ7L6kFv
	PDmH4aA/c4wuaDdcxVfoTxVkltoovjNE9A4HjXrxalILy3f+AAvlR1IhuN9KYBjsbPD5EpdbcszXn
	fckysNgyznBZVg3hlzxXHFkLGFMZmWNctqhyr/9Ly1Wj9Kw6QflXG2ZlRctI/JRz44PD0ivkAe83I
	9XFloRw0w5FgiYiosJzPOjUD4PoprYg2vIl3c3KX1rNAYflixi8nojLg1VvayLuqYEQQ2AxduP9Ao
	7YhzQ27wAzZyUGij6ND+VB7Gr1iwbD+pydZKWvXLVp/cZVLfm0mPVaqmLBkH1Y0bt9VFGTXzBPbsL
	s9UZE/ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tInrc-0000000CQir-0oqy;
	Wed, 04 Dec 2024 11:48:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tInrZ-0000000CQhq-35nC
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 11:48:15 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B47IBBS003350;
	Wed, 4 Dec 2024 11:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HiFx9ztH3YONmubYFQIQW7MYPVw/KT2DWtF8J5Ub+
	Bs=; b=szssRyadF0Rc47hcu790unoeVqOFcpUyBIF+OaXIvpM8UanYQGcHxg3eI
	7LZGSymko4J46hzVUchghjlhECWQRtgxRZYBg6nKyxT6lVx4a6wEa/7Z1/tLt6gS
	eN2M+nuuJFRAUXE5NDBeiZbzz58zBRj7lbo8xMrjRGW7Jh4SIl+t9HZmV081f00i
	mRSrYeeuCaEC9WhkxgeMcuaFGv6T0QW6x2cCFMqRtjpXCdywVIWMioD2H+0kV+4D
	5CoM/2gk1WlEP15OgC0z2lPNiOS/0Q074ojG5OraxoHrldkXqbt+tG4zFIOxiEdM
	3dU6pQ35Op0r7r4/VFPVPiayutMfw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437r4pqer3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:48:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4B3vaj005278;
	Wed, 4 Dec 2024 11:48:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1mp4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:48:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4Blwck26935842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 11:47:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FD402004B;
	Wed,  4 Dec 2024 11:47:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E19620040;
	Wed,  4 Dec 2024 11:47:56 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.32.56])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 11:47:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, hch@lst.de,
        kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        gjoyce@linux.ibm.com
Subject: [PATCHv2 blktests 0/2] add nvme test for creating sleep while atomic kernel BUG 
Date: Wed,  4 Dec 2024 17:17:46 +0530
Message-ID: <20241204114755.190660-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rRYci5MCMc0xAQYHPV_q-SicHkLUQxP6
X-Proofpoint-ORIG-GUID: rRYci5MCMc0xAQYHPV_q-SicHkLUQxP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=874 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412040090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_034813_899746_17DCC70A 
X-CRM114-Status: GOOD (  15.16  )
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


