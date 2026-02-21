Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F668C5DF7D
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 03:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=; b=UX8nCw8NKMqZC15uzozy4mAqo2
	BkTp0ehZlbfuaj5ptgKI9BQHZMlIEQXxmiwx/ynLb/ErdCnz4vS/V/ylCDMIdYO8zIF0zJy/feyQ+
	8OPKTfAw3fBxewpYG+HknG6MlVnLdhRCKYJvRtW1fh5oD3/bNz/p9Cqw+5sGqPpaX+GgN6ue47ddJ
	ciwSbsgK/NG/czVgjllb9pspGZRT33cC6532e8QOsDXWgHL3lN4eKwD4Pil/cf6rkug82zvR6TdG6
	GsUHTbAYm7It0RS39nhqJrSveNlnS8eLz8dcnHsU48Ok88Xw3/iiIdXWSLpaY5bm6sCwgrlaxUS6P
	odFdmlNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdk1-0000000Fnc4-1Uhq;
	Sat, 21 Feb 2026 03:33:13 +0000
Received: from mail-oa1-x64.google.com ([2001:4860:4864:20::64])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjw-0000000FnWx-3nst
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 03:33:10 +0000
Received: by mail-oa1-x64.google.com with SMTP id 586e51a60fabf-40efb4bceb6so190454fac.2
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 19:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771644787; x=1772249587; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=;
        b=X6JZ3SkH8MhqsB31Ncyo/yxy4KQy7lm0smdMJO0B/JxUruVIa7AVHax0LFQkOjM9LQ
         hAQpESmpYkSwYXXMKFP1fu90T6fKHfAk9BMWhmgc8taDoH+XiEIya9BEjy6HgeeDUhl8
         RvoWsr0cMfNey1neTNglY0IO4+VKmqOQ4V0pPHVnGTWSjbPuEnxeIhbtk4tnVqLDqFxM
         b+nGCh9DBr8DzNdsSBY+nyYmNJ9kJvWGKCC5d62seiY+xDcX2zUT94LYxZC1IX3iBhJl
         5vnBYLUf0BJsyPdnXBnS2naVTYJBm50v8GOrgbI+5aq7BggnLPKi2COG38wLzmdI1eUw
         QJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771644787; x=1772249587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=;
        b=FNJtk4Wwl2jXIi/5sfaqgaMMyS75Q07oQYlO1LU2xN5EgHZ6hdUl1kKE31VOjfriyu
         Fm32BoXbYNxAmI0wYRzBokG4feIr/GAcoxVNF3DA7lq1pLuzjEcBMqlH7DqCqtVHLvda
         C/UUcVgIpCl6frNVRAzJuiVGRijWAUhVWcUsLCgiMNUcLpARvujEucE/eQm/WPnCv/ig
         R5W9n02nU2nzdwPWA78OWDlJR0sT5axkxYnH3N+lktXXkHNbd+eau58FtUJmd1d3pQja
         9vlKx18EZCqdhjBWOyP/Tl67Y5ZCWaqjmEDdgQU5XrrB9FV5YLjv4GtDtBS9GNCoLdo3
         PGJw==
X-Gm-Message-State: AOJu0YwwK/5h7+/ymSRONSphDrOLZx/eY0DLnhczjh0DbC5ZgvJy0JTf
	SzsqbGCrMeOGcSuNoTrYvB4mOGwEVKu9f0679cO+VlrRBBSikgHQspExERBg4ZAbdpLUHqpctvm
	1Yu0dQRAGCdeJg+ss11s/kqmtiCArdRtSWOTFHrx6sP1XBbRdoaVV
X-Gm-Gg: AZuq6aKkSsh4pXFklmf+pHXtohJNVAdwpz/OLdm3f4XXIbtA6M09RPThTqkSprhrz+9
	zXrX46Ivl/SoCp5yfdPZg7fZVSQyDf6Z6zRREA6BuecLgcWCpbkbniHwSjJedx3KWjPXjm7chqw
	aXwla9kInKzUpBMNkdLN0vuV5MQ19kI6fOlnLOpu/LyADjy+dNJMQykhy+uE4fRKbE2taVW+CCg
	ga2ZMNuGOEolp6JxMozHK++xJ4KpwUKgjoy+APOR4njpscRRBv8E8Oc6yZH3detwp+/4J3h0ptr
	Do4hTq6YHWSpGSvs5lQ/liGXdekXlLmwerL/Hz95tmnsY5W3EWTcJH3Ru67muth0ZyCNjMS+yhg
	ndGI54dnsy8LtscuM8jkAYC1T3RtDanlz395eW64=
X-Received: by 2002:a05:6870:41cd:b0:3e8:304e:b0eb with SMTP id 586e51a60fabf-4157b135a66mr921056fac.5.1771644787385;
        Fri, 20 Feb 2026 19:33:07 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4157cd86b54sm189672fac.7.2026.02.20.19.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:33:07 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2A58F342181;
	Fri, 20 Feb 2026 20:33:06 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 203BFE427CB; Fri, 20 Feb 2026 20:33:06 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 6/7] nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
Date: Fri, 20 Feb 2026 20:33:01 -0700
Message-ID: <20260221033302.1451669-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260221033302.1451669-1-csander@purestorage.com>
References: <20260221033302.1451669-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_193308_974787_A6626910 
X-CRM114-Status: GOOD (  15.38  )
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

Use the NVME_NS_FEAT_OPTPERF_SHIFT constant in nvmet_bdev_set_limits()
to set the OPTPERF bits of the nvme_id_ns NSFEAT field instead of the
magic number 4.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/io-cmd-bdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca604..d94f885a56d9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -28,15 +28,15 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->nawun = lpp0b;
 	id->nawupf = lpp0b;
 	id->nacwu = lpp0b;
 
 	/*
-	 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
+	 * OPTPERF = 01b indicates that the fields NPWG, NPWA, NPDG, NPDA, and
 	 * NOWS are defined for this namespace and should be used by
 	 * the host for I/O optimization.
 	 */
-	id->nsfeat |= 1 << 4;
+	id->nsfeat |= 0x1 << NVME_NS_FEAT_OPTPERF_SHIFT;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
 	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.45.2


