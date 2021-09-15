Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0354C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:29:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A2761263
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89A2761263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RuNC095EgEPVnHz+mfGzJjRHCYoTyCo5Bs0mHnbCdX4=; b=ux2nlElovCrAd+
	LVGZZuK/3v4C+AbNMaJYXhHpkxNFoWXGg7GsctUbrS35gJZRUFxcoer6Unesevpb9f5sRJtVv2sUS
	6IuIpE29y5GLS+u84rXn8cZLIRvJPT+Owtcc8j903aDYRGL0/UDIDfKjY5wlCoMdsnW4tM7YabEro
	z0QsvNz00e3myD8N2mr+gL5RGkMLwMxaTjTBcSX2Ajxl3oF/4ggfnr2NTLFc2f1sH7HeNuhNgehE1
	waeuUwE32rSq9aLVy1dzLQUW6SFPgFT1Ewoj0t+ZbQ/etb/1Wg1wUkNtAfvPZVube5gyk3riLemAw
	YXywq/CMKdFfMTVUDJ8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQUye-009ByB-AI; Wed, 15 Sep 2021 13:29:28 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQUya-009Bvl-I5
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 13:29:26 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8gtq5qxCzR9Yf;
 Wed, 15 Sep 2021 21:25:07 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 21:29:14 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 15 Sep
 2021 21:29:13 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli 0/2] add "State" field in command "nvme list"
Date: Wed, 15 Sep 2021 21:29:10 +0800
Message-ID: <20210915132912.3004-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_062924_817513_7EFFADFD 
X-CRM114-Status: GOOD (  11.27  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When NVMe Subsystem is connected with one or more controllers via fabric, such as NVMe-oF over RDMA,  
if some links are down, some nvme disks on the host are faulty and they won't be deleted immediately. 
But the "nvme list" command does not show these faulty disks. 
So add "State" field  in command "nvme list", and display the status of each disk for users.
For example:
[root@localhost nvme-cli]# nvme list 
Node        SN                   Model         Namespace Usage                    Format           FW Rev   Status       
----------- -------------------- ------------- --------- ------------------------ ---------------- -------- --------     
nvme0n2     25658552656655456265 Huawei-XSG1   2         2.83  GB /  10.74  GB    512   B +  0 B   1000001  live            
nvme0n1     25658552656655456265 Huawei-XSG1   1         2.78  GB /  10.74  GB    512   B +  0 B   1000001  faulty            
[root@localhost nvme-cli]# 

chengjike (1):
  add "State" entry

 nvme-print.c      | 15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

chengjike (1):
  set disk state

 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 59 +++++++++++++++++++++++++++++++++++++++++-----
 src/nvme/tree.h    |  8 +++++++
 3 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
