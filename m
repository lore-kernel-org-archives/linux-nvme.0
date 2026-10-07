Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06827CA601D
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=; b=ReJdyVeeEURVfYtz8BArbXS+N7
	szGZzN4lSxGpiBHwtb64C7otTS4fyxNcVQ3n5mJFib5+ak73jHATdwbG5tcHSCoyjSDF9wGMxqnHC
	PQNQX7Q/0aBsC0s21To1yvCv+Ai/3nF0sorx1opnREMgN7I9ESPezIklb7jfZUDqKpWgx2YrtmwZN
	4XtJQ2XO1coQKhKLwmK27xezsE2CFj/z3uabyva71du2SleimbwVSeRj295pQcovayG2YFSNDFBrx
	L887DYqaThYuQfgoyn5iAmpIlwJ7Cf+U1B1f9ZMq4/DGEF3a7+EfjawTLLM3t475uzaBS80wxkfmG
	j5Eh+KwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtt-00000006hzu-3SbG;
	Fri, 09 Oct 2026 16:56:53 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGgr-00000001cJw-47oF
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:43:31 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-48c45111bebso879224f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337408; x=1791942208; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
        b=LOW3GGszMi/XIT6TNid1psW58LDWaiKv/WMV/KhgDWfrPMjMlsx/woo2rz0oUc6tTU
         sOb2J+LsLJSK4jYLqhZjQ4rvIxch8JlRrf1dsHQTvq9saLY768H1gfnonFafbgZ39MTR
         Q/0UU8A/Eb/7aZbu54l22/PsRsmDoQ80VMM47eb3Uqv3gPnfc/JZlyjCQaoldnnaP4qi
         +UPCEDQTnNobJ5AEIDIocUhvLnH1xeUqiXdfSHT7G20Vnqa4jlE91oMND9fXVhKnSIT4
         kW9dga9Dc9QLAi4NpTM4rRTG8dZtzQ8zIRUEFvgMm1R1S5oRIdxdfamckyH7/S/QMZvL
         TgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337408; x=1791942208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
        b=zqxNJaS/cn2eyrFH0b+h8FDy30QHFCI2TdYK+ZizivTNzZ3rCOcRFFNxGx0CH12LuV
         AuP1C5CsKxXBxrgu5G3kobaWVdVAyHQ8TEwl2iEoFwMNRwwneOHL8FuyNNssxW7uCoLe
         CmDMmfqBckeR5C+IeuIsvPusEzswLnPSZdx6N7DaIGr9frvRiJS/esAWCpLA3R2mGSfH
         WWob694UCj9KXPai2OqieX/SGE6evdk8h6g3olzUrcvNihn21KpIKw+A+Mri0ThRMvb3
         LV43b9TXtS2C2cnPuVfx9Sy1+O5hSjWzVRvVKyd/d64k4qacGWytrUFYQ0Vdm1BiiJ5H
         2aqA==
X-Forwarded-Encrypted: i=1; AKwUvBxfjO6ioaPoq9BeYFOFDYQg067JPLXLBqA6ZpVCbuvPTCI/k0ksGx0RROY7wRIN6Z3izQx5dsM5dLv/@lists.infradead.org
X-Gm-Message-State: AFuF++mQP/UIlpHJ3ZcAaXOwYNMYEs2r21fzRZ4s2JBOSZuR1f7FCfMa
	fhHv51gHytMrbPmmKG1g6EhegCqqTlXRZeH2dsT7IodCTo7gID09/wXu
X-Gm-Gg: AYBFou30g6Qtq0PjnFp+xzk3zFh8m7fe90dwhyPhGcdZCq0uHDTux8/r6GCtc80cZjN
	bwe/PjHSTJ/l4W5nwM9i+G8UiL5IdS6TgD41m2KR89ooUnMjlbt9YEzO9tjfuAyiOwBjJ1HNVuk
	gbGSVns2bcdISlbnadA+J1grBacMyh4PgK8tp5BrR250mU8uGTFu42PXL4Ag8a9irXjqal7/wva
	FKkBwf5ipuus7qpg35OVZ5l5COm16kEjMH2YUMiLXpiqzfnCGGgYgGMu42kFrBZFl8eUKAMLfDy
	ZEaqKis+o7WJ+p9V6n7pSc+ygl/2FFynDspKiFqcCUxLBEOFUmK+wxdBU0j/reA9fWGSQRQ9/W9
	TvDPdNm+UFavKB6YjveQDp+ED+CD8uBAjG4GP9EVu4dBJzdezsNHQMAbqSEHaHGb/cm2HjQ9QR/
	OOHZ82Q1u0JGvr0Ocysu+Nj7dP/DxJrcBcXUpVbT5yTjFphtF5MizsQ4JGeOdSPtCEdvhatgbh4
	wO96sE0AHVF/NeFiZjL1160WkYayAN4NiJ8DcKGeG2HvUQaXtj8HWYdNXFLZ930WKJwfXj3qN2w
X-Received: by 2002:a05:600c:1911:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a180455696mr7216955e9.33.1791337408104;
        Tue, 06 Oct 2026 18:43:28 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:27 -0700 (PDT)
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
Subject: [PATCH v9 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed,  7 Oct 2026 02:42:54 +0100
Message-ID: <e46bb4ba345595eb920f2e14077f7f3d3b044d0f.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184330_037019_71D80785 
X-CRM114-Status: GOOD (  16.57  )
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

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 77e6929f665d..6930a6897b41 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1456,6 +1456,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -EOPNOTSUPP;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 9ef88383b363..73d7b1ebf0b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,7 +26,8 @@ struct io_rsrc_node {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0


