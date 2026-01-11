Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D56D2502E
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Jan 2026 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lNWpdNoixzhYFh7RTcLxk//q72kMwXx2vrdcjVQPs7Q=; b=RDwILjOfo53O0+tvTkpFTuVUO+
	v13LHVSd+nhJycIzaivD4ElxnN+O2Uk6C4tzCeTanB5g2b0MMnPcoBEQAtuq+3Wh9UpgJ5cu8ThCv
	dOPgZKMbRGZmlV5Dd9dWOjQiP13IHsCAsAfPPjSHfBxT8luVVW/P1kWnmbDBhN7lXmdHTGSW+dQgN
	sSJ8e9BjLWne0YgryaI4BHbCervBCzaees8cNPQQttlaSFgaZLvsv79B+OW7wzOqCaGGAW7LGK+xQ
	rCObIYMU6kasdOqj1djF2yvbGXhjt7WRepV2otmNSjuvyw5JfLY5C6Jcioly7HCcJWw89JzyR0h5r
	N/7ilUIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vf54T-00000004Zf0-1JCq;
	Sun, 11 Jan 2026 23:42:09 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vf54Q-00000004ZeG-1BLb
	for linux-nvme@lists.infradead.org;
	Sun, 11 Jan 2026 23:42:07 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so283531b3a.1
        for <linux-nvme@lists.infradead.org>; Sun, 11 Jan 2026 15:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768174924; x=1768779724; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNWpdNoixzhYFh7RTcLxk//q72kMwXx2vrdcjVQPs7Q=;
        b=Q5lPQTCKdOqpvbBNBs0R5BN/0J2GTC0d094HaC2/mnl9dmcc385Cn9MwYQJcm8DnpM
         HycpH+r8EXka6giGvc1K/LxzX36Jt2V/F4fW+Cp9Wm5xQPuFyqmdehGjj4dy9a3I+FvG
         HtlHFN1nG80O8B4rcy8PFlHj6FPFjKX6UmCRUH63rxf6FCfJnMoN2/4wkWYlUJuNFMzq
         5KYUayDB+b7sm8dDPTeEbEv4+Aow/RS1lRJPEDgYvmC8hT2stl+yTkinVFiYPRbJGB+Z
         v9U7d8HGcRZNV/n+qBQ8Q/Uo8LfUSeq1VHusDHccYiFSudsZ6M8yO8oo364nderxU5BQ
         wXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768174924; x=1768779724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNWpdNoixzhYFh7RTcLxk//q72kMwXx2vrdcjVQPs7Q=;
        b=SGHgV3XRkUb60Q1++9I5+BEV7Awec6qH9qJnODhfyY74/HQS56qsccuQ3yIff8v+XI
         3bSzabyqZMOyRi9Qq0crunCoQV7/AblcZT/J163oebcPslu5q1PuFqp9HWR5UUFStQVq
         sSAbhY2Dyv0mabw8GO9ybDnFXJs3qUoEhqQIWjImAegBsVBkQP8K/3O2wTfaML/grEQX
         CIN0NuXdvoydHVJy83JGlni4u/FRJADkbdPq0PWRdSK7UT+Z9s580KXSo5pgFni5JWef
         KFRwRgIhJ9vbW/fLz7OQzIki+OA2ZrfSnCY56BcGnDoaFXcyW454jSryitJVVlMU/uZq
         980w==
X-Forwarded-Encrypted: i=1; AJvYcCVRDGXyhvmh/JkgpO/HU1GemIhVuSq/9oa5OvUkSo6DHFP768N5jKIjoSKdqDciiygY1tH8Sibu4Lru@lists.infradead.org
X-Gm-Message-State: AOJu0YwgIKlhynWOcV/JoNppA6JddKUjzGwYVPw+stTnpcIzM8NozKqM
	7hDucfi1btoVfznckQAc8xwUwqcNy+YzsSkx5TSpNpMbVEBwzcztZ2zD
X-Gm-Gg: AY/fxX6P2U1E4s0y0YA4uHEk9VfT9xE+PutQz3SeQwvtc0VOrkSNYkMOswCZYxZNGSP
	dN4cbzh1rV9v74amS0VYfU1WYJGLRXeX0jiT21LaK6waJ0+CZ2Ur10vZ/vlheL0+ywGt+VTQQa3
	07FAglYGHPR7KJXJH4Kh5hKbRFZ/cBpdULbyrP0pc0AOVt08njkUXItMWdSnp2bwqKx4xwGzuJa
	xfxTPXR7TUxFTluz4TXYEDrJ5f5BFB9mZbYtE+Yi05R8Hi1OIbiWhpjxZfLK0MQEImx479P5XZH
	Sbmo0Q8Li1Od+uE9SR8hsL7b+JgbBge5YsKj3AIIWNHCrhTTvLEMYH3039SYj2c9Pg4EiCBAcwo
	t+NsCZPvA3Ke6ICWVhC8vmCu0Xsu14w5fgppALrVLMuKRodF9iPDx1LP1aDFgz8NpMDq7q2g/F9
	qeD5cozh8FjcWqCjHI
X-Google-Smtp-Source: AGHT+IHGW3moNtpJxRd4hxMMHx2oAtbkufLJoWR1jvFU2OxSBUAOlCjV4NPLWC7iqiid6qI3Y0r/tw==
X-Received: by 2002:a05:6a00:e13:b0:7e8:4587:e8ce with SMTP id d2e1a72fcca58-81b811a05fcmr11443851b3a.65.1768174924341;
        Sun, 11 Jan 2026 15:42:04 -0800 (PST)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81dc51581e0sm7942642b3a.58.2026.01.11.15.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 15:42:03 -0800 (PST)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3] nvme/host: fixup some typos
Date: Mon, 12 Jan 2026 09:39:03 +1000
Message-ID: <20260111233901.2439097-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_154206_326699_159E5790 
X-CRM114-Status: GOOD (  15.29  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Fix up some minor typos in the nvme host driver and a comment
style to conform to the standard kernel style.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
V3:
        - Fixup the comment to standarn kernel style
        - Drop french style spacing removal.
---
 drivers/nvme/host/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..92749f6d0f96 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -25,7 +25,8 @@
 
 struct nvme_tcp_queue;
 
-/* Define the socket priority to use for connections were it is desirable
+/*
+ * Define the socket priority to use for connections where it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
  * possible optimization.  Making it a module param allows for alternative
@@ -926,7 +927,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			req->curr_bio = req->curr_bio->bi_next;
 
 			/*
-			 * If we don`t have any bios it means that controller
+			 * If we don't have any bios it means that controller
 			 * sent more data than we requested, hence error
 			 */
 			if (!req->curr_bio) {
-- 
2.52.0


