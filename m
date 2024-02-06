Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C52C4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNe+niz+/Ug/5EsnA3f0HuL34rjJh1jN9bAzDCkX/68=; b=YyJLZ3cVkfhqI8oL5DqMuaaHbu
	w9yb3ej/2F2jTDskQgGXrWbLoUbKkp107Amy3NoL+XNAQlc2BDCJUlTPuqyd3hLoy7e4uHMOX97CN
	u5WXjiuiCWT872DIX7L6MUPrNAlxyX50svPwB4Rg/qoRysNLEnbAo7MQTOSF0WUe0LzSR3s/dBLNs
	lD5Zl0Ty36the+Y0wkZOswFrup/7aZWGpOUJDq1JtAByWIKV2/qwsANMnEYLO5lWg6NnUNUkMhHXa
	3+SpLZOEme5k22+4FDkxfJYPoE0HBve9DPowA8ldRaVlXoGVwS9zdB5H4xkwjiRzo/9k8kQpPthHP
	GfAdDaYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLK1-00000007gkS-2EzY;
	Tue, 06 Feb 2024 13:17:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLJy-00000007gic-0qZ1
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 13:17:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85627221A7;
	Tue,  6 Feb 2024 13:17:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6705F132DD;
	Tue,  6 Feb 2024 13:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eil7F1AxwmVxOgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:04 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 1/5] nvme/029: fix local variable declarations
Date: Tue,  6 Feb 2024 14:16:51 +0100
Message-ID: <20240206131655.32050-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206131655.32050-1-dwagner@suse.de>
References: <20240206131655.32050-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 85627221A7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_051706_411816_622D4496 
X-CRM114-Status: UNSURE (   9.67  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The syntax for local variables declarations uses whitespace as separator
and not commas:

tests/nvme/029: line 24: local: `bs,': not a valid identifier
tests/nvme/029: line 24: local: `size,': not a valid identifier
tests/nvme/029: line 24: local: `img,': not a valid identifier

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/029 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/029 b/tests/nvme/029
index caed0f7ec476..db6e8b91f707 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -21,7 +21,7 @@ test_user_io()
 	local disk="$1"
 	local start=$2
 	local cnt=$3
-	local bs, size, img, img1
+	local bs size img img1
 
 	bs="$(blockdev --getss "$disk")"
 	size=$((cnt * bs))
-- 
2.43.0


