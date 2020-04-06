Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D0C2BA1A
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 23:55:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA10420692
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 23:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JFphkR3w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV5s7/wH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA10420692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=d1MDfWcJsUzYdfY8gBqEaUjzDKkByqD4GX7aAjQyyhU=; b=JFp
	hkR3wD1KCJHC/eAfJolI4O62gVjfaK75SZDlpy8zgqT5B7caLdPA9hpsVxojdoIzbq4mdPESHBkhm
	0due/0mUGUrXNhFt36mjTVGi+5W1EWYluJbXBgm2bSnPdZzL5GMwZcdMosi6uXr7d4HrGr282rPsT
	mTIAUEQ0M3Mrib4SDk/mI68nF0y36dXnDVWUw9OyjDIellNnrECUl5nzYAkcwoRCkoimMbXXwym0S
	BpAwlLS2WjahH7ADjZNyGDGyYO45sv3Jx6vTiF0geJw7ixxQp2hvM2sQL02B9XrOkY2GXIIIS1s8b
	X8mfdGi4XooIGQEcfu0NnyVXl34H6dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLbam-0001iY-78; Mon, 06 Apr 2020 23:55:48 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLbaj-0001i3-6r
 for linux-nvme@lists.infradead.org; Mon, 06 Apr 2020 23:55:46 +0000
Received: by mail-wm1-x343.google.com with SMTP id j19so10605wmi.2
 for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2020 16:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=FKlkOrXLpMkHhtM8y+Dbnb125yeGSkSrelXVtTdUKtg=;
 b=kV5s7/wHPqWTotQAo6K+QOykVg0qEGtvRZMFGodGEtxNhfARTdYh7v6dxpLoEG3nbU
 c/yL72528J3J99yoiGJU1WGWmPhWRN80UigYd9Y7XhKQMdCuIOn2aqMZNy/WB4PhfjD4
 92ju02EswUpuHVw52ox6+N4zTO6uTLqjnNGbeL/QpyPW7LkSrlvZRZlHTCYFP1cMQonY
 zAChlnjnhqtrdL5RHtj3sXkCb0pQobnN69KoH/qZfw+fmWwKYHQVYqsmiuPWKU5n+AoX
 18AhPdi8bFT8XdYmbXUaMokPQen3DCBhFDgJBs8c9uW4V0r5e3d8Ap9in0BvzjwXQN01
 hedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FKlkOrXLpMkHhtM8y+Dbnb125yeGSkSrelXVtTdUKtg=;
 b=lFTDrCem18HT+hDArkKph0u9JaAcDCIlJAQdzsiemAgLVgczdWiObnYhPGhj7HWHkE
 NLULQX+D/lJceqaT/xHQ/Rnh++ZB8KeGeKvwx3sKdRl8aJ67XaQiX/vdx+SLWpQPs5sw
 akdi3nxQaLdEa0lySMa15oPYsire49jawlWU2MMhEYTdDcV3wyxdVaACnUusWzdtqWV8
 Uko/Pv8KHXGs7bplUPlLqPET6mkpXjSviyv50P6HK5r5gCCSunrOR5dRAlemu9GHy9Jm
 8x6C2/x0RX3MCtF9YPavsMtpSLVkt1KbfhWEWlGPV4IHqcZc0xJpeW8hrFgDpASZDXCW
 NRww==
X-Gm-Message-State: AGi0PuadPNDG2Ob4VN/l/PO9EF/pMJ8JqRsSwx+8zRhV9X/oxZKxTqz1
 z43HXjHn21UUqq5s8lEKQos8Agw+
X-Google-Smtp-Source: APiQypJa+qrvJypD7GSuY+vX4i6aG73W+c86syHLZFZpYVqsLGcGpKN6oJAukAEwiLFnthipLvzmwQ==
X-Received: by 2002:a1c:ab44:: with SMTP id u65mr1873031wme.45.1586217342266; 
 Mon, 06 Apr 2020 16:55:42 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id u6sm22077615wrm.65.2020.04.06.16.55.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Apr 2020 16:55:41 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-fc: slight cleanup for kbuild test warnings
Date: Mon,  6 Apr 2020 16:55:34 -0700
Message-Id: <20200406235534.59650-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200406_165545_249127_E6AAFA93 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: James Smart <jsmart2021@gmail.com>, kbuild test robot <lkp@intel.com>,
 Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The kbuild tst robot flagged the following 3 issues:

Case 1)
>> drivers/nvme/target/fc.c:1201:37: warning: Either the condition
>> '!assoc' is redundant or there is possible null pointer dereference:
>> assoc. [nullPointerRedundantCheck]
>>  struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
                                       ^
>> drivers/nvme/target/fc.c:1853:7: note: Assuming that condition '!assoc'
>> is not redundant
>>   if (!assoc)
         ^
>> drivers/nvme/target/fc.c:1850:37: note: Assignment
>> 'assoc=nvmet_fc_find_target_assoc(tgtport,be64_to_cpu(
>>              rqst->associd.association_id))', assigned value is 0
>>   assoc = nvmet_fc_find_target_assoc(tgtport,
                                       ^
>> drivers/nvme/target/fc.c:1896:31: note: Calling function
>> 'nvmet_fc_delete_target_assoc', 1st argument 'assoc' value is 0
>>  nvmet_fc_delete_target_assoc(assoc);
                                 ^

The tool isn't smart enough to see that line 1854 sets a ret value which
thereafter causes the routine to exit. This occurs before any of the assoc
references, so it is not an issue. There are 2 more reportings of this
same failure.

To quiet the tool - rework the if test that does the exit to also
reference assoc.  No change in logic otherwise.

Case 2)
drivers/nvme/target/fc.c:1202:29: warning: The scope of the variable
'queue' can be reduced. [variableScope]
    struct nvmet_fc_tgt_queue *queue;
                               ^

The tool is requesting the variable be declared within the code block
that utilizes it. Ignoring this report as existing code style is fine.

Case 3)
drivers/nvme/target/fc.c:1137:16: warning: Variable 'needrandom' is
assigned a value that is never used. [unreadVariable]
       needrandom = true;
                  ^

Another parsing issue with the tool. Given that parens were not used
with the list_for_each_entry() check, it inadvertantly thinks the
break exited the outer while loop not the inner for loop.

This is not an error. But, added parens to the inner list_for_each_entry()
to quiet the tool and as it is better coding style.

-- james

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
CC: kbuild test robot <lkp@intel.com>
CC: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 02d9751bb7ee..27fd3b5aa621 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1132,11 +1132,12 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 		spin_lock_irqsave(&tgtport->lock, flags);
 		needrandom = false;
-		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list)
+		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
 			if (ran == tmpassoc->association_id) {
 				needrandom = true;
 				break;
 			}
+		}
 		if (!needrandom) {
 			assoc->association_id = ran;
 			list_add_tail(&assoc->a_list, &tgtport->assoc_list);
@@ -1837,7 +1838,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 						&iod->rqstbuf->rq_dis_assoc;
 	struct fcnvme_ls_disconnect_assoc_acc *acc =
 						&iod->rspbuf->rsp_dis_assoc;
-	struct nvmet_fc_tgt_assoc *assoc;
+	struct nvmet_fc_tgt_assoc *assoc = NULL;
 	struct nvmet_fc_ls_iod *oldls = NULL;
 	unsigned long flags;
 	int ret = 0;
@@ -1854,7 +1855,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			ret = VERR_NO_ASSOC;
 	}
 
-	if (ret) {
+	if (ret || !assoc) {
 		dev_err(tgtport->dev,
 			"Disconnect LS failed: %s\n",
 			validation_errors[ret]);
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
