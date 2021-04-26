Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B0C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 19:15:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4FE61154
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 19:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4FE61154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EcWrwy7d7QKAIOObypGdS3I0Cvs33ckpjihHeVAJRZk=; b=aRCCFE1ARxTBdMGBH9Yg+eq7RH
	8h72ksHC1vx3AB6ibbtojTFQ31kaykMi4DS5Fcu0pBkkH1pXTd7J4b8pL9Zxn/jPQp5KPKg1Ijdkt
	nOs4h3dOMbPGa7P8+Z/oa9zq6DA/0JSkrd9S4AxBfs2dgu35TWMDX48F0lGGHlm0tQPhK6FndswUC
	sHT0Fhlh3N1ltJQOIMD/omK3xkW0gTLAVOHqV4U76NL7tArEzNtblocLD9bSQCUIc5LYQAl0mUf8+
	ff8qIkgS/bRryd6U2neXei2GhR0nDzz3WO6eE1BozTZktIeGt1AEswRp7F90el8Jc898uIO7niaoo
	Lsit+c1g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb6ha-008MPK-8y; Mon, 26 Apr 2021 19:15:26 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb6hV-008MOc-NB
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 19:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=N8nIt7gKO9Ch6G7VGVmDlNPpyHj4qj4iTTfusbP0Dv8=; b=KCFl9gbf9u++ECCZmruFUJuCR7
 Ks1R53FePNC4Lgepk8JUe4MDZjJDWslSrKRBwr1NxMp/ZXvgIhEQxEiy2kBBrgYk2O1bKh26hbrDD
 No8Bb0w9mkVUSahg4TnjGfF7rSLlPaUUSLVHmnVRJ/7JHWDyrRISBAfboRib/SCuw7MaKsT5To949
 tDtrvMwhHWysE3Wti/T8Co40GL0I5UYbLzHofBhdTDbzSrzpZvhdOrtG7ECI+qjtC4G+tYvxlBxXr
 lQL+mZKoivFfOdM2c/GUMQyu0DZ9STUSsph6XeYxb3JZnnBPRTq4x97pzL6Y3tCFraGyUZaWuzRiy
 6suiUwzA==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb6hR-00G8If-Tg
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 19:15:19 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13QJBEEX114056; Mon, 26 Apr 2021 15:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=N8nIt7gKO9Ch6G7VGVmDlNPpyHj4qj4iTTfusbP0Dv8=;
 b=ibzMK/RtK20laLSJuUJE5xA0ioUGpvrrjknN60N3y+ZdOB6D8CUGrf5y2ldcMtfGCoMI
 w1TCq7i+QkdaWBGfpumhXf/YJUMZHecIFAkVny7us6ctlhTLuTgGQ89m6+Up/RRE8VuV
 W0Mmc5z0+2fHQKMCpfTBV5LrQ947rCOFX7KdGHQyTK19hFTfVKZ76YVoDCEUDerx3otZ
 FiiUMtf1Nt/+JjaX2AzmKzUx0iObaN0oTALa0FvssBLgnGFZ+BoX8B1+b9Qwfb1KXYD7
 Cl+uhVkzy92w4cIqfti4cZ7szyhZzVazAl7jLYYawMmyquMqes4niWVIxWKBx4fzS39F gA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3863es833c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Apr 2021 15:15:11 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QJC3Co022290;
 Mon, 26 Apr 2021 19:15:11 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01wdc.us.ibm.com with ESMTP id 384ay98ccp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Apr 2021 19:15:11 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13QJFA6727656560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Apr 2021 19:15:10 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 228B46E054;
 Mon, 26 Apr 2021 19:15:10 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8C506E052;
 Mon, 26 Apr 2021 19:15:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Apr 2021 19:15:09 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, wenxiong@us.ibm.com,
 Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Update Persistent Event Log
Date: Mon, 26 Apr 2021 12:52:15 -0500
Message-Id: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C_Smg1v7MvHbk7U0Zp6v2MY1tBku3GbZ
X-Proofpoint-ORIG-GUID: C_Smg1v7MvHbk7U0Zp6v2MY1tBku3GbZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-26_09:2021-04-26,
 2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_121518_136759_CE3A10D6 
X-CRM114-Status: GOOD (  16.76  )
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

Thanks for your help!
Wendy

Wen Xiong (3):
  nvme: Add event type as filter in persistent event log
  nvme: Add set-feature(0xb) in persistent event log
  nvme: Update in persistent event pel code

 linux/nvme.h |   6 +-
 nvme-print.c | 219 +++++++++++++++++++++++++++++++++++++--------------
 nvme-print.h |   4 +-
 nvme.c       |   6 +-
 4 files changed, 172 insertions(+), 63 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
