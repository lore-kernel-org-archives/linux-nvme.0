Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75313606A32C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eQmZe+jr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c+HPXXgR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Uw/cd/kzkyBkXI5zP9mLCKnmK/pe1xDS1i27lZNCuU8=; b=eQmZe+jr2d+pm1
	8NWDt9ZDenqwTvgbxhnDWiY/pMqDY60tJxz1gG6AderP1ssXtkX41pXKEk2y13Z1ON4HsLxaTK1EF
	G4mEZV3VethLavBXjLqIfdVsdGDe+6iL/ubFsUtb2W5ucl+eqmU4d2AozOdZxZtDhGMEBYTavBTp4
	3s5wCmWxIINo6BS454TQoeumA6wAXd+mA280/ZE40HXo91hXvT6qy61yjwt1RnqeacV5qxHwsFjEF
	T/5IHJuuBlEbukfzV7P3XTIsyQiKDwRjE6KVlSmIYg3fHvfwS75eRZxyUD3YlwSw3ItlTk7jUaKRV
	1OMdZnH6PCy0gCeXhx0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsri-0000000ECUD-0PuP;
	Thu, 22 Oct 2026 13:29:54 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsrf-0000000ECRn-3cAR
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:29:53 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so13853425e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675790; x=1793280590; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uw/cd/kzkyBkXI5zP9mLCKnmK/pe1xDS1i27lZNCuU8=;
        b=c+HPXXgRI9+b+w3E0CKL4fT/XlvduEUNvMzdSM1UtR9UmYSOgpiNKSL7b74tB4xKhl
         X0noGnW7ciDnaBr3oOeX0P1mJbfcTkDrARVim2NiQOeLYYNcLx3KJ60kl9krEZWlHFY0
         DiM/DqwPID/0RxecJ01aDr758J7Z634oDX8z2DJsYdddzO7zmIspDIB1du4dz8pGrtr8
         Xhk/w4zUhyQkimB3FcrKHUc2B08uII6jruqNNMLTPHLWa6Kmo8lWl7oElWUVW/WCLQoo
         eZ1uuLaFD3cs9VaL7n4JtobxR1Gum4YH2F1bbRr0o8ulX3c8HkzobQZlnOVSfZjjBoWZ
         erLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675790; x=1793280590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uw/cd/kzkyBkXI5zP9mLCKnmK/pe1xDS1i27lZNCuU8=;
        b=Wmql81MH7f9IB7lQfnnHJy6LGXcF7PuP0C+sZ99HQrzio+eZ5TIzQ8Bc8K0YKk/JIE
         afO5J+CTcZ84hLICkVcob+azLEDh/NkEfkBIETuoXrjxAjV5Lt8sFZ7iBo9Na9ay/Rov
         wYNwGIE88ODEvIAXOgi6bwc1Pk/2Jxh/eA7eQQJhadS8TyPxjGJ/TaqKRtuoksgpBRUr
         Bax80n8K75u0Zs0aoHTICN43xlkugZ1tZ5v2MsdVCvxPCmISNkaYjPAA3ggRhXxmibfX
         KksJp/KVaFVJIsmW4oC50JCWBPjncwkS0/g8m9nAuFzbHVmw5eRcKPEf+Ujc+qk0Eqhz
         ZwSg==
X-Forwarded-Encrypted: i=1; AKwUvBwAozccD6jPpkCIiip56YthPDwJZlbRswmqvezjKfK1QUH/P2Ju8mE212/ltbGtvxoGEG73P//LmhQp@lists.infradead.org
X-Gm-Message-State: AFq9FYJvQovh2JmfB0evGqCIWY2i4J16HgL7vqYgK+Fn1GFswxH0fSsN
	zcHvlrzg+CHP4y/63YOQN3O33jl0IoD3RBnEVy7fOFVgSYEPtU3LEyml
