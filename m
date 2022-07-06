Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46555C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zPsDr5JnRzFl1G7OAEerBmu0l7waMoDPRejqTL62EaQ=; b=xyaKMQhgA0Gzugjm+6iXuQhY9W
	XVRUWtkIFwsrXj4VaKVvtfO5mjIamZUPYQ+V97O49tpMFomyyASx/GKRoNEi6RdT95bZlnANhjbsw
	w3w9HqKR7HGZHxYyXBSntLO0kVZDf9dtlaNr9/76qCcg+xOpo5SimOX7FYROMvFa5RPeQ6oosbH5s
	pcDbMmR6CTWM3tXWuNLw012OszY//tsUtks6LKV8S81SExeeLWzHxmt1gbfSD0WmxQirVmxJTLXWx
	VbWT5aKnD2PuK3IIhDA5Xczjf6xhIklcABy3cFkf5Sni7wa7DpY8/nBkWt9WS8aVFCGSumDx1XO4p
	epY+ftRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o90JH-007Lxj-RS; Wed, 06 Jul 2022 08:22:59 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o90JE-007LtX-9g
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 08:22:58 +0000
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdCC94M8qz67gQT;
	Wed,  6 Jul 2022 16:20:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 6 Jul 2022 10:22:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 09:22:44 +0100
From: John Garry <john.garry@huawei.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "John
 Garry" <john.garry@huawei.com>
Subject: [PATCH] nvme: Fix nvme_setup_command metadata trace event for cdw10
Date: Wed, 6 Jul 2022 16:16:38 +0800
Message-ID: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_012256_504197_DA27247F 
X-CRM114-Status: UNSURE (   5.67  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For x86_64 allmodconfig I get this warning:

In function ‘fortify_memcpy_chk’,
    inlined from ‘perf_trace_nvme_setup_cmd’ at drivers/nvme/host/./trace.h:47:1:
./include/linux/fortify-string.h:352:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
    __read_overflow2_field(q_size_field, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘fortify_memcpy_chk’,
    inlined from ‘trace_event_raw_event_nvme_setup_cmd’ at drivers/nvme/host/./trace.h:47:1:
./include/linux/fortify-string.h:352:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
    __read_overflow2_field(q_size_field, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cdw10 metadata is 24 bytes, and we try to copy size of cdw10 metadata from
nvme_command.common.cdw10 into that cdw10 metadata, but
nvme_command.common.cdw10 is only 4 bytes in size.

Fix by making the trace metadata size as 4 bytes.

I find that this warning started first appearing from commit f68f2ff91512
("fortify: Detect struct member overflows in memcpy() at compile-time").

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b5f85259461a..d6d35f935006 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -57,7 +57,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__field(u16, cid)
 		__field(u32, nsid)
 		__field(bool, metadata)
-		__array(u8, cdw10, 24)
+		__array(u8, cdw10, 4)
 	    ),
 	    TP_fast_assign(
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
-- 
2.35.3


