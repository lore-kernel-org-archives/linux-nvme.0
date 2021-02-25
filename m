Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4DBC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8968964E85
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8968964E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IRt3tH58cppVuQdQ0a4bem2E+K6DZFr+C5wL/Wf+J08=; b=DmN3bKOKFYdKqojLVinSYswW3
	IgUx7TxgwvM1wVat7AOL4+93RAoIn0jKxxb8soP4WOI4mDAvORgJ2+IYTIUE8YMK4p9mjnjvrIka3
	I10spbJNUOkaR7k+5GiqprmbQeSKDNS5UpbK6jwjSxbt/lEXE7nKIdioCToE4ssu3kAkPkUuNwnto
	t4eGrNtgGWzMVWkymvAvFxEw+//HD6MPtejpzSODdd9XtuF4WODUzP7d6NZKZfRnS7Sj2el1SWL/x
	ljUTbd9qFZblidTv9qVT2aIo+Roz4HP78QprgLIf6AGDfbWMVQT/O9olfHeicuYmeZLWkk60kW31h
	hoZbu5t5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF5uU-0007qr-1d; Thu, 25 Feb 2021 01:57:46 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF5uS-0007q7-Dh
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 01:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614219084; x=1645755084;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2W2aVHPam3riGr+6DwpXcaE30DYoFlisEOk/5IRGVjM=;
 b=PKrjaRR23jkImFWWa4kn0rypRsfG43MXEQ/Rrh+htPTkRBVjLBtFh9o2
 XZMcyfruHi/8N2bcYVBOeMWiqzLx8AH+3C3rF4/0BKfT1mTizbPClUz16
 UeekvGYxFAzS0E9mLZsMHgT8MX1U6vcmKm7bWnonz+mynaPnTA/KZX4as
 JGpkunziZbLpT8PMgqiZ4Ht8a248vE9ofXWo2DtqC3GamuoYtwJVRyZWk
 +ouPSzDexFi4qRi0Bj9m4f/hWsOTBBOBqJ6wn8xdML3kiuEs6o4/TxBD4
 HEmCo0khl/lZHqbI6cPGRTHEnmZEw7fc18VMEtZUjbk956sD24HG0YG5Q g==;
IronPort-SDR: M9eo3GmHnU97uqm5gpz/SsCSJaK+n/9gxSqDP88bEH481LCE9PqQB/okXP0+Bx1SmtSQcmy5GP
 LaGAtt9y8CubeSLu90WL4CADM55H6KJvpfF8IeTLP6ziGRfgrmqdGbfEwvFUyWD7jRvmdTk9n5
 1QhGl0NpPZHirFM73DvpKiugEOlCPvJ1HPSiXWmr29g/uCcgOfuOK3WyogjEiSafpnyZYtH+e5
 fqvhGGqtxnridtjRNccHs4VfZAMemONQJbPPH1VLGOH67l9wbwKG/lGH8oSgB/GUl8AL2+STRL
 Q88=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="264959807"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 10:11:23 +0800
IronPort-SDR: gLz/2hxP5P8ySLTK3QSPFxSaKSjMnYJlTQuwFTFwY+1vQIs0y7lVx/iGvfUOsvFaNjASo85YOx
 4pmsv6aiWjHbvUlMdI2A5jqdn+ZVH5eaiumz9mdc3xj/brGnSI2bI0uz4W7YXaxe8+qf+oSVTz
 3moq0upECnJziIYcprjyejRk1PS44eaMmdkmd/y4fnY9+HOpA3OJzNFxkLJd6qhdN/ZA1OGcRd
 2YSrKBOyB+4wPtdK4223dsJyAFkgAflNZ6DRz3Wgd0J4Eluffo1Z2HxThJS3r8YDt/0C7JxIqa
 kvcotQWsj4aFPFz1pLhpb40+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 17:40:59 -0800
IronPort-SDR: zZ/42q9t5VcHGHjenKySIL+6jNQS18EhxrR9ZFS3PP33UVOSHOaUPnoO6kajr+nycszxz0WXih
 3z+PrPcIwtMszGPsckqWL8pn5EHFzzdAtUePHP2Yvgn7tzKB0TnJBS1hbiNnGfHfsD4IYQx0R1
 poR2PwlHyhMoOk3PRMzqHDbeBesdwnETE7csaJ5AvB4NI0hPUKvP6R2z5nvx4n/AbhGRCbbZZi
 qbTLjXFwrL+zGRULR+luJZGKGDI6LxAbeCzP1hx+jcYKveRSyKv97InlLVIoGUr84JdZ96sQkK
 EiE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 17:57:43 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 6/6] nvmet: replace white spaces with tabs
Date: Wed, 24 Feb 2021 17:56:42 -0800
Message-Id: <20210225015642.29288-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_205744_609516_1F2D88CF 
X-CRM114-Status: GOOD (  12.87  )
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

Instead of the using the whitespaces use tab spacing in the
nvmet_execute_identify_ns().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 16a3e434f52e..f4cc32674edd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -513,7 +513,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	default:
 		id->nuse = id->nsze;
 		break;
-        }
+	}
 
 	if (req->ns->bdev)
 		nvmet_bdev_set_limits(req->ns->bdev, id);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
