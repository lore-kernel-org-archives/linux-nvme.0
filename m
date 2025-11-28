Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4652D116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOTI9zrIzg7zm0suBs1FvPesu0SkZxT8M/7CVofybKk=; b=4MhKXycCmEh0/W5nR6voSoi/Ep
	KMohQGxeb6Dfxi8O1qYN514t0gRjwkhOcoY/fPX7cYr40W+v9EoBJ8RNOr1VKI7LoUU/U7WkR8w7a
	zx9WU+djPEtJmqJuSpdWaHBUyDH9gvzBtuj8fJkfwh96qK5WfpMG3Wybuhw8LFZbH0B2cfzfzeUDH
	tsOO+67Ly/E8eoPDw2bMGS3KPwR9BqPHiVjWTSE409DU9ZFlG4abu3YcY/ljQZVQoPa/QTGYw0Y38
	qfLiwpjT78qJ0QSG9uzAck+cOqtKdchk/7He2asJUpjeEg3N7g6vUzfwfcweSB8qeBJZsHlsGtPcu
	FbL//n7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtug-000000009Tr-0Y18;
	Fri, 28 Nov 2025 08:33:10 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtua-000000009Qm-07LD
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:33:05 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso942313a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318783; x=1764923583; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOTI9zrIzg7zm0suBs1FvPesu0SkZxT8M/7CVofybKk=;
        b=Xkcbs7lyQaHq66BTPxwFrou/PVxi3Akb+ISJP/nKDTCNvdgpriCHDuy/gwIUeq2vTk
         00Z93kfrHN4C4tEmGs8YbeGf/BXDSrnw7jTabieKksHYjcA2EW9N21sqrLg/vrEVjm5H
         DEOqN8x30Y+JMI3GQ7NtwTGznQ880gpGc1KJKTQD2eSsQxy6GjxZYC7LV2lmi2S4tz+J
         gyjIfq7TL9ZKV4ZSEzpSz+cKZlduV5cDe8XTL4Ug9EcUko+xtwHQyfZ4sr5yCPBrXdfw
         6bhm8k75toeFEcJez4iQq+IP5fjGcTO7zL3Xn9wjlFsaH5ARuei3OyUhOky1DMCKeL8x
         vbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318783; x=1764923583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOTI9zrIzg7zm0suBs1FvPesu0SkZxT8M/7CVofybKk=;
        b=vPbT4L2QbeuZYnEbGJsMuW+Cs0MD7+VidJwuk7LLTiyQSSmVYvn7HX/Wuysy8VoWX3
         8hg3giHdS3OUDCxswH5QpH23+0SkesudczjqryG7qmY5vAoyg9KTWvCnJrKDNBL/9nEy
         KsdY639R0j9wwyTNj/32cKq7AjB9iCjQW4OAThiYsvrUp8cLkUb1MWYtWpbd61fe9BT5
         5DYvvBqsqNCT1QsGsQJyMVBwODsGkrtRQgVGo3qMLkKlZDKCWEZY4UBzWQM45Qnj3z94
         Rv7mpnLr9vZW7OUxh9RJb6ftOIEWa05PihM//t1z8F7fCoe2ngN2Lt/JYfvpauaE8Evp
         bA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAQurwBql9qUQFIFjIfdd+ImRZkqi0VGzjRgUFOQW+90jwMoavsPUy6vR4hr/wLQcrniB3+ktymlE7@lists.infradead.org
X-Gm-Message-State: AOJu0YyJyJ+eaUB/EhKRNoU7ftTtqO2cNIDvFH3vCpDH8Y/OrkM6RFZT
	OjPvI+q7tjz/GQTcDbn+m+QjZrCDaWCO12+AhQS8W3STHa6/EG5QXJ1c
X-Gm-Gg: ASbGncsN2lH31WZmuPYo2+vqldy0mwRN2BPKSQ1Y36WCjU3BlGb9Bl5ok4zHDcb1rST
	qqqvJNNz/BqxZie7jtgOvkLubNbKfN2u1Vb4IofSRr5tJsn4m2ARBxDSPqUKxs0I4xWG0LkgKh/
	16qyZAIo3k5QbHODX+jz8JNJbyGyyuXBG86eY5xixt5OBvwWeqHzklfdcyXF0Fh2/Wl0qq+YMVe
	5PobjPn41rijHMVOaY+d14qMfuSKdZnG3muG5Utoq2S+QZUYPUVtm5VYz8zKwM/8DqCTXZvFife
	aaR0tX+9f5Y2Y23Jv5SrduZTdQQRXjBdv6+b0W2GfhtYOugw07AQBAWsNwKfwkBuAGiQ1Y6HQKY
	AKEFSx1lFFBSVO2CCsdi2wH+8Vscm7VvNOtFv+vvUUGaa8Ot+hkBrck9Zj1X/eetJzu2iwe+4pZ
	Ffvv8tjh6i73/W3DvErciqLEAk+w==
X-Google-Smtp-Source: AGHT+IG9KZ7rWCO0ABhUceCtzlD+O/EyLZjlRlvHPaAHNjz6G3IYpmLI91Aw7ItyMwREv8ZXa06T1A==
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id a92af1059eb24-11c9d870411mr17435747c88.35.1764318783005;
        Fri, 28 Nov 2025 00:33:03 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:02 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 05/12] block: export bio_chain_and_submit
Date: Fri, 28 Nov 2025 16:32:12 +0800
Message-Id: <20251128083219.2332407-6-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003304_065581_AC54E18E 
X-CRM114-Status: UNSURE (   9.07  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Export the bio_chain_and_submit function to make it available as a
common utility. This will allow replacing repetitive bio chaining
patterns found in multiple locations throughout the codebase.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 2473a2c0d2f..6102e2577cb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -371,6 +371,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1


