Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81649C7EE2A
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTGNiKoQbsEbQ4VSKu14TwByPsQaFPpXQPix7APqu0E=; b=V/Wo2+Mm/1zAzQ4RFDSdnincnH
	bj88E0OHloJN/3lfarbqNWwb2cMkMfR78uNRYDssdgBPI/Sts1BE7mR2B03ngsBUfwLv0QqCXFNGS
	7IKBbSgfKQSWV613fZ3rSfchuGuY67Q1dp+aCd7Hfww5ZeCOpPg02v5oFtPFy9htQVz+sFG6HE8KG
	K0xs0HC0nKlEElSUBxSwI51jfJJNE/jfB3UbryoyVK86vOizHFyHNZE0V1bnW+XOXmGnCvYdnLMvY
	chMwM+M9+GhpDidtFJ3/YYUVSUH7ALHuiYZM7s/R22736UKKU9qfrORek9icqKny527gLuInVz1NY
	Fr4ZcuDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAv8-0000000F4Ev-3chj;
	Fri, 27 Jun 2025 15:23:18 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhg-0000000F0x1-2d58
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:25 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-ae223591067so220791966b.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036963; x=1751641763; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTGNiKoQbsEbQ4VSKu14TwByPsQaFPpXQPix7APqu0E=;
        b=lUK37x6/FkwESfPjmlDDMbK8xAIVb1FHkuYxNHc9BnAOEPFST8PAezkweHxb0vTeRT
         JHNSAZkoDj9EdxXiK4FBxCcqir0K/OYh+gmaB5oevpM4qgPm+T8QiuGqrPkIYQ6oO2Wl
         O0iX0TcmJmLG5f93BhckTl9DmTUSumrb2jsB9SeZlamTuFUI7ajsBzIMDkht6BVQhaRD
         T8Bp/MmNzXFy6fTBJH3gvI3bSSAwXqNez5LAWCS7iid65oUe8jlAshmYTcbcKPkoEa32
         ILeu5DVA0aNJD432rlyHMVnUR19WEILx+Ww4/rcWGmnTGwRzfGi7sb+gNR8Ocmqf04XU
         uO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036963; x=1751641763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTGNiKoQbsEbQ4VSKu14TwByPsQaFPpXQPix7APqu0E=;
        b=xVQcW1cFqQan882bfDAsqh8MytnXGnOunAFcWGShgNMav+hNqI+h1Q0IAbC6qOlGSD
         HD4daUcjwuVd22qZFDt3E/jcP1qHlMc0C/Vpd0/OQ78Sy14l1kXt8C0OdWfb+pU+XCbp
         yERfADZQzEUP9lJlybzxtAGnflVZ43v/YKrd02Tf+tnvdwfzX3sqaVrHXgW8VGXuMT6G
         nyW9LVuwIGvpIr9teq472kgsO4LQpdkxUbNIrfFTTGW9WT8H9jzn0dbdu8jlx6nqwGLD
         uFnKVuKayhqicEWPnCqz5DOMyOz7qdM7d9zB3lpWAx4wmuGuRH2XBxrob8SNN15SRMsr
         wnkA==
X-Forwarded-Encrypted: i=1; AJvYcCUxGBTZvkmR9SkeVjGUK19xL5bXXRcQTsR65nA1wXUaqAq5thQUgHIGDp7/O+DM5sE6S1yfY/cxUULl@lists.infradead.org
X-Gm-Message-State: AOJu0YzG0izI1Vjxyd07wxQ/eifim10OXKhGGdbwww98C/58Z+Z5dCvO
	Q6hEoUUaSRWJen3jlCBn/dkZmTOQrIxrYS+TMo4YG7Zbe1u84y2qV1sP
X-Gm-Gg: ASbGncv9m3+iOmMbUmU6yiz7punX80S5aLg0DzD62o/qhBGFF1bzNeyGZIFny+yGZ2m
	SKeRAX3R2D/Sh66/BcVeD84rhtQ+RMVfkscGD7HxzMdRX6xPCi+d860XG/knEgZ8ihfcp1Hp/Dd
	X2WnBeeAk6j7XOEBb5tTFpWUkP1E8WjByFTT3bZPDtlDHSlwLlyvtcsJQW3pFW+mgzwXmFdIxci
	hDGbFugfHN06qX6pudShHSM1we+cP4/CFsHo0854V/LjWnfATI0Bd43YfdugZ4i2lrG5k39IF+q
	8trLSDAPDRjfshb6luo/jQ7KrOmMYur6FRyRfi2LNmFgMdRAQIFyOlkof+/wVLZJR/RihvWtVo+
	C
X-Google-Smtp-Source: AGHT+IHddxu52eYe4GdP027a7+vbQPkX8qfQtf33mc//fGgKF8hjaVtLQZicWUAm2AT5vyKpmMUdUw==
X-Received: by 2002:a17:907:1c1d:b0:ad8:9c97:c2da with SMTP id a640c23a62f3a-ae35013de6emr355935966b.40.1751036962582;
        Fri, 27 Jun 2025 08:09:22 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:21 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 03/12] block: move around bio flagging helpers
Date: Fri, 27 Jun 2025 16:10:30 +0100
Message-ID: <8621d50e186a9a10dc98e5aa7834e286612522cc.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080924_664113_A6BBFE8A 
X-CRM114-Status: UNSURE (   9.44  )
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

We'll need bio_flagged() earlier in bio.h in the next patch, move it
together with all related helpers, and mark the bio_flagged()'s bio
argument as const.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/bio.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9c37c66ef9ca..8349569414ed 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -46,6 +46,21 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 #define bio_data_dir(bio) \
 	(op_is_write(bio_op(bio)) ? WRITE : READ)
 
+static inline bool bio_flagged(const struct bio *bio, unsigned int bit)
+{
+	return bio->bi_flags & (1U << bit);
+}
+
+static inline void bio_set_flag(struct bio *bio, unsigned int bit)
+{
+	bio->bi_flags |= (1U << bit);
+}
+
+static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
+{
+	bio->bi_flags &= ~(1U << bit);
+}
+
 /*
  * Check whether this bio carries any data or not. A NULL bio is allowed.
  */
@@ -225,21 +240,6 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
 	atomic_set(&bio->__bi_cnt, count);
 }
 
-static inline bool bio_flagged(struct bio *bio, unsigned int bit)
-{
-	return bio->bi_flags & (1U << bit);
-}
-
-static inline void bio_set_flag(struct bio *bio, unsigned int bit)
-{
-	bio->bi_flags |= (1U << bit);
-}
-
-static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
-{
-	bio->bi_flags &= ~(1U << bit);
-}
-
 static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
 {
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-- 
2.49.0


