Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA3DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBEoSOa6sNK1EmPZimrrF5SYoYJi1d4Ra6tWX1cnd0o=; b=UQlW6fyQO1vDUclWu+PZLzKkvz
	ZXESZ5D0hjE1beiAfuIs2vHHHd7vLIUqzRATERxXWRVfN2TFqjP6lOtFt/B/xeEENeSKLQkd0a80g
	EOJ3+T1xu0a+FhAjll9fEubiv/ANZS8CjCLLT63OHyzgfwFg4QWG0J78N6jTYx0vsrDbpNU2wzXld
	zBxIF9jMxn6kElDi2+8Kx0Qw1f4Rl3WWVrTbstDi76UJLSsM+S5Cjpo6G2D8QmmIg2kDM/Sm/A0No
	GfptswwH7/fC82OzKhBr+SSqV8J/vFeQdsCdfS016HQjP5EjMU/jiAibRgj/lo17plqLKljGWagDC
	W2zpNzXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n59j8-00FPbD-Jf; Wed, 05 Jan 2022 17:05:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n59j5-00FPZ0-Mf
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 17:05:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CCF8A61835;
 Wed,  5 Jan 2022 17:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B78C36AEF;
 Wed,  5 Jan 2022 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641402326;
 bh=CXd24YzqYAqII94cHDbP9cfZzq/4lctBKXJnnDewKUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z3Yqw0D/U8orvCZylc01mAIK11/iuESuY1/8HoM/FNFQahnOl81G4543EUIqehYiG
 MK5dOgVdR9Egq58TI387PTAPMKZ7KShtDta7NmCewkwxdZv6lFpcVUMCG5VDkHXWLv
 V3xfFfB4asAJQKFHRMysMlVcrOW66ljGUdI93ygGhP1BAx+FBWVWXIT8d4rkkjJI1V
 c3EB0nIHTrhaic4ui+EFyYqr09gd2k9snC+0DWZsPGNzP1VfuvPKpKgJJBNF0mmR1n
 yA+6ZMNrlLSlgYQZttEoSgmPMG1kz7AK5oni9vkziCq5duC7AvG7Sm+37hoS1OsM6L
 J9WRcoD1eNKqA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/4] block: introduce rq_list_for_each_safe macro
Date: Wed,  5 Jan 2022 09:05:16 -0800
Message-Id: <20220105170518.3181469-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_090527_802394_CF462095 
X-CRM114-Status: GOOD (  11.22  )
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

While iterating a list, a particular request may need to be removed for
special handling. Provide an iterator that can safely handle that.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index bf64b94cd64e..1467f0fa2142 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -242,6 +242,10 @@ static inline unsigned short req_get_ioprio(struct request *req)
 #define rq_list_for_each(listptr, pos)			\
 	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos))
 
+#define rq_list_for_each_safe(listptr, pos, nxt)			\
+	for (pos = rq_list_peek((listptr)), nxt = rq_list_next(pos);	\
+		pos; pos = nxt, nxt = pos ? rq_list_next(pos) : NULL)
+
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
 
-- 
2.25.4


