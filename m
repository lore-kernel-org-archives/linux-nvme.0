Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23164C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 01:42:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B700B610A2
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 01:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B700B610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AEd5aEOSJg++e8jPTdS79fDTrvslfGiSfBwIMaYQLns=; b=JB/9i8ib1vy/f1
	23oeRxD1pyvKS4IPHP2ImZkdACNiNkv2zPRJk/Sp8BuGQKFTfFCU6HWUUV/lOipC5vh0xmDXGVegg
	7xNW4l7qvFdqUAVOj8Rxon4cLjd+7vdrO8wwPdXEToaU+2IqrSVPPU9AN6HLa9iYCXsjXSztf7Rht
	QBo7p8PoJZGKffQKnpPa514PETHS8yqNiAmtlRlU9n/MfWylWmWctJuA3wwiWptPfHGRq3wLJmScD
	RCML000v5WOwKG2QgbIR7Dw0i76MFYWGJ7oe6oLCieCnG7eUZKFItokUt9gAEKGhFFjl2Ri8y8ANz
	3CInOIGBaBMCD1vMggdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUfen-001MmU-Lh; Mon, 27 Sep 2021 01:42:13 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUfeP-001MkH-6s
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 01:41:51 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HHlcr2FnQzbmqK;
 Mon, 27 Sep 2021 09:37:32 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 09:41:38 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 27 Sep
 2021 09:41:38 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, 
 <chaitanyak@nvidia.com>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH V2 nvme-cli 0/2] add "Path Access" field in command "nvme list"
Date: Mon, 27 Sep 2021 09:41:35 +0800
Message-ID: <20210927014137.3756-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_184149_440605_8A3F01C0 
X-CRM114-Status: GOOD (  12.40  )
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


This patch V2 is to add "Path Access" field in command "nvme list".
I have adjusted the patches order, added proper commit description,
modified the "State" to "Path Access".

When NVMe Subsystem is connected with one or more controllers via fabric, such as NVMe-oF over RDMA,  
if the link or NVMe Subsystem array is faulty, some nvme disks on the host are unavailable and 
they won't be deleted immediately. But the "nvme list" command does not show these faulty disks. 
So add "Path Access" field  in command "nvme list", and display the access status of each disk for users.
for examples:

[root@localhost nvme-cli]# nvme list 
Node      SN                   Model        Namespace Usage                      Format           FW Rev   Path Access 
--------- -------------------- ------------ --------- -------------------------- ---------------- -------- ------------
nvme1n1   2102352TSB10KC000015 Huawei-XSG1  1           0.00   B /   0.00   B      0   B +  0 B   1000001  faulty      
nvme0n1   2102352TSB10KC000015 Huawei-XSG1  1           0.00   B /   1.07  GB    512   B +  0 B   1000001  live   
[root@localhost nvme-cli]#


chengjike (1):
  initialize disk "access" variable

 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 57 ++++++++++++++++++++++++++++++++++++++++++----
 src/nvme/tree.h    |  8 +++++++
 3 files changed, 61 insertions(+), 5 deletions(-)

chengjike (1):
  add "Path Access" entry in command output

 nvme-print.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)
 
-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
