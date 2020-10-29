Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6133AC4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 19:00:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ACD20756
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 19:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u4a+tI68";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y+Ssqh8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ACD20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VHs2B6yNVzuYNbLsnaNlP6ENLW5NKcVPg0EN9rvAiDY=; b=u4a+tI68LibjXJoQmm8Z+sURT
	PmTi/3te+BZ+5+KY3sMBDgahU9G2p43rdX9oAdOL6BHxWd18m84Rvu0MC8+0DDGTwyVw4AqBbgoL2
	maPnKlJVym3hRfIcVt0k6zAYCMA7FyTQa1cbss9oFSCYcuqp3Zyb2LAXb35fhV4Sx0gR0jpKor1zn
	NNYZxPNahOoOFc9Hjk4Szp72jPWeTCxzACzA+ZlGCCif9ffqNVxJ2PwdBKSD9ka2SSlDeXk8ZoWPt
	AxJJOUONp9QEvaOW0aRS1R2JQ8XSWcgq2yeyT3vXPROezcGjybMJ0MBp8MBxpfJWVYrxnqO9ECkt6
	C/KP8G6gg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYD9j-0001C5-PE; Thu, 29 Oct 2020 19:00:15 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYD9f-00016S-Ca
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 19:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603998011; x=1635534011;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kmZwp5Vx/iGkeaRqR3FJ7dKV8da8PFUyKQz1e6MY0kg=;
 b=Y+Ssqh8Ekkr5dBgozfTz7JQY86JaQxuP8CNl85NOv3NF6kgtm3JQdF5J
 DS7B5A/CS1Ck4KfOKdGSsTnmygIQI2bEdi7i7a9IrUHYCfm1z0jHpMT04
 3hLz3pw5FAkuBWDUopl16fj1cr5YxEFR14EJlzSK+Ln0ak0UNWnfz+bW5
 xj1PVniwaJQCTSpPvh7YguaWJKp2GJnyy7p9cvfwU21n6QVed8TukU0R1
 Hew6O5v0IizUh4uUydo+YjQHnoZ5upBZ/zVnuP9nfPn7xEFzyfkCzBsgj
 HtZWf+vlpob8XyEu5e4lE5sVEPP3hQuCtn4rkSfoELzrFxb01316ETlar Q==;
IronPort-SDR: 5TeGNKkcDYsFLNeDzOGp5co07toNezxGCqqGXq/aZXnXwfz1tLu63+gB3IaeX5HiF9/BfrJmPV
 D6VgHwOCJFMKYzhAUZX1oMZRzBxxEcsxRFEo8DdUsN2LE3fq+r4g9T8jIvacUp6QFAK+UHqV8n
 S+pH2ZGxRgjYGf1a7aZkbqU2LCER3GbHd9lRZfjwKSipLRrknwAT3+KbBmj3XvakJM12p7Sb0t
 zm5iwS3ePiNuUigAQII3+kjJLu3Mt+h4fEbU9vHVQFaY/rwqeBLdgH6+09kaM10G8/ytxxeO/B
 bog=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151175678"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 03:00:11 +0800
IronPort-SDR: QnMYR2I6TKp80DBAS/UUOX4qWzw33EOayeanFqBy8QpU7sZoO0nCBFoxYTwE67/VkJHXPEt7+y
 BIQ0l/T85Lotip3VC/rlsrddgVJ/TR4paHlOG+zLlMV/GkPeTYJhAjfUprcxIRHbGwzcIfXgKB
 NCx2WMmTBX1gNoKbZwWlefTisNZ5MBGIvRUvLtZYV00XSe0fhC3iFapiuIZdC7xxOyPr/H0ST2
 0rYe0lZ+LrItE7P/Fvj5W0cFWS7+dBSUG+KL1Q2TZFf8PTmDdbL257d6mjpc/TIlHkO47VhB9p
 W1P8MvdYo0/2HGk4Ff9572q7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 11:46:26 -0700
IronPort-SDR: YjBZ+q5bPAw6EWLL+jZi53FpJhM4g3qW1XlOp/zoBJC93d0LPL6uMmYpmyRLOgidl0u0QHCFpO
 ERvih9o5s9XMkAnn7ZYweNE8I4BJECbnVNTEomAU41koWTdXEyEIJ1QAAKvDL7GynkoKJP3S3h
 J6AZDdG5mXA0IYhZGangi7IF1aLTQWIbEh37pYEuJW93AUgEtK1aH+4SKqN/EdBH60DbCCVgJ2
 KsXVSrc3ZlMFAW4kKCQNjfCpNFUrvQ/7olxz9aE73ET/dqo0PeX4yzfdnwKumFy2YCCXNyRo8/
 uCA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 12:00:11 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-core: add new line after variable declatation
Date: Thu, 29 Oct 2020 11:59:58 -0700
Message-Id: <20201029185958.7013-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029185958.7013-1-chaitanya.kulkarni@wdc.com>
References: <20201029185958.7013-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_150011_637863_F735922E 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a new line in functions nvme_pr_preempt(), nvme_pr_clear() and
nvme_pr_release() after variable declaration which follows the rest of
the code in the host/core.c.

This is purely code cleanup and doesn't change any functionality.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 16f590a03486..b4fcdc373144 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2212,18 +2212,21 @@ static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
 		enum pr_type type, bool abort)
 {
 	u32 cdw10 = nvme_pr_type(type) << 8 | (abort ? 2 : 1);
+
 	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
 }
 
 static int nvme_pr_clear(struct block_device *bdev, u64 key)
 {
 	u32 cdw10 = 1 | (key ? 1 << 3 : 0);
+
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_register);
 }
 
 static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
 {
 	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
+
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
