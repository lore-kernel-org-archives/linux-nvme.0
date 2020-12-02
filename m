Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1797C64E8A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E965221E9
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E965221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MIbFsRHcmQSBOaM0/L8FbAxt7evnPff1XMiwiKtTmo0=; b=zhT0Al1UVsUf9z8clCZahlcwt
	3V6r7tH59nTkk3B/BN7CdOcz01gWmw7c7/VfPhm0+kmndXL8vBmPoECI5FD9uq1Ct8lSInJJAXphr
	ZdSBcmEGhztui/7LhaBtLMCzRWpFYvI6KYNQzjpNsviu9Isw4XK/qxKdDwShYdtac9hNH0mVjBNtv
	48fw2qpPikS9gA18VDf5hS0kgxZicBqdP8EHnZNk5HXaUK1W4+1Nb148r5fK98dIDiMfMdb9HsMCL
	d5Njtrn1naYo6Lx+46+zFJ7aB31Yyx0zVhSLI0BLY5kEYu+PwpG4HFYjxz/rT7rytr5SA8KrzRoXz
	/32ddLc8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLXW-0005Pw-W9; Wed, 02 Dec 2020 06:22:59 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLXT-0005PR-Pp
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:22:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606890175; x=1638426175;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=82+/5kJqGP6zI/njb0x75RSCgHH8h3QmrRRPprctKjs=;
 b=ZCkehM7vao3Z+hyciXu+wFcPTQXMEmXQainsQ1t/LP2qMg4eSkzqHrqZ
 SSBAzbF34u2gNoybf1G6X2LeqBVNk0krTMh48x4U44aaasNL/1OIb9QyQ
 6UdNUfDwERCj8PgBbUk2Nh/xytfagtz02tDITrR154Uege0cniFXUlg/w
 JALhQ6yCrKkOTEJzz0QOJ6F10tc2dY7MCACmOL5ufhlNPQu3nnJwkO+b0
 zpSYukOnldZ2nUpzlIfQMhtYsLtMVNbp1CWEF/uNBMphnxNlNnbrEiYOT
 c1j/YGMrjIV7fsAR+KRCt8XSGRZyDNZ5BQOjAXQyjePaLz722yLX78Xf3 A==;
IronPort-SDR: hnR8H1jKz1+G4fkFf/McNtpLJ83u7irIPofL6t2GN+JP1aSCx7Or1t9WWo4KbS81IKJ9uW787s
 qL/6058mb6A/7KFOXmq6AhOcGhHyccTHsqNuvgoxfqsaihT7F6655PuZIn2p6BgpMmrwL1HvWQ
 iukauW4cHCCjvzSsQEoUAgM+aULaphYmU5YJiwfPH6oz6QESgLcibxBNtQ40+lsKiwX6vED4K7
 7KZRuQvDeGAbDrOUqmny6VRpwZxDqDKSid7y0jywMOHfLq3XyUPXoplObJEeH7lW62VvkZ/GE+
 WNs=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="264126071"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:22:53 +0800
IronPort-SDR: yOlssIUqGfM8GavpGnOtSP07VKD/FmzEIF/tjJ1ZhnBUZU3N/L6wk+UNMyqK4UTFSLaeKvkpN4
 iN6gDU98Z+VAz9vmDq265ZpO5W9QCHzhI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 22:08:27 -0800
IronPort-SDR: FNXPoB4WvPAm0gJxkZMp4eSWXqfhXKyjMr67/9mErB6XiLHz3b0Vx13uYOkiOCzfVzrFFyfv2F
 OVk0pD3ek5Fw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:22:52 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V4 1/9] block: allow bvec for zone append get pages
Date: Tue,  1 Dec 2020 22:22:19 -0800
Message-Id: <20201202062227.9826-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012256_013690_EF48ADD5 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: johannes.thumshirn@wdc.com, damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Remove the bvec check in the bio_iov_iter_get_pages() for
REQ_OP_ZONE_APPEND so that we can reuse the code and build iter from
bvec.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..54b532bb39f3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1110,8 +1110,6 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	do {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			if (WARN_ON_ONCE(is_bvec))
-				return -EINVAL;
 			ret = __bio_iov_append_get_pages(bio, iter);
 		} else {
 			if (is_bvec)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
