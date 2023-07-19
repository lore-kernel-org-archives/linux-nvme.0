Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC537EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xW+uhPUE+ehv7xxEWlCDttHH7MJVEx/V0moFUS0v+9I=; b=Ijj/l1cgs+XaPp4/3oGP9Hooh9
	AYPSXHuSdzY34WGGKIzvE72kPgx8H8HmJXnB2YtTwbVGEKIMXLfdQBvUxlX6fKMJLICyXuNHXibo5
	Js09+Oa8xmDJ8CfTt9QB0EcSg2BxXy0duoUFIJphkXnKzi0lLgJ0R2Fjk1PVqwou7u9QS61DbW3PB
	hCmh4owpDCxm1FHOJ/3t8uFER429dpqfCfm44zU9Fze2EyDS3wVdwWDGFgBZJ3nqo3TbrvEaBNsuB
	QSN8EKt52/pveZzexcSY2wTAxIgErjliiQ2cS29LyiPBpVAQ2+lJ1yPqhRC8D62JNe6N4G0lP6Rpl
	adVCr6Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM2kz-006QkV-0v;
	Wed, 19 Jul 2023 08:42:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM2ku-006Qdx-2V
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 08:41:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCEBA1FD6D;
	Wed, 19 Jul 2023 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689756112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xW+uhPUE+ehv7xxEWlCDttHH7MJVEx/V0moFUS0v+9I=;
	b=IKrsLsXnxSfWq4gO9v48Bc1FRvqaUcDhJYFwnm44BDObVz9bzkb2AYqk/s3pp3I2xKPU4A
	+DrXeLWkgGzqv1wB+iX8/1lqRaYFFuIl1loSSqTEgiwo8seWjlrj4uDGRac7x8w/IGZLsf
	iImXuf1MXp+gfuUR+WCu5J29vbEUIq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689756112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xW+uhPUE+ehv7xxEWlCDttHH7MJVEx/V0moFUS0v+9I=;
	b=y8g4zV29W/byclYlayCxuxMLUdhZPpeLWSZ07y5ngUKe9SqW/G8E+bOQVZ+sU+ONYeRlkj
	+9Ti8J2cs7nT/yCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDDB41361C;
	Wed, 19 Jul 2023 08:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pSTdMdCht2SCBQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Jul 2023 08:41:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 2/2] nvme: remove warning for shared ns when multipath=N
Date: Wed, 19 Jul 2023 10:41:47 +0200
Message-ID: <20230719084147.16272-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719084147.16272-1-dwagner@suse.de>
References: <20230719084147.16272-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_014156_958684_14B16D30 
X-CRM114-Status: GOOD (  12.62  )
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

The default value for the module parameter multipath is Y, thus the user
has actively chosen to set multipath to N to trigger this warning with
shared namespaces.

There is at least one external mutlipathing module which conflict with
the native multipathing feature (Dell's PowerPath module). In such setups
the native mutlipathing is deliberate disabled but the warning
that mutlipathing is not supported is confusing users.

The warning was added in ce8d78616a6b ("nvme: warn about shared
namespaces without CONFIG_NVME_MULTIPATH"). In the mean time the config
option has been dropped. Because multipath is now always built-in and
the default is Y, just drop the warning.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d08371967ce3..e8faee21c7f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3494,11 +3494,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 					info->nsid);
 			goto out_put_ns_head;
 		}
-
-		if (!multipath)
-			dev_warn(ctrl->device,
-				"Found shared namespace %d, but multipathing not supported.\n",
-				info->nsid);
 	}
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
-- 
2.41.0


