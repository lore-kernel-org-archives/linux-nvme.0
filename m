Return-Path: <SRS0=OKIn=7E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71759C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 03:42:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DAB207D8
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 03:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GvO7CsRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DAB207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+KJnddDpKWZNZeqyPATK8pdvaBKfx7yh8/HbwQn5l88=; b=GvO7CsRlg7Kaas
	WBjFVsl3S+e8vk5Sr+hWqHiN7tR9fmOOTrrYxh6eJnkEKMnz5RP356yX0qRvaHg5Ea7++e1UgOQw1
	J7SPhRDmTZXR8PoIWjgSH7tOjeITZgXDqWv07FvovTNx0s8QG+MQY5eB6qPBQYGrEjJq4LI0tFElZ
	+uvVYSnOa/fsunki/vILJ1rU06R5UU6+LB1+3WP+qXFhevGhrr8CZQowscCV7Wtnv68gdS/vKBBJy
	0BoyYrr92cTnAKJEVN311J3H6zDfUgWQEtCxjg9X1pFPlz3Dj/6/9gOI9NuMuqtwQ3UChb0n9CNUU
	hfLb8FqKTQbaQAXz7xNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbyZa-0005r9-HW; Fri, 22 May 2020 03:42:14 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbyYM-0004p6-4t
 for linux-nvme@lists.infradead.org; Fri, 22 May 2020 03:41:09 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A90ABD17D2FEA8B23843;
 Fri, 22 May 2020 11:40:51 +0800 (CST)
Received: from [127.0.0.1] (10.74.203.66) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 22 May 2020
 11:40:40 +0800
To: "kbusch@kernel.org" <kbusch@kernel.org>, <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Zhouhua Liu <liuzhouhua@huawei.com>
Subject: [PATCH V2] nvme-cli: Add huawei vendor id as filter in command "nvme
 huawei list"
Message-ID: <3a4b9e11-c653-2d81-98e4-09be9b0ab584@huawei.com>
Date: Fri, 22 May 2020 11:40:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.74.203.66]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200521_204058_385612_39F842C6 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: wangzan <wangzan@huawei.com>, Kangwenhong <kangwenhong@huawei.com>,
 "Wangchong \(Michael\)" <Michael.wangchong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


This patch V2 is to add huawei vendor id as filter in command "nvme huawei list".
And comparing with the last patch, I have remove the symbol \ to comply with coding style.


Signed-off-by: Zhouhua Liu <liuzhouhua@huawei.com>
---
 plugins/huawei/huawei-nvme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c index c935f47..b4aef1e 100644
--- a/plugins/huawei/huawei-nvme.c
+++ b/plugins/huawei/huawei-nvme.c
@@ -41,6 +41,7 @@
 #define CREATE_CMD
 #include "huawei-nvme.h"

+#define HW_SSD_PCI_VENDOR_ID 0x19E5
 #define ARRAY_NAME_LEN 80
 #define NS_NAME_LEN    40

@@ -80,16 +81,15 @@ static int huawei_get_nvme_info(int fd, struct huawei_list_item *item, const cha
                return err;

        /*identify huawei device*/
-       if (strstr(item->ctrl.mn, "Huawei") == NULL) {
+       if ((strstr(item->ctrl.mn, "Huawei") == NULL) &&
+               (le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID)) {
                item->huawei_device = false;
                return 0;
        }
-       else
-               item->huawei_device = true;

+       item->huawei_device = true;
        item->nsid = nvme_get_nsid(fd);
-       err = nvme_identify_ns(fd, item->nsid,
-                                                       0, &item->ns);
+       err = nvme_identify_ns(fd, item->nsid, 0, &item->ns);
        if (err)
                return err;

--
2.22.0



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