X-Gm-Gg: AYBFou1OXUtmo49+wQy+l6rzlVwI0sx1ew7DL7psLYJ+W3HegNXgqzhEWdq6zYMjS9/
	YtfiDALMkeP6BjB+dZaca7DHJM0lHkQu5aVqKmJDcLSzOeHrThbvpiy6tC/Rcc8eJyWpFBnWdsf
	3qlkrZx1T3p3jYoBJFRCUll+3b248F+R1npV2GzI2PgPpruF9Y2MTdstynWvja6jBYsUrGL4s5a
	RXJxnfOhdL5g6AWzcdCryjFnZlN4yiuseV3vBXFkzzRmcY3i1vjs9HsAZUQ+IbZN3cyJIpYyn8I
	/cwDb3mC1DSTCqdREQ1JysZmhIn7EBVkio2MGINlb5yLRfuS4slAd0J776KHpCQBhSGj+yvCCVl
	XfoCLrHJewwZhVDOHUu3+yugiEua9H3EmNU/6nZntlYaGgpK1WPcbjzfyu+AWdp6Iobu2Xn948G
	EW9iT+XdBSWT2hIoFBkvGjd0yyRYRca6goEcnNTOXcLT2cmzVovDZ/UDnH5mFe+DXvKPgwW4diQ
	NFNX6odB3PYqNPxA/zx07fs6sL7OuMChh0pt4ZoMTrnr9a9H83B2n/9gXBj9K7s7AaB84sx0GRd
	TCOedu42m1N+SiGkeFOLEV+UbQ==
X-Received: by 2002:a05:600c:46d3:b0:4a1:80d8:aed0 with SMTP id 5b1f17b1804b1-4a1fdd15be9mr114440055e9.15.1792675789631;
        Thu, 22 Oct 2026 06:29:49 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm108832715e9.5.2026.10.22.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:29:48 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Justin Tee <justintee8345@gmail.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	James Smart <jsmart833426@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] nvmet-fc: only send read data for successful commands
Date: Thu, 22 Oct 2026 15:29:30 +0200
Message-ID: <20261022132934.3592924-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132934.3592924-1-parri.andrea@gmail.com>
References: <20261022132934.3592924-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_062951_927386_A55B72F9 
X-CRM114-Status: GOOD (  18.85  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a read command completes with an error,
__nvmet_fc_fcp_nvme_cmd_done() still pushes the whole data buffer to
the host before the response. nvmet_fc_alloc_tgt_pgs() allocates that
buffer with sgl_alloc() and no __GFP_ZERO, and a command rejected by
nvmet_check_transfer_len() leaves it untouched, so the host receives
stale target memory.

The buffer is as large as the data length in the command IU, so the
amount of stale memory returned is up to the host.

The tcp and rdma targets send data only when cqe->status is zero (see
nvmet_tcp_need_data_out() and nvmet_rdma_need_data_out()), so no nvmet
command can rely on returning data with an error status. Do the same
for fc. The ERSP then reports a transferred length of fod->offset,
which is 0, matching what nvme_fc_fcpio_done() checks on the host.

Tested over nvme-fcloop: a failed read command no longer transfers
data and still completes with its error status, and successful reads
are unaffected.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index eecdffefa24fa..b95893adae36c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2487,11 +2487,11 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
 	} else {
 
 		/*
-		 * try to push the data even if the SQE status is non-zero.
-		 * There may be a status where data still was intended to
-		 * be moved
+		 * A failed command may not have filled its read buffer, so
+		 * only push data for success, as the tcp and rdma targets do.
 		 */
-		if ((fod->io_dir == NVMET_FCP_READ) && (fod->data_sg_cnt)) {
+		if (fod->io_dir == NVMET_FCP_READ && fod->data_sg_cnt &&
+		    !cqe->status) {
 			/* push the data over before sending rsp */
 			nvmet_fc_transfer_fcp_data(tgtport, fod,
 						NVMET_FCOP_READDATA);
-- 
2.53.0


