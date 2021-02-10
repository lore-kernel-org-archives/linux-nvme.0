Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CA9C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308F764E3E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308F764E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3fBapQ3t0JjrK+ITNp1UcC+cVwFOWiU4jbnrJOM4OGU=; b=whko0ZArTd969khQZpFr7B58D
	Rb0t2cv3/VL21DBviKxiPaSQsT8vDWwMrsG5iSqDc+McafB63TL8KhNmM1Vfhc12Q0rNt9GpV6Bfu
	blH78kLLl1TmQSF2LLQCefbVL8esDNe6hHPKEHQ4DK20sxJOpM4QI6HGA87pVnzjRv3HNlhxvCRX4
	U6NVYUqe2f8VcLf3UAThVW0OfhC3t1ERJGrklcZbIcZg8Lhnvy5jnRe0K2QI89P03/Gt/rTj3b8PV
	zuG/l50EbFtk94ZExegV+YByK5uMtIlUrqlfwIqx2mB1hBcPX8apAjd7jRv/Vk7rhV7IOU/4KZXyV
	3UjPt072A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iMK-0006ma-Ax; Wed, 10 Feb 2021 05:48:16 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iMI-0006lf-2c
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:48:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936093; x=1644472093;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+2uE+RO/SCZukRwUnLQorvH4bPyZ2XnI+Roj35iT/Q0=;
 b=fCCXpSHSUh08K4Vvg2mFT7OLx7ldniBGCEt1zOnXleNlOINSIOmJbnsz
 bqolQYeUjAzvs5zG/3e4x5CvBxSdYY95miDuKHwHWXKCAKxrcLeRhix3J
 JLwYtRbNiw7jpT8gIFYluoE49HI7QEfLzQ/JgYaw0aMjDG0sVnKCur+Se
 GQwO6ByZS6Qo/u0FIDdIHq+EEyobXTLJ+EQdj/nKskh2QsvU+OMlQNJeu
 6DSWBEmWjrIjSd+GoAxTWllenA5WAqPkKr3URvI40NR8sq4wE97/OWHFq
 35A0K88dNIEmGDy9XDMB5jbuXa/lN6/LtobeoRg+WZKKDzXNd57eXLBrq w==;
IronPort-SDR: IzzhM4iPYAEbee1KEETL20DMD9SZEWNa0xYuL/emJ2wtym8FIbJ5gjahPfLGI3pw2mIJqbM0US
 OM0GWPxk7BW7GPp/RO3hjtmISfYmJDGjsdsZAQj3peYFuIl514IdD8sgWbIQcOFWLfyrro8QO3
 B8Mh0cPajV8klHmFlA2vmAu4blsSADbHpbc4nCWmUjcFTLuTRwk2VYJxEi4lW//I/Cz1i5ICHm
 smdqFCsIbwc0alyKQjN0VpYQGRnEgXRcXwi10+gaccwV9dXOjQHeaUJSpIsk5Q44POq1rYB9ox
 ExA=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="270080455"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:48:13 +0800
IronPort-SDR: 7BW6ifAq5TMEfL5Q80wf0TDGw1Vg59AbXk3jVOx/HYfn9gKuEiYraNat3M4qB0iRwsUD23Rfi7
 MlMxormSziZuMhIfgoqsP+DwnYQf2uNn4rfzu1u8HB0ek7PfGpEOBzqZHgh7Vcas+YHcJn9n1I
 m9mlaFwwldIiTOQS5HAWHNuiC7ofp31sXelLUWhr4g8KtXRATUM17R/87apHDbbFovBnbRupYh
 iTRjtrbhSnf5vAk8uoNhHamqrIuHdlsR0XfBEv+J7zY3NthHouY6LCprXxXu7OlNEQXMOnxWa6
 O0lSRt1igsgdaHysFlyZRPF7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:31:57 -0800
IronPort-SDR: o+N51llusTt+h9oZVY4g+N9mQG7D7kQcKfkeDOodvR4XUrmWwQ6ew0haZ0M38L7zhlzEai5gz8
 gQi77ODSXtRM6LUsK/zGIohJ0m3JM4HF+yEt5kuRdXsgv7VUQ7zg8EIaGTymxi5IPq+vF93JXE
 g4sB4ChSXp5bx4EVCXb5GCVq/dp+LGtmp6qt/xvKFuiWTYI7iAMNhaZHsfm5MDi3IVdmvougDc
 EBooFB7jCVv1AjdTvu1nO3pFhmV1ZTSGJroY6Tca84iuP5N6a9o4+sJ93kfHE1owJw3srb1JZW
 HIc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:48:13 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 01/11] nvmet: set status to 0 in case for invalid nsid
Date: Tue,  9 Feb 2021 21:47:52 -0800
Message-Id: <20210210054802.34269-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004814_262877_7CD94F62 
X-CRM114-Status: GOOD (  13.61  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For unallocated namespace in nvmet_execute_identify_ns() don't set the
status to NVME_SC_INVALID_NS, set it to zero.

Fixes: bffcd507780e ("nvmet: set right status on error in id-ns handler")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 613a4d8feac1..5070ea5cf260 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -485,7 +485,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	/* return an all zeroed buffer if we can't find an active namespace */
 	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
 	if (!req->ns) {
-		status = NVME_SC_INVALID_NS;
+		status = 0;
 		goto done;
 	}
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
