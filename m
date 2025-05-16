Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0E5C3ABDD
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 06:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tEk59W/u4+uPYl9k1Y2/CKkQbe6L7UuAEu0Fw0oFy+k=; b=rH829+pLJ7UvaLDEUySwPW1ZrL
	bir5e+klXGnApfS/xhaKiRfIl09rZ1u8tfZ79K2q+/yItm3qYUb9LE1SXML6FIxhC049uWjYY5Xv/
	hIPHzjylFFzRG+hmOLUCM38qTYqHb2kKrNtosTpm9gxLa2q4RHRgaleg8qhQ6d5AAwBBrmB4WWrR1
	qnRjZzVQS5ovoyZcH1LbhjWSGdkDOzCXymrv4F+4HtC7U3icaVqhFd2/C5zMfd+pst9D6kklku9O9
	RJ9v9epD+8El/31bM88aPu6zuLvMOyg7clgz5E+g/QSPNIOH8/MRE4WkAtH4u4JVklhPa5BI92bvT
	n41XQrMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFodJ-00000002Zuc-01Eo;
	Fri, 16 May 2025 06:33:25 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFobG-00000002Zg8-3wrH
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 06:31:20 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FLbdRP023897;
	Fri, 16 May 2025 06:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tEk59W/u4+uPYl9k1Y2/CKkQbe6L7
	UuAEu0Fw0oFy+k=; b=RNm8KcAnLgYvo1UH488mbeE11q1ZXwlwz1BOD75mfw84h
	myzJItAiLYbXlK8ue4h5euAsX0oqIGbATtJkV37pLOS3+Kq7t8vHbOBhzDx/ZGNJ
	aGKyBldcnwz3Hjf0qgvS2D9juUbIlo8W1zho8/OL0NE2v6Y71MR1c/w/HxmGw04i
	KgzABC2vOkFCObogsZD6leQXOCOSfSxzTDBQll5xOF0RaRGEdFNp9SEeFwX3XZmm
	lh9B3IbStP+eFbR78fpq6ZYxFNfmt6S6rSHrMH/n32MIAuv/gtmV/lWa71gnApBj
	2HqSCWFaDR6hPyp25VvDfa+dNt4AzzLFecTvVYQgA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrberrqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 06:31:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G40XOD004264;
	Fri, 16 May 2025 06:31:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmf0y2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 06:31:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54G6UlYm035769;
	Fri, 16 May 2025 06:31:00 GMT
Received: from shmsingh-git.osdevelopmeniad.oraclevcn.com (shmsingh-git.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.137])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46mrmf0y1v-1;
	Fri, 16 May 2025 06:31:00 +0000
From: Shminderjit Singh <shminderjit.singh@oracle.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Cc: shminderjit.singh@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH 0/1] Add quirk for Samsung PM173X with Subsystem Vendor
Date: Fri, 16 May 2025 06:30:58 +0000
Message-ID: <20250516063059.3456399-1-shminderjit.singh@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_02,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160059
X-Proofpoint-ORIG-GUID: orXONm5lP-vmz70X64364Q5O3lJniLpy
X-Authority-Analysis: v=2.4 cv=R8YDGcRX c=1 sm=1 tr=0 ts=6826dba6 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=7jYusffMPjmihPzoxuIA:9
X-Proofpoint-GUID: orXONm5lP-vmz70X64364Q5O3lJniLpy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA1OSBTYWx0ZWRfX+nMkRYVtbjhn kryojPNYpdVOf5BuLOJGuPpxAzNwFVjYEefm7ITTMKT8bpya+cJ1b6jInngtzwH5WcQm56Ev/jO P7nqQZiRl3vRkmOKThME/kRsxTiF0M7R6yMu4FfAqpFGPw1On2h5vaEIm/027JVQxEyKjeQo76c
 n14nWGezJDfZqROO0Irc0ak3FY3yiqm2BO1vX6dfhgAPR5R0g3oxvYtS57GQIt1pfipPrED2vtE 2RfcOWdH4dRHqwZf2snD654Jam8K0z9pvFHAgHDtVvXKBh/R+z1aMmgMsvMvlA3jUefeeZWdM0H KyBAsGuJgjzW7vIng2xGCSudaA7M4E4p/yJL5hH/d3ClZKtkFl1awFe1SvbCXCTiuj006jgX5vG
 U2eXUI4Py8N05TkiZqEO15/S79E11vjm6RGvOSNQ8t6CPvPe8WN+PCoSM84ZNto62WLOeKyK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_233119_095303_C9C9B1EB 
X-CRM114-Status: UNSURE (   7.93  )
X-CRM114-Notice: Please train this message.
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

Samsung PM173X with subsystem vendor id 0x108e exhibit quirk. Add
NVME_QUIRK_BOGUS_NSID to handle this.

Shminderjit Singh (1):
  nvme-pci: Add quirk for Samsung PM173X with Subsystem Vendor id:0x108e

 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)


base-commit: 546bce579204685a0b204beebab98c3aa496e651
-- 
2.43.5


