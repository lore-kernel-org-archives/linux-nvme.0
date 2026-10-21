Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7D606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=idgxy5Rx;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qfDnWxhk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YyJXsx8WGgy7IrPhM3cdbJDYzcbLMYhf/whTKN5q+t4=; b=idgxy5Rx5I9dCEHpS1NeO4xnnv
	d5xEvbU5gtSQxjupa07szrAwwo1LzKMdGpIWSRU/PhCymohwaAawYBcX9m+tRmrp6qcxxZo+NL4Ni
	dGRye2IQTMs64nqR8GRsOm/T8RhI2P0YSUtLbyC/x9Gk5syMiy32t8fAg3IYyiI+2COsH1qXGPN2a
	0Psl1r3agp7IXLrea82/sotBJO3nb8TPUA7NzrX/hccb+pPCJJZMMyPZpaUItyqWBGs9K8RlgQMGj
	+fl6QjrHDanm0su2udb1UjQNJWCGpStOZfP4p6wv2HIedmHheF/8ByLFd734AErnxDKdY0xCcwkfD
	n3BZLtjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJOYM-0000000B4b1-43IP;
	Wed, 21 Oct 2026 05:07:54 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJOYK-0000000B4aG-0gE2
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 05:07:53 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-91ba702cceaso4338876d6.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 22:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792559271; x=1793164071; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YyJXsx8WGgy7IrPhM3cdbJDYzcbLMYhf/whTKN5q+t4=;
        b=qfDnWxhk8QwjWBZTSOMVw4ArMPvACCuQghKplyf5D1dZvlC1G8w1fH8Z8MrNsF8aEK
         eaXQ7TrBI5x8jfMZPWl3+p2KhKUgUE3iHCzCO5jQchl3PBYs8eumhfendD03ooL0B9HP
         zsuEihbRdEsDOr8LJhkBLpb64l6x70pDuLWkUjK2fV4rRDYqGcJSiG5vpsD8KjfPjBdg
         DWP7VI51YZa52ynqqTIWkTS6f/FeToBhWzcH8OlAH2sBE3cvSj8X5SfPzgZzpHl1zxx2
         /Ts9UuUMHRjFqvHhRjXiwQ9hE/TB0AnHpFsPFu2gC9DalbAYw9Pdwo3DfI6lwFmaSHPc
         QQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792559271; x=1793164071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyJXsx8WGgy7IrPhM3cdbJDYzcbLMYhf/whTKN5q+t4=;
        b=v4m4vEcjfrdIFmRN4bQzDywFB9CpZaRfbv8+HTLTSeCEDhR1u/XEYQ+j2Bmy6MIhtC
         7DztNK5UBpJK2tjQl+hgpde/PZtrgqzPX0k9yejB2GtG0hiNiekPLUXRalcPRwQ2Vna3
         OF89ULFstuiG0fzCkUm4wBJUfPjjQFgudK1OOTUSnn4jPd0WS+kWGGvbXqG5IMOJeOp/
         4xqapL91MkuDg2fsElyiU9v52wCGbYRfVOCvMn2O5VvC4aP5uYkcY2RLd0Ubyz+DcASA
         nNlyCROst+JUDar1rePj3syIQuVqcQVo+aOYTNP/V46ftU7qQIvWbkyK4D+ZrzeOsROr
         YZ2A==
X-Forwarded-Encrypted: i=1; AKwUvBwae8ug7AGNBplmnjF+m/irKYJcKXu/vxqXxlpOQRcZnmpmPqjOiMR5h9WqHelR3/RkVq0ttxGx5GRV@lists.infradead.org
X-Gm-Message-State: AFq9FYJ2M0xlK0QsvhopwXEw0z1s7GaeHaurvxxVUVjzD/JeVcY51MID
	gXGN72Qk6xSgg0JU1Ar4Wuj+StRpBgMjEoyEfkV7qVSGdM4riIUIQmUN
