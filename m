Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EF6C7115A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ysAR0yE+Us1cnHYzApgdYXhn0CW6qObAXT8BVYnrL7I=; b=Y7k9tW0yQarwKKhYtuRq4LxXZL
	fUykcatb6tM6aje0CRffSZrSTNolabF6Xtu8q1bGcylSKP42jX07fi8tqNX+By1HPlKu3ue1Kxbpk
	LWeiFdFcsO+gU5wRqPmliGDg9e7F/8Lvq3NI3q3pGSmgZsHp70jOpZSmtJNs307QJYm4iFKoOPhmN
	ZWKnOccRZ/4U4XDCJ+LgHgaKnBV20rBhf85AcNiyick9qgpgphFsJnuLYc0rg0F2/GoivNcQmvRG1
	uiGNV/sEgwyFzPdXSSdlxXFNm1eefnPl4bXA7HM/UlZFfr8fSV5fIAcw1peQVcPeBjOs836pxQt0X
	n/EgRoBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uREaz-00000005FRY-11kJ;
	Mon, 16 Jun 2025 18:30:13 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRER3-00000005CrJ-1eFh
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 18:19:58 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuS92015738;
	Mon, 16 Jun 2025 18:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ysAR0yE+Us1cnHYzApgdYXhn0CW6q
	ObAXT8BVYnrL7I=; b=oyGXx5ciUZJn7zjbXEHUM3gMyxFdMnWKG0HRNdMEsC9nl
	oMJlSYwnVILflVPuYChaigcshYdG/1wzY4okkvrdWZcIh5GoaBD87B3gtZfRiZ0j
	jjGuLBF13nYgh/DH4pBaLbFq+x1Sg5xrjOrNKYtRDWsuZsk4gTYD9ciTcG7n9Zcs
	o1GUAvxlI8PLhm9ezZpiBUV/t6l+0QycWX8Z/zw7/9D8Mo0VXPMJmn3jzWLafa0V
	b5TjusobDuY/xwYc8O6f8AYyR9lGUPpYddG3m8lvcCU3dNgtK5D/1biugG6JGLW6
	MRJ0tDHIpelL6GCqViig9bXV0duCRMQIKp67kQ7wQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv53drb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 18:19:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GIETOA032196;
	Mon, 16 Jun 2025 18:19:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh890ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 18:19:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55GIJdEp016156;
	Mon, 16 Jun 2025 18:19:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh890e6-1;
	Mon, 16 Jun 2025 18:19:38 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.d, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] nvme: Fix incorrect cdw15 value in passthru error logging
Date: Mon, 16 Jun 2025 11:19:29 -0700
Message-ID: <20250616181936.2094176-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEyMiBTYWx0ZWRfXzQ65P/5oVfh2 ntoWhG3RTTMUfm74z8Ki+ivlEJoIzXKxWpyyDByOwEP+ouQfMj5HtxYhFYjEjiIZJgIf4sUKgXF GdhMUtjdgl8oZvBLH+nQzrPy5gJUlYMG3x7wZUAEqO4yCNlLiza0k6NniaHVX2cW2Hpixlw7/XA
 OZ6IwZvKFuDfvY2UF62F3q+nZbmLKli5L/3kkmVe17FQx0vYl2llDvDsgPC1rMKhf3th0mktTM8 PaxqTYMLcAg8WsTIO6YoKDw1ruxncsf7Lq3mfoH8f2mvc3U3TCFqRhs8r6MMy/nEBc9T3dupTNv Tv22u0ydY2tALFmz2NKuFdKMsFA8EK9GTkY3Z4VOyzY/GwTomC5xMLdk2Y5Pa6uIZKOIejzP8mo
 acYiiIXDaLP5cssNqDcwn25KGytUa56FiRdAdGgwTjtvXt4yUR5kZEYKzl8OzNioAxjhjijW
X-Proofpoint-GUID: QNIwZEwuSV9pJXpnom1oWen04q35hoO0
X-Proofpoint-ORIG-GUID: QNIwZEwuSV9pJXpnom1oWen04q35hoO0
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=6850603c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=AeMM1KqErxL4ncdj0kYA:9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_111957_550652_11145AA3 
X-CRM114-Status: GOOD (  12.66  )
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

Fix an error in nvme_log_err_passthru() where cdw14 was incorrectly
printed twice instead of cdw15. This fix ensures accurate logging of
the full passthrough command payload.

Fixes: 9f079dda1433 ("nvme: allow passthru cmd error logging")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
Is it ok to keep Fixes tag for this fix?
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601..f3e07cb92385 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -386,7 +386,7 @@ static void nvme_log_err_passthru(struct request *req)
 		nr->cmd->common.cdw12,
 		nr->cmd->common.cdw13,
 		nr->cmd->common.cdw14,
-		nr->cmd->common.cdw14);
+		nr->cmd->common.cdw15);
 }
 
 enum nvme_disposition {
-- 
2.47.1


