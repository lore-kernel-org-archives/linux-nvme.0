Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6747ACFB458
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lao8RkclT3/69bN4gjwpvUgH4IG5FvsEaawWrvbjEYs=; b=yZHFb8m8672OxQjNoqOh1am8D+
	RJ/SK0ZmRahvWtyV5SBg0h07Eo9sUJHH0639UlGEZ1+2gAsGH/eyStUlhSl0p0Wmmz9L2t6YkN1cm
	tCMZq/4PLsBMqF/twHkqIHGPM2K96kWl0DQ8qKKK8o1q0cK5IzYnHwnCUMG7r7Wgazdbd8swSwyyX
	w90tTfkPhbNY7C3Lmd9enX37wfq4KWq+RGjUKXCGpduHpsIiqCqaOd/92CRtWzzp/UnkDFVmtSyKk
	pA93zhV9NPykTnYjXbvmzZ8utbbIv9bbrceqT8CMfuLexHlv/pyFUaG/Csmm5HeQo1SRjOoPjsRMa
	q6ZTjZNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxtZK-00000003dgp-1v7k;
	Mon, 07 Oct 2024 19:38:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxtUR-00000003clW-0M0K
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 19:33:56 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497JPTCb028248;
	Mon, 7 Oct 2024 19:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Lao8RkclT3/69
	bN4gjwpvUgH4IG5FvsEaawWrvbjEYs=; b=FBkIWAmb/Xxu/B1B2TZp1/0zFGJZv
	/A2ZugxAVE8Ko4+HjKf8GuihV2ACFdhyQM+4Tqq769Mziu7N/jMqtdhPsqCR+Mw/
	qo+ue4cSo2bPbxJ3AeLou402mvNYYBE+4i1afTgCFDL1urD7T9gkzMoT+oHxFNpv
	j/bINyg3rDFG63KL8mPvL1q6T5FdqhVyFqaYXf4MUUMw0hHGUGj097BNrluMvzCf
	enJTrhg3BpwgU4ml8bFnQKvB1C7BQ+tM6RAZU0glE9vGvN8RBdQ0lgGxUobFYfdu
	T8mG2i1FgBAeHv4V8JFQZkEoDL19TcLem2CsdqaPvz7b6PsEessNTA1Ew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424ns4015a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 19:33:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497JXSSG010885;
	Mon, 7 Oct 2024 19:33:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424ns40155-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 19:33:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497GcAmg013804;
	Mon, 7 Oct 2024 19:33:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss0nc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 19:33:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497JXQtU34079044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 19:33:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 524D458059;
	Mon,  7 Oct 2024 19:33:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3B4358043;
	Mon,  7 Oct 2024 19:33:25 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 19:33:25 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com,
        gjoyce@linux.ibm.com
Subject: [PATCH v2 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Date: Mon,  7 Oct 2024 14:33:24 -0500
Message-ID: <20241007193324.5846-2-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241007193324.5846-1-gjoyce@linux.ibm.com>
References: <20241007193324.5846-1-gjoyce@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6oNAXfPebMK2BPIF28mYx0VGnK2GxzcG
X-Proofpoint-ORIG-GUID: Z8lMBl6WSn3Pi5KltiPm2K3HKh100VKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_123355_274859_32241778 
X-CRM114-Status: GOOD (  16.94  )
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
 drivers/nvme/host/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba6508455e18..10eca7660ca7 100644
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
+	 * restructurade to handle retries, disable CC.CRIME.
+	 */
+	ctrl->ctrl_config &= ~NVME_CC_CRIME;
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2489,10 +2494,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 		 * devices are known to get this wrong. Use the larger of the
 		 * two values.
 		 */
-		if (ctrl->ctrl_config & NVME_CC_CRIME)
-			ready_timeout = NVME_CRTO_CRIMT(crto);
-		else
-			ready_timeout = NVME_CRTO_CRWMT(crto);
+		ready_timeout = NVME_CRTO_CRWMT(crto);
 
 		if (ready_timeout < timeout)
 			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",
-- 
gjoyce@linux.ibm.com


