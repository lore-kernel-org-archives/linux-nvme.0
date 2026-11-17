Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCAE606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KU0BPiO+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dd7PPHtm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=NUhA+uZG5XdxMUQDorM5AwEpculFp+rMbhcc7G7XRe8=; b=KU0BPiO+tQAwmRuG33dw3A68zd
	uZ2MimqUdK40e15Lm7CpAXg+tFJFF0hJ4xVLq5rdgaSCMdiwDf2Nl2LWhcHxCqrC5OgfEgtsFL9HT
	hyso68cYLBssBlzeq7Ew2tkAe8YJ7q5vNlJ1ls/mTTdp7HYhJm6XgZX2PCCWOMrpYSvjfF1KohVO9
	lydWiX2uV2rPMLtBOSDXjsTGr4aq4Whe+fzhTCGdPyR3k3y6YXjF438DkGV71SA/NV0wWiwhjpFlz
	tzuo+Eis64zSBqUdrz95I7YnzlRdm1uGQUYRyA2Mcnffv380JTd91iKd6wRSFquaMD6uVjAOyV4HN
	quc2+b3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT7kw-00000004I4Z-2j4l;
	Tue, 17 Nov 2026 01:13:06 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT7kt-00000004I4B-0lJ0
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 01:13:04 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-1ae58d17cd9so3284197c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 17:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794877982; x=1795482782; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NUhA+uZG5XdxMUQDorM5AwEpculFp+rMbhcc7G7XRe8=;
        b=dd7PPHtmchj0aaVPB8r7X6eLhueF659YenvBOM7WwVR0t26QUZ/uoTy7gGX45am2wJ
         qf7V7XR9/9riggXANuP2gOjnW0ZXg2m9E/NKKq4XVwCSX9dbpuZPz2lM8oIkjuJEotgj
         ldUkGtAJunnaAwXwtcLAviHC/UbzpMHHKk+2ncHzYFvTcb4pGJnuViYyb7HER27/UWR4
         9mtD52vzMdI79/nCqmtwkJjv0GklCqgovc2MPx5XbHIZqQEg4JeF2AXz0JqoPmHA0L+1
         Q8Fy+cKBoqxPbnRcHifSfilK/gNgYwxyyvTkeS2KPZrQJvPeFafs6VDbChHnkrnDjUUQ
         ///Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794877982; x=1795482782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUhA+uZG5XdxMUQDorM5AwEpculFp+rMbhcc7G7XRe8=;
        b=eKS8hzdZ4tG1hxh8UZ10boKd1g7Rbh+P3B89I97T4IuJStg4aCBeqTZgtnlsW1o27y
         KmthTBoAwkWLLq3cO5S0MGHvDi9p13ZZE6MNpEAa8x0nOzhzqtzEny+v6+v4U/iKbSzu
         8Rw4jWFLazFFX/0XyAGarqtytVRX/yMCbQDVLk/35+nQ6blk/TN+7od0xtxmQ57mkb93
         D49NMX0/3EBJ6e4lqKr9FKS0ft9ZWwI9msA3XsKK2OrbX6q1JfVQqeyO0/XXXeNdRCC9
         R5YNoI/TFZF8SUS0511I+FwkXwlsBbHO6tJSi5pCmrKjn7TRUmdzB4Dp/gxUwzROBiKF
         WRwg==
X-Gm-Message-State: APuU4Z+b4/ZZy6l4x790NJ0Zcct3LHsdfCEGy5VAtvFgfQLL2VnX0YJR
	ZFP4PIAJ9j851PbOV+5pWEaM86AfEB6fa6t+PKZKOFwCDJfifKV9kY0kQmvf3vNnmh8=
X-Gm-Gg: AYBFou04N6XC2i4u9h/b/DVBCgd8NolsBfnv6mLNq+tjyJMQKJ+Rpf5GSwFcJt5JQdD
	F0UHJ0TCKuWUIZ2WzpdcBl1kCsSX3yZ2EaGDJfge0jpBg5P8gGjTaqXs4bDS4dX1LMuL9IMNTRp
	yiOwqsRgfAAgOY50px3cVimQ+viazbHiPRUqJD+f9FI+IxkuQw6MmF0FsZHFtZHdNNlChwVNflu
	7nARAvYTXH6Jg1/r6h8Kw2SX23qwrJc/QAYu56XA166w6dQOmHB4MnGXzJ/L4Ix73cCfbJbCcaj
	8hAlSaW41VyWJ32BJiqe27obeYM8ijZAMOUSqlvDERM9gicL2ltDAYdor0ojdbjPlFNjC20STMV
	pfDBrj/+X5sAZN5FzU+O81ICdWQJ2QMQFJq1vduyIbwQvGu0f3mFi6sFfRK9hCkvNFgMn2dMJff
	7zE/ZWBdrzXokilOmMAXcT1b/SaynZtYjhD0VGGKZ7gIZs4Cxh6etqCSEO9YBaIyMQigq3QJoEt
	vX1ZnhSsK53i2rYeYOQJslx+Hv0EmEWU16ETTVm6iLmkDjZDvis/HTUWwHVJpWF3lfiqa6dfx5A
	d879+GBZnLI+7FuUQjZUfi/qr1cZTo+EdSGqeSLonvFNCJ3j4sWjRJYvXCe/VluoW/Iy8QtnFMT
	o7Ah5bDVf1hDZ8yuXyEZCYTo=
