Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06FEC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8927764E3E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8927764E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KfhX63ngN8aObqnPnwjeK4zS4ye47diohoTHmVvcMI8=; b=qi6fROTS0sjJEcjEqGVrkcXfq
	6DbV2WH8rzsWSZ9X9UxzL77dwOR7N6dQxZnRL1DcN/Y+o40ohTkRaHI1tOsnPAEmrRNNprKZwXylD
	EZW3KqNwVfUzsCDU+UV8jO6kXCKlDfhayZiVOHHUgaDywQEXs210nKpb+2QwuBX57fVBkK3fzP3dB
	3gotYAPrOlqwXyy9mUUDjdEez+9oRYMBlUPDF9sPopn+3V0OT6R6zAjqttbxoNDijYW3g1wGm4zoS
	D5WbZC9yZwaWpS0Uhas+XywqW8OIIG5fSSw405R94hA/UAZWS2Z+/gQYKfd3LhGHxBFYCkeDiNIJT
	75BRlBlQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iMk-0006sh-Rc; Wed, 10 Feb 2021 05:48:42 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iMh-0006rU-DS
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936672; x=1644472672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qPm0ouqhe1QMVAMI8qOn83o8KMbDB7LihXubVrAejgQ=;
 b=UHNb2BKhgU2ON/UoT9N/nxABsjG6EWBc2RKGW4qJdN/scTrCQGKzV3s1
 O+vIz4YR7eZG4A+31npAAmtTDHOVG4Z5f+h+zeBckzsIYcJhirm/fPOWT
 dZBuFmfaDIVphRx0+4xzic2Z+lojrNqpPg0tT+jRyGqPVDk8P0kzJEPsP
 a5ei/31SPgTkQ/Pllcrj+kNITugrLjLv6ix59gpSrHcotS+letOQgBUmw
 dOAXNaJ60Nx1lJXXn81tOSCMSeEM2nulHBqSOilNhxIyMrU1HeEGN+gz5
 ZkkMnXwZb94tqfTkYZmLDRY0NlMpXwRUgVC1AzE2NFUC3qd0doL/Mg715 Q==;
IronPort-SDR: zMT98aJKrPz6ae7QqXGwgOMXvfIhlGJa0B8LC86uGJi5R+FlRKym7I78WhRt/eQF5vPOnkoRbj
 6bS9IbIuzddFmcn60CBXQAjCMVqeYvnCFwp88OZb8q34PaX+BxSa6r74dxLBvsLolPe8b8NTgB
 6ZHCWLDbzoKzqG55HdCTlrJw0E+ftYcfafFYObGIcu8hi/3Ucc8MKBdkGIIr5vZ+DbcbHplfJD
 /PcBR/8cFN85H/KQwqNoamlTKkEu7gEgqplGy7QG0wFDtoz8tR397ZX+SIGmhGNlRwP8OLSL7t
 2Qs=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="263725167"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:57:50 +0800
IronPort-SDR: anr8lQFnPbBzuN4XZkiLInSjjrB7er0AJrtOjNeNhos5wW/vMVMB3dPa9ngywnqbDKp6VKpLzy
 d8+fYp5uAlVLErmxbO1Y6nRQKK572yHA7hRz4aUg43My6ez8V2oaXoQVzShixJCirB/5xMkdEw
 A/QQ/RdAVhz6tPPOzMCz/bNGT/PSgvISPwmKzo5o2S7w9OgtJWjCi2XA4tnkuRA/X4aFTjdXzj
 FO4iObd3IJrUeo4yaucZHBM5qMH+yi9ORGQWDVey+venDyF5xp+jU8wP0g6OUsZI8lyL11gJoz
 OsoUALSgJN6XUpz5w6YSop9u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:32:21 -0800
IronPort-SDR: Li/2o+tJuAO43MYIvjsLJwRNTVX7qQnc4h3c4PsV/ZI7IbH25oxxwiQE7o2KZAR+4vwJcx834B
 pZP+l3SQKzzgoSqVsMjXKOzPdQhA//UycMZ2IX+zpvdmzAcfKaSTXqYkzlAgPT1CTqK+75O+03
 X9ddTX712ueJDMbieaImRc9R+o3a3OlRr68dHT52U5I+yl9HKn7gUSEcYVygoiqePRibF3JLnz
 i66Y++yyRxgpYU3yj9l//ffCrcAfTN1gQMVi9qQ+f1ewGoeHoCmWpAKcryYUW6N2B7sUUoNUVk
 vUs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:48:38 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 04/11] nvmet: remove extra variable in id-ns handler
Date: Tue,  9 Feb 2021 21:47:55 -0800
Message-Id: <20210210054802.34269-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004839_585465_A551F874 
X-CRM114-Status: GOOD (  13.41  )
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

In nvmet_execute_identify_ns() local variable ctrl is accessed only in
one place, remove that and directly use it from nvmet_req->sq->ctrl.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f32533480e66..552da813da18 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -462,7 +462,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
-	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ns *id;
 	u16 status;
 
@@ -523,7 +522,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = req->ns->blksize_shift;
 
-	if (ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
+	if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
 		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
 			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
 			  NVME_NS_DPC_PI_TYPE3;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
