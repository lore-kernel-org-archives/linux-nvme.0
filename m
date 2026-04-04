Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A3CE63FF9
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 21:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BpUSN0Z1IHSioYzVwD8gPk5Nfoeljdg8BmOBofC9qpc=; b=eQ8E408Bu2zI8HZmh1H2GjmumN
	WLDm9tbyuvce4uaRZJQfhRPWzNdn0Uu8bij/6MbPvI6yD09HwRJejMhyk9PZvKxy2nvFQtfimoo+O
	APZgLn4rig7fl0IB9tM0bcBU4qlq3Nu2Ar1GLzUu4ziNm6ZbfB6GOOx+8K09l8YKxljWEx7vKpkcr
	R9rtJ4Nrmx2T9x0xVVfAiXJR4AW5xf/TDJOXSS+RquBE50Twv2gqpKlE/jJJ/bM7tjsKdfAYif1WF
	0no32bwcq9MSecGUJE/Z7uDAvV70DoPD6YtXFm/UEDJhuuBFpGgXLzFZsxqLBLrCeF7+zU3t/IWUB
	RCc5rY9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w98T9-00000003l08-2prS;
	Sat, 04 Apr 2026 21:23:51 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w98T1-00000003kzg-1fSo
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 21:23:45 +0000
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6FC483F64A
	for <linux-nvme@lists.infradead.org>; Sat,  4 Apr 2026 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1775337819;
	bh=BpUSN0Z1IHSioYzVwD8gPk5Nfoeljdg8BmOBofC9qpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=o0ulnqFmOIz8JdcBHCGEtjP3tMp8MlirYfhdkIeYOL5fHjv6Pm4XGClOQdvjlHzii
	 RvmJGiSFDcJomyTtDNhMo3raNGBCWM1jb/OERsrgaW6L2JxqcxTQSKSMFzqoHOjbDK
	 WtlZ3zAoZMlh57AbJr7PoEft/4gbNsh4lU+N9A9lnu1J0pqnz6WTsa7TeYy3ZYixWs
	 kOoVu664M0V82Ldcyye0F3eGAXcW+nskEYF8L3tFnz1glb2dHcTxG86f3qgTuAAvnu
	 xxEUW/d9cMWmbwQvUncKl5Z7CbbDMrCJ0dsd4deJjnh18OurUB5QwH8GkZQ8bafFGf
	 CQhBNWyEGYvZVKrTrBsLsX/UdhbGNUsdQwk8kU8xtqWlwB7p0cR3Usu8bPPSGy0I0y
	 W+3G4sl+8Pe4laJOQ73uIb8DC4CJhhBWqp/yQnAkOcDCCDbhDE0gPS6thO2RTxQnJx
	 cnGFYTq3Z0MEX8NYVksRvbL8Ur6njaIRV/s2hQwRSfhdZW0yDbvPBOq5dVxqRqBd22
	 d8AJHKWuVnW4nZXx5eKI7TqnH1XBPXurZoBFUPw8qjkuioQPSkf1qa68MjdHg4b1kW
	 oNglJzChv3uUscBdLADc6ArjXSK2+l8jD4zX9LpsT5xi7XPZF84ocijImvYtOmokaA
	 sFIa4yfQ8Wa2D3HeMUvSx6Ws=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48884e969f8so15916945e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 04 Apr 2026 14:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775337819; x=1775942619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpUSN0Z1IHSioYzVwD8gPk5Nfoeljdg8BmOBofC9qpc=;
        b=LQvUgNzgH+0tYG3BkuSdrvCMo+C4npXXxN+S4SqtQWbPlm4ol1RgU8Cv4wZ9HLgGaE
         WctfFV6S+4h5qnI5cDkP+2qTQ8kDXpleymZ/tyTA9F9mrV7UNTc8SPs3kQP1HQZ28/Pm
         Ez626miTCS5vSgbMnW9D7W01sHeVGocSy4h2F+yWVXo++/1jfkgplCuiqo9pNYTcrac3
         s66wbLiZcOEehGkyY7FWdjG9MFpe5dXbVz8FxYh7+RBhQoOMlXWPSQDc0SnztcfkIkKi
         zmBpn9WY36mzHq4HNXeG082jzaRTnKkrkqe4jFT/Tx3mEPxn6UrQtcVO8gIkzEUujFBB
         JdKA==
