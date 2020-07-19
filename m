Return-Path: <SRS0=ghop=A6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E94C433E4
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jul 2020 00:30:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7551D208B3
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jul 2020 00:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vY6mpC4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7551D208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kXvSXO8KhGdRypB5Zb+qaaO++iMRw3/K8YV2Jwdxsvs=; b=vY6mpC4mqfsyCd+zISttA5MTqI
	vN0eLbyJpM1y44yo9GYOm9KqNKvJlxAsHQZ5vRrh5UxEgvjvHmljlZRXjCHgslAjLXnA3Bw9EjbtF
	6UGLevDnIdY875weFmZJLAYmIJTj2kavBmP8FL1DkvYoumpkUYTwN9z+MGXckOCGijz86hlxcZWL2
	heSqrDIPA73wPba3tXGXHZwnFJCP9PmXbVFztX6qkPvHnvYManbf9YSrd6r+qrB2LmjvYat4O1RZ6
	5INX0iTmPl2/pSFx184YniaQUASR2oGahTyxpjkQajgeMP2hegbBbWiRz1BEOBj+4yYslA44yBDtV
	tA/dbgCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwxDo-0002oW-UR; Sun, 19 Jul 2020 00:30:29 +0000
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwxDf-0002na-Bt; Sun, 19 Jul 2020 00:30:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-fc: nvme-fc-driver.h: drop a duplicated word
Date: Sat, 18 Jul 2020 17:30:15 -0700
Message-Id: <20200719003015.20745-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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
Cc: Jens Axboe <axboe@kernel.dk>, Randy Dunlap <rdunlap@infradead.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Drop the repeated word "a" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/linux/nvme-fc-driver.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/nvme-fc-driver.h
+++ linux-next-20200717/include/linux/nvme-fc-driver.h
@@ -672,7 +672,7 @@ enum {
  * Values set by the LLDD indicating completion status of the FCP operation.
  * Must be set prior to calling the done() callback.
  * @transferred_length: amount of DATA_OUT payload data received by a
- *            a WRITEDATA operation. If not a WRITEDATA operation, value must
+ *            WRITEDATA operation. If not a WRITEDATA operation, value must
  *            be set to 0. Should equal transfer_length on success.
  * @fcp_error: status of the FCP operation. Must be 0 on success; on failure
  *            must be a NVME_SC_FC_xxxx value.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
