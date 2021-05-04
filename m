Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323AC433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:57:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73AB610A0
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73AB610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WqfThlBRqXQIqLqvSS51jTk7kSSOUL8io9oLYkrPJuM=; b=GyRf5vWgibd9BvlOb18l7TAlPN
	Nmb4qKeOGi5kRG44xAIDuMgkIrHVNsWViFdvFoTGXa4GcqMko9orWxlZH4CkzQ+oWpppikPZQAND2
	hsTIfBmXEs1syNL5DA2EutVTbO8WdmwSIlm/YiW8M9TQYSbtwG69BPxwcX9tgbCLwMAUynTGrIJVg
	mD3+LTNPC6xLdAvtaKSIXvabKe7ColU9Ty1B5W6AmyYf2QYNjDIlIc2bqJXXFBSUpU8ibRqM3vIip
	+DdpdEsf3JBwIAXPvcV9JPs6ok0wEtv7BzLYo3QqiwzoyJ6yPf4CmDpCMP5W2YINRWGzY9SYBwIWG
	Uc0yoPMg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldwTy-00GOrm-IE; Tue, 04 May 2021 14:57:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwTv-00GOqe-Kz
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 14:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=3mwNktlEtqPyo6gUDeGAf+qpDKr1knP3cqPHK5BCAGk=; b=qUttkygb6pD8BBgB79n8IGisNz
 Ay2iqryXKCanpOvkO/eDGDWAllrrwrOD4sZvxd0mi+rwcuAbl9INOkKkhgERnkUOzRiWpOerZz6QV
 QCjboHOLfuGenisA7A7FrRIMFdvG4cr0ajfkeQfGKqvDGVEjyDAr7emdEn2PJermha06sxVGZaxZz
 FY2+e47rrYfqlGiQF01Wqru79Itj577eldHKUx/lfB4uRsi+CPgmVd+KWGYZYbpq5FYbmYPSpOuyL
 B0f27IFuKmT/+dmSPcRqzgFzXXKNkanlrrLWVi7B4KafHBCCPU7mUD9qbl0q5Q61yjRmILKoSqkCK
 hdi3keKA==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwTs-0043GX-Qm
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 14:57:02 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 144EZYi7194002; Tue, 4 May 2021 10:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=3mwNktlEtqPyo6gUDeGAf+qpDKr1knP3cqPHK5BCAGk=;
 b=qs6Zwx6yXlXW+DEBaNBvV+dymIowokU9MlGz1mwkAS8SB83WZHvTYA2e+p0cdrL0fCm9
 tG+Y7vTN/9k3qtbDqTzatF8lfDMYgfxz97zgoRwm7VTrub7o/QUtH3VZDqo2MDIgKhR7
 QbQmh96l8PdsWZKdqD3GzW7mV5MFg8aCXEdZCA6jSQQQpEXMDWB2r9EmlJu80wKODZVv
 9Z6pImNSoieToETEJklsDBiYoxpUgMP/mlQ9tx2S312sUmXcWnifcXs1d92kDSfZsply
 OFDwXrMR2Q8mzQDS8gLYl5mwv3OfGZGn14Uc3XDKUZHXW4mrokbDYgj7HSWyw4MEIWI2 UQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 38b7gmj4s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 10:56:56 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144EVc5a014690;
 Tue, 4 May 2021 14:56:55 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01wdc.us.ibm.com with ESMTP id 388xm8x2gs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 14:56:55 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 144Eus4831785378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 May 2021 14:56:54 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3C03BE056;
 Tue,  4 May 2021 14:56:54 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CA9ABE051;
 Tue,  4 May 2021 14:56:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  4 May 2021 14:56:54 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, wenxiong@us.ibm.com,
 Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH V2 0/3] Update Persistent Event Log
Date: Tue,  4 May 2021 08:33:44 -0500
Message-Id: <1620135227-21783-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yxXKGglk3GZIifeQJjfMBogVD4kvWE1Y
X-Proofpoint-ORIG-GUID: yxXKGglk3GZIifeQJjfMBogVD4kvWE1Y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-04_08:2021-05-04,
 2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_075701_005298_A98BAECE 
X-CRM114-Status: GOOD (  15.33  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

Hi All,

We have tested persistent event log with two kinds of difference NVME
devices. Per cusomter's suggestions, we would like to add or modify
the fowllowing patches in current pel code.

Chaitanya, Thanks for your comments!

Thanks for your help!
Wendy

Wen Xiong (3):
  nvme-cli: Add event type as filter in persistent event log
  nvme-cli: Add set-feature(0xb) in persistent event log
  nvme-cli: Update in persistent event pel code

 linux/nvme.h |  16 +++-
 nvme-print.c | 216 +++++++++++++++++++++++++++++++++++++--------------
 nvme-print.h |   5 +-
 nvme.c       |  12 ++-
 4 files changed, 184 insertions(+), 65 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
