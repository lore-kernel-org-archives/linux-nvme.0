Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5674ED206A8
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Message-ID:Date:Subject:CC:From:Reply-To:To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zHAkc3aSRt4H58MO7hMNVzjrvfIHCs6a3GVXcfFgctw=; b=PW6y7hWXcCwXlThcPO/bNx5vzC
	ky4xo3dh+/zXbCy+jEzY4S49Sl/vU2tl9WfX83YyEwU8CgoV24OwpT0mDHD+bAyVg5j+cUPIgDF6q
	M/9/CRupDWGg2HTO3tCVGfCwI8FAL7NcrXw980kWR+P93YywRiUFAWIzb4B3HEhI2moverL2e32g6
	Y2ypP4LLdpr4EMKwtol6tPcK+bKlH45v6FZ5pO1c22rsvl+BRispreHwS8gVGJE+7xvpftJRpNh/s
	gyn23QhOapGfRIfBJj3Fo7ZKbSARQoE3lwCaiT708bB1UganOCYjH7lQYmwCGpjEUcnBb59PsxIF+
	7vpdJ+6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRA45-000000086Oe-2yiX;
	Thu, 04 Dec 2025 14:12:13 +0000
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([18.197.217.180])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRA42-000000086O1-2clK
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 14:12:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764857530; x=1796393530;
  h=from:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zHAkc3aSRt4H58MO7hMNVzjrvfIHCs6a3GVXcfFgctw=;
  b=RzMgZeVsuzW22Ff/9D+0Kwn5QoEEjBgKc/8CxYn5fnfYKLXyOcnsnwh9
   4/aIoN059YjyiDdwADdz0O9cAk1HvHyiVO93gNpH2gIbnupBxr4rKXsHI
   hf3VRamZ6nuLlRxCHk6rRO+neFDwtYjFKrMQyFeYfw0e+J9ns9V2oyqJY
   KKatYjonqw0UWt8T9S4lbi0l/jEwUlfA3MDATYV2muVg5tuY5qQpromEx
   3HQfVKUC18t0NtQ2R+dJAgwB3aYarTm8lByDJEkhBJASKrvs7zgE02KbN
   dteCv/qiqrzMj4AgA+gWsmcskzyJttJElG7XfAnPvuOSfxPa6/dbxuyvn
   w==;
X-CSE-ConnectionGUID: 6v7uMLzkQECqsHpUxOH2jw==
X-CSE-MsgGUID: yMfl4VxmQLWEY7OOKlSdqA==
X-IronPort-AV: E=Sophos;i="6.20,249,1758585600"; 
   d="scan'208";a="6237372"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 14:11:51 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:13953]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.24.148:2525] with esmtp (Farcaster)
 id 5c9fd160-a5ea-47ec-9c7e-ac7ae8294279; Thu, 4 Dec 2025 14:11:50 +0000 (UTC)
X-Farcaster-Flow-ID: 5c9fd160-a5ea-47ec-9c7e-ac7ae8294279
Received: from EX19D008EUC002.ant.amazon.com (10.252.51.146) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 4 Dec 2025 14:11:50 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC002.ant.amazon.com (10.252.51.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 4 Dec 2025 14:11:50 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.029; Thu, 4 Dec 2025 14:11:50 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
Thread-Topic: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
Thread-Index: AQHcZSfu6ypIT7DcmUS6OdgGRPM68A==
Date: Thu, 4 Dec 2025 14:11:50 +0000
Message-ID: <20251204-tests-bryce-8b3b2823@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.68.42]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_061210_958913_1CEDBAE8 
X-CRM114-Status: GOOD (  16.20  )
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

Because the io_timeout of the IO queues can be modified via sysfs, the
following situation can occur:

1) NVME_IO_TIMEOUT =3D 30 (default module parameter)
2) nvme1n1 is probed. IO queues default timeout is 30 s
3) manually change the IO timeout to 90 s
   echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
4) Any call of __submit_sync_cmd on nvme1n1 to an IO queue will issue
   commands with the 30 s timeout instead of the wanted 90 s which might
   be more suitable for this device.

Commit 470e900c8036 ("nvme: refactor nvme_alloc_request") silently
changed the behavior for ioctl's already because it unconditionally
overrides the request's timeout that was set in nvme_init_request. If it
was unset by the user of the ioctl if will be overridden with 0 meaning
the block layer will pick the request queue's IO timeout.

Following up on that, this patch further improves the consistency of IO
timeout usage. However, there are still uses of NVME_IO_TIMEOUT which
could be inconsistent with what is set in the device's request_queue by
the user.

Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001..b9315f0abf80 100644
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


