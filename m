Return-Path: <SRS0=1aKD=O4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2730C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 12:26:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D8560F44
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 12:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8D8560F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Wn93O71wuTz9ySqPkdrTLu0hlNJPhirsB1SqQbmvh6Y=; b=ygI6lfFx/c4W7k
	FbRILNmrktRlLw1Z0+2CmwUX6kTKav3SVivsxqeo0fWiAs3rK+HTJeqqhVSNVhNgDMpQwIzrG3X3x
	fwM3wziacDKKHgwQgqidsRyWIgl4GnXtxWkzSf/RozJ2bIH90hnIojWi+yzFDLDjpchwtAE3+Mha1
	YnWOH1x3HhoML/4TdnJfX5dp4w1RNtyvBSLBeOAOdHVPSFV7wz43ElPup4HU0ZKGNi/py+fmb4Xtm
	yaeSIJbiU0g+A9NxVENoHHI+nS86zVQpnln0P9+cjvxen76V+VcxKwxPOoz+orUM3YgvVWB2FNO/T
	YWqrF987x28Q6FEKYjMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYowr-002gxo-1e; Fri, 08 Oct 2021 12:26:01 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYowo-002gv9-0f
 for linux-nvme@lists.infradead.org; Fri, 08 Oct 2021 12:25:59 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HQnNp4nzszYk36;
 Fri,  8 Oct 2021 20:21:30 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 20:25:55 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 20:25:54 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, 
 <chaitanyak@nvidia.com>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH V4 nvme-cli 0/3] add "Path Access" field
Date: Fri, 8 Oct 2021 20:25:50 +0800
Message-ID: <20211008122553.1779-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211008_052558_274994_617FC6F8 
X-CRM114-Status: UNSURE (   4.49  )
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

This patch V4 is to add "Path Access" field in command "nvme list".
Changes on this V4 since the last version of this
 - display faulty disk through the value of nsid is set to "-1" by Sagi Grimberg
 - The "full/partial/faulty" fields are used to display "Path Access" by Sagi Grimberg

patch V3
https://lore.kernel.org/linux-nvme/20210928085050.4141-1-chengjike.cheng@huawei.com/T/#t


chengjike (1):
  display faulty disk in "nvme list" command

chengjike (1):
  get access state of Native NVME Multipath device

chengjike (1):
  add "Path Access" field in command "nvme list"

-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
