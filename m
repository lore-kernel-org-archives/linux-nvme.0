Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EC9CAC587
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 07:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GZBzkNSMlmIkXR7v+DqjmX4bPRcIBLEhcOlgv/ZqaSw=; b=tVCxdFeQEoWfXpR0VMOR2+8wAu
	+KhCjwiPIHzzGw4wqhL38BcrszQsL8X2+Uz07PS8OjKdcic4wCd7U4+6+e8tMMT+MHTWQy7ikzJGt
	dQckIcBvGlKuk/5pkMbZ3TmIi8tj023UpoSwcjPHiKe20i+zEZgrpxMUOf8mQMF4TrcR1nu//G9pG
	5p0EZyqWKulRpfDmq9b626vmOt83nuDaJif2O7H8ADUWwyxynlja6Muy8uFIY6niklvGXOA6yrhe3
	lF78BWwgbmwdEFTa2zYwmNHk9pRjfprxpKG297LpwM762Z1mlMl5lQxB1rLfr21iHalYpUSoVxcRk
	QVJsBKeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbmx-00000001VLF-27du;
	Thu, 11 Sep 2025 07:32:15 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbmu-00000001VK3-38ai
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 07:32:13 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso383193a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757575932; x=1758180732; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZBzkNSMlmIkXR7v+DqjmX4bPRcIBLEhcOlgv/ZqaSw=;
        b=YobQpnGIk8oJyA8SsN+XXoW+EQwW9XDH3mcIBUvvh5Smy28I/Zf9ygFNi59Ki66uoI
         7vi7LdZJh5T4NZphK8hlCVJ0gVHv9jrN4eEWZi9tBj9NK/5N7rsvRyOb+CQiZsgcULtr
         LAblwJLnkvbO9RvTjcdPv/3xeoyDD4dDSNWG4vqCnP8PBGmPeQxVDxptcfFg21Ol04QP
         +Un8fWmiruKXAQwsxxr4VyfFA/e66A58/eiW7pMJKQOQIOTdggcqccbN2a4hAT2vF4h4
         7sz1+CVkiyRiCMS8m4OATHz+V01JwHJCQI180puN3YUp9zuPngi4ozZiC3srdmMoYG9k
         atDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575932; x=1758180732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZBzkNSMlmIkXR7v+DqjmX4bPRcIBLEhcOlgv/ZqaSw=;
        b=V//3myvQc0UeoXgBfr8cJUkTgkhB5uxDKigFj3zUDEPTQAZZIth7y7EjKr/DZOQObv
         PY/yjXOLqXvLzAOczNp0zaHb9dg8+l+GfNWpj6F9A/JyuQXzr1pr797CxyqDM/Wg+2VN
         3nuLRaURUL9dHtGKcJYQGQtGmsyLs/Jr/wNUvtA74XPWIXrJo16ddUHCguhB/V15ILEs
         ysKbb79Frx48nhsRfPlrf2CEGxi0E1pBVjc+pTmddYs4jomAr+WG05rtdlFetL0Z0x/L
         MdvneTDnxNPNQxdWs8goTj1j4fnGVDd/W017iX93DpT1NeXppT8qI47pJyrIUdVbiSnA
         Pb1A==
X-Forwarded-Encrypted: i=1; AJvYcCVbUj1GI6V5z8DZEXRoY2wt4PrFiqflETieHTjPTJCVxc2Ej1G/GkAdZPp4RgbRt3AD16DSsVj++HVr@lists.infradead.org
X-Gm-Message-State: AOJu0YzJe2ekCMhLuOcNZhMvWo8PpKQVdKkJJ4BssK4BF4NzaLBXSM9p
	6FwOB+UaJ+AqITtbm2G0i/XCdnHa5AMM0ckGXcF6AUEtXJSMS54bLeOcsplHVjB/K4Q=
X-Gm-Gg: ASbGncselx0RnN/tLorC0eKCnIxDpFrsB0dkDXRGcE7aGiu5AKrintkFTzgr8WtS1V1
	yfNs4B0L8LxuWeMOqkI5tw+chevDwT06I5bO6PbaedhZchfasGpqpFk96fKmVvNzYjFM9o5npWi
	pSby8ci/IXqRemBU9d/XEu+bdJfUYNMhkA5cwKad5g2jq4G3CxG3LwFq3O4Od/FJj+hRL0Qdl+Z
	2A0faOh3lzueuUPjmwZmB+6d4bn1BSEJ9O6NBC78nVZVWCY+QdX5OKj6z68dG3dKQ4yngwHYWv/
	9HJUs7P6gk3iVAhiQu7ghXMo1zuxK+VVeJsM24xIwNcxJFX1ZVKflqJJ6PtuWOy2gfEnE+iimSs
	FWvolZfGzAXF6AdIrnCpHGg1UMs5N6Ug0s+hY+eESua8y+G4=
X-Google-Smtp-Source: AGHT+IHb3fEzi2I0Xw68tnhgTa5p89puCkcqtSm1frcG1ldvJKNL158VkcHDDriI2alZgWwrHA5Yrw==
X-Received: by 2002:a17:903:990:b0:242:9be2:f67a with SMTP id d9443c01a7336-2516d52cef2mr261971415ad.11.1757575931815;
        Thu, 11 Sep 2025 00:32:11 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ab4345csm9667835ad.96.2025.09.11.00.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:32:10 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: 409411716@gms.tku.edu.tw
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	ceph-devel@vger.kernel.org,
	ebiggers@kernel.org,
	hch@lst.de,
	home7438072@gmail.com,
	idryomov@gmail.com,
	jaegeuk@kernel.org,
	kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	tytso@mit.edu,
	visitorckw@gmail.com,
	xiubli@redhat.com
Subject: [PATCH v2 1/5] lib/base64: Replace strchr() for better performance
Date: Thu, 11 Sep 2025 15:32:04 +0800
Message-Id: <20250911073204.574742-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_003212_790710_301A98C4 
X-CRM114-Status: GOOD (  12.81  )
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

The base64 decoder previously relied on strchr() to locate each
character in the base64 table. In the worst case, this requires
scanning all 64 entries, and even with bitwise tricks or word-sized
comparisons, still needs up to 8 checks.

Introduce a small helper function that maps input characters directly
to their position in the base64 table. This reduces the maximum number
of comparisons to 5, improving decoding efficiency while keeping the
logic straightforward.

Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
over 1000 runs, tested with KUnit):

Decode:
 - 64B input: avg ~1530ns -> ~126ns (~12x faster)
 - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/base64.c b/lib/base64.c
index b736a7a43..9416bded2 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -18,6 +18,21 @@
 static const char base64_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
 
+static inline const char *find_chr(const char *base64_table, char ch)
+{
+	if ('A' <= ch && ch <= 'Z')
+		return base64_table + ch - 'A';
+	if ('a' <= ch && ch <= 'z')
+		return base64_table + 26 + ch - 'a';
+	if ('0' <= ch && ch <= '9')
+		return base64_table + 26 * 2 + ch - '0';
+	if (ch == base64_table[26 * 2 + 10])
+		return base64_table + 26 * 2 + 10;
+	if (ch == base64_table[26 * 2 + 10 + 1])
+		return base64_table + 26 * 2 + 10 + 1;
+	return NULL;
+}
+
 /**
  * base64_encode() - base64-encode some binary data
  * @src: the binary data to encode
@@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
 	u8 *bp = dst;
 
 	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
+		const char *p = find_chr(base64_table, src[i]);
 
 		if (src[i] == '=') {
 			ac = (ac << 6);
-- 
2.34.1


