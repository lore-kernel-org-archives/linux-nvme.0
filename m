Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1E4C624A5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ULi6Rki5/tvET8en7dY4fSu+G4UBSNcYl0+3p0k9WzU=; b=EEgtzfGISwesPNjVOvmRlCZmyU
	tZrgZ+Xc3Z/v76Iry0ebF1jgZeUEoJkjEVTAqmWoga6cA2U0S9K8yp+SKWHATSTk+9K0xx9bNpffE
	4ckeQvRyj6T7tZ7KCsPfvpB6YMPjQUuCJ8qmMZeCEmFme1xavHARgfyvwnWZ9OACrWwpqmmGBzzH8
	EanQVqX4vSgErPKI4YCE8z3N3vSaw4mcHFQy0Alf4WGedPAny3bJwOWCc/jactlzfQgr2Qog90fGf
	DPDoD8DwZQD60oAIugagnN6ZEG3F6LE3NgvJBWNyqKtWq3s5NZZmQeadsOYF9Kl7SvzpgrvYwdJ+u
	WvFpntAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x13oZ-00000009q4y-1fXj;
	Mon, 31 Aug 2026 15:20:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x13oX-00000009q4M-1Zmp
	for linux-nvme@bombadil.infradead.org;
	Mon, 31 Aug 2026 15:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ULi6Rki5/tvET8en7dY4fSu+G4UBSNcYl0+3p0k9WzU=; b=brPNjrAk8fuG7Qyk9rohczjZPn
	UxiYCNxhedwY4Q7lVy+837DQ7RerzTGfwI94/OHjbb9fxjt+h+JYrXQ+mh2pyP1usUtecXqEORBn+
	ZjIslGBLvN7+RcmSdIH2kU0vvtXbjjt2Rar5ScwyffvhLavaOujg/+/EL8yFpc/ta6y637EWrU1TQ
	M8gvWNUj45iHu6JQHWh9KLsMk3BWMKm5/9VhuwsmkxtG0KZOn0jeKnb2WCgSY/T5bzIovKp/n8alN
	xKu0f4JRxWjvErcoLprQqr5jSt/noUaS+slPdvSmMCBeg+YDwNs9nM1VilQlhEnubphMNLKi+CIZO
	WidoREzQ==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x13oU-00000009zSF-0RTf
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 15:20:48 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ8YZ2530456;
	Mon, 31 Aug 2026 15:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ULi6Rki5/tvET8en7dY4fSu+G4UBSNcYl0+3p0k9W
	zU=; b=BCnJ5Lx2dCF5lwdR4vcznk0/gdu1GmTcPS8cyhp0v1YLbyiDshYMJmOQO
	UO+ZmTAWpIjeUIq3v34Fqw+Tzx/FUaU1Zl9QMa5D7Mw0GfzsB85E8/Chb6RTgwrI
	IY2AhFdxENGpi2EnHZyee/8+pjduOpDKwvynYV5wi36Sm/WZZ33/er1byQmfCtCp
	JhqX9jN7z/dpZRjhIGOCX3v3W+cLPezD3obFiGsggiefLMPmQYm+7D8QXpCNLxMS
	zHr3PMo72HB04h8fLfCFDaNwtOX29huMeGskPG3dxmqwapIFeMp2UYJX0pPITmn3
	P0p/OpSFo3gqs0JWuGYOYeZgTz3UA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5a6vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:20:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuIEY020111;
	Mon, 31 Aug 2026 15:20:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6em8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:20:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VFKPsd43974968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:20:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 170122004B;
	Mon, 31 Aug 2026 15:20:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD6DE20040;
	Mon, 31 Aug 2026 15:20:20 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.22.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:20:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
        john.g.garry@oracle.com, wenxiong@linux.ibm.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/2] nvme: add reference counting for transport modules
Date: Mon, 31 Aug 2026 20:49:53 +0530
Message-ID: <20260831152006.819471-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a959bbd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=aEDpHz-RgUC-pIA6d50A:9
X-Proofpoint-GUID: 7JvxWaLIpNqUDsL02R8Q1ezTsvBAG0Xo
X-Proofpoint-ORIG-GUID: 7JvxWaLIpNqUDsL02R8Q1ezTsvBAG0Xo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX/I46hzRFeOOg
 fFwB0yvoRMxJWkQqrAYzhn/8TPHwe5iUOZ6XJJBXnEwGuYLeg7e4ip8DeOLMLclewNGGZ8u+5u1
 Zh2mH7zTCCzqFxkf78xDPIN5G6WM4+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXx4yv+gSaBpxy
 GqhYkVncBPv9hM+p2KJT5FyjYyZL+gsPYOrzdaD9/QyNC0M8+BrRzkBZvbXIqF8NUJUWRHM82fq
 ieJNRjHuZz0ynEsNUVhV6iZwJUBuYB1r4zk9/OCiX3tRBlm+k4SQC3fmhjKwXN6aDGikq5YgLSR
 jirgMBnyTxRjtfOq1VmfvtX8HYqCjg+uHqSoRx3odziX87g7g629Wv7vugj0CQ8rjyPwKukD2sc
 7KqNTlZ6knmgGQ/XiDLTpaYctUYXODKt2k+xO1BoAiVS8xkKmAEMhUM2p/6sgpaF3Wh7hIs1v4d
 v9ws1YWgh5K4fRJzQyjI/PboSE4K01MsY6NQgTs7W9CbQaw+jIS0oCcEt560Bu1xturm/molAGu
 h80cKmSxJ/VbuKunkEaHZDphGr+DbIGBpXCaSOvk/kTfe1l7ByZYifT1cpNK7iLQvqpxwBd3eV+
 QPIfjyLKQGIGdo0OGSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_162046_631063_F24BC5A7 
X-CRM114-Status: GOOD (  12.92  )
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

This patchset adds reference counting for NVMe transport modules while
the corresponding multipath head node is open. This prevents the
underlying transport module from being unloaded while it is still in
use by the multipath head node. Unloading a transport module while it
is still in use can result in undefined behavior.

The second patch adds a Clang context annotation for the shared field
used to track the number of active head node openers, allowing the
Clang context analyzer to validate accesses to the field.

As usual, feedback and suggestions are welcome.

Thanks!

Nilay Shroff (2):
  nvme: keep transport module referenced while head node is open
  nvme: add context annotation for nvme_ns_head::nr_openers

 drivers/nvme/host/core.c      | 11 +++++++++--
 drivers/nvme/host/multipath.c | 37 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      | 33 +++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 4 deletions(-)

-- 
2.53.0


