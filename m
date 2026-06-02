Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4016CD6E5D
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 01:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBUV0ZKl5dn5qAIbynC2sc0LbBigrU604bqLQhPbA6c=; b=RgJhwpkj534UtHDKspTXAZbJdC
	4Mb3Q9LLeBn2eUgnb9avuGEYddaxpTmVLlY1v7b/sM4Ab7mQmCq3KZL3g1AseunkuERwVLgSKKMq1
	StFlxY7LMa5hxZMgqH31MMGGrnKOX0BuXvK+Fz0lGzuC2oVguljJUSG8eC25/iHuwqXhBjeFQTeee
	R4UK6imFtjX+q5HYDw0weN4FrZS5Z9k5tu4oM3RaebXj5ZoXdgIUDgurYopv4898ugsmJtWGYS60U
	af41JytLm7eSkVjMDvjsUF42IpRHe0bMjqo0GIHarb4OI5SKmfH4EUVtY8SVIGmMAmxaZ5A02poy8
	o8IRgLpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUa6V-0000000E1YJ-1c6Z;
	Wed, 03 Jun 2026 01:09:07 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUa6S-0000000E1XN-3hoh
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 01:09:06 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c8585c51f1fso54187a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jun 2026 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448944; x=1781053744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBUV0ZKl5dn5qAIbynC2sc0LbBigrU604bqLQhPbA6c=;
        b=Y01yeT7aIV3UuFx7Gnwvf7hadBamDbYkVykkkprt9rAoBuH2C1EkBYnIKx5q+Z1Nfe
         W5X+hZpdKQ78Ft77C6Yw4ajclQ1Aeg4zMay9XKccpaTzqgRKpY/kHSW3Foz4F1rHalSw
         xaeGdP/Ti4xEEBtbC1ggF8tO57LYndbGvYkUJm/k82oNhYA3bfd/ONWz87WTVkJqi/+U
         OTrqFLnEtLuy4LDDyOWNenGmSvw5MWx63rgEHeMxXS0qKBjwHErnlM7dheM8HOnxMEv8
         RS8B4TNQ7KhaNdJV6cUOd73y/D8tc7bscBvAcbdxiFo1NQ3v04Zzi8JddMHWi6ltsGRr
         U9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448944; x=1781053744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBUV0ZKl5dn5qAIbynC2sc0LbBigrU604bqLQhPbA6c=;
        b=fson8bRAJ0oTK2LSVwvTnTXTzPl1nBTqzSg1LqyDC91eL+QXcLgmBkGEKP2KjFbrQU
         Buu0oP83IEzcUs+8aIKAe1Vi7mS5m+Dj+/bAuDddP/Ra5lE4wWIdz38wjz9U7ryVCeql
         6WRiM3MCR39gTBudux3/hTucl35ZHsav5bjFpc+9Cjmex/J/QCIEKmGxIgaUf9LePi2i
         Bd2cPLSGyvExbJ+M6qvRAjlffDuFZxUAff4XhjcGoCzpWvbql56uPjhoj3pZXVjfDyfE
         jQN1RgmWT0zPp8vrnM3fu7exTYjZB6xIcGU/nrzVfNrI963g9yXgahuMXPwkLhZN5sdy
         j5VQ==
X-Gm-Message-State: AOJu0YzRh9ceGVza6DsLbT1BNdJ5Yv7VKQVQW1/OIC0kuN1uRzaKnJfb
	4QewlsdT0p81XnTB3AaeY1sFBMYo6VKML4CESCbIRjTAYcVfQYkXIVAy0yPovuKLUkY=
X-Gm-Gg: Acq92OF2zAi4B/oeHAJXwcQU2JTAFMuWuMdzXao73ZZQPQNGQIiGKg38nL5t2XJPjqB
	0pO6OEgcBowYj1bjI/su7OqlGT1LvLvAJCnz48utN7JDRA7uXPMvV06JE5CL9JMU3YZfWsXB8V8
	o4aDy85pQ1esTxJMSsMmPv3qz/eXpBMiTgx+Ip8f4JASNNHCx6udpQIEWpqF6G9Mf+q41wq3lP+
	QcD45BVBAEZuhkYY4y/ANhnJioNMqCY1Lqg8BTDsnE70M4ExDtRL2hnWepWFDJHRe0tvg34/kSV
	vUqSsrGVj+X9iPzws67m3fa7UGpkrKLRYSu+woD+jwin3pgjDceMc93Q3MzMUYpdwgsEMrwRloa
	mnynq0zUyz9T61nrtOzeWWpkp5Bgx3bU88VKCTwnQtWOUJfmLS/Aj2EFkTGvHlVtr7IFNm13ADr
	AqBqUIzr8cVL+O3B8N6CCITO8j0Jb+
X-Received: by 2002:a17:903:2b10:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2c1645e77b0mr8896335ad.8.1780448943692;
        Tue, 02 Jun 2026 18:09:03 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609ed97sm5076825ad.41.2026.06.02.18.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:09:03 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, nj.shetty@samsung.com, linux-kernel@vger.kernel.org, gliuxen@gmail.com
Subject: [PATCH v5 1/1] nvme: validate FDP configuration descriptor sizes
Date: Tue, 2 Jun 2026 22:00:01 +0800
Message-ID: <e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f.1748841600.git.gliuxen@gmail.com>
In-Reply-To: <cover.1748841600.git.gliuxen@gmail.com>
References: <20260527133205.GA12042@lst.de> <cover.1779930057.git.gliuxen@gmail.com> <cover.1748418000.git.gliuxen@gmail.com> <b2f3e4d5c6b7a8901bcdef2345678901bcdef234.1748418000.git.gliuxen@gmail.com> <ah7KRIl3LNsbWLO4@kbusch-mbp> <cover.1748841600.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_180904_920339_C9A3D749 
X-CRM114-Status: GOOD (  13.79  )
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

Validate descriptor sizes while walking the FDP configurations log so
dsze == 0 or a descriptor past the log end cannot cause unbounded
iteration or reads past the buffer.

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: liuxixin <gliuxen@gmail.com>
---
 drivers/nvme/host/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766157ba6..48633a8bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2275,14 +2275,16 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		log += le16_to_cpu(desc->dsze);
-		desc = log;
-		if (log >= end) {
+		u16 dsze = le16_to_cpu(desc->dsze);
+
+		if (!dsze || log + dsze > end) {
 			dev_warn(ctrl->device,
-				 "FDP invalid config descriptor list\n");
+				 "FDP invalid config descriptor at index %d\n", i);
 			ret = 0;
 			goto out;
 		}
+		log += dsze;
+		desc = log;
 	}
 
 	if (le32_to_cpu(desc->nrg) > 1) {
-- 
2.43.0


