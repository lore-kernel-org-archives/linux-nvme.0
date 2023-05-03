Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6F9C7EE22
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2pq1wjnhWpzpAUzywg7yjYCKpUJJXlcUeZCAZuKjeQ=; b=hp5wnBpzbW3FNQfXT0G7awAwC8
	TB8DmLstMWQtEqaK3WSltTUcZS6e1tgK2EbJmypMRL0OB4Ab4Xs+pmuRE+p0LMe0XyywhNjUDvbHd
	CMDev7+ThfrWkezxSxg33vC1QHVNmkWE04gDHC1ZudYBbvpYePuDxw4QXIfeuuiBxOvVbbqqEbbLb
	TI9+nNVL4hAkXljJnWXhBfXKbHeUeUi2Xsr1kp+Y6iAqto9R0nVRBgMHtZm5P1F1arSfkxY3axDL9
	bgFcI32RezdGHJE6GqRsoRN6emvMaCOY51tZMDLJUgBeEvox2Z/eUkhBkki9XJC6BYY8FF5IAlyXC
	/7Mdb5nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SR-003kNs-18;
	Wed, 03 May 2023 08:03:27 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SG-003kBk-1O
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D6B4223FE;
	Wed,  3 May 2023 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2pq1wjnhWpzpAUzywg7yjYCKpUJJXlcUeZCAZuKjeQ=;
	b=ajMzP1vczLO7G7jIFOc9NiidYl3WFlbFEYBsoWk5mT4U81vaYTbjZr9pcOOAfYA5/Wnv8n
	gF9mfH3QzZ7eqmT/3/XLXcCx9W5GVaars2uGz/GGATDQq6hjZmjYuzdhQ3Je48S7Eq3jCT
	uDZ5XBFtdofwoW/HsWrSRNr3T6fr1CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2pq1wjnhWpzpAUzywg7yjYCKpUJJXlcUeZCAZuKjeQ=;
	b=Fdy1nUpx1DqPaJ5pDiwa7wy5yJ4yRGpqmlpU+rtEVOjvLbIo3wBU/xMLMqZWOjUkcxeUOP
	6NKxwyuyAGhxFrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F66A1331F;
	Wed,  3 May 2023 08:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bwWbC0MVUmRDYgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:15 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 09/12] common/fio: Limit number of random jobs
Date: Wed,  3 May 2023 10:02:55 +0200
Message-Id: <20230503080258.14525-10-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010316_611093_88A0E986 
X-CRM114-Status: GOOD (  10.79  )
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

Limit the number of random threads to 32 for big machines. This still
gives enough randomness but limits the resource usage.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/fio | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/fio b/common/fio
index 1db6128be632..06659d7d1d84 100644
--- a/common/fio
+++ b/common/fio
@@ -189,7 +189,8 @@ _run_fio() {
 # Wrapper around _run_fio used if you need some I/O but don't really care much
 # about the details
 _run_fio_rand_io() {
-	_run_fio --bs=4k --rw=randread --norandommap --numjobs="$(nproc)" \
+	_run_fio --bs=4k --rw=randread --norandommap \
+		--numjobs="$(OMP_THREAD_LIMIT=32 nproc)" \
 		--name=reads --direct=1 "$@"
 }
 
-- 
2.40.0


