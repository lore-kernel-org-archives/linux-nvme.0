Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F64CE8374
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2024 16:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FOslC+hHhVgTLdPVk2PEPcHJ6uT9jaT+O/ZZI26X6V4=; b=ba4gdBkwF1xYHaoDyLsbIUMW4S
	veF+0LhesUqAD/MiNv4LwzC+GJIilRlTFdOVyI4vZUH7iFSzeGmDphn0jnvv0fP1ssJT5KFaTg+Qh
	YY8SWJg/wTt2DAzQzswmkdlavd7bGps7D7cwVhgUciKl6CiIBDwnPRFWpH1wW1HNwEMLDGF/zkjmT
	7eNbBKChv5CTdDucPNMNV5qz/C+OZIfycPgSGEerb0wKm/v1mlNi8Quczr5MUn89U78MffCXUbOfz
	86RzUa2mcR9aKjjvydv5oSIcnVoBblvGUvZxW1Vv72Tu0LFHGhdAwBa2Z6b3/gQdecJt21DNNOU3F
	Gi21DSYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svJaB-00000000I1a-2LrF;
	Mon, 30 Sep 2024 16:49:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svJa8-00000000I0l-0JJ8
	for linux-nvme@lists.infradead.org;
	Mon, 30 Sep 2024 16:49:10 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UDxJW0005194;
	Mon, 30 Sep 2024 16:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=pp1; bh=FOslC+hHhVgTLdPVk2PEPcHJ6u
	T9jaT+O/ZZI26X6V4=; b=hHbkXl6qzA06Ehewbv3m2WdeqyUDPdD/Hx0litvJCG
	eWGZfDSrNfhUOD//ctjsNTQ2T2OpMpmEbVafziSN2nZ6h0RcQJaoC9swNgvOU73W
	M4HVKonD3njt3PjLkM9Yg9RFQuQIdX2lIv6i5v8xiRO5aoi79dtHRN7Kv3FTanJK
	25PTyhkQRgHm7Ombb0c5eY8Apl8wDzVZxOYjvU1lOxBnp9VJSu7SB1Pi3v+NDc24
	lHb9bn4SbLDZYH9cwRu25F2sVdoB8/WJr6XStCaFq6mMiRkdS//T3BrkIjdOIdBl
	P9MpAMZKUskJzLEs4b0VQU0hWh+RspEebdP3XDNmrVyQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apb5cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:48:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UGmml6028731;
	Mon, 30 Sep 2024 16:48:48 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apb5ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:48:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UF1W1k014616;
	Mon, 30 Sep 2024 16:48:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmjyhx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:48:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UGmjOe27394790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 16:48:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8257958062;
	Mon, 30 Sep 2024 16:48:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 439D558056;
	Mon, 30 Sep 2024 16:48:45 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 16:48:45 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com,
        gjoyce@linux.ibm.com
Subject: [PATCH 0/1] nvme: add retry for media not ready error
Date: Mon, 30 Sep 2024 11:48:42 -0500
Message-ID: <20240930164845.8406-1-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eFlxLpan1zaW5AMS72kb9ZSBO7oX7Cw1
X-Proofpoint-GUID: i228XbLDDKKjuoX8pOdO7vqtVVN_cSb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_16,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_094908_232250_9057B218 
X-CRM114-Status: GOOD (  20.14  )
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


The NVMe host driver sets the config NVME_CC_CRIME if the capablities
NVME_CAP_CRMS_CRWMS and NVME_CAP_CRMS_CRIMS are both set. This config is
written to the controller before NVME_CC_ENABLE is asserted.

The function nvme_wait_ready() then waits for the controller to indicate
CSTS.RDY. Subsequently, SED Opal init code issues a TCG level 0 discovery
command to determine if the NVMe drive is SED capable. However, there is a
period of time between CSTS.RDY and when the commands listed in Figure 103
may not be successfully executed. If the controller is not ready to process
these commands it may return a status code of Admin Command Media Not Ready.

This code is returned for the level 0 discovery and the NVMe driver marks
the drive as not being SED capable even if it is capable. Subsequent calls
to sed_ioctl() all result in failure and a CLI is unable to manage the drive.

The patch proposed here retries security read/write commands if they fail
with NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. The maximum retry period is
capped by the value provided by the controller value NVME_CRTO_CRIMT.


------------ relevant NVMe Base Specification version 2.0 passages-----------

Controller Ready Independent of Media Enable (CRIME):
        This field controls the controller ready mode. The controller ready
        mode is determined by the state of this bit at the time the controller
        is enabled by transitioning the CC.EN bit from ‘0’ to ‘1’.

Figure 36: Controller Capabilities

        Controllers that support the CRTO register (refer to Figure 62) are
        able to indicate larger timeouts for enabling the controller. Host
        software should use the value in CRTO.CRWMT or CRTO.CRIMT depending
        on the controller ready mode indicated by CC.CRIME to determine the
        worst-case timeout for CSTS.RDY to transition from ‘0’ to ‘1’ after
        CC.EN transitions from ‘0’ to ‘1’.

Figure 94: Status Code – Generic Command Status Values
Admin Command Media Not Ready: (24h)
        The Admin command requires access to media and the media is not ready.
        The Do Not Retry bit indicates whether re-issuing the command at a
        later time may succeed. This status code shall only be returned:
                a) or Admin commands; and
                b) if the controller is in Controller Ready Independent of
                   Media mode (CC.CRIME is bit is set to ‘1’).

Figure 103: Admin Commands Permitted to Return a Status Code of Admin Command
Media Not Ready
        Includes Security Send and Security Receive that are used by
        TCG Level 0 Discovery.


Greg Joyce (1):
  nvme: retry security commands if media not ready

 drivers/nvme/host/core.c | 82 ++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 28 deletions(-)

-- 
gjoyce@linux.ibm.com


