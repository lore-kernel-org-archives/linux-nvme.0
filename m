Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB43C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 17:10:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CC764EB3
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 17:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CC764EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YpUsEgcjZRMkfTlrn5zXWY+EbgVMZmTSsr/6GAKUHLg=; b=SFmNWiRTXQsbruQcfKLGVsfzo9
	SMK6Uf9lPGvvPg3LYEVwVLqPOCo20CARHAHH/3Nygizbnyi3RzO8yHHJcK2RLEycx1/dmHUu8r08L
	J2DbZ44XJx0oZqS+H8fkqgRj2i0sVwT626HhXR5MR22+nLjlPf7HEF43+bpR+uHoZqoddr67bTPlG
	+NGvqVNSJa73JEt+bTl2gq6cU7nW2Q/gdtfpxaJ0mUbVqiW/Xn/NnNcLEZAgh4QZ+KnxU65k4/w+Z
	nFB0LrFj7dUvT63D2uV6kRTh/VADA45SbHrW7EKblTWDxkyIphkT27VKO3prIB5tgB5vh5mzoGTWd
	exUg4Wrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCmoR-0005Ye-Ep; Thu, 18 Feb 2021 17:09:59 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCmoO-0005XT-Sp
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 17:09:57 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11IH2iJp014724
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=iOzx0OYK+UNNO4YieKhBdXb+NeFDdGB4h/IMLZWKEDE=;
 b=bJ8byuD+IfzNsafnTuT5ksNz78g8uFrPi9pvcA84CumsUrxShNo4S8ODQfS2/gvNMziI
 +SjpqhcllOu7hIQ1PJjVEA9Pf+sebVPztePov2p451mBZ8l1w63XRu8Z/vVnl/dbA8EO
 fOriPTB+Psa9fEeQr8Cf52+N/0+GYcs6avI1vBunEEwA4EcshZSmLz72wBzbyNQz7aEB
 jnN7bYyuDp/C3yGqVmxW3NIgw2AKldnBPX3YOCAlCU1j7sikqK2ZPbuj05aT4HjlD4hd
 h4XgJncKyjtDi75bo4NmO3JmzWmVjhyCDAnwi4zGv448Km9VqG9QZR5NDnDXrdWBuHG5 jA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 36pbhg152b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:52 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11IGxSWx045130
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:52 -0500
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com
 [143.166.85.200])
 by mx0b-00154901.pphosted.com with ESMTP id 36pw0bvmbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:52 -0500
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,187,1610431200"; d="scan'208";a="1047578350"
From: Mario Limonciello <mario.limonciello@dell.com>
To: Keith Busch <kbusch@kernel.org>
Subject: [RFC 0/2] Split out firmware upgrade from CAP_SYS_ADMIN
Date: Thu, 18 Feb 2021 11:09:45 -0600
Message-Id: <20210218170947.15727-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-18_08:2021-02-18,
 2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=552 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102180144
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=678 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_120957_050663_E734B8F9 
X-CRM114-Status: GOOD (  16.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Mario Limonciello <mario.limonciello@dell.com>, campello@google.com,
 Richard Hughes <hughsient@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 jorgelo@chromium.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently NVME (and probably other drivers) require CAP_SYS_ADMIN to
send all commands to the device.  This means that software running
in userspace needs the stronger CAP_SYS_ADMIN permission when realistically
a more limited subset of functionality is actually needed.

To allow software that performs firmware upgrades to run without CAP_SYS_ADMIN,
create a new capability CAP_FIRMWARE_UPGRADE that software can run with.

For the RFC, only include NVME.  Other drivers can be added if suggested.

Mario Limonciello (2):
  capability: Introduce CAP_FIRMWARE_UPGRADE
  nvme: Use CAP_FIRMWARE_UPGRADE to check user commands

 drivers/nvme/host/core.c            | 28 ++++++++++++++++++++++++----
 include/linux/capability.h          |  5 +++++
 include/uapi/linux/capability.h     |  7 ++++++-
 security/selinux/include/classmap.h |  4 ++--
 4 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
