Return-Path: <SRS0=1WVC=4N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30B3C35E01
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E2A21556
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uximsAJB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KM44AS6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E2A21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nszU9IC5AMNRinHmLTsBMKvyBoLlUgr/HJGR+/HPV50=; b=uximsAJBfmFg1g
	A2jy4Fj8VGQI2uVd6c02OKMiLrOGcqYXouwTVgSyv7a9zs3TE0X9kV32rawksWgsc55f0286eQywh
	fjrlvkVb8u9ZyxsRwyn14Zf7kf0a+7MlRTszEI9D8QvrY2FdwaqIf64uDZmq0jLYQfye1/hoPymD2
	Dmn7nqzcRvfNtq35Gjn+yK66Jna1gX5BkgvqKKvoE4Vph1adatdav+dg/RcHvNqK45pbthtjvhsDl
	1XPdqMaYpdtDlSQT8twJ05IWeDTrMwga/YAzslMGF3q4FSFMC1kZfMixl92JkSSE3oafJvBE757rO
	8rGOoPo/DM6mCStTvQ2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6gPR-0003j9-Fd; Tue, 25 Feb 2020 20:02:25 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6gP1-0003E0-2o
 for linux-nvme@lists.infradead.org; Tue, 25 Feb 2020 20:02:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1582660920; x=1614196920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=67DQ2tSweyaKg/Y7z3kejPHwNjR9kHAbtdB3UyNuDvY=;
 b=KM44AS6lfbF4/9A/7HoFIFdP25zsu2Tv//XhcIFyeZJZCr6Jx/m93h71
 uypMCaY/xHv0a6jOJb/W5JsauI79EwBknKFYNSk9D9MDWzsWYJwT7qMcF
 v8EFAEjg/a4cHMcpg6011HhJbG6zM/jugPuPcEKIqBje9Hi+Lc/vElLB1 Q=;
IronPort-SDR: v4N10rnEAUYDisN5FtYxmYgQyFO7A3h7HpOOv2d5J4UPbO22NpQUyNVRv963Z8USuBBYDc81nx
 y4OC6fqFnx0g==
X-IronPort-AV: E=Sophos;i="5.70,485,1574121600"; d="scan'208";a="18185712"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 25 Feb 2020 20:01:46 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS
 id 34471241B84; Tue, 25 Feb 2020 20:01:42 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 20:01:42 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 20:01:42 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 25 Feb 2020 20:01:42 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 4/5] drivers/nvme/host/core.c: Convert to use
 set_capacity_revalidate_and_notify
Date: Tue, 25 Feb 2020 20:01:28 +0000
Message-ID: <20200225200129.6687-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200225200129.6687-1-sblbir@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200225_120159_406939_80F501B6 
X-CRM114-Status: GOOD (  10.11  )
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
 jejb@linux.ibm.com, Balbir Singh <sblbir@amazon.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

block/genhd provides set_capacity_revalidate_and_notify() for
sending RESIZE notifications via uevents. This notification is
newly added to NVME devices

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ada59df642d2..4699388c5260 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1810,7 +1810,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
-	set_capacity(disk, capacity);
+	set_capacity_revalidate_and_notify(disk, capacity, false);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
-- 
2.16.6


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
