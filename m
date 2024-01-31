Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50D8C47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JYJKynXe9UUhDqw5CgJKsFfFlQ2oIqB1+5/pcYhsDAI=; b=yuW5N8Ccw9z3vcqzzkD6vnKK8d
	5KYYAkr/+tCiqF/P/289J2TBLlDg7dkWeLPzp7D7uPjg8t5xX0Osqa15vyDUPq0d6zpPN3yP61Yk5
	okna1lgxfJxWQCNnyZXE0gsweBe9ov4R7zyHbka2eJz/Q5RGXvf9iR+P+B+XCCgEkS/JYntyaGiyT
	Vn2hyyWmCAqTNTsRkQdvHylXgHO8ZqDMEVHjLFTqYk+mF+MfFCxyr8mjdhRFQlC8DndBqglDsSHoi
	C+7MioYF3xJWeBKQzC7lYGfC8oQR6JQF2Je9oHQA4vh0ZCJLV19H+ypBtsrV4nV2JdeS31WXqmS8s
	VeR0qORw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDh7-00000004ayj-19LC;
	Wed, 31 Jan 2024 16:44:13 +0000
Received: from mail-yw1-x1161.google.com ([2607:f8b0:4864:20::1161])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDh3-00000004avY-3p99
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 16:44:11 +0000
Received: by mail-yw1-x1161.google.com with SMTP id 00721157ae682-6040d0c9cf1so8464967b3.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 08:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706719448; x=1707324248; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYJKynXe9UUhDqw5CgJKsFfFlQ2oIqB1+5/pcYhsDAI=;
        b=Ez79FQn9sR/pw9cEn8vGoBPquDqTV1s1sREcfpWPd401+hAbgO1/yRMc6nT2QTsSIj
         Hj9mb+7Vg+A6c+GVYN5s/BnDq34biWAMmGNPdBowBeSGvT1mkRWVNlelAMyoynCJYVSf
         oUbMR9JKIBKFErUS7/J50s4S8ZfmcgMZT9zucHKjSEpbg/ygPqVwkED+WLcdXGpv4L1w
         hQJZRKHZGWLHlbWb4aEPsYrdwGdNl1JcsPa0cVLIoPOZUTD79SMWYA+dg4AqL5kgb3eN
         mcAolvhu0MkW9qe+VPfbMExvIWQURQYprihSKZDV1QM+vRzAwqrlUImW+2uBGc44hEmA
         iwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719448; x=1707324248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYJKynXe9UUhDqw5CgJKsFfFlQ2oIqB1+5/pcYhsDAI=;
        b=aHrt11gwEcXWTUkQuYwZFgxnaZXLDguawJLmHdrBgBw0Wdad4TxH0XTACztdGtleB5
         yZrFIt42nGQcOQrLuVbI2Q0WWJ9TcgWGcz/sZavHcHlS3VEOYYI5h5rnPARmwEWSd+Yv
         r5hFr4T1LoDBpbJYfVLQ93+v/ljcNmPNW/1fBIUyDrUvlu9K1GTjJ881fJKh/1d8tgYh
         KH/a4KUxvibAHNerQ3tx7MGycnJJFK/TJeDhpQfqMEbQjdlUjDNFwl6LHczy6ofZmng7
         EpPePs9FVqxewuf3akxVTvfnLICiilfciI1bvoWcbY7PU1aPBdo35uMJZ2yOusi8vd8U
         8+YA==
X-Gm-Message-State: AOJu0YwK7OhZrePiXooS0adFa1IDtgP2x9uWzfTGQTCWoeNbEfHRLHb6
	mLq9GiT8cpySBh/XMzNGZhjRKN1czKzoyR0FhUDlPIBmhDbItlbp8QrpaZ/6Pb+GpUqcGzr+zMQ
	ohKe1K+PRvweYnXsfcQBPBhB7HZApvOF+2PgBimHz55ZIF/pn
X-Google-Smtp-Source: AGHT+IF9JEuxGAyF7Pa7Cw4ut1fBGV/l26Y6ulZt52qO49b3b0xm1VZZ8S2KP/w1GKJp060pheFDw/GnUNWw
X-Received: by 2002:a81:b667:0:b0:603:d3f1:1c37 with SMTP id h39-20020a81b667000000b00603d3f11c37mr2032635ywk.28.1706719447887;
        Wed, 31 Jan 2024 08:44:07 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id z142-20020a0dd794000000b006040afe5c52sm119494ywd.34.2024.01.31.08.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:44:07 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2EAB734071F;
	Wed, 31 Jan 2024 09:44:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 216EDE4FE74; Wed, 31 Jan 2024 09:43:36 -0700 (MST)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Cc: Caleb Sander <csander@purestorage.com>
Subject: [PATCH 2/5] nvme: remove redundant status mask
Date: Wed, 31 Jan 2024 09:43:12 -0700
Message-Id: <20240131164315.160042-2-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131164315.160042-1-csander@purestorage.com>
References: <20240131164315.160042-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_084409_978733_556C83F3 
X-CRM114-Status: GOOD (  14.07  )
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

In nvme_get_error_status_str(), the status code is already masked
with 0x7ff at the beginning of the function.
Don't bother masking it again when indexing nvme_statuses.

Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/constants.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 8791283ec6ad..6f2ebb5fcdb0 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -173,11 +173,11 @@ static const char * const nvme_statuses[] = {
 
 const char *nvme_get_error_status_str(u16 status)
 {
 	status &= 0x7ff;
 	if (status < ARRAY_SIZE(nvme_statuses) && nvme_statuses[status])
-		return nvme_statuses[status & 0x7ff];
+		return nvme_statuses[status];
 	return "Unknown";
 }
 
 const char *nvme_get_opcode_str(u8 opcode)
 {
-- 
2.25.1


