Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB6CFD316
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 02:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7A/o1KMdHnERZPkaP005IU3nW52A8GrE+BEL9651kiM=; b=tNJqr7xCDKfmGNeJgllA/LDTku
	Eb1w5PWA7xwgwa+Ii36BcL4+q0wEM4+svy17wnqVjqvj412SD8qxaTz8+Vay5ZTmGixwfTJrHBXye
	p7SvR4KNPg25N1kZ++/2/y2D8unRWeZwvkpZJVQwoxl/PYRzanB/2QhC55rSUP/tSu6S5DdpLiLoz
	0b8MjN8ucQPCfThjTeRU2/xnfBE+qQtA1Y4b6xUyeBxvZM2G96obyio/3vNfhOjmeCn0FSkZKACqp
	qMw42wMgJzcqg9yYw+0S/OdcxsEAJz++86q/ROZcgVxb0e5jeQmF7uBZxhuiABw4KQrhHtKkGH7/X
	Cdyp8n1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMm1-0000000B010-1Voe;
	Mon, 24 Nov 2025 02:57:53 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNMlx-0000000Azxx-32jk
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 02:57:52 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso2222895a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 18:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953069; x=1764557869; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A/o1KMdHnERZPkaP005IU3nW52A8GrE+BEL9651kiM=;
        b=l2ohW4HNhJ5CkYc/hL9wd/ChJkGhk78NSkhBY2ww68LtSLmYx1UgZKVWYqLJpyq2id
         KM643qWhVIRZOyoZ+x7F9R5E7+ALUWzh79xJ6Xk3w86h0TnJQrs/TQIvJvdcDJDt2IVr
         6c90eDIUW98DYmbx4U50z0AUpWxVFct7xYiAnj2xZayb+2WirishP9zZEyB6TYMUV+xj
         4zmr3WpJf+YhovGYqs+lgsvpAItTEx5i+aqtoY2Tw0EdXu8c1RElUhUB1lmkgKsNhH/l
         RY0EtnlXQIs9KRy8ML/1PqE+hpmVWWMIcVLhCuC/Aw7vEhgi0CLhN4EYjh9Msb1hSktn
         Jyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953069; x=1764557869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7A/o1KMdHnERZPkaP005IU3nW52A8GrE+BEL9651kiM=;
        b=h9DSNZ3eM9ty7dOuGGixeEIu3Gh7a8knIKzoSzPHULSe+rMpvk7Ua3ume/kS4Hiqtk
         Hb/mH3AY5Wljwc0mKnkv1OkGYcqojcnjlO2/eQfqJbBtL632D6wNcfWz0NP+hsR1JyXC
         RAxEeoowqwNYx6XD8CUFKzqBQsMVFSfW6z/mhVrzX92m7cGdfnXrXEH59CarFhYduIlw
         yX0tLDVvsoDvSoZSh+/A9JN7J3+B/Gp4pCKOB4nLeiuRRNMpmDz4AWsOpINvPhc8Clbp
         95j8e5QviieTr3Bh8xkaE9JW1F5Tfs49/DvhYIq6sOTi0ZMhmnTXiGNFh/Mo2cgueuAq
         UtSA==
X-Forwarded-Encrypted: i=1; AJvYcCXVOJUxAeqeqmDPO/srnSURppaJL3n/xdC9nszcXa9ecZkZ9cZk3rTBAWPrviD7WcRGNfULGb/Tk00H@lists.infradead.org
X-Gm-Message-State: AOJu0YwIoNWXrxu4YXDgl96+FfI68cjuPixCTw80Zfv1KOvb4ltJaQrS
	oNq6f2kx8XoIYfUni6FEat3JSwnlyktE5XgEYnMaTbNiNk8ZSeCGtP8j
X-Gm-Gg: ASbGncuzJ6sai0d0jB/BaGwUIq+23983H1kgFR4BzpJs3j3rgHQTVGwcSa56/I8A0bJ
	BIwAhUqDoUACGdIx6qVHaw/YCQ/mHa/9QIuC0FGtkQTbQ6Hvrfaz+zM5Re8GbZrzwnJu8B0JNEH
	tcJuFxJZaY1Xn7iT5d4YDGBdk9uogGsVrF2PRTfYu2NfoewvQ3b9H8FKoUI2UGQMqFCnWVHiRzR
	f9x+Z2/7zBlQrGBYcJMGDwaPL5I8wudUuNPOECv0pWzWpfdB456C9gXdv8DG3BU56CGX6bbyIDY
	KbMurU6oxOpW/7xPoMCyTbLwdDls9Oin3wOKdWmqMKhIBxYDfddxZ+qgE0n6v65LwO8IndavmaO
	U1sqmEUPO5Ohvd1/ct+G84Y2rbwCrfTz9VuRa5Dbc8ooRNMKUNldPwXF4JuKSWX2g0FTlY20Iwl
	IoKzfRiKsaASK1Q56uZCd+XLVTtLLr0y6YpXqJ1ErhXQDFNZ4=
X-Google-Smtp-Source: AGHT+IEmMLANDAnmsBNCneTvCZSlRusetXy+m9HCywmHN66AM/499qf8PoyOZ4xW94y10CRf7NdkQA==
X-Received: by 2002:a05:7300:538c:b0:2a4:7cb9:b7da with SMTP id 5a478bee46e88-2a71927d85amr6563682eec.25.1763953068821;
        Sun, 23 Nov 2025 18:57:48 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm67532109eec.2.2025.11.23.18.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:48 -0800 (PST)
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
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 4/5] f2fs: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:36 -0800
Message-Id: <20251124025737.203571-5-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_185749_771512_BF6FCEBE 
X-CRM114-Status: GOOD (  11.79  )
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
__blkdev_issue_discard() call tp err. Move fault injection code into
already present if branch where err is set to -EIO.

This preserves the fault injection behavior while removing dead error
handling.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 fs/f2fs/segment.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..3dbcfb9067e9 100644
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
@@ -1360,6 +1354,10 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 		}
 
+		__blkdev_issue_discard(bdev,
+				SECTOR_FROM_BLOCK(start),
+				SECTOR_FROM_BLOCK(len),
+				GFP_NOFS, &bio);
 		f2fs_bug_on(sbi, !bio);
 
 		/*
-- 
2.40.0


