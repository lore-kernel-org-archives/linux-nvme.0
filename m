Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C63CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 09:04:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DA1611C7
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 09:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1DA1611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/etJdfWIpY+Zki/ztN+ghEIqGufi9D7ajIv2l3+g1Tk=; b=Buz071OBG/MFM+
	PU+cChysk5ayCVPWxHybxyh7QcNjvfPfrAq+ISF0OHOYp963ZQXd+d3/fux/zDxM7mdWwJ3q+VW7W
	Tdm0AoSWybPZ6MDEIoKHpDUIu6YJkXN6R0oW0vQQBLVXJ+VWipoAiAakaho1R37+R64TpPTjwGNDL
	YxFpgate34QZ+YYmf/reFLN0cew34D4KYpWLKSdRKJxoTwqSDY7vvbpj+/WKp+9yhaJ46cBuK1PCP
	27//zw/kt0tv3HEigFwrBjMsgvVDSzgUBmHFDaId52N3arTxNRbIfJwIyqhqenz7/nl8wnQkaH9xC
	C5at9Eu0mNzUCWxIFIOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV92X-006RlI-Lo; Tue, 28 Sep 2021 09:04:41 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV8pD-006LWu-A6
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 08:50:57 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HJY8s5cpzzWVXD;
 Tue, 28 Sep 2021 16:49:33 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 16:50:51 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 16:50:50 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, 
 <chaitanyak@nvidia.com>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH V3 nvme-cli 0/2] add "Path Access" field in command "nvme list"
Date: Tue, 28 Sep 2021 16:50:48 +0800
Message-ID: <20210928085050.4141-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_015055_575810_2EADD9AB 
X-CRM114-Status: UNSURE (   8.58  )
X-CRM114-Notice: Please train this message.
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


This patch V3 is to add "Path Access" field in command "nvme list".
Changes on this V3 since the last version of this
 - updated the commit log by Chaitanya Kulkarni
 - added a function comment by Chaitanya Kulkarni
 - modified the inappropriate code by Chaitanya Kulkarni

patch V2
https://lore.kernel.org/linux-nvme/20210927014137.3756-1-chengjike.cheng@huawei.com/T/#t

chengjike (1):
  initialize disk "access" variable

 src/nvme/private.h |  1 +
 src/nvme/tree.c    | 54 +++++++++++++++++++++++++++++++++++++++++-----
 src/nvme/tree.h    | 11 ++++++++++
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
