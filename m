Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B7DC4167D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cE6pCOkG8VB8NCmHUswVDdYmjB1x/ugVETT8yljrntY=; b=b0cFzy/KUj2PPIHguxB/SzFPTm
	M3ifefUNeruP3n30Kh4AvPj95+qkqU+JDe6qFI2N4pkWdBbfREYy6RQcA5a5Xr3FU7I/jmSZCxBdF
	qqo9Q1e/wK8aKyrxrcC89VyEKew6xhGS3bhssQwl+1XpcSDBWBmJXuXKpS+b1NJXRT/JAe8qQWltb
	Dkz8yOz8HDyH1AMe5VP7q+7NeB313H4M7xlqeicd/eLVQeCcAzHAgUaWIOLXBsqrmQUz8rsLs6RmY
	Ks57OnXnoOHZsS4EahjqgqXvXxJyfN/b/Dv3Nm+p8rqJdvy+cjO0zhrQvNvH6VgYpFQJahyxnH0YV
	feaQLsfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTaE-003VmE-1V;
	Mon, 30 Oct 2023 14:49:38 +0000
Received: from smtp-24.smtpout.orange.fr ([80.12.242.24] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTaB-003VlO-0j
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 14:49:37 +0000
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id xTa5qOlxecvbdxTa5q48rW; Mon, 30 Oct 2023 15:49:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698677371;
	bh=cE6pCOkG8VB8NCmHUswVDdYmjB1x/ugVETT8yljrntY=;
	h=From:To:Cc:Subject:Date;
	b=Er2l+6NauL9234lJe7ylyNTS7h2FxAYZxIGdbUrnqT7VfXoom0z5tvfFX+wo/kwNT
	 XogrjtbgxYUWy1xFHaL9wpsWjPnsRHYyd171U+cbZ7NhD0Zrkmbq0fvI/Nlm3Dm2YI
	 697gvVaod9WwwGS9U5lEBC1TMbmpsMo3zofyGKqDDjjViKFNG7tiIJy0cu1vux2BOM
	 OFZykYnrx5D4/UXRyAglnMe8cJohqJRv5ZwAp2qcSLqjDTVPhDgsBCUyGK2281IPvB
	 5zntwOGXgeO3sKoRnUYOWvFQWIKzfmgpaWC8HEJbAIYnKBVOb/McdJpLFV/1i+MLWR
	 rBQD1EiMkBQKw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Oct 2023 15:49:31 +0100
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-tcp: Fix a memory leak
Date: Mon, 30 Oct 2023 15:49:28 +0100
Message-Id: <7f132cc47e627d63ddb084f3d0fcad10956d1e35.1698677322.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_074935_676164_555773A0 
X-CRM114-Status: GOOD (  12.45  )
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

All error handling path end to the error handling path, except this one.
Go to the error handling branch as well here, otherwise 'icreq' and
'icresp' will leak.

Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v2: - move ret = -xx; to the main path   [Christoph Hellwig]
    - Add R-b tag

v1: https://lore.kernel.org/all/f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr/

Personally I prefer v1. Pick the one you prefer :)
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4714a902f4ca..f97711fc9f9f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1423,13 +1423,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
 	}
+	ret = -ENOTCONN;
 	if (queue->ctrl->ctrl.opts->tls) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
 		if (ctype != TLS_RECORD_TYPE_DATA) {
 			pr_err("queue %d: unhandled TLS record %d\n",
 			       nvme_tcp_queue_id(queue), ctype);
-			return -ENOTCONN;
+			goto free_icresp;
 		}
 	}
 	ret = -EINVAL;
-- 
2.34.1


