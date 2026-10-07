Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5E3CA9ECB
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZk+12RxIUpX87ik4Sju0ydtLd9LDkS9K++2ovit7qo=; b=LXt1/+9kP/mo3/4frfjY7wzWzb
	+toztZTKPU9nGf4ruUzMjFhKaYzFy4OaOa5p/UEyQ+/5gqFnL2MFuegekW6lp+faEpFtP1OtlUc4B
	SQuk1izf1n1htAiIHd8XM80ezLHgXUQkTmCNHYPKZuoQIw2QpTr97MSF2PfUs1LBN3CglYhmxORdb
	9mMG+BfB3YzI0XFm97IcEDpWIogtUubkoy5ok306JFHb9vh5lhHwQM7VBFtlCVZFcyRSV7WOB9MyN
	xf2enDHzS575gedFYCksl2i75r6NGJwclX4V+uoqclG/E9tj5+qqsnDpwpYK05/WmrxGjuOfCTf7q
	8Y71AlkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtf-00000006hZE-1Xle;
	Fri, 09 Oct 2026 16:56:39 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGWB-00000001ayu-1kf3
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:32:33 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a01933b584so11485045e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336745; x=1791941545; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZk+12RxIUpX87ik4Sju0ydtLd9LDkS9K++2ovit7qo=;
        b=K0Wy29GTCIZ/Uqf92RT0Z0jaB/WLhVGj+epbkq5AJdzlcdZMUsqpon+GOEKpEEi+Yx
         YZ7NVQdQkoh6A4SHeFMx1Bv941fwZ/qj84Un44clFysCoNHDhj/bjSlgVxPdp+ItnqCI
         UI5cHB4XPXSc7qYB/ME5kgqITk9Hd/IUx/gjZj/3uNcEihF9hE4cCPL8m0mQUtzOHhwg
         UF5VudYT2Vdlg0T60O1DftQ7tUmaelTi9DSIvzym/C/ZeFQRb731YET0WVQ33/JACCTQ
         TxaBtpXBAiGrxxnhZps09VFko5+KbV6TAIUBpYAe4BIovOdMykH5v3vKOoUK9+BjmIOs
         1lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336745; x=1791941545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fZk+12RxIUpX87ik4Sju0ydtLd9LDkS9K++2ovit7qo=;
        b=NmnU4Qg/0dipGeVh4fxa2Rw0oQ/NOw403F9Mh3EVSQaQ9gbh7q4YVOSE92ebHb4+6U
         XQyvJzmRjVGfuVHUPZNjpgOgPkVMUpXyLdHSGiZq1MWGG7q91eZ+00IMtkilLj8aBbLS
         aqQu5cEQ4J7e0l8F60sHtEHJ9Yk5kM9soh7Pao6mBXsX/rGSeSR2Z1/Ai+2IE/hAUaMM
         jKq3EpzsGSqpFPy+O/SuISgaxDYvGmP2N54Y4+HBziVcwIzM/GeaQ655BFwvVgKzd40X
         mFWMXbG3YvUK/Ku7uIKAGNcEPscVZ8vNVVt0jE7N6wmaVtpTUAsFTcKnw2SHt9hJUGAL
         jLMg==
X-Forwarded-Encrypted: i=1; AKwUvBzjNYTGQZO5qV5hLqRjdxBbejVsnogWkiwYduqFUIJySxpH6yKPTegH0MeFYFpU3VJIIMrb0zf3PJvJ@lists.infradead.org
X-Gm-Message-State: AFuF++kUpELJ3nObzv1s/LrruxLgXIv+6Kus6nvaZhoyjn6tXTaWX1GU
	NqQSud1da9E2wN3l2MID8Cz/v2tCqspABx70X/NWlzD2OfxF6CEzv5Zs
X-Gm-Gg: AYBFou3hWN18gQyouZXymBpUHK986sS0sid45n/2PwpGxnPryuQtWIT8Mf1Qp4vsvYm
	2PozSKpFUzQsYJTqXPTcie0S/UHerhCBz5FgdF20Cl/5dL/1cqi1+UaLp5hX+02UFvK/5Fa+Hdk
	Su1+kZiTV6LeUwUvXrqk5SICobqyA+G8g5Gm3gWUadHUk/w+B7qH6ZAe8Gc8tVYAxNQoTWCU8fn
	ycxw7BWhKq7Vh4FtwlZa/YpaKQF/DNQVi+9kRFMGE7ugVSEgiL9/y/6/BwJwHwOC+/Dc+nfmUnO
	IkN84T0Ky8nF6wfiT+uhzPWo2CzkrCIuIYdAhKCzKzeAvq1t5hN3JETJoRUjNxQOhLZZMFE8unP
	qxlsWRVWVojpDad3equSv/ZP1r+TlmgFkbu53UBKLhJ/6i1ricGnLr7grziKsRM8uO0t9tlfXy1
	UwC5dyr4Bwvd5V+PjGrN/o7xI/UTP2nXcaLrC4+OpsLEAjWYtp0vnnYvd6+/IgSJa7Ql03Z4vJh
	Mb/7/wlYQUK0JzaWZN1gDHVftzS7nim50K6nikPYUsUpTqNV1EF07m4AYZtH7MHGn9CxaLMgroR
X-Received: by 2002:a05:600c:3b8d:b0:49f:fbad:29c1 with SMTP id 5b1f17b1804b1-4a1806611acmr8359665e9.33.1791336745490;
        Tue, 06 Oct 2026 18:32:25 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:23 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v8 08/13] nvme sgl fixup
Date: Wed,  7 Oct 2026 02:31:51 +0100
Message-ID: <e4caf53b7334af5390d4098cb5883ff551246a5c.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_183228_345778_768960AF 
X-CRM114-Status: GOOD (  13.93  )
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:56:33 -0700
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

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 651f7654d73b..79b3c1092e4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1287,16 +1287,15 @@ static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
 		struct nvme_queue *nvmeq, unsigned int entries)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct bio *bio = req->bio;
-	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	struct nvme_dmabuf_map *map = nvme_req_to_map(req);
 	size_t length = blk_rq_payload_bytes(req);
 	struct nvme_sgl_desc *sg_list = &iod->cmd.common.dptr.sgl;
+	size_t offset = req->bio->bi_iter.bi_offset;
 	bool pooled = entries > 1;
 	dma_addr_t sgl_dma = 0;
 	unsigned int mapped = 0;
 	unsigned long tmp;
 	struct scatterlist *sg;
-	size_t offset = bio->bi_iter.bi_offset;
 	size_t remaining = length;
 
 	if (!entries)
@@ -1305,8 +1304,6 @@ static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 	iod->total_len = length;
 
-	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
-
 	/* entries == 1 fits in the inline descriptor; more needs a pool. */
 	if (pooled) {
 		if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
-- 
2.54.0