X-Gm-Gg: AYBFou0RBzLAaLT2tb2jMkAFHTvDP+TqJ2L6s6BT4ax9e+3dy6omXSxSLJDhGuujDdV
	4+VCs3+zGWhZ0R7YMtCji19BHLgH/IkU/SXt8TiseaBLjOflSH4t2Ovar+aDQ60JpXB+kUc70G1
	dfy+LWDKdfkV5svMymuSmguHetaG7E5ynhCCZTCmZNjl0X4fkCVYk1P96mXtomR0X9b1isRojaQ
	aqeTcLKNLxcZu5211GNsjAG92+SZorTEyn6PmmtXwSlcu6oZzoH47372ASzHkNGRVTzfomHNMsU
	2Wu/nE8ABayjWK2ELIYQFMWr4Muva98XiDhdqYEYBvJwMz1xGLBScBrtDvf8PrXLMHJatork1Oe
	C3bMDo5hqyv5NcrEnA9x4yKuj9DSX8+lRwLTfSn3R8vtgfZF+htYcMe1uBCaimoxDgZwKQ++cRT
	KiG/ZQXQz1aFdbbeGJugIO2seLsXvrRijTYpvu+G+7Qgeky/V1xelqbynthQFvWvAxtGdhIl+eg
	ETt1G0/QXuc7kaXf8UZpYW/1f183vzZ4ntEBgTakWPP5nJRa9cbqHoTJ7SkI5dvSf4g1EMsHXDM
	mHsfCXJ/KFUP1eRdQHp/pe/HdSXjBPIG395TY7FRJvSmcARUHNLicYHJQAsTkDfUEKz+qMAkWLD
	6Kx5H1tg59tWUT3M5iwj9Z4MW9Hymj2ATs3CvlEM822ER5W3ROndsfvfQdFuNfyrvDrIIFqLz
X-Received: by 2002:ad4:5aaf:0:b0:917:9cd8:f26f with SMTP id 6a1803df08f44-91c12ed7e09mr15835936d6.25.1792559270620;
        Tue, 20 Oct 2026 22:07:50 -0700 (PDT)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:81c:ed4a:9bc8:12f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c1c8cfsm15888056d6.33.2026.10.20.22.07.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 22:07:50 -0700 (PDT)
From: Andrew Stellman <astellman@stellman-greene.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Stellman <astellman@stellman-greene.com>,
	stable@kernel.org
Subject: [PATCH] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()
Date: Wed, 21 Oct 2026 01:07:48 -0400
Message-ID: <20261021050748.32491-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <166ea8e3-189e-4212-a457-e0b6e2e678f4@kernel.dk>
References: <166ea8e3-189e-4212-a457-e0b6e2e678f4@kernel.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_220752_216516_B04E79AB 
X-CRM114-Status: GOOD (  20.11  )
X-Spam-Score: -1.7 (-)
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
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_rdma_map_sgl_inline() bounds the host-supplied in-capsule SGL
offset with "off + len > inline_data_size", evaluated in 64-bit
arithmetic. off is taken straight from the host SGL descriptor
(le64_to_cpu(sgl->addr)) and len is promoted to 64-bit, so the sum
wraps: an off within len of 2^64 makes it small and the check passes.
off is then used as page_idx = off / PAGE_SIZE to index the fixed-size
rsp->cmd->inline_sg[] array (NVMET_RDMA_MAX_INLINE_SGE entries), so a
crafted offset yields an out-of-bounds scatterlist index that is written
through in nvmet_rdma_use_inline_sg().

The mapping runs while handling a received capsule, before the command
executes, so a remote RDMA peer can reach it (the Connect capsule is a
write and takes this path on a queue that has no controller yet). The
host controls only the low bits of the resulting displacement, so the
expected impact is an out-of-bounds write that faults the target
(remote denial of service).

This wrap was reported, with a KASAN reproduction, on linux-nvme in May,
and the check below was suggested in that thread. The fix that was
applied, 48c0162f647b, reworked how the offset is mapped but kept the
original check, and its page index turns a wrapped offset into an
out-of-bounds index into inline_sg[].

Reject the offset before it can wrap.

Found independently by static analysis with AI assistance, not
reproduced at runtime.

Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
Fixes: 48c0162f647b ("nvmet-rdma: handle inline data with a nonzero offset")
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Closes: https://lore.kernel.org/all/LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me/
Suggested-by: Keith Busch <kbusch@kernel.org>
Cc: stable@kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---

Thanks Jens, and sorry about missing the CCs. Here's the patch.

While preparing it I found that Bryam Vargas reported this same wrap on
linux-nvme in May, and Keith suggested this check in that thread. The
fix that went in (48c0162f647b) changed the offset mapping but kept the
old check, so the wrap is still in mainline and now indexes past
inline_sg[].

Tested: builds with no warnings (W=1) on mainline 4a8bdffce502 with
CONFIG_NVME_TARGET_RDMA=m, and passes checkpatch.pl. Not tested at
runtime, and there is no reproducer: triggering it needs a host that
sends a malformed in-capsule SGL, which a conforming initiator never
does, and I have not written one. The wrap and the out-of-bounds index
were confirmed in userspace against the expressions in the source. I'm
glad to help with testing.

The issue was found by Claude Opus 5 running Quality Playbook, an
LLM-driven code review tool:
https://github.com/andrewstellman/quality-playbook

 drivers/nvme/target/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ffa1e172c2..e47c572d82 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -864,7 +864,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
-	if (off + len > rsp->queue->dev->inline_data_size) {
+	if (off > (u64)rsp->queue->dev->inline_data_size ||
+	    len > (u64)rsp->queue->dev->inline_data_size - off) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 	}
-- 
2.43.0


