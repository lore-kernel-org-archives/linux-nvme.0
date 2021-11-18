Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CF8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3339261B2B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3339261B2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Pv8uHxy1Ctec3oTJtL2chFExM1aGL5sxbvB0jUlk+2Q=; b=Orx3kYEzyz7aEZ6ZNsUXkhs2MZ
	AIq/S9sPh15t72m48axnQSwip9i0ZCqBIH0I7ZPcaXTOwXXE8UNA7IlYhpZW9L0g5pk6MII3LaO9p
	fAzco78V2GmEUekvxJUKNMpFHejsKxOl4GN6X8TQ79iXl2YbUUCenOx1eaIdGLh630fFLXKOZ1dzP
	6RbqhTRKzTOgWLWB324n5jwb4lw0ebLtxyFdFjIbykWaA9qC1VvAxFt4AaC54TWsSaHrASKYfmMDG
	uBf8U2+ORPXiMCJKVJr3YgGqaSUOBXk8NYUobuSUKa/VXcq54k90rFK2w1GrOqR+mPPLxt+SyfzpP
	loHmOFUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnm7q-008YEN-Bz; Thu, 18 Nov 2021 18:27:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnm7n-008YDd-HS
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 18:27:09 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHg6OI000879; 
 Thu, 18 Nov 2021 18:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=Pv8uHxy1Ctec3oTJtL2chFExM1aGL5sxbvB0jUlk+2Q=;
 b=CMcr/5w0IwkXdxGvguQkOYZg/0TuMXzgHn/tk/I2Y+spyXACYaw/v3dUsymNyfULJDuX
 KPwAHkw5lC4oTk5IkIq8YuZpwEDyO6/lbk4VXKTO7yYxvq9dVNSqc57DGNi9+T0WRk/d
 SwRnFqZOvuhGW9UAE7SuUEvQyg/vBLov1DaRzVYqp6t6jnDh1+6EAwwj0mCyIfgZQ0/g
 xEIiqvEFEaYISxVC0uzKJ0D193kDG4fAfYwSL50tjkcvACyu0mPZwEltJ9kSE+AoxZ4I
 coskeGYwLbL84eQ/P5T9Eby3KTStbZeyYZLnCcX72R7EP1COlNVb11kq8Ltl0s9eHgDQ kA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cduf1gyr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:03 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIIpJn020057;
 Thu, 18 Nov 2021 18:27:02 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 3ca50dcb5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:02 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AIIQx1x10748262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Nov 2021 18:26:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48ED0AC067;
 Thu, 18 Nov 2021 18:26:59 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C405EAC069;
 Thu, 18 Nov 2021 18:26:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Nov 2021 18:26:58 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: chaitanyak@nvidia.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2 0/1] libnvme: Add new events support in PEL header
Date: Thu, 18 Nov 2021 10:57:18 -0600
Message-Id: <1637254639-19479-1-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NqhkfQd5KhHspfYDXjF5IPbz9xHWKw45
X-Proofpoint-ORIG-GUID: NqhkfQd5KhHspfYDXjF5IPbz9xHWKw45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1011 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=782 mlxscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_102707_731860_6BA03D0D 
X-CRM114-Status: GOOD (  13.50  )
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

From: Wen Xiong <wenxiong@linux.ibm.com>

nvme-cli tree splits into frontend(cli) and backend(lib) now.
This patch adds header support in backend(libnvme).

Wen Xiong (1):
  libnvme: Add new events support in PEL

 src/nvme/types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.27.0


