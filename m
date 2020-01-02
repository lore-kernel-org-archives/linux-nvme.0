Return-Path: <SRS0=Pbb9=2X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828CDC2D0DD
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2020 07:54:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B64206DA
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2020 07:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOONKi6M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nxngOqCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B64206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U3eTc0SwU2yxPr1dA/f+hi7KVcfQhhvqjxPnLky9F9Q=; b=qOONKi6Mf/Aw7w
	EqCRkS/z8MJRhg0FTmUjjwen6jNiVWZWYyTeSd3qciK1CIHP4uVcnB5znhXwOKTMvgddwml80E7E+
	cg3UYiivYSUXzD3JdU3rY75VwYDIge6gueffHNZMHn5h1tyxufrLnNHuk/pyJM3/LRJsMNMaFc3Aj
	xJKMT3BdBAgK56r6iXPE2mZ7ahsvR88BD0nwUxgF+KJ79ABEFoiD2cFyYXwJ+6Gd+5RpZ8ppT3n4O
	S72Kj5b4H0z2S7DV/NLFpLZD0kgRA4S92wJ121xE4R/tQe/h/+TJwhGqCifktMTjalug3wshPHBRt
	cLRbEbMmL13qHgAbDiBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1imvJd-0002eL-Vz; Thu, 02 Jan 2020 07:54:46 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imvIu-00025k-W5
 for linux-nvme@lists.infradead.org; Thu, 02 Jan 2020 07:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1577951641; x=1609487641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=RlibLQQganA2BZ89ch7dSkDd5ROuDmDBz+7MfRKKRsw=;
 b=nxngOqCeG8941fJRI+lz3Hjrr/bWZleGFBYl5uD9ICUkyXH4MVZXfiIg
 inF34FomqvOy+HfTfHfV0jzstpYekC6XG+sXs+DzGmATQ0LzmncyCOOW0
 RQLSGoU/0AiRzNK34P8PHghKxTrBYUTaTOMZtCfdSeF4Tb5cOt5Ae09Xg 4=;
IronPort-SDR: PPLhSY4jNtRBa2o7qMz8aHt3QgFdThFlbslEB5/L+ZcMKItPHVxhHM7qn/Q5Y0LGcfjtOs8+LX
 D3R9mD+FVJHA==
X-IronPort-AV: E=Sophos;i="5.69,385,1571702400"; d="scan'208";a="11240006"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 02 Jan 2020 07:53:57 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS
 id 93F49A1F00; Thu,  2 Jan 2020 07:53:54 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:23 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Jan 2020 07:53:22 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Date: Thu, 2 Jan 2020 07:53:14 +0000
Message-ID: <20200102075315.22652-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20200102075315.22652-1-sblbir@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200101_235401_197418_D2C0BECA 
X-CRM114-Status: UNSURE (   9.37  )
X-CRM114-Notice: Please train this message.
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
 jejb@linux.ibm.com, ssomesh@amazon.com, Balbir Singh <sblbir@amazon.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

block/genhd provides disk_set_capacity() for sending
RESIZE notifications via uevents. This notification is
newly added to NVME devices

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 667f18f465be..cb214e914fc2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1808,7 +1808,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
-	set_capacity(disk, capacity);
+	disk_set_capacity(disk, capacity);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
