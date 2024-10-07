Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528FCFB441
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rxe2CbBJm/n3FnlgYRPCXTt2s2Vgf0BpNjNZ3IAb9ks=; b=nGyt8LF3477kWIXk/ip0Xsd0Bi
	qu7jcLyrNtqsshm0fUgXiSpw+y/mZKu5MgX0YoIkMNlc1UZJfUmKZD7cVa9Fl1iDumO2TThcVSdXb
	FStr+croECiKJNkoOn4xZm65LXy6PnZBb+pZW4o58JAOeYLPdZqmhlLhb+ctSmTocb9tJRbutXAfG
	eFb268NSitzCOCR1iHtqC7FTx+uKkAKySii06selULHUSC/OSjf8G/1MBTbE7ACTQ2R2EqETvHEQo
	7CAGBzoy3x27DIpcec2oZSEUEFoVHRvLjQjcWOy/5Cgv3TXh1FZW+n6fEF9i16BtfrdLZT4tvUoie
	WnZb9xpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpF9-00000002qTZ-3WWk;
	Mon, 07 Oct 2024 15:01:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpDe-00000002prd-1I1T
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 15:00:20 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497EndY8030099;
	Mon, 7 Oct 2024 15:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=rxe2CbBJm/n3FnlgYRPCXTt2s2
	Vgf0BpNjNZ3IAb9ks=; b=CkK0C80LTXhcC5k0mLLguY+x+NstamqZUZTqjNZQQi
	Xrg7Lr7kQUns/HqHqgtTN+wbhaaNQjCKKsaicUswZmcpSnTNARjR6KZP7Y1DRA0P
	24UmcNL/bqrDScEUiACAtG0QxkXlPzBwA1wZJ4WzOodqiOt9VI+yxDBNheNd7eMt
	8sd05TCQwdJBygDr6atFB9sauQK9cMqvs4hxqxqOMdSKuNZvYms87zu/bI5id/bY
	sdZLaAG8X2+CmH6oboCWtAomXzrvffauWc1D65zjZE77O1KMxPyI+kydeeUtbAje
	D7PuphE++fQp1Zk4j9gO2um33fiAEr3PdiHENhoqw87Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424hra81uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:00:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497F01Sr024883;
	Mon, 7 Oct 2024 15:00:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424hra81uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:00:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497BvZ7S010718;
	Mon, 7 Oct 2024 15:00:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0j7055-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:00:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497Exw9h57278972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 14:59:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86C1258055;
	Mon,  7 Oct 2024 14:59:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 509A75805E;
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
Subject: [PATCH 0/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Date: Mon,  7 Oct 2024 09:59:57 -0500
Message-ID: <20241007145958.7933-1-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S9GLvZolG64NU8IyNAcFI9aKHlONwemo
X-Proofpoint-ORIG-GUID: U2vxDh5pctCLoRdYevq4pRVEZtU8EAez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_06,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_080018_502929_EFE9CD8D 
X-CRM114-Status: GOOD (  14.10  )
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

NVMe 2.0 introduced a configuration setting CC.CRIME that allows the 
controller to set CSTS.RDY before the media is fully enabled. In this
case commands listed in Figure 103 may return the status
NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. The NVMe driver is not coded
to handle these failures so initialization errors occur.

Since the current driver does not:
	1) retry media not ready errors
	2) utilize any parallel initialization that CRIME may provide

setting NVME_CC_CRIME provides no value.

The NVMe 2.0 spec says this about CC.CRIME:
	"If the CAP.CRMS field is set to 11b, then both controller
	 ready modes are supported, and the host may select the
	 controller ready mode by modifying the value of the
	 CC.CRIME bit."

This the CC.CRIME feature is optional and this patch removes it.


Greg Joyce (1):
  nvme: disable CC.CRIME (NVME_CC_CRIME)

 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
gjoyce@linux.ibm.com


