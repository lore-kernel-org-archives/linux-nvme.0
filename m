Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A9B1073C93
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YOO38u7VGuhQaTSS3mjlZHnMtq5PDCORndXhr0qapdA=; b=P4JhJ6hUQM/1n0/EkDxIjHXrYR
	t3rKLqor3gABa8Rtr9eYD6XVjpK3NdO+Eb7BbZ9O3H5lyXatKDZKSKurWE0HPyljuhTvDkuIJx9PP
	mzxnvTkDwi1Ygw1yckxhqzE2rByL4D4tVOhuhjq050s79i6fyQFlRWNUsClG/NddaMroVfNbAEobb
	1qFaegIwAT8npR8EW6YP72QEnhsOLUMdjm2xOvAwrHIUluRMYrCD6ArOrb2TFvT2R4U5N2ZHCI2S4
	AfIMq9/qcurVNUDjtPFlcwjx8hQQEH1OzAiMlosmX+5yojJ5ar0dB9yP1zJSS6twl5zpKa7upYonX
	9NMyK3jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wASN3-00000008sDp-34xz;
	Wed, 08 Apr 2026 12:51:01 +0000
Received: from e3i439.smtp2go.com ([158.120.85.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wASMx-00000008sD0-3E8P
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 12:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1775652346; h=from : subject : to
 : message-id : date; bh=YOO38u7VGuhQaTSS3mjlZHnMtq5PDCORndXhr0qapdA=;
 b=mLJtzbYrgjKhjzN4kbv/p6SbQsbaqg2474mwDrARJuZZ+6cAtZ5WAVMnWQO22CfnAOI5E
 nZq/n0I4xp7mWq6A/ln5Wp6f2MF//fcTP9roX/sN8Txh0KRzhgOSZdws4M81DwT4wyBPNV3
 mdkmXJTAmNGOU6ZlNpEHfxcDdQ4hd0XfTc16d6U2ASxqQh4gMbR5JHeEHTYBKdqQ9UFYNXU
 xi9uRZudtimYQ+BO5PWE32p6wrjfn1wCr4C/Qdm4vOKDuQYrXyN6yxhoxTDMwYHTg7qi3Ns
 oBPGqYDmN2IW7s/XotK08fZLItyBenNBy52Y5VBVmjNy8P405dJUuVZeLyFg==
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.99.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1wASI0-FnQW0hPrPP1-pjm5
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 12:45:48 +0000
Received: from flavio-x.asem.intra ([172.16.23.77]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Wed, 8 Apr 2026 14:45:44 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] nvme-core: fix parameter name in comment
Date: Wed,  8 Apr 2026 14:45:22 +0200
Message-ID: <20260408124522.2375297-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Apr 2026 12:45:44.0861 (UTC) FILETIME=[9DD82CD0:01DCC755]
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sokn9MPFOK
X-smtpcorp-track: P-9_H4O4YQoj.MiBGrsXGN97U.oaHzzwDM5FK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_055056_288877_A5A3A45D 
X-CRM114-Status: GOOD (  13.05  )
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

In the declaration of the structure "core_quirks[]", in the comment
referred to the devices "Kioxia CD6-V Series / HPE PE8030", the
parameter "default_ps_max_latency_us" is reported in a wrong way:

nvme_core.default_ps_max_latency=0

The correct form is, instead:

nvme_core.default_ps_max_latency_us=0

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766e9cc4ffca..ac5a7d9781f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3013,7 +3013,7 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		 *
 		 * The device is left in a state where it is also not possible
 		 * to use "nvme set-feature" to disable APST, but booting with
-		 * nvme_core.default_ps_max_latency=0 works.
+		 * nvme_core.default_ps_max_latency_us=0 works.
 		 */
 		.vid = 0x1e0f,
 		.mn = "KCD6XVUL6T40",
-- 
2.43.0


