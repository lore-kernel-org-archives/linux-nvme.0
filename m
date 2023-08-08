Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F85C41513
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/YLVCeWbOC5zGBWs9MF5sPBcfnhYRaJ1x4BlOnFxS4=; b=R/GU6UF0pKsk03sZN5RXRu9jyH
	MEuGhV1z52Avk4DjVhAR8tkJ2NmMl9ZGsW1fS23y7gIF7I6e9sne0e15hEV43r2qbh8ObdjDOIrTE
	5clvxyZ5/qZGRm7v/cHdgR5gbxnJ/DZmKkrO6NSvB2kC2jZZ6fYul9SOCvbfvQdyvH5Rnz9f1vFfr
	PugHJtu3oAF4IqhK/BldYCqG8paowJxndc+f08j/gYu+BEWxkQFNJsqU5orw1NftHoxdWzFIBjnN8
	S/HtIBbIj89ZUWOEv91pHwHjUztskbba6tz4wVon/56cbjX0gdSIUZ9aA++DMq1ExOyiCh13EiXbI
	AlRw3BIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTGqK-001rNk-13;
	Tue, 08 Aug 2023 07:09:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTGqC-001rLr-36
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 07:09:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD944223FF;
	Tue,  8 Aug 2023 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691478554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/YLVCeWbOC5zGBWs9MF5sPBcfnhYRaJ1x4BlOnFxS4=;
	b=H4NZ7LtnOgJiK5ddlmJrLoNZSVL7aFBE6PT6hVKwRTOyoH6kgjQW5PDRYhRhJKToFK2s+L
	BnlnH1QTgJWTcu6cG2tA+VO6ErhNTRlpC2u7VuqtjGrEiu6JmXnGoNey7Hhfy06UxpOvcB
	Zvy9Jd6pTYvaG88JNLGMFxNz625jtQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691478554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/YLVCeWbOC5zGBWs9MF5sPBcfnhYRaJ1x4BlOnFxS4=;
	b=GfdwtYY+4z9vNKfS4ZmQ3lWCstnHBH9VZ/RJrOH9ct/6oXyYz+c85qWgEKfkDR2Epl1KD3
	moV1z0LeV++M7GBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFDFE13451;
	Tue,  8 Aug 2023 07:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id FUWULhrq0WRvVgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 07:09:14 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v2 2/2] fabrics: Do not pass disable_sqflow if not supported
Date: Tue,  8 Aug 2023 09:09:07 +0200
Message-ID: <20230808070907.18834-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808070907.18834-1-dwagner@suse.de>
References: <20230808070907.18834-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_000917_146928_5065A58F 
X-CRM114-Status: GOOD (  13.04  )
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

From: Sagi Grimberg <sagi@grimberg.me>

Only retry a connect attempt with disable_sqflow if the kernel
actually supports this option.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/nvme/fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 9725eeb3cda8..f0e85d3b766d 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -1043,7 +1043,8 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 	if (!ret)
 		return c;
 
-	if (errno == EINVAL && c->cfg.disable_sqflow) {
+	if (errno == EINVAL && c->cfg.disable_sqflow &&
+	    nvmf_check_option(h->r, disable_sqflow)) {
 		errno = 0;
 		/* disable_sqflow is unrecognized option on older kernels */
 		nvme_msg(h->r, LOG_INFO, "failed to connect controller, "
-- 
2.41.0


