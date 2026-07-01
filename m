Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028F7C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 00:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TQJ/JvMfAkKXBx0szGgzrO7EQFJZisOeaeBc2Gq76do=; b=Zmwungf8prYueVBUIIoM1PyZ3W
	8RzmS6Is8AIUHbQQRskKotXHRtjPkeR0EcXNnVEg9JWYca/mxY1HWlT89wcNsoINbdQSZcQ6lyDYr
	BM2ED8rNmwtv7yLU3Z5fFZXpHkljJKQ0/oXQntocOlWhdhRImko1ycivVHBa5rMVIfBYYa0U0p1nw
	T/WOaxpfajey0BrJrnt8lOKcGs8xZLCYNkHBctVN+F9JNSuCPPFEg2bY2LEQRsNZaGvwfvWFC/WVB
	9xkZa6o2xGbdopslzmnxhMG3Gg5hn8cPY20gr9cO73TMimoYcDS3ucPl20mk+j+nj9LhqmJOkgJOy
	xdpAQk+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf5Yk-00000003JF1-0tPZ;
	Thu, 02 Jul 2026 00:45:42 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf5Yf-00000003JCz-2pkH
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 00:45:40 +0000
X-UUID: 535dbc9875af11f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:48e6944b-ae95-4b05-9ef3-4e6c58927b89,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:9599ae7fbb7f86be09010f39360d05b5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 535dbc9875af11f1aa26b74ffac11d73-20260702
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2132210900; Thu, 02 Jul 2026 08:45:30 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 0/1] nvme-auth: constant-time DH-HMAC-CHAP response comparison
Date: Wed, 1 Jul 2026 14:30:00 +0800
Message-ID: <cover.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_174538_038401_1E2248E6 
X-CRM114-Status: UNSURE (   5.65  )
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

DH-HMAC-CHAP compares HMAC digests during in-band authentication.  The
host and target paths currently use memcmp(), which may short-circuit on
the first differing byte and leak timing information to a remote party.

This series switches both security-sensitive comparisons to
crypto_memneq().  Non-secret memcmp() uses (fixed prefix strings, NGUID
checks) are unchanged.

Xixin Liu (1):
  nvme-auth: use crypto_memneq for DH-HMAC-CHAP response comparison

 drivers/nvme/host/auth.c               | 3 ++-
 drivers/nvme/target/fabrics-cmd-auth.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
-- 
2.43.0


