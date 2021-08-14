Return-Path: <SRS0=EXTw=NF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AFEC4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 13:08:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7215260F48
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 13:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7215260F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZDXyRoxuAD84qJYxZJhyO0EOV9eKC6uo7ff7P2g3JK8=; b=kfTb5GBwQYta3/
	Q0nEGXWLLGf6E3pL+oLI3GhIOcMOysCWsUGKmKHcfwe1iL80/6t/nmiolUKgTKNSmitKB5nZBO//D
	ofrTcdFcoK8pco8bj6LfysdfZlVufvcsGjqsB6zwUk9IlPShTVZVtG0UbPGLEpBIaJzt5l4fhQNYM
	nB1iAyeKp2WNTLNAIb+wW8NwCaw1BSKoIC5Zixp33pslaJr/laMkVd2GZuAK2Gwd/wKukiCAj+6sJ
	9lrV+YwYLZ3oy9fgQJKP2p1y/n7ex6m+WiVKOVQdyIV3nW95ixgbynR/q/I6oCEsa051ii7Et0+Pq
	ATGhLF4smfREEpFqltBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEtOj-00EAwO-LH; Sat, 14 Aug 2021 13:08:25 +0000
Received: from m12-12.163.com ([220.181.12.12])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEtOc-00EAw7-8r
 for linux-nvme@lists.infradead.org; Sat, 14 Aug 2021 13:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Av482
 +d+YJrKYfkN/13xjf5bvh+1P5/3cpVV/qwemEs=; b=R0GEV8Sn8HmP6YqWJvqU3
 itLb6etp4xiDkb+pi7IlavBlkBLT3TBfYNOCZUJvd/ZSt2xejqN9VJNySsToPsPs
 QxY3ekfXeTFz9CDO4MENtTbsCe3ZqYb+6OgzTtX6zhmC/HDDN9pEc6MlRIGU4yJy
 YWCyCrGGLfL8OEF3nVzg3w=
Received: from nilus-desk (unknown [120.229.1.29])
 by smtp8 (Coremail) with SMTP id DMCowAC3tz_yvxdh4neuTw--.41150S3;
 Sat, 14 Aug 2021 21:07:00 +0800 (CST)
Date: Sat, 14 Aug 2021 21:06:58 +0800
From: Nil Yi <teroincn@163.com>
To: james.smart@broadcom.com, linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: target: set NULL to iod after assoc refcnt is released
Message-ID: <20210814130658.GA68215@nilus-desk>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CM-TRANSID: DMCowAC3tz_yvxdh4neuTw--.41150S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrCFyktF1Utry3Gr4DXryrWFg_yoWxWrX_C3
 4UCF1kWF1ruFyDK3y7Ca4rZrWakr1rX3WIqFWDKF93Aa4UurW5Ww1vvFn3X348CrW8Xrnx
 Ar17tr15C3y3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8XzVUUUUUU==
X-Originating-IP: [120.229.1.29]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/1tbiqxTuElUMahld7gAAsa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210814_060821_933648_607A31A5 
X-CRM114-Status: UNSURE (   7.80  )
X-CRM114-Notice: Please train this message.
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

After the refcount of assoc is released, the corresponding
pointer should be set to NULL.

Signed-off-by: Nil Yi <teroincn@163.com>
---
 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index c6c1839b4..8114cf678 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1870,6 +1870,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 
 	/* release get taken in nvmet_fc_find_target_assoc */
 	nvmet_fc_tgt_a_put(assoc);
+	iod->assoc = NULL;
 
 	/*
 	 * The rules for LS response says the response cannot
-- 
2.17.1



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
