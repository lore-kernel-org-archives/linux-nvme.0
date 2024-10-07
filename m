Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8D3CFB440
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uxbFqoRlIL60j3mdG2Al4fYXRPjP5yUAsHvQh1x0m9M=; b=xGKq5WfNrJHDHBDNc/dfXzD4e3
	y4WsJyH+tS9nJOHmnIJ/YBgVwBTqMwIOMCPM4ZyXKJs7zu1M9M9UVzQZVDanafIRuC/UMXlUmM8iA
	tB6aU5Q82/YX6byhlFXPuFsCnBkBe174eUI4gmlvKjvftOBzY0DyyDIufuOfwNhZiYyHzFKDatEgH
	sDKRZ9bw/u8ahNVFljy9wvbPMyd1ZqOg/paolL81xCXq6hpMYnga2IsfZKo679spATRSTiF5PoP2r
	YTbKEwKDnxTY17TBZlhxs1vjVNh3r5x6+z3PKL+zN9WbUae8ADLCNRzcUXUAFkN5GXhrziiUsr2mR
	HJbT+yCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxtZJ-00000003dgd-3MCn;
	Mon, 07 Oct 2024 19:38:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxtUC-00000003ch9-1jMM
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 19:33:42 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497JOOXc025940;
	Mon, 7 Oct 2024 19:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=uxbFqoRlIL60j3mdG2Al4fYXRP
	jP5yUAsHvQh1x0m9M=; b=MTjldRFWrNfvYYxkIkQDKf3xqki2boZHZ+dVBiDdbm
	UVRnej8myly2eoNTysNOgCepktWBis5y1X0d+M7k3gJjYj54BUJKmRj7F0t1Dx58
	mnqpCEPh3W/7DxCjZ0TSdB3Jl5UrCwY670JyrX73GBA6cvKXJZTrudrXi093Mkcb
	S6bFNMpwCY7xAnhT2xBmyoYjd5TrBZRE+EY3MU90SbBxZQ5a4G2kkqRDnoVdWFEZ
	RRdYZGcmzF1INz8r3tsbkERLtdN+M1SqE2F2gB+gmuei5VTWP0+9Xsf5eU0czmGm
	tny1/jhgZRYdrsGug7a4qTSkX5MduNliod3czatzml4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424ns40158-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 19:33:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497JXReu010879;
	Mon, 7 Oct 2024 19:33:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424ns40154-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 19:33:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497HdYaS030187;
	Mon, 7 Oct 2024 19:33:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmgfjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 19:33:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497JXPUQ36438406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 19:33:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F6E158053;
	Mon,  7 Oct 2024 19:33:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED9BE58043;
	Mon,  7 Oct 2024 19:33:24 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 19:33:24 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com,
        gjoyce@linux.ibm.com
Subject: [PATCH v2 0/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Date: Mon,  7 Oct 2024 14:33:23 -0500
Message-ID: <20241007193324.5846-1-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fun159p0MZRaAxJRvl1N-Dpg5v5_WplZ
X-Proofpoint-ORIG-GUID: JdGZtJZkzu1_zsomt2HRm6_b4GqR2LeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_123340_799301_C320ED38 
X-CRM114-Status: GOOD (  14.54  )
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

Changelog
v2:	- remove NVME_CC_CRIME from timeout calculations (Keith Busch)

Greg Joyce (1):
  nvme: disable CC.CRIME (NVME_CC_CRIME)

 drivers/nvme/host/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
gjoyce@linux.ibm.com


