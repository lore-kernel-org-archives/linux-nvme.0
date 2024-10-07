Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7881CFB43F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QT5eX6v4HIQkY8oMXhN4nnZg9+twnKLXXqR4xPy/NI=; b=fILq9we/TpNFC2QyAXuh8o+jU3
	Ab7V/IzlmXn+Af30lGm9mwccfWteYA5uYCL1VGRY7JtW88b+PYPwdMao06ROuOmnTL5/x/hdX7SoS
	3uKzSy0t6ly6e+vTPaLc1ruc691ms2X0mHbruS3ztTaqecLYfixRdV/QIzmPPlwKXGJ4Xw5hgiMEX
	JtwtxTFhSoHHaGFoDd/puU12DvrehaHkmSASzce38XOaLowZncDX22euRRhi4pVLcJiHbmz7vvx7H
	WQFOcohJ9nXseKpcBh8A92qrb3NC/eO0HfTMTXmfkba4Oz4jl0yakMvHLuICczAQiQSeRPMZ0H4c0
	PszoUnag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpF8-00000002qSx-2Oei;
	Mon, 07 Oct 2024 15:01:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpDe-00000002pr1-1fsw
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 15:00:20 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497DLBv5009828;
	Mon, 7 Oct 2024 15:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=5QT5eX6v4HIQk
	Y8oMXhN4nnZg9+twnKLXXqR4xPy/NI=; b=QpMnGPlT05PP37waABEOfyIHsfyhy
	z7W0Lrs03RC7cPSk6AtsQLFSEkoiXMAtf7ueKvFxutdYBHIv5cCIcujgI3WovZKT
	1WlZN9l8bp4kc17vRMv1aqcvoGgzc0lTrIcjCDunJoRiG+S9Vj3Z5Haj53RitZtf
	RQXKiKXu2prpe3Hopuu3Cetl+b+4C4W7oI9pCmzZ3W3Ln75KPXpfGoQiVQWY4prB
	0vmOYk7vKtonQ+BQKq42Yia5n8EPKO+nRUgaAPZAvnRE8sCfHmF9AaMppXJceDvS
	pv7ICyeni5m9jXN+XdQu4N3seNNLMwQkc0rg1AwaI6lQ1nRhx6l/Yqwug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424gerrja3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:00:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497F01bN009330;
	Mon, 7 Oct 2024 15:00:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424gerrj9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:00:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497CH4Af022861;
	Mon, 7 Oct 2024 15:00:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0pvvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:00:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497Exw5830802530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 14:59:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C040D58059;
	Mon,  7 Oct 2024 14:59:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B86C5805D;
	Mon,  7 Oct 2024 14:59:58 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 14:59:58 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com,
        gjoyce@linux.ibm.com
Subject: [PATCH 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Date: Mon,  7 Oct 2024 09:59:58 -0500
Message-ID: <20241007145958.7933-2-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241007145958.7933-1-gjoyce@linux.ibm.com>
References: <20241007145958.7933-1-gjoyce@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vM5XoZMy73XONcfGH3LE0cP7bewtlIp2
X-Proofpoint-GUID: FO8afNFvNYXZ0SGn7wC3zEStkTxuKB3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_06,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_080018_606175_46F3EE6D 
X-CRM114-Status: GOOD (  15.44  )
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

From: Greg Joyce <gjoyce@linux.ibm.com>

Disable NVME_CC_CRIME so that CSTS.RDY indicates that the media
is ready and able to handle commands without returning
NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba6508455e18..6b313524143a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2458,8 +2458,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
-		ctrl->ctrl_config |= NVME_CC_CRIME;
+	/*
+	 * Setting CRIME results in CSTS.RDY before the media is ready. This
+	 * make it possible for media related commands to return the error
+	 * NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. Until the driver is
+	 * structured to handle retries, disable CC.CRIME.
+	 */
+	ctrl->ctrl_config &= ~NVME_CC_CRIME;
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
-- 
gjoyce@linux.ibm.com


