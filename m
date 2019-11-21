Return-Path: <SRS0=O3HW=ZN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BFEC432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 17:59:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DAC20672
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 17:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fRFnlX7X";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfZ0Nzz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DAC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=wgXbbEKnZdp0oaVvPyKhmrY/hosB9/OzggI1r0M+evI=; b=fRF
	nlX7XRB22Wyl8IKq9If42GQGdEG5RRcuh4yWVWkF62leihuWcvtZiSS+llIAzVK4lYpDnk8lvl2ow
	CDSxTiw9wvt2C7gkkjbAJHOcsz2gFFnobW2v9iHpQDoc1sz+D2G9ti1l6GEzD1sauGeK9l0pU6lP2
	CX/wp0NWD6RQUWPDDiYztViRwQShc5P8X7dQuC4BVdvLLK23GhfPUU+hasoaPNY6WdJbav59eqSS5
	b0fPZKkX8v2XjtnbsNftRqLm89rcUyi3VKaMMaHLm3WkocdqTMOVGDG8YxXktoen7NySjx59eIldf
	juRljJPdbmtgwuEn8nglv+Y2TqjRumg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXqkA-0000ES-8O; Thu, 21 Nov 2019 17:59:50 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXqk7-0000E2-9Q
 for linux-nvme@lists.infradead.org; Thu, 21 Nov 2019 17:59:48 +0000
Received: by mail-wr1-x441.google.com with SMTP id n1so5518993wra.10
 for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2019 09:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4TIeXD2zcUlhfsTSS9GTK25VQMizljeJp9l5nsyRE2E=;
 b=TfZ0Nzz/InAORKxh2r4Xi86dbaHnbN2rj4/1NzogNfGvLVXfeTyCVL4jUjHvO24LdS
 FZMvESiqaXkBzWvN6qihoyF9ZpxWMH0CcB7I+hiu7DtAYRSNwFMVNyxESjKgYyTu8kSU
 PeGzDWUmsBkmpPAPlwH4pxdoeqitruC66phiuPhI6iTNH9RCAZodHEt9sJbEsZ3D7XV0
 vqrIXkQy+Hg2ijw3wVN4NYibdreVlNGtTvl4WhJbX+PGBf2kZpkIZk3HBl+KmCPg/aBV
 MDq+Z0/o04hCe3LRJSYnUJrxwWNOugBA41xayCCeOrfqz0pWOP5qGHXz/wzEjnUPfZfa
 JKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4TIeXD2zcUlhfsTSS9GTK25VQMizljeJp9l5nsyRE2E=;
 b=L8Vdf/lc2aY54elo7FNbVYLvGyifN6M8jfeZrYPbOOtstWRH7eVGTf67j5a6/oVdu+
 t8afuIrQTc1ISNIXEDgOW7goS9a/efzjLXyL8zSiR2L//X+hEEF2ZEHqfkIhXmawSikI
 WSjwpEiorOnpyNoo7R6smqvDNt00sUxqtM0eoIqqkO6pvfEAn0E1jJ2QKu/VS25AIJgw
 jEengrC+1OtswJ1nFGLocoxNWof7p2vI8SkGwrUs8IfL6PrWrs3iQNmd270Q8lFXxzac
 7pQsOOBTVdU+7eHwjLCj30ACqHPI6G9l4FVHaxgfo7/CqvJCe8tWJrlIJ/VwOputNy3X
 B2ww==
X-Gm-Message-State: APjAAAWh+9es99uKPAssMlQ7bN1/GLauMrlj3yDoEJK2t7RaBcG93nI5
 jNVSIKlhFR1OyJ5ZEtZAdxGa4Zd7
X-Google-Smtp-Source: APXvYqzuwZ/tgrHPOs4eBr3DSohsZ9wV6XG/YaTv2xqBLGP+zCjd57iO6uATc/MASIuzTObCwgIh+g==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr13287754wrv.382.1574359185738; 
 Thu, 21 Nov 2019 09:59:45 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id w17sm4378530wrt.45.2019.11.21.09.59.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 21 Nov 2019 09:59:45 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: fix double-free scenarios on hw queues
Date: Thu, 21 Nov 2019 09:59:37 -0800
Message-Id: <20191121175937.19615-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_095947_332323_48712E1E 
X-CRM114-Status: GOOD (  19.51  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If an error occurs on one of the ios used for creating an
association, the creating routine has error paths that are
invoked by the command failure and the error paths will free
up the controller resources created to that point.

But... the io was ultimately determined by an asynchronous
completion routine that detected the error and which
unconditionally invokes the error_recovery path which calls
delete_association. Delete association deletes all outstanding
io then tears down the controller resources. So the
create_association thread can be running in parallel with
the error_recovery thread. What was seen was the LLDD received
a call to delete a queue, causing the LLDD to do a free of a
resource, then the transport called the delete queue again
causing the driver to repeat the free call. The second free
routine corrupted the allocator. The transport shouldn't be
making the duplicate call, and the delete queue is just one
of the resources being freed.

To fix, it is realized that the create_association path is
completely serialized with one command at a time. So the
failed io completion will always be seen by the create_association
path and as of the failure, there are no ios to terminate and there
is no reason to be manipulating queue freeze states, etc.
The serialized condition stays true until the controller is
transitioned to the LIVE state. Thus the fix is to change the
error recovery path to check the controller state and only
invoke the teardown path if not already in the CONNECTING state.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 679a721ae229..2acb850bf9f4 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2910,10 +2910,22 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 static void
 __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
 {
-	nvme_stop_keep_alive(&ctrl->ctrl);
+	/*
+	 * if state is connecting - the error occurred as part of a
+	 * reconnect attempt. The create_association error paths will
+	 * clean up any outstanding io.
+	 *
+	 * if it's a different state - ensure all pending io is
+	 * terminated. Given this can delay while waiting for the
+	 * aborted io to return, we recheck adapter state below
+	 * before changing state.
+	 */
+	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
+		nvme_stop_keep_alive(&ctrl->ctrl);
 
-	/* will block will waiting for io to terminate */
-	nvme_fc_delete_association(ctrl);
+		/* will block will waiting for io to terminate */
+		nvme_fc_delete_association(ctrl);
+	}
 
 	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING &&
 	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
-- 
2.13.7


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
