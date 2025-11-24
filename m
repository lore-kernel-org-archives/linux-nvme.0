Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94328CFD36E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=14mujLSQeTKxSJUy/um1pAgQzTbPorW1qBu/kH6klR8=; b=htaA7K1J8LYJPZkEpH4+lfRN3Q
	tJUZZnExG6yNWXagPw1Xx2YpRViQjeGABwe6CUlrfekckzqnd5bEBW2A35HBKRYta+fAqvrHoYi6p
	BC4t5seG8tu5bVDqn30zo9kLYVe7AIFTJMrp1xuePNI4n/pLhBbX+gWVuR/RGUZ0WeciJBs8/lSbW
	+jdgKn5QWuDwq3+fUAhF8b1UVUk1aGDn8aA5ZvdczJ6Ma2AOoysacS5lK+LR1DPnH9DGnUF7A4Ugk
	LSlvleGIfBn/62HdXlF/7367vlBHZlLUhksMb9FK4LOAPhADMd3Lm32M+yUAHY291p5T8AI0r5RWN
	i73S3DpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIJ-0000000CTfy-4AMr;
	Mon, 24 Nov 2025 23:48:31 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIG-0000000CTd9-3qxg
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 23:48:30 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so4182979b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 15:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028108; x=1764632908; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14mujLSQeTKxSJUy/um1pAgQzTbPorW1qBu/kH6klR8=;
        b=QUCPpzT7fd6VvAO8xMTqSzjwsm5GLB1n0du1q89Itl6LdP0r6v+5d9JxQIZfjntSuf
         LFG7qXAkIHWivZccHOdsEMsyDsw8WkrvFLoSMzlOJMJxO4LWUxqnEj6l3iKzgwkXNyTL
         6wZ2NBXNfuuH3x86FywYj2JEnGpjX3KJW81nXNWfg/EKF9RX1TLZbQ6PfizscA5VC6C+
         X+vsxWxmlbpIUAVYcOq5/UkR+TnZ+KBwZiAjz708oRevZKTB6qcwVMUIsqZKve49A2/c
         OdsPQFeFVI3VmHXfmn/pRI8e/J4xcQi8+t5gdso+OD9BC8iMcGcMiLS4rVozfTJtWh91
         T2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028108; x=1764632908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14mujLSQeTKxSJUy/um1pAgQzTbPorW1qBu/kH6klR8=;
        b=CiEg5fPxrW838Z/zD1pqPgauG+AbDsDAeqg5p+S5zzE69mmO+HK2htYov0e5hW2DoO
         SP1rGZDRhGCkapjl5xnLNSDF+y85eWY8fR12Z40Gu6yZ75/tgI5pyGViNbwhqzpjDjR/
         f+VmJBMVbxpcl98QipCKLpIUdBuSQHiUZJL4GonZTJnMGF2+OwHoSl9GBekXRVA35+3y
         Mt6XU7MrVZTP1g7QuaXs34hZDfj2/f2MOiqBlC5zd6qzgc84GczEzNnzt3JoTI9dXMwt
         rVHLNODnYDUGEPPGuWmXKUZyMT5mG4OQXwswkHbtl3Z2qoRL3l0+Yp12XI/1Zz6TxLcw
         F/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWcCy64dxaYErHgbyfIpdqwefY+8SUobE1EWMXU634ZHT7vfrM/Vs2U8nVLtPoMV88A343Z6MDskF0@lists.infradead.org
X-Gm-Message-State: AOJu0YyQRFb5Wnw7mnduJJmnU3f3+IhwO35lXwUx4tRdyDxHwMsWZATM
	Nnl7eBWM9CgLsz7g7897IGuN44zDyHoy5kHFy5KXRR9i2kxRSDjAggng
X-Gm-Gg: ASbGncuDkQxnl8q+9jtJBVOp1XsFq+EEG4NrV+oF85CLIkJt6GhhJg+WpWEMYezbM0y
	2faa5SvLBeKlcYuDd8FeFUynf19uRj7puQXrglWLBqXxkFXMYU2qF8cDFG7ch+aDCdbVvIrPCPY
	2AO32cXVuQsb+43zai8+FXYY35aOCyi9vJjY6BmczhPFvcsNFlovDQKcHSaUO+H60GpNi76Je8v
	EfHcEA9UZx6aSX/SKd1nL5bIe637m7Wqd70VclMQZJP/YSSQJYeE9PXJoKYw2I9Mu5L7ri4axxV
	JzcAkl6j1SPHf6czDhQfeN6ziebk4+w0/+oItklT+DZrkcO/0y7bQFjsZYSfq2mnUvzYJX5R2fF
	jEHF0Jo8n98T4PYtzf55dOPj9fenghI0EWMACZ//i2X9gFDyOZF4cXRmYVBS+VO09bQcmjLf+m/
	qNrneqTjfDeajN2z0O3ZP9f6H1auQdZFpsPIU3vl+jXpNRpho=
X-Google-Smtp-Source: AGHT+IFryzmc/XiOW9LSO9isjtYB1LRYx6LJmKSX/rJnv82E/9f71NMvnHJMZsWalBLPhm0XU6n7Vg==
X-Received: by 2002:a05:7022:ec88:b0:119:e55a:9bf5 with SMTP id a92af1059eb24-11cb3ef2594mr558577c88.17.1764028108043;
        Mon, 24 Nov 2025 15:48:28 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm50934844c88.4.2025.11.24.15.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:27 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V3 5/6] f2fs: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:05 -0800
Message-Id: <20251124234806.75216-6-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_154828_957364_E30812D2 
X-CRM114-Status: GOOD (  12.90  )
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

__blkdev_issue_discard() always returns 0, making the error assignment
in __submit_discard_cmd() dead code.

Initialize err to 0 and remove the error assignment from the
__blkdev_issue_discard() call to err. Move fault injection code into
already present if branch where err is set to -EIO.

This preserves the fault injection behavior while removing dead error
handling.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 fs/f2fs/segment.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..22b736ec9c51 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1343,15 +1343,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		dc->di.len += len;
 
+		err = 0;
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
 			err = -EIO;
-		} else {
-			err = __blkdev_issue_discard(bdev,
-					SECTOR_FROM_BLOCK(start),
-					SECTOR_FROM_BLOCK(len),
-					GFP_NOFS, &bio);
-		}
-		if (err) {
 			spin_lock_irqsave(&dc->lock, flags);
 			if (dc->state == D_PARTIAL)
 				dc->state = D_SUBMIT;
@@ -1360,6 +1354,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 		}
 
+		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
+				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);
 		f2fs_bug_on(sbi, !bio);
 
 		/*
-- 
2.40.0


