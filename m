Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F22C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:28:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B3561264
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87B3561264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YKY5z4Ho0GpPxH0V/cxms153T7njE+fbu+nGJ1x4I00=; b=RX7y1HQ86ZBAq5lrxuHRsmvrFg
	5XndTyL54hNqGqbkPd4prH8/pR5hgp14E33e6dekTjllJTHVW/v40qirefGOL7k86hhQVHfw3JBnC
	XNAD28ds7SqA/lOSUWoS0uswONgIp2KHaqeyammfCSbe6NkvC+t4A0NBiSP+F6RgeMy84CoRcHvyf
	A0lYlMTvuVkC63AbzHqfadnKiyQFzdnzzqf5SVdFr9UuZzq34rZHt0ckVMnMGlg6C0aDajiMw1SWA
	Pla/yDHBvB8hVfNFupGFiFrBOSfqwgU/NLWLWvx7lf2WuVPKtaFVlvb/IWSHf4pZdV5PQLNs9Z00l
	6a+JGeYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnm9R-008Ydc-U4; Thu, 18 Nov 2021 18:28:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnm7y-008YGL-3Y
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 18:27:19 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHIhS7031284; 
 Thu, 18 Nov 2021 18:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=YKY5z4Ho0GpPxH0V/cxms153T7njE+fbu+nGJ1x4I00=;
 b=AumxI6ObYZJ1/nPaLzq7Vv+2EKQQZe2q8SJAJsBhvJNLzLEHRH1vbg3C8pSDnzX1byfG
 vvBm0QkBGYfgJDTeLe2UZK3CP1TXZ7O1OiEOZGE/Yte9FJd7SkN/FHEg4xpZKbBJBO8/
 uZ6N5Va1hwK2hJXI7s74OxYsYk2WAxn/ApY5FAkWmnlo2oBk7rwpIXLIoTeuC6PxuJaE
 p9sL95VWJiwYBf/5R+cFvw8/wL0htdmezrrC6mUL7CKXJNnom/IoM90fEhPUojuYPzVI
 Gg46mF0jqz6mh8LByYZ1oaDFq7o1DPCJIJ5YOp5X7DqxckpxSeGXWasMlWQpuiKebUBi xA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cdu4c1g8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:17 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIILFb003376;
 Thu, 18 Nov 2021 18:27:16 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04dal.us.ibm.com with ESMTP id 3ca50d4acr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:16 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AIIR8X536241794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Nov 2021 18:27:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9613EB2079;
 Thu, 18 Nov 2021 18:27:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FC92B2082;
 Thu, 18 Nov 2021 18:27:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Nov 2021 18:27:08 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: chaitanyak@nvidia.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2 0/5] nvme-cli: Some minors changes in PEL
Date: Thu, 18 Nov 2021 10:57:23 -0600
Message-Id: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OOKfPfwM5ZRL1q2WIKTgq6L23hpl7p5e
X-Proofpoint-ORIG-GUID: OOKfPfwM5ZRL1q2WIKTgq6L23hpl7p5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=813
 phishscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111180095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_102718_283998_F8AD2846 
X-CRM114-Status: GOOD (  16.20  )
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

During NVME hardware bringup, our hardware IO team give
some suggestions/improvements for PEL support in linux.

Changes in V2:
- Add cover letter in the patch series
- Add "add_bitmap" function in Decode bitmap patch
- Add output of "set feature" event

Wen Xiong (5):
  nvme-cli: Decode "Supported Events Bitmap" in PEL header
  nvme-cli: Adds event number in persistent event entries
  nvme-cli: Adds readable firmware level in persistent
  nvme-cli: Add support set feature event in PEL
  nvme-cli: Add support Telemetry CRT in PEL

 nvme-print.c | 138 +++++++++++++++++++++++++++++++++++++++------------
 nvme.c       |   4 +-
 2 files changed, 107 insertions(+), 35 deletions(-)

-- 
2.27.0


