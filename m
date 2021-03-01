Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14044C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:07:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A6664DF2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A6664DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=97XqqOTHyL2wCuPgGrXeWhPvSwK0J5a+jZsqwuVFjGQ=; b=W18W7s2B3UsQfS4Q4ndM4kSUk
	j//bmg4m1m1UJJZ0oQ4w/duv7N8amrR7vQksrJgUb73YHmSS0asK5XngnZE3Ai1vCW2hGA2jpN55s
	mKOkcZzpYEW00Ou+lQLSMiZUMSh3gziHtLxnbYH56Fyhe3VxBPda4oj1aLth2P3plIHCIokbHmLV9
	UmG14uMfH/Xka5asIz0UIEXP5oVaAaasDwpk4XJdJWy3zDBzf1zFK4wLdrEeYIU1B0UdxgBfQRpwN
	BzMSNDfLeoIP4KGwX8VNTkXx8rwRGCadaCWuehVlzzEFG+zpLiuEj5s0rJoffogeC/nCsngkfIzMr
	GzSaO1Jkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGXxr-0004Zu-FP; Mon, 01 Mar 2021 02:07:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGXxm-0004YP-Qz
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 02:07:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614564431; x=1646100431;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z5YUtNSNR5jr3BNdqkNDefg9KnbMMzrzKnsB9lrphmk=;
 b=RAN5lWCHnJFTNmcedfCztiWT3m5feMKa8MQfT2NGUO1MaNad8252jlud
 beqVD7/yOTDGuk20QjFqqRrWeiHAMu6f5sHNbkEvou29Jsu8EUEB6c990
 nlKDlTVIA0CuLfFcVV2UUyJGGeZUH4HH2Imi3WJ0tm4GeV/9/MODB01Gq
 vKLNN6W3OPmTPOEQsjdPRM/oYSiUtMlzeANc7NCrUSbT+O2jvZGnShXDh
 kYK9zEsWO83mdzxDGBdMKxrBHiNJj9Pfq8Ue3q98IzxGG4JXVKKAUjk67
 3YvokWzlNDZLuYl9s5yJX2KrHr1Tcjov6cDZ7rqD2CzMgA/Hzrqmip1o4 w==;
IronPort-SDR: FgIEuZ6zqXnVh1GScxWpm8oV2gRAZZBWhrHMqm/tytarxYWg2Lz4RTHKupd4+p2Hm3UYtLuYQ2
 oZzjyhRirHWj6OmGvzrl4niywSGUlxJx5sSaLh0/076qRVX1gdarkrtndZWTkJPV1eqxht3ZF6
 2nynPQDITyKJmK5rVnbrUs3HvAXXHjPPOGLZn/LXZnD4nA1EChG3cOWaccpanqR5sGo0JpCX8j
 WQzo86Sg1F7wrjaeprJq4BWj24mBRCM2yNQffIjvzgsjsLOL3m68hY78IodfjvzZFnXWbj6uaW
 EZU=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; d="scan'208";a="162191659"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:07:11 +0800
IronPort-SDR: 7E+y0HpaIo4hjA3UU0IrPrjR06UIElijmII3qPqtTy6DCKgKT9O0i2T+UvGffdpqPD04sNDlVg
 7xHRCVN2WrsucUypOvMALpyKnnUiFmYm3ZgOefWO8wHTpTdIUjX7CqylEKdHYVuLBnd+cdkRGL
 IDx9eQvN4OuZl52bh2X5SZtuG6rAdnpuSttQm+WdTsIvDtjQitEvSuhp9F3B9cm5Y7B/ttf+fV
 C/u7TYJdnf0i0Ra9iETHlvw5l/BtWTe80e3WoxkxdZBBIYFNQyEQv+iOEzsfxbXWAN1OYOipVm
 AG/thMNntzl1g0z3SO7k+Vp2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2021 17:48:27 -0800
IronPort-SDR: TGI28IFKIb6TdFqTufpNrnawH62ZVuuL+PQNlP5B7r1QjNIfNHnTwdrqWRgYRKrDMd+hEt6XMu
 Bvh5QK2yno5EaxJLoVeMFj9lHu+nLI9zlExDtS1sEDYubpcryovvAPkcUkzEgbTjpNWcFVdPR9
 0UBZv2Zr29WN+ZJg+zmSEYoedu0bKR77/5U+sgttABvpMwi/M0bNtHwNVWuZY2442b8KggOH/P
 3XOqaMnNrcEDkYPo0xa87rXYUwS/Cho48u/ImKlag7y4xjEw6NLd81k9+kpwbDaOPgj/1976GY
 fO8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 18:07:10 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 7/8] nvmet-fc: update function documentation
Date: Sun, 28 Feb 2021 18:06:10 -0800
Message-Id: <20210301020611.18669-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210228_210711_040252_F6AD8E3B 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add minimum description of the hosthandle parameter for
nvmet_fc_rcv_ls_req() so that we can get rid of the following warning.

drivers/nvme//target/fc.c:2009: warning: Function parameter or member 'hosthandle' not described in 'nvmet_fc_rcv_ls_req

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d375745fc4ed..1f1c70f9f8eb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1996,6 +1996,7 @@ nvmet_fc_handle_ls_rqst_work(struct work_struct *work)
  *
  * @target_port: pointer to the (registered) target port the LS was
  *              received on.
+ * @hosthandle: pointer to the host specific data, gets stored in iod.
  * @lsrsp:      pointer to a lsrsp structure to be used to reference
  *              the exchange corresponding to the LS.
  * @lsreqbuf:   pointer to the buffer containing the LS Request
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