X-Forwarded-Encrypted: i=1; AJvYcCWRoOd2o1eeSPvO2BYW2deBRKK5pYx547hE44qrPGGpJRoP3gKetl1YuS50uoUks38rEzOUd0My+UUB@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7IC+WZkOV5mnreItyIvJBwh0Ey4RpzwktMS/FnXwS7HxH1s1D
	9/bG1afMdW/EieQJ47ElUlmn35ju++Wa+qjF7RjU9sJCB2KFemh3AEQcETxhxAQVxu9IHDG1UgM
	OWDZRqo7IO/Ugug0hPJJKu091lT70ILoILXX0uvyGGCIk9/Vk/akD6Is2M5+zWbNOAfjhhGL+C7
	OtJMlPcdSRL4pCcgNL
X-Gm-Gg: AeBDiesPwQmooJYxaPVVECHMZ6RJ3SyqMyrXLoJDAcM5dfGXpAo1/2VOgCLWbacr54g
	MjKZtGt7m0y9XMJMi0rK9CuNP5qhLRbeHVrbX1vQKA2SKl5xqHxZx/6RXwFkeLYWOTVjm7v8NMw
	DSdMlWknxzaew8ART3SBLWoQdIUbaij2pdeQg2IH1t1hO7UwrDv06/GZI4RmtiQR+RVT4OZ5OTm
	cM3XgDMV0oUjvIDLpOUBBOl7Su1X+kic2V16Hk7xa95ozwmCDPXZRykNI03Wy6jXTfh/CNonCmG
	kMWBEAI+B/ZdgG1C2+4wICaewU5JLsvmkQTXY7Yr9dqPKrLWQeauvNVSzyTA63TYqpI9nj5O4/d
	L2j7oGzaqaizEO9f5a7ntB04=
X-Received: by 2002:a05:600c:c8d:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488997a6883mr104507605e9.23.1775337818694;
        Sat, 04 Apr 2026 14:23:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c8d:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488997a6883mr104507345e9.23.1775337818231;
        Sat, 04 Apr 2026 14:23:38 -0700 (PDT)
Received: from localhost ([176.41.26.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488940e075esm211104355e9.9.2026.04.04.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:23:37 -0700 (PDT)
From: Cengiz Can <cengiz.can@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	ioerts@kookmin.ac.kr,
	sagi@grimberg.me,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Sun,  5 Apr 2026 00:23:36 +0300
Message-ID: <20260404212336.1808498-1-cengiz.can@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_142343_824421_A5640546 
X-CRM114-Status: GOOD (  14.64  )
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

The stable backport of commit 52a0a9854934 ("nvmet-tcp: add bounds
checks in nvmet_tcp_build_pdu_iovec") placed the bounds checks after
the iov_len calculation:

    while (length) {
        u32 iov_len = min_t(u32, length, sg->length - sg_offset);

        if (!sg_remaining) {    /* too late: sg already dereferenced */

In mainline, the checks come first because C99 allows mid-block variable
declarations. The stable backport moved the declaration to the top of the
loop to satisfy C89 declaration rules, but this ended up placing the
sg->length dereference before the sg_remaining and sg->length guards.

If sg_next() returns NULL at the end of the scatterlist, the next
iteration dereferences a NULL pointer in the iov_len calculation before
the sg_remaining check can prevent it.

Fix this by moving the iov_len declaration to function scope and
keeping the assignment after the bounds checks, matching the ordering
in mainline.

Fixes: 42afe8ed8ad2 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Cc: stable@vger.kernel.org
Cc: YunJe Shin <ioerts@kookmin.ac.kr>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8f7984c53f3f..c6cc1dfef92c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -312,7 +312,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
-	u32 length, offset, sg_offset;
+	u32 length, offset, sg_offset, iov_len;
 	unsigned int sg_remaining;
 	int nr_pages;
 
@@ -329,8 +329,6 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
 
 	while (length) {
-		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
-
 		if (!sg_remaining) {
 			nvmet_tcp_fatal_error(cmd->queue);
 			return;
@@ -340,6 +338,8 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 			return;
 		}
 
+		iov_len = min_t(u32, length, sg->length - sg_offset);
+
 		iov->bv_page = sg_page(sg);
 		iov->bv_len = iov_len;
 		iov->bv_offset = sg->offset + sg_offset;
-- 
2.43.0


