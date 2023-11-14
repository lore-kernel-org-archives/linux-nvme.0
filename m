Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DC4C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JbZpk08S+KC0I1JuW/p9Snt86ye/34jItgbM8atmTqY=; b=ZIliJEUJzYvoz7pRrK4D4wsgsD
	dk8PulsiV15dvOI6IVr0TC7JQH853qtIs8VwMkW8s+TOeIoCxT4c3JSggK9YJy+7iJ9ll+aDshYhN
	tYYdzIIsr59FZDSR7JqpRUmW6gyxkkYcqdpVRCQqskiz3gVqUXxtHiGr9r6AGpaiufwOAXIUmnyyW
	c5xaIS+CB4a3QTUX0xKdYoyTYMFA8qUJoNBfsZ43je7mGkwy3ap4vDSZ7M5+k0OpAD2ZR1D3CTerq
	XwB0aM4C6HzTZLraWscTXSQVSr9welc2zTDb5y6EG7q0KgqaW6iB5lpMix+KrU3l0twV1lpxhZSbR
	SYO5687w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2tJM-00G0n5-19;
	Tue, 14 Nov 2023 13:18:36 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2tJI-00G0mA-1I
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 13:18:33 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 91D27218D6;
	Tue, 14 Nov 2023 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699967910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JbZpk08S+KC0I1JuW/p9Snt86ye/34jItgbM8atmTqY=;
	b=xZkopGUfW55IRnUDWUf4vFo/fLn4Bnzaa8eV2QGPC9UCznY4xldeAZjMKTjOCjKliWolF6
	d444I3DiejfDJ4pxNwD0c7xnwqw0f8wnpZtwrueTqfblSRk7BAGSvhcnAVSSdn1RSgp+QK
	q3N9Cw14eZlUt0DZs3N/WKNFoyLxYUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699967910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JbZpk08S+KC0I1JuW/p9Snt86ye/34jItgbM8atmTqY=;
	b=xpq5QL6SUWEz4ttaihZI++3eL7MW5VhPFWYGxT+BjM3vROYzX2vyurVbkIHp7ARCYbv1zM
	AJtCfeIlxbR/koBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 4684E2D1F6;
	Tue, 14 Nov 2023 13:18:30 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4E4B151ED1CC; Tue, 14 Nov 2023 14:18:30 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	kernel test robot <yujie.liu@intel.com>
Subject: [PATCHv2] nvme-tcp: only evaluate 'tls' option if TLS is selected
Date: Tue, 14 Nov 2023 14:18:21 +0100
Message-Id: <20231114131821.47101-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.49 / 50.00];
	 ARC_NA(0.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-3.00)[99.99%]
X-Rspamd-Queue-Id: 91D27218D6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_051832_584692_0785E886 
X-CRM114-Status: GOOD (  11.23  )
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

We only need to evaluate the 'tls' connect option if TLS is
enabled; otherwise we might be getting a link error.

Fixes: 706add13676d ("nvme: keyring: fix conditional compilation")
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202311140426.0eHrTXBr-lkp@intel.com/
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89661a9cf850..6ed794815517 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1916,7 +1916,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	int ret;
 	key_serial_t pskid = 0;
 
-	if (ctrl->opts->tls) {
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && ctrl->opts->tls) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
 		else
-- 
2.35.3


