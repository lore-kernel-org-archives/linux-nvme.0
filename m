Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECC6D116F6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Message-ID:Date:Subject:CC:From:Reply-To:To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wzsFdx+keyCFgK34LmkGoLhE2h0ZNEqi7A1sMhFhiF4=; b=WF0mq5ozod78AoyH1851tYcC+z
	khRPnfpjl1ShCjHAPqI3QFbtAXEwKt7BU/SH52hddNdGwC6S+H+utIxt8/29sv4vUgz54A8MPLSy4
	/gqPlPE9mHTyo/PZmv2Uh3b3ra7v/EwYaPiwo8jL/iVspgEhnSWL/o745aMi0gWK/H5M6a5ZgJImN
	mhBOLUb7PR+Yb1palh8DwVdbIQKZZ7cPkZx3AhdYYD8rpO6kgqhuUhB0f5Kmj+Y+BjBaw+2a1r/SP
	bdpVuEH8lRPLGRd+E67Z1X/vxGN3IGQaSGruXJkLsdqxipVu+zkeAdIdDj7PcvLbnrTMuwwCxBARN
	/OLcVK9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQQuG-00000005TaE-0OoE;
	Tue, 02 Dec 2025 13:59:04 +0000
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([63.178.132.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQQuE-00000005TZn-08dk
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 13:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764683942; x=1796219942;
  h=from:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wzsFdx+keyCFgK34LmkGoLhE2h0ZNEqi7A1sMhFhiF4=;
  b=D1xcsYkiMMPe8qRPJw0B+dapc6lXCDoOhV7uAGeRyszujS6Z8F30Groj
   J7CzEs7SXvj7dKDbbedLdxZCNy8N0qHAmWWT1aiZDhtpX2UszraKf/5hT
   SC5n0dlZDkwTabRZwiXhOyUB4qGyflA29vTdNMUaJ9hRC4HK2u+nSj90T
   y++nmDYg3h6raYYmYZwuCpLHxLDhdsObnArJEz/6HQrkYrBIIxfzLhr+X
   JOfxrwMVuHoF4/66QXDVTmX3ZCYEjCzfDKqDf6DYLL/1b1cBYnAQisnRI
   LfhUoQ6zRX21rpgoDfIVbCUw/3B5v6ftDGpUIXk2zIpQuC+gGrTXQaG4m
   w==;
X-CSE-ConnectionGUID: q+PeaZ37RH2yabMv508nhw==
X-CSE-MsgGUID: m4M+9335Tem+PFQjTbAKvQ==
X-IronPort-AV: E=Sophos;i="6.20,243,1758585600"; 
   d="scan'208";a="6013240"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 13:58:24 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:6925]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.117:2525] with esmtp (Farcaster)
 id 1736efb2-f213-4266-b1a5-16143464efd3; Tue, 2 Dec 2025 13:58:24 +0000 (UTC)
X-Farcaster-Flow-ID: 1736efb2-f213-4266-b1a5-16143464efd3
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 13:58:20 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 13:58:20 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.029; Tue, 2 Dec 2025 13:58:20 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: Let the blocklayer set timeouts for requests
Thread-Topic: [PATCH] nvme: Let the blocklayer set timeouts for requests
Thread-Index: AQHcY5O3whf4KR8jnE+UaXlClzLbxg==
Date: Tue, 2 Dec 2025 13:58:19 +0000
Message-ID: <20251202-arrow-debris-c25524e1@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.68.42]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_055902_385575_9AE43919 
X-CRM114-Status: GOOD (  15.31  )
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

When initializing an nvme request which is about to be send to the block
layer, we do not need to initialize its timeout. If it's left
uninitialized at 0 the block layer will use the request queue's timeout
in blk_add_timer (via nvme_start_request which is called from
nvme_*_queue_rq). These timeouts are setup to either NVME_IO_TIMEOUT or
NVME_ADMIN_TIMEOUT when the request queues were created.

Because the io_timeout of the IO queues can actually be modified via
sysfs, the following situation can occur:

1) NVME_IO_TIMEOUT =3D 30 (default module parameter)
2) nvme1n1 is probed. IO queues default timeout is 30 s
3) manually change the IO timeout to 90 s
   echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
4) nvme zns report-zones /dev/nvme1n1
   This command issues IO commands with timeout 30 s instead of the
   wanted 90 s which might be more suitable for this device.

This patch, therefore, improves the consistency of IO timeout usage.
However, there are still uses of NVME_IO_TIMEOUT which could be
inconsistent with what is set in the device's request_queue by the user.

Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1f719351f3f2..3a6d74e6dae11 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -724,10 +724,8 @@ void nvme_init_request(struct request *req, struct nvm=
e_command *cmd)
 		struct nvme_ns *ns =3D req->q->disk->private_data;
 =

 		logging_enabled =3D ns->head->passthru_err_log_enabled;
-		req->timeout =3D NVME_IO_TIMEOUT;
 	} else { /* no queuedata implies admin queue */
 		logging_enabled =3D nr->ctrl->passthru_err_log_enabled;
-		req->timeout =3D NVME_ADMIN_TIMEOUT;
 	}
 =

 	if (!logging_enabled)
-- =

2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


