Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CB0CCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=muPZR2EFB0oSgf5LU8hlA8LwOzFVPmAYEO5+iKyULIY=; b=DGl062uUeuyuqg1g5tvCh18BGg
	tgvBRR92C3jILGUZz2lUiKjJlk40/sUAG0ktRL+pw8yHBmvesHSoLUJj9fo0e33o0WFH3ji+EZz4w
	nf0p37lMNrmTIxNaLREFtZovkVMSISpbqxAhfQyU4LqC0jqfM+AqqnHHhbn20bwjuwO95kXH4+h92
	4ZORH+crREn5wZgUFvSgW83Mxg6v2QBGeplhpO5XqiitMQJCVUxBb4NGxxjkZXW6RIqlj4ajkvZEb
	OrzDCeVhBPWWLenbOIvrQfOY89x6CuwwhHA2fw1lfo4b/2TuEzsakEc8DihvQJbvVwFe5AixgRady
	PUFGQxgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3IL-00000000hXj-2vKM;
	Wed, 29 Oct 2025 10:20:45 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3IJ-00000000hWd-2E0M
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 10:20:44 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-34003f73a05so978785a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733242; x=1762338042; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muPZR2EFB0oSgf5LU8hlA8LwOzFVPmAYEO5+iKyULIY=;
        b=Max1A5o52T5Ulrv2bYwwj6cMdeTFkLydaTUcRszDBRazLe4EgIa157uAGJj+HL5M1u
         vUfTpBOWqth5jlLZ3c78kYHkX1nAlzD69/0ofGsHltBzxFjCvvMz+0r7Dx20MvBU6nOu
         HLSCcW9pSfSi2zoEdU0pYVQiaCWlwZHFDELTU4uCnNY6iNK9Qn6jxpErBxOtY3k6eIbg
         SzLqoW1PNnDspitiFcp5sJGWPqJEA1P+d+ovVEtQBd2os+QGiWjWYBr5MzE2qBIm6aVC
         EwhDsmDhzUiu0PLyI7MsP8YBjuOl15AOnE7egBflsIl0idzDVQZ7EAni4TSpRhM/QIi5
         P/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733242; x=1762338042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muPZR2EFB0oSgf5LU8hlA8LwOzFVPmAYEO5+iKyULIY=;
        b=ft741C0LX6dUe67tI+3IJRdBiJAnZsl3jfZYqh2FArR78Wj8lwGRtWpEPZzJd1Lj9F
         bjvmp3i8CBceS+Y7EbT+9TBZ9rFLmM42xwYRYj05Z3PSQeIKwhpvVtFwVV6BVjZyY1U/
         +a1mkVf9XiIGxArS1/Klolw9FkkOWO5rzqZMr/jcbokXsIAhCdoVqSxl9f/JXrcVuumq
         QRyqitS3aZS4X2wimhEzJQUpoNsVhWApzaG9VDQ9yiejJ/QdHq/79ha6elQ45iVt7fcD
         UhLEMqa3Og04EO7wzayxSa+2QTT9Q3eLrqfOLw6r+ELRd7Au5vi0fJZhdI8YVOALu6jx
         Y9/w==
X-Forwarded-Encrypted: i=1; AJvYcCU7eyj/UJSolN2lwwN7cZ4gupDq13kKTnbz/k7a2raJ0kd8dLSHK4Rb6poDEaKSJzWx2Mu4Jewz3NJi@lists.infradead.org
X-Gm-Message-State: AOJu0YxkbGBs4wfXbtlBcIw5bbtsnN7qocLbFT2iwVkHC1QQNoH6Y1mU
	VdPuW+/06J5uyFGMpnhYwzgBuPNl2pJygWIhmdFOJ6MMbXFSO/v8cO1Wvwj96zXMaIg=
X-Gm-Gg: ASbGnctfn0FbhSuyGZIdwJPDv0SlntAJMqj/Ld5EQdhM80aZCSnQauoAKUKlNEQ9PJf
	xoryxWVTd4HdT3PItQC1TDVH99BDPU7CE95CEc0wvH0qKnrEVxGRTCVAGBKep9lobrnij+uKAqw
	GyvYhy6QcqE5jn+ffCe1EWN+GenJo8WYj2eRTQWm4dgqNcsi66ks0YRbjGvhgWLPH6Xxs+mHCHb
	xfmbxTWcCmIvI/rzchcWgRVHNfzZanltMBOf8QrK6YqilNehY86MTtuHqCmL6iGT3ZGh4i0KRsU
	sKoNDfJEYws/Vql42p7P52JvSX/zI0VCh9ckxJknH1ij28C6TvSMy8qW2q4kmH+Tli/YvymjR3t
	/tIjLLvdEbRNFjhqqU2BJSK4UshzkIZfQI87JMJbzHVReFKCbom9XezxhCEGZhVaWzVaWyyyvVm
	FthoAC+rwYY4uw7K6EasXAtcjh
X-Google-Smtp-Source: AGHT+IFrDmoqflAy+Vvmh8+Eo6wG8f+LzM2aUxs5UOYfH1wyy2050pHKCKkM65jstFpCS2r3tIFSzg==
X-Received: by 2002:a17:90a:d448:b0:33b:dff1:5f44 with SMTP id 98e67ed59e1d1-340286bc834mr7455074a91.6.1761733242563;
        Wed, 29 Oct 2025 03:20:42 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed706449sm15024924a91.2.2025.10.29.03.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:20:42 -0700 (PDT)
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
Subject: [PATCH v4 2/6] lib/base64: Optimize base64_decode() with reverse lookup tables
Date: Wed, 29 Oct 2025 18:20:36 +0800
Message-Id: <20251029102036.543227-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_032043_572260_CD686C32 
X-CRM114-Status: GOOD (  13.12  )
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

Replace the use of strchr() in base64_decode() with precomputed reverse
lookup tables for each variant. This avoids repeated string scans and
improves performance. Use -1 in the tables to mark invalid characters.

Decode:
  64B   ~1530ns  ->  ~80ns    (~19.1x)
  1KB  ~27726ns  -> ~1239ns   (~22.4x)

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index a7c20a8e8..8a0d28908 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -21,6 +21,21 @@ static const char base64_tables[][65] = {
 	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
 };
 
+#define BASE64_REV_INIT(ch_62, ch_63) { \
+	[0 ... 255] = -1, \
+	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
+		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
+	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
+		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
+	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
+	[ch_62] = 62, [ch_63] = 63, \
+}
+
+static const s8 base64_rev_maps[][256] = {
+	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
+	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
+	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
+};
 /**
  * base64_encode() - Base64-encode some binary data
  * @src: the binary data to encode
@@ -84,10 +99,9 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 	int bits = 0;
 	int i;
 	u8 *bp = dst;
-	const char *base64_table = base64_tables[variant];
+	s8 ch;
 
 	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
 		if (padding) {
 			if (src[i] == '=') {
 				ac = (ac << 6);
@@ -97,9 +111,10 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 				continue;
 			}
 		}
-		if (p == NULL || src[i] == 0)
+		ch = base64_rev_maps[variant][(u8)src[i]];
+		if (ch == -1)
 			return -1;
-		ac = (ac << 6) | (p - base64_table);
+		ac = (ac << 6) | ch;
 		bits += 6;
 		if (bits >= 8) {
 			bits -= 8;
-- 
2.34.1


