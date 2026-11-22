Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2A606A320
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZAHMlM8l;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=X1HvDEFS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ju3+Kzur//wZ1L6j9QF+ag4oEga6H+h5IALePIcZepg=; b=ZAHMlM8lRtcsHxJp8KrxXPnCRd
	nV1lKKX+Rf+ypqQRe/LSp3S9cvn2LWAYOWWGcF4MVB/QcLeWBkuN6ehA11QSzs/nnL5PI5c/7grFk
	tVx1V7JXz8VSEUaJkyIHF9kljFpC9HOVWIVunJaEsvgN43Cjzs1YizqfUBYs/3R5xqjz6K9OJJrRh
	FYR3xTXvk7GbKQ/ombUMIiM48A6j2+nAZC8a9UX/q4qSTfKxQwNZRX2s1h2iXicQ6x2hOSskOhmAr
	xxsQ/nthUV3YwYuz9KXrnKop+5qHssx+7dSaWr3a56zFqO1LbNoDL4Bowl94moPkHiHQuFldSaxwQ
	xezz8TlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV9cg-00000001HRK-0DL4;
	Sun, 22 Nov 2026 15:36:58 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV8rs-00000001DeA-1mB5
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 14:48:38 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXX4x2cQpz5BNS0;
	Sun, 22 Nov 2026 22:48:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795358913;
	bh=0qJjM47HXnOSi2reeQMhqCNH+1k6sf1nNxDed1gjJbY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=X1HvDEFSVEGtcUKIIqTWR1KjxOu2lPFakWgIqmmicTZuPAHrDz+8X9v4NsD9a2XJK
	 GoHViKAMr7GWe2oDWmOZjkgaNkdpKI5dwURIcs187Mf0o43SPsKupLE1i3/PNHrB0e
	 4JwavCfNJQoc346MdqojC5NTGp6byuDCk1PeR3xz4YdbWIunOxkpozIf7rTPJzBiCv
	 BsCHOrhuTJeT9u5fEQazEjC9HBoGIn1fqsE0h42KdjehaKUq0YeINnD4KGbgPOG4bw
	 DUPGKmKHjqfTmdmmN4uPoL54OEJkOFkY8TlsWzS0Wjj6ZP/LFdDY8XJZliWfx0kxEr
	 FBVLPy6y95IYQ==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AMEmST3038793;
	Sun, 22 Nov 2026 22:48:28 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:48:31 +0800 (CST)
X-Zmail-TransId: 2afc6b0300bf8b6-4e46c
X-Mailer: Zmail v1.0
Message-ID: <20261122224831886ognkZtXtygomcSayJJdF8@zte.com.cn>
In-Reply-To: <20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn>
References: 20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn
Date: Sun, 22 Nov 2026 22:48:31 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <hch@lst.de>
Cc: <axboe@kernel.dk>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvMl0gbnZtZTogem5zOiByZWplY3QgYW4gb3V0LW9mLXJhbmdlIHpvbmUgYXBwZW5kIHNpemUgbGltaXQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AMEmST3038793
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 22 Nov 2026 22:48:33 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B0300C1.000/4jXX4x2cQpz5BNS0
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_064837_105313_CC5627A1 
X-CRM114-Status: GOOD (  11.25  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sun, 22 Nov 2026 07:36:54 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_set_max_append() derives a sector limit by shifting 1 by ZASL + 3.
ZASL is a byte from the Identify Controller ZNS data. Values of 29 or
larger require a shift of at least 32 bits, which is undefined for the
32-bit operand. ZASL = 28 shifts into bit 31, which a signed operand
cannot express either.

Use an unsigned shift for representable values. If the reported limit
exceeds the range of max_zone_append, use max_hw_sectors, the same
limit used when ZASL is zero. The hardware transfer limit is smaller
than any append limit that requires a shift of at least 32 bits.

Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Drop the warning for values the driver cannot represent (Christoph).
- Clarify that such a value can be valid and why the fallback is safe.

v1: https://lore.kernel.org/r/20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn

 drivers/nvme/host/zns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index e31ec6f4f94fbe872d346516b02dd1e6a2223872..a93f3b152faaad34199e0d6276536be0c0ae8767 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -27,8 +27,8 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 		return status;
 	}
 
-	if (id->zasl)
-		ctrl->max_zone_append = 1 << (id->zasl + 3);
+	if (id->zasl && id->zasl + 3 < 32)
+		ctrl->max_zone_append = 1U << (id->zasl + 3);
 	else
 		ctrl->max_zone_append = ctrl->max_hw_sectors;
 	kfree(id);

base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
-- 
2.43.0

