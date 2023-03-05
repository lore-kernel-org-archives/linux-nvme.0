Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FD1C61DA4
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Mar 2023 05:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R/NDT2Qkp35VTC2Z1LkEf0c8GfOdcQkTrVgVj4Xhmrs=; b=CdsyNT4v0cKLpr+l1Rl/8AX+Uo
	3zOjD0tWM3Dt91+Y+4Yp/akHyY1Z918mHYrbFYT+5CLH8Jgm9Zn4mMKrxVZ/CdLl1Eqz00KHiY37X
	PcFzaVoeYpLFAIxg3tc2ZC/QrOlVvj8x3Z2KEEIxSdiRMehTuQaHA2+mCy5kge1xvgUNQfWDUNKUS
	aCJmTxrcIdtTIUreV7PCqL1mDK0JlAhTEjQ3Y252AcKj3oVdFXpFe4Io418rKiMQtK3BVtbu84vEM
	lPHO2TYxHxOQU9ZVTtqlO1rdC96LgjV66s5J8kPwuVoUIwg0u+FAD/y9BPmII0P5P2THZX/7YOwQ8
	9OLrFpSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYgb9-009qIs-O9; Sun, 05 Mar 2023 05:07:51 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYgb0-009qIT-Sf
	for linux-nvme@lists.infradead.org; Sun, 05 Mar 2023 05:07:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677992862; x=1709528862;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gxUbbb0L1sHDQfAEYrVAzIvg5fOAh2e1SCA9CSuq9+U=;
  b=KPRwVna4XEx2yEqn40fTxJ6cTxUQs6alo29AfFRaZbA9pK4nRTspwtY+
   ko8kRY/bgI4RPz2l0Qtqsewg2liGBcEn+4EMdH0dvhxYLib+OlDjjSA5M
   cxBRyArsR14hLZcrpvDMwOPf8lKWJpU0NTWPal36dWEbZ/LdAyjQ4DNj0
   RShKODSieIvsP9K1tKfj7Sm5jDpc7ExPvM+DFfTl5uE8jM61usG5ojwuh
   EgZ/wH/n6X1eqIjN1V7WBikk0nohI9JZDovOZvtvN+aBdTkRJv0fk2DJA
   cZ49YHgKnmrRo7IB7f9gj8gjeNWsvf5iMLXQKfYhor4isYsZG2hAkIhh4
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,235,1673884800"; 
   d="scan'208";a="224818388"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2023 13:07:36 +0800
IronPort-SDR: PC2O/zwQHtP2c6WvuoQvJdobRH6aH4oseOUaSWtqx7GH0+N0nX1r6/FvbEKINLd10876PPhg26
 koCG5bj8tQE6JbN/odTbrBkXu9qHF2GhRSv3N/LQoIcn6ANttyyfgauECb74OMtcKpxKqrJ/Hq
 2KB4MZsk7plHjwYeXV9vyAZd7KQ/rOX3nGhvVt0Bng+CUmNRFko1H2ERuwrVWHJZBqeBhjpcN5
 mJekH3/PSe6T5oKtszdPJFfpHFHWl6pBR+37QiZyM3F4qixIh79LIaaD3Tf663ES2GnpBYj53f
 1iE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2023 20:18:37 -0800
IronPort-SDR: FGbemEq5a94jCeitdalF5/IX+QMLcIEku0yXy9noYIW+alfncOpTphk3pFVI6Pas5i9ztYH5fz
 xFbW574YGoBlhkCXhjUPva5gheFoFVcqFNoD2Txi0j+pa5y1OQKkFJtOm+xZqltkGqjNK16Nub
 LrRVN3qedG99+HOHIWOyj/OonbYKZ5jYQoImjjI5tiUN+fdsUXS/ys2X/UEwVNHCa+XXKuhWBk
 6+CigdFCknuywcbBtF8r8Fvi16sik1zm0ADamFW4qxtZi+CxO3R7YndQqyAbZ968FjxLzR3L6j
 JTE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2023 21:07:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PTqTN1yzJz1Rwrq
	for <linux-nvme@lists.infradead.org>; Sat,  4 Mar 2023 21:07:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:x-mailer:message-id:date:subject:to:from; s=dkim; t=1677992855;
	 x=1680584856; bh=gxUbbb0L1sHDQfAEYrVAzIvg5fOAh2e1SCA9CSuq9+U=; b=
	A5SmaMDZaVq2FQ3mNk0GR6I6qLizsZyWO4QFpiklGd3gt8vXoQ6qUPul/nTmCN97
	jh8qgzRs21aTnKfJ7pxLOzdiTKgS9XG76cIHcT2lkWieY78QP1RziPNjE6Mzy2mc
	dqYKD33Zxi8Kyl+Kwrusy9NSI+qXODAI9UKPNlfG3ZC34unnDlyEh2BMuaXDelyQ
	f/BOEFwJgCmm82RMjXulJtm3cYSvMw+bFIEh2Ii2/4jytjM5BvkPV8Cttmu0PMqz
	h9zd2jNxeNypDCCmABk6wuViJ0VQ1rcprApMx5ejiVFMjVs3TkyjXAabGqfYyKLu
	eUEhH7Gkwk8BXBgjGskzPw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8Oe_Rlxb23Bo for <linux-nvme@lists.infradead.org>;
	Sat,  4 Mar 2023 21:07:35 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PTqTM0nyzz1RvLy;
	Sat,  4 Mar 2023 21:07:34 -0800 (PST)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvmet: Avoid potential UAF in nvmet_req_complete()
Date: Sun,  5 Mar 2023 14:07:33 +0900
Message-Id: <20230305050733.4768-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_210743_077327_3C91894D 
X-CRM114-Status: GOOD (  15.15  )
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

A host ->queue_response() operation implementation may free the request
passed as argument. Such implementation potentially could result
in use after free of the request pointer when percpu_ref_put() is called
in nvmet_req_complete().

Avoid such problem by using a local variable to save the sq pointer
before calling __nvmet_req_complete(), thus avoiding dereferencing the
req pointer.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/nvme/target/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 597d1b2c0d52..0f9193323a02 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -758,8 +758,10 @@ static void __nvmet_req_complete(struct nvmet_req *r=
eq, u16 status)
=20
 void nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
+	struct nvmet_sq *sq =3D req->sq;
+
 	__nvmet_req_complete(req, status);
-	percpu_ref_put(&req->sq->ref);
+	percpu_ref_put(&sq->ref);
 }
 EXPORT_SYMBOL_GPL(nvmet_req_complete);
=20
--=20
2.39.2


