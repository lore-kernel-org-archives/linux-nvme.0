Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211F6C001DF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iRtgBAku4257SBCPX9EvO+HL6e6liwMpsxDBOvqZyE8=; b=oG874EzzBB4ntW4q9W744JRJg9
	WRYBc6OBwrrzpL/xQGdkBBiOEs3dikuoqw8jrUe1EGs0OaHIQw6RDcyNS1y4z3OqP/g3piL84kWDO
	bUwcjbbgbbB7tFZw1dQ3zAzrzt1IFkx+qdpasVSEojBQEHKM7qH9io8hWEv7Lusw+G62GaoCb+JLH
	KZBMTcPKTM8fozgdzDiQjOc3hcTJaoTVzWw0J/Daf+SZRLUKNO3uBwtjrI7pa8AOe9WMeG0Yhyc+M
	hRusuile1Iim07+5bX17wo4WEkXG//3EzOs4/2Gxg7SI5a1HlzVaxx5AYBUjcL2Qw3OO9gdmUJwv6
	CtFIk5rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIos-0027KY-1y;
	Tue, 08 Aug 2023 09:16:02 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIop-0027IS-0g
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 09:16:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2EC420018;
	Tue,  8 Aug 2023 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691486155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRtgBAku4257SBCPX9EvO+HL6e6liwMpsxDBOvqZyE8=;
	b=ger7pBuTrwZ1HKfT8z3sjooEkTpJe3raGS/n3xoYQLq0YXFOHoeHwbeOG6Bj+fsq/6zX54
	E1NP09owVZGoBvJeH64xMMrenfzb0bzQiygBaUWOhWaAINnsLapt19zbZUkeg0wBX+Qq+I
	j8LrLs0n9TeihtMldqsK9LaAO/bydwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691486155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRtgBAku4257SBCPX9EvO+HL6e6liwMpsxDBOvqZyE8=;
	b=y8Vlt3iowHtcCUjxibL0cRrP6Ih1Ml60GjqxgTHt1Yc1NMC+MzeOs2fm8IkUJeY+N/r/h1
	l43pwJ9arV5cIGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4FED13451;
	Tue,  8 Aug 2023 09:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5zvcK8sH0mRFEwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 09:15:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v3 2/2] fabrics: Do not pass disable_sqflow if not supported
Date: Tue,  8 Aug 2023 11:15:50 +0200
Message-ID: <20230808091550.25349-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808091550.25349-1-dwagner@suse.de>
References: <20230808091550.25349-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_021559_422375_8350E130 
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
 src/nvme/fabrics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 9725eeb3cda8..11d99580072a 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -1031,8 +1031,11 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 		return NULL;
 	}
 
-	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
+	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
+	    nvmf_check_option(h->r, disable_sqflow))
 		c->cfg.disable_sqflow = true;
+	else
+		c->cfg.disable_sqflow = false;
 
 	if (e->trtype == NVMF_TRTYPE_TCP &&
 	    (e->treq & NVMF_TREQ_REQUIRED ||
-- 
2.41.0


