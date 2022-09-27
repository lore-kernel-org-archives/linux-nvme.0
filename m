Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046BFC6FA86
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 01:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JOcSBJDbPNKdxxi4qNGAXtFEhq+6bWrLRCXy9taKBK0=; b=tuOdUNKTT6ivyz8fzMM0ukx5dl
	uqvXMTRi7HHUSftdDvKrF8wYHAznOiIIZkyqj9fX2gKKRCl3Cc3ttwHB1LytP4d2roShwU+QkXzL0
	zNeoRrZ5/Bxw0R4oo5dht7DJzqERoCIu3tANO6Q7jRxjA1JHp78SXtViV6algdumrrHvl32HlI1Z8
	IFLF5PcBuV3BTM9kLsrVN4oLuR6RnBEQUt4RFGboQogb5yUiZNOpszTLrRj5+HXCbeK2/87G6frAs
	80ZkKJy8MjG0tSfcm1MGZJbqnt7gZa+5CBuKXpMxvjLMydonwpOjrIrEihRiEUuUrzlZUORZWahtd
	Yysw8nPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocze6-007gyI-QT; Tue, 27 Sep 2022 01:44:26 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocze3-007gxO-Oo
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 01:44:25 +0000
Received: by mail-pl1-x62a.google.com with SMTP id b21so7802517plz.7
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 18:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JOcSBJDbPNKdxxi4qNGAXtFEhq+6bWrLRCXy9taKBK0=;
        b=5JrmfRjCkoo8fy6h8FWqSC/AqEwpNNb38xn8OjD/0YU5l3Mta9yDZCbiDZIFOdz6+Q
         Mgu4jOGkIcM5xdha+tICm0Ov2rJ7dnZFBDyIJcvG4XIAjVxuwn5J/s4j5NMcXIZsSKqw
         nJ9f4ioCr7XgSl6Auo4hZPg+hwkpCdAQzZdPrpagC/0vnA28ZBvpsytRqttn0sLaK7Yc
         WCRSDTkiXPcxOmJtTv/aj1zh6+IRAoXIQ2WLcQKCLz358PJrlF2TibJMsytrKzIPKDtl
         YYz/VByzA8yNI3CwxnuKA2VDlWy3qQsnerdJAJpnz2OM5d+W8woPCcgxnpzFCwxMIlsu
         2mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JOcSBJDbPNKdxxi4qNGAXtFEhq+6bWrLRCXy9taKBK0=;
        b=C+wZ0jiOnuKQkmLuVj9Z9aJcWtsJXhR3JGAyk4cjVLF095nPP/5AGt7kilpaHji9ua
         eUd+EQfW8Jn5qouUBKepjqx1KdPGpBCc1rDYu5JRbsybCPI9YbJLQzxjzlWsWCxgG80h
         BgDx+U1gYo4P9bEmV2a6v2gSauLMtimyFh18kG0f8YnpovS/R2o1ZEttwnxnzaZfdXJt
         unnQ4VqWPg9lH6i7cGDBMYntNUuABj7WN4sOohllvdLPhUwKWmhFM0ha/2lWUQ8UfYu3
         FqxshlgKAfRVTc+oNVgJYuu3XvCdN6NwHDrzC2rWWMrJwGbC1hX2bD+dQFmElVpv2lRb
         SSpw==
X-Gm-Message-State: ACrzQf2DNW3uPh43PuOtMtEcSikPhN/LlhwSGkSIULPLSGqkuRVpD32K
	WIxsQ8hpDDuC1YnjHmhr/T7nqQ==
X-Google-Smtp-Source: AMsMyM4KIArFZjPWWsnRlC7IjrVD3iZswBYccQQ/vEud0zbo9JCCXs4kFqw8RguhuttKJ+I9uCTqrw==
X-Received: by 2002:a17:902:d58d:b0:176:da94:e6f7 with SMTP id k13-20020a170902d58d00b00176da94e6f7mr25043917plh.11.1664243062579;
        Mon, 26 Sep 2022 18:44:22 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm183062pfp.113.2022.09.26.18.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:44:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCHSET v2 0/5] Enable alloc caching and batched freeing for passthrough
Date: Mon, 26 Sep 2022 19:44:15 -0600
Message-Id: <20220927014420.71141-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_184424_031924_94C0A277 
X-CRM114-Status: UNSURE (   7.27  )
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

Hi,

The passthrough IO path currently doesn't do any request allocation
batching like we do for normal IO. Wire this up through the usual
blk_mq_alloc_request() allocation helper.

Similarly, we don't currently supported batched completions for
passthrough IO. Allow the request->end_io() handler to return back
whether or not it retains ownership of the request. By default all
handlers are converted to returning RQ_END_IO_NONE, which retains
the existing behavior. But with that in place, we can tweak the
nvme uring_cmd end_io handler to pass back ownership, and hence enable
completion batching for passthrough requests as well.

This is good for a 10% improvement for passthrough performance. For
a non-drive limited test case, passthrough IO is now more efficient
than the regular bdev O_DIRECT path.

Changes since v1:
- Remove spurious semicolon
- Cleanup struct nvme_uring_cmd_pdu handling

-- 
Jens Axboe