X-Received: by 2002:a05:7022:3c84:b0:1b4:fa58:9d3 with SMTP id a92af1059eb24-1b5030bb43dmr11232487c88.24.1794877981588;
        Mon, 16 Nov 2026 17:13:01 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4182:5788:5c03:2bf9:5b8c:32cd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3815045b90esm1193654eec.13.2026.11.16.17.13.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 17:13:01 -0800 (PST)
From: Ankit Gupta <ankit6791@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Ankit Gupta <ankit6791@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme: limit Write Zeroes to 65536 logical blocks
Date: Mon, 16 Nov 2026 17:10:49 -0800
Message-ID: <20261117011230.10288-1-ankit6791@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_171303_229454_23D1A30A 
X-CRM114-Status: GOOD (  16.03  )
X-Spam-Score: -1.9 (-)
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

With nvme-tcp connected to nvmet-tcp at default settings, the target
reports MDTS 0 and WZSL 0. A 33 MiB Write Zeroes request on a
512-byte-LBA namespace then completes successfully after zeroing only
the first 1 MiB.

The native Write Zeroes command encodes the number of logical blocks
in a zero-based 16-bit field. The namespace queue can advertise a
larger limit, either through the MDTS fallback or through WZSL. In
that case the host truncates the count when building the command and
reports success after zeroing only part of the requested range.

Cap the native Write Zeroes limit at the number of logical blocks the
command can encode. Convert that limit to sectors for each namespace
and retain any smaller controller limit. The DSM deallocation quirk
continues to use its own limit.

Fixes: b94e8cd2e6a9 ("nvme: fix Write Zeroes limitations")
Cc: stable@vger.kernel.org
Signed-off-by: Ankit Gupta <ankit6791@gmail.com>
---
Tested on arm64 at v7.4-rc3 (aebb72744764), over TCP with the stock
nvmet target. Full-range read-back passed for 1, 32, 33, 64, 256 and
1024 MiB with 512-byte LBAs, and 256, 257, 512 and 1024 MiB with
4 KiB LBAs. Host and target traces confirmed the expected command
splitting. A smaller 1 MiB MDTS-derived limit was preserved, and XFS
formatted and mounted successfully.

Claude and Codex assisted with the investigation, patch preparation,
and validation. I also reproduced the 33 MiB failure and checked the
trace by hand on an unpatched kernel.

I will follow up with a blktests regression test for this, as
Christoph suggested.

Changes since v1 (sent to the maintainers off-list):
  - Move the calculation into nvme_max_write_zeroes_sectors() and
    derive the maximum block count from the command's length field.
  - Describe the affected configuration and Cc stable.

 drivers/nvme/host/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4aa02869b79..441d70001920 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2093,6 +2093,16 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
 		lim->dma_alignment = 3;
 }
 
+static sector_t nvme_max_write_zeroes_sectors(struct nvme_ns *ns)
+{
+	const size_t nlb_bytes =
+		sizeof_field(struct nvme_write_zeroes_cmd, length);
+	const u64 max_lbas = BIT_ULL(BYTES_TO_BITS(nlb_bytes));
+
+	return min_t(sector_t, ns->ctrl->max_zeroes_sectors,
+		     nvme_lba_to_sect(ns->head, max_lbas));
+}
+
 static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		struct nvme_id_ns_nvm *nvm, struct queue_limits *lim)
 {
@@ -2143,7 +2153,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	    (ctrl->oncs & NVME_CTRL_ONCS_DSM))
 		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
-		lim->max_write_zeroes_sectors = ctrl->max_zeroes_sectors;
+		lim->max_write_zeroes_sectors =
+			nvme_max_write_zeroes_sectors(ns);
 
 	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
 		lim->max_hw_discard_sectors =

