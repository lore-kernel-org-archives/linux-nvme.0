Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE61CC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=; b=Y8AylyzOtUMhAVNIDmNnaixo+r
	TmiNpoU3yK2LFJjGi+UvgefSsqVcGEizFg4toXCxxodlFOzipVdTXaHinsZMP4PThNOogTlGQxtKH
	sxCKkxe3B+oz71IjCzsgipRhieO6xeseIooXJfN7TYtZf+7ypfQGYP5luXkxIGpl4Jw0KVwn/9SU9
	vFoAzcUEkCB//+Prl2mM5zmGm8LDPgU9u/qqLkvaeI2O0Is6C5ZMA+3JdQkW/HCAzXtHHX5DhZVAa
	RqWIciqjcYk6hXWK9d7eP/UvOGO1xztTXqBoek67xGkJPAaiGwCBj+61K03Kw8sFXal+8y/PvKYAc
	R087qpFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFlQ-00BGLy-30;
	Mon, 18 Dec 2023 15:42:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFlO-00BGLa-1R
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 15:42:39 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 154B71F37E;
	Mon, 18 Dec 2023 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702914157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=;
	b=L19Sc9vVeoGzkuaT2qhVSvnG1e+bsLsIbDUptKVOlITXwsbz8oar6ZZiFL7/YNxqipOTqr
	/Nz3myfKu/2YrcLBQ5sEOOAO39HhKdsxqEgACVxrUl5wyRvzZGvuJf7GJvH8s4g5HN28pg
	SV4xV6TSZxp67M6sRZDmFOe0T4RRR+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702914157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=;
	b=DqqX81U+go088EIo54twaH9n2d7KVeW8hu+UFLich8bj+0EIpHlQFpXv3AFSLrcDJipvhD
	E21TFtbKbh+D93AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702914157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=;
	b=L19Sc9vVeoGzkuaT2qhVSvnG1e+bsLsIbDUptKVOlITXwsbz8oar6ZZiFL7/YNxqipOTqr
	/Nz3myfKu/2YrcLBQ5sEOOAO39HhKdsxqEgACVxrUl5wyRvzZGvuJf7GJvH8s4g5HN28pg
	SV4xV6TSZxp67M6sRZDmFOe0T4RRR+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702914157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1dKZcA4ezXwEdxeSlAbqNEVQJZBbN3wkn2D2BYxnGI=;
	b=DqqX81U+go088EIo54twaH9n2d7KVeW8hu+UFLich8bj+0EIpHlQFpXv3AFSLrcDJipvhD
	E21TFtbKbh+D93AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 06A4213BC8;
	Mon, 18 Dec 2023 15:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ea/SAG1ogGXOfgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 15:42:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 04/16] nvmet-trace: null terminate device name string correctly
Date: Mon, 18 Dec 2023 16:30:52 +0100
Message-ID: <20231218153105.12717-5-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
References: <20231218153105.12717-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.81%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_074238_716255_9BBEE97A 
X-CRM114-Status: GOOD (  12.13  )
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

strlen returns the string length excluding the null byte ('\0'), thus we
cut the last chars from the device name. While at it, switch snprintf to
ensure we always have properly terminated string.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/trace.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 68f5317b1251..952e69f9737f 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -59,8 +59,9 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
 		return;
 	}
 
-	strncpy(name, req->ns->device_path,
-		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
+	snprintf(name,
+		 min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1),
+		 "%s", req->ns->device_path);
 }
 #endif
 
-- 
2.43.0


