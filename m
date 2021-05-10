Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC4C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D5061139
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D5061139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gTrOG2mPN5d8SGUZ/P01WEf8/60SXw1JzVaqVznN/1M=; b=lqhIK/aBiVYu68mB9xkC93rGh
	FiWdV2toez7FVlOK/py3WsorIVokcaUiz0j+iHSsSv4T/bFGs5nLPxsbViroA6sxf1TF6TLFGOCWn
	7I0W7i2oMySEBiWbviHgLrVTgfYq5EkNuHXfLaCODz+lu1LoPAV5znT2J//k2X2O7+eu5sb2KpZhK
	eX6GowhjlYSFjq0RXj/i1WwP8yWhRlLUG89raPt5UxqPCkF1tZl3xA4LW1s0aFteBg1aKQr2Xt8mn
	cSUMjZK1V3+9tWWwHBQgCtF31O4FeA2YE9GdT5ZMgwSjy49EeMqsZQ3qb91h4ku0z/5XbrY6227E/
	LkYPFBucA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgBO0-00FWY5-Qn; Mon, 10 May 2021 19:16:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNb-00FWSz-G3
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 19:15:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=PhLpp8vs00fJnY7WB5cD5pXBPKRzj4ZSWDvd6wG+IQw=; b=AOrAdkYR0VI/2UkS0A6wrTZsDC
 6k7aKLweDohSlfcvVQGZvW7FfeHlcR5xA35sa4A/0A5NAowlchiOsRwBcYT4Z3IjhxKV9YQVW4imd
 FTKY84V74paKlZNl90/2FDWyU6Rp4/wTD1za2Qk36NgOKAnheavjCDwLBLGGWJ5MolXgN6ez2nnpS
 TPEcH80QUbhPGUqPJmltfsyXbLPCYw3xVpNupw9SrrjHTtQtJhgojA7PVMZM/31u6fIjmSjqczZHB
 OGyaE5nbV1gghUJiDXTKQqPLgTKPqEy2MgCmDla5JiTP3JwHuiCRjcnZ6WY8PHu9yUDfenMkNsn4r
 zXpSitHQ==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNX-0093t2-D5
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 19:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620674143; x=1652210143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HNxnJbO7LQw///jcDDlEmNOOsE8xSieISytg2/wTD+Q=;
 b=BmBCQOQgVZesJxevk0hGBMxIY6dcRyPC1m80maSNHDJFKn5IMpJrSmAN
 9Y/8V7KVeji8H6k8uN4FcY6ino5eV0kE3B/+q2aM1G8gIGARjPC4tFuJL
 7+gl7M7U/eNLm0CjgLNW8+r7D/+W4pZ6F5799g+kCYkJqrRmsujKQTB9q
 +/17IW3dlV+kfz6A6cxTqTHCCv+Y237tpPHzXjzE8543cuG86gS4UyWHj
 /gSUEFsRsATbPjk06+eVBxMrLMlSQLRCN6Tdtjw5HsE676s5WtIoQ1MtZ
 BeNLuYVUaqiBpKqLU1arj5QDHrLUUtAszHr5XON1DmMeIdYw0Wj5OqLE6 A==;
IronPort-SDR: rP7h+8zWIh0clV0uskLydhWscll4aW+fMR6z3lLSuilG6qexBNlb8gfkBmZiEcw6+znSC2j+lZ
 2h1hPG8VlLWKQR7ystGwb05Jky1UBu096vpMEsZJJrwVZTNBL8DZas7DP/1zlfoCjM5juW0uEs
 M/GvdN99ugJxrAlieUWFozcHFYRmkUaTmy2poFhqs+9rjwgOSFb/extcpHifC/1cCq7IMW9ukH
 PvHbQptNcrnOc6VpfT+/wDrbdsh6mTKPLPm1GPUT8iJpTieDSiV31g+UGoSBSt7mW5WrL1+k29
 ARk=
X-IronPort-AV: E=Sophos;i="5.82,288,1613404800"; d="scan'208";a="168207427"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 03:15:43 +0800
IronPort-SDR: KpMABjGp61WexTgWvcS0OXYZ+Iz6FplIXojmzEju1eoYgUAxeByaKDJ3Lft5IQG1zx4s5scbqc
 VCU3EqM+fpJH5w9x+ICj3JjPDfjSiV/8mr3eJx4V6TtUw3oKr+worXTOPegOd1Is5jUKqdecac
 fzk0KOiCPRXJVyxuLZ0wU72b3uFph7uFKh0D43+eAJRjfw+6L+DNkfrLSSBWk24tEEp/P8Fo0o
 UssfrHZdqKhqLgvDfJsQChNlE9IYiEhQpoxc3zVWRJWr94E95cDp5bBSvisJP/JDiuDr3OgL/j
 NfLaykvBuKVk3wTEjllXqZhd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 11:55:42 -0700
IronPort-SDR: fHMk9fqw5c/z9w524MBqNZ3ECEXa+mnDdLZFLKmYPTgxlqD7I5DiJ5QxhS/JmfTyXrAtWShxMp
 X1wgMP3trNyfuqRnBQeZB5GxCIrejFsA/YwHZvPgGISenky6lVX8Z/8W8vBo3rQE9AvBtxTqDj
 iC+l6nkmBe3CW/UY7yywRH67s1vArwPIjawN2jDlwaBK+kHol5G2TqieRQNlJ87WXhy1m9TqyQ
 mFvtSdWwY3OAKgyBZx3H9aaW1ZETmKzlwr/qXlCf2MvrHLzY96XxOSL4/LHfdvyJF3/FNfjlUG
 TyY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 May 2021 12:15:43 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/3] nvmet: use helper to remove the duplicate code
Date: Mon, 10 May 2021 12:15:37 -0700
Message-Id: <20210510191538.38306-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
References: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_121543_924538_F55564A4 
X-CRM114-Status: GOOD (  12.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use the helper nvmet_report_invalid_opcode() to report invalid opcode
so we can remove the duplicate code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e7a367cf6d36..dcd49a72f2f3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -975,10 +975,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	case nvme_admin_keep_alive:
 		req->execute = nvmet_execute_keep_alive;
 		return 0;
+	default:
+		return nvmet_report_invalid_opcode(req);
 	}
-
-	pr_debug("unhandled cmd %d on qid %d\n", cmd->common.opcode,
-	       req->sq->qid);
-	req->error_loc = offsetof(struct nvme_common_command, opcode);
-	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
