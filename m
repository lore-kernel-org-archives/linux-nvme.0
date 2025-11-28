Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD97CFD376
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NqrU9sAvwHlZJQNnImTr6s/wIfO8kcl//WUqMA/q7Cw=; b=DTW/TUYoYsX5J6XzCwWKp31hmx
	R/OlKh8nI5yCqWrxm1qRU+VGMFJS8AJ6mCQd+HknXomnrSbo4+YQqRggEnRtU29Jm+B0DIO7w89im
	TjqCr7CfD6KasI47mCUff1D19ec957Y7vOg4H/ROF/2BLYI2PWZeZRJJnfKoau1LEDtSZvXo6Wt9s
	z2GcEfo/I30Q/4kE3o56+ZqeROXvB+AMTS/KTz/DCg1Ko7w+D0VHzrRyeSp07h1yUbu/NlsHrDZm/
	O7Tx8Fx7CfvS7HULmgbjP041+/Z4Ef5PNbw4QMlmRJ2cYjmYxdHlM9a6kYxIqHu7NYJYUtZb25Owm
	fIuLImSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuD-000000009Fh-1GvU;
	Fri, 28 Nov 2025 08:32:41 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuB-000000009FJ-0AGv
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:32:40 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7ba55660769so1359354b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318758; x=1764923558; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqrU9sAvwHlZJQNnImTr6s/wIfO8kcl//WUqMA/q7Cw=;
        b=Heaujz7ToMhvRq1TA7rzHuyKsUnnP4COMaXYzVdlq7vsw+W8pM+bctOLlnunEPCJA3
         duNpQLJQgzawOLs1YZ/KVPWmdZGyDWGt1q1x3YdIWzom276wfTShfaDWXr5FwvP5CyW0
         7+PpcPN3cgoXl4Yi8XMmAH5+t2425AjNBpV05AfwA2oCNBGu2vf86c8tToJHCgyWmkLk
         WD4674ImkjyTk+0gYOiI7Ok7VDzx7xRwbd9NChtVCU7++Noox9nHdissoke78UrYFCE7
         xEM9vqSLb7qVlNr96M2RPPd0w/NBET+UTwMZP33/vz+79WgkVTZ784gTWQgl/+3/dFoR
         BzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318758; x=1764923558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqrU9sAvwHlZJQNnImTr6s/wIfO8kcl//WUqMA/q7Cw=;
        b=Hw1K1KgCqoKPKuiVe+es1R4dwhBvv1qlIxtygdrah9HCjYA9Y4ypC5ayMyel9NH1qP
         L5/0eLvHGdq9oeQJz7DI+SoxgUUSUq5ooYSmMX+2SfDI56oyRD7oYoA4+Pmo7PJweuq8
         n+fJ5JwxzsUIyFpyYZVKzsBZeSOig7fLmn+g2pTe1YTp0uyQb7oCvKLW1ZfvGbJNx/Zd
         XyfbqoSpzkCNfldyJFWb96Qmpf8GOprBKZRIRSXtSj33Y7cGsWMk660un8TaozJQkLvl
         D3+3QpJBDR8733cc3he4kEbt+zAi/JZc+fXCCeBKQhGurecJiSeTDJqJFHbafCC7lg2y
         jgHw==
X-Forwarded-Encrypted: i=1; AJvYcCV4TyYl7sMaM4h4VidxtvVN5+tShXABrdJsrf4e75yNDTUThfpRA6hZsti+aeiKCweBK+ttFV9xHcX9@lists.infradead.org
X-Gm-Message-State: AOJu0YzahdAcbJWo3EHs9oDCBBQo+G2gE0sT0c9jpyzocQOhNJkYH48m
	MOo2gXr4cE/L5Dbv6iWjbgPIxQO7ZLyImWwxozKg8nXnXMDw8UPrbL7B
X-Gm-Gg: ASbGncvPDEFvbwivBHom9KqIOsdrRTgphkwT6K20QfGbJH9mPU2HpWgFiO3H8ca/3UP
	kwJS7kv7K/WLZSLkK+mX4xf0PN1AQDexVwJaBny0RzqVQxPDpIZWnHRDWlnddHqGOyofbDxA6Wh
	slCtB4PvfOf9csF1iCZX6zL9YsXbF364a3SIS+Cs7q2tpELnZChHV8Rm4ssGJ09KY5JwgMbsscH
	1G5MzNGZI3HaHP6zlaLWywuSMHD4WAwbkWHbchBecUG4HWyre+a2jDM3gq1OPnz1nSWcWa/mVVo
	hO6es1V6sIGwSsjOEnYf9dSJvADJG5jcmq9633PtPfeTKSuOJNLEXOb9g28KaeNpIYB97mq9laK
	geqPcKhx/0S6DcOVgvZSHa/j6kjuIrs3N/AYxhfBWh+bNKRfLO6UMCRDWPwJZJqI7CawfrSgt2f
	YnJ3uBwP/PnsFKazAnI/kkABwplQ==
X-Google-Smtp-Source: AGHT+IHdakmTE4ccsFNQ1yLU+VXJurH34ar1nC0le8zm5bpThSihG4vDxPqEawqzf6sYQkBphfQIBA==
X-Received: by 2002:a05:7022:ebc2:b0:11a:e610:ee32 with SMTP id a92af1059eb24-11c9d85f282mr16086363c88.25.1764318757636;
        Fri, 28 Nov 2025 00:32:37 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:37 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 00/12] Fix bio chain related issues
Date: Fri, 28 Nov 2025 16:32:07 +0800
Message-Id: <20251128083219.2332407-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003239_083202_8E4F2016 
X-CRM114-Status: UNSURE (   9.01  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Hi all,

While investigating another problem [mentioned in v1], we identified
some buggy code in the bio chain handling logic. This series addresses
those issues and performs related code cleanup.

Patches 1-4 fix incorrect usage of bio_chain_endio().
Patches 5-12 clean up repetitive code patterns in bio chain handling.

v2:
- Added fix for bcache.
- Added BUG_ON() in bio_chain_endio().
- Enhanced commit messages for each patch

v1:
https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.cn/


Shida Zhang (12):
  block: fix incorrect logic in bio_chain_endio
  block: prevent race condition on bi_status in __bio_chain_endio
  md: bcache: fix improper use of bi_end_io
  block: prohibit calls to bio_chain_endio
  block: export bio_chain_and_submit
  gfs2: Replace the repetitive bio chaining code patterns
  xfs: Replace the repetitive bio chaining code patterns
  block: Replace the repetitive bio chaining code patterns
  fs/ntfs3: Replace the repetitive bio chaining code patterns
  zram: Replace the repetitive bio chaining code patterns
  nvdimm: Replace the repetitive bio chaining code patterns
  nvmet: use bio_chain_and_submit to simplify bio chaining

 block/bio.c                       | 15 ++++++++++++---
 drivers/block/zram/zram_drv.c     |  3 +--
 drivers/md/bcache/request.c       |  6 +++---
 drivers/nvdimm/nd_virtio.c        |  3 +--
 drivers/nvme/target/io-cmd-bdev.c |  3 +--
 fs/gfs2/lops.c                    |  3 +--
 fs/ntfs3/fsntfs.c                 | 12 ++----------
 fs/squashfs/block.c               |  3 +--
 fs/xfs/xfs_bio_io.c               |  3 +--
 fs/xfs/xfs_buf.c                  |  3 +--
 fs/xfs/xfs_log.c                  |  3 +--
 11 files changed, 25 insertions(+), 32 deletions(-)

-- 
2.34.1


