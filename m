Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642E9CFD35F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 23:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L8zwVcuAssRnEQZ8e7ewIMIsPfvOXMAA4RWGmHyZ+Rs=; b=K/3ElSIcazyeLv1eGBtp5Np11m
	masoz9AsOaV/XP3SlNN6CieoMgnlxgH5Ifqj3iuy0E7ViKYScBA9im8ZqZrSylp4UAohnXTAXjws2
	a0HDzQTdisE+yQmRhXgYN85m6Rt3zmqiNKyFcUTSNCkQ3lRdZRBiSV1knuREIfTBruu0qEUWzRg5i
	OcX53pJg1qnHnXAPAtn6VWZPV6xiT1scHeLmsB7QXEH3Ym2GEueB1e+54lImanhiOPgn5KANemcjf
	ydwIBAr1K3YHJbK1EbdHIywuz/wnBvaXq3Yz2coHXCSOpIF/KyawbTnfhQd9X6Jy1hya9LSw2+3xt
	XoeLe7ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIB-0000000CTaR-3YM5;
	Mon, 24 Nov 2025 23:48:23 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIA-0000000CTZi-1Qtr
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 23:48:23 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-297f35be2ffso73563905ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 15:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028101; x=1764632901; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8zwVcuAssRnEQZ8e7ewIMIsPfvOXMAA4RWGmHyZ+Rs=;
        b=B1dgdRRA+k8IUzCvQgNpKTiq7pYA3mj8K93jC00M59NVKXmMCJsyyelSaWm3hMd0fc
         qDh+COmX4GTwTusr44+n7DjWouZUJvZS7kQVxodaPKcu4PhIsRijXusXPWSMsJdLQ5zR
         wUVK2LO1UV5OJyl3zcK3yCIA0a3r5VFwe0gKyGKpUNMAtDpDH4yy6MAciB1puOpbedMW
         imjuXOsoZqgKbXPAT8Cnh3itqHUpVfJigtYsN4AkBW4iITDoDP5ft1XNhS72dJa1ClcH
         9H811X2M3Ok0OdWdyC0G7eGDzYVPq4eA96LzLROyVwPI6iKQNHaM1VbRAkxUTSoLlnDW
         4rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028101; x=1764632901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8zwVcuAssRnEQZ8e7ewIMIsPfvOXMAA4RWGmHyZ+Rs=;
        b=X6rwg8F65tVhVYs4Wq5iSs7ply6WWr6oKtEJm+cizSJ6aWpzRKUDjmh+OnVq6GK9Vw
         3/Obc+2xmB6nDnXKPI/g0zyXnC4tGserGFxXXj70Tf/tu7hGN9YtY7Q3/0HgkxHhdRM/
         xEC8dn3wlmtf8HBcd3hSR5fBkWZPD+0zOCIguElH9OS8IfKwXMH42gYsnYTdBnTT89/r
         FOwoN3nLyxOMrkWSFedqxPVzd240GDFlDNUlMu8LdCYDsXTjT80BjF6g7yCoQ4LvF6n0
         A6ebQFQBNM9FMP8DHm6WfVz493265Ka79X6wsoj08xav/h+fQwFxsun8+VQE+oBa1Mws
         dmvg==
X-Forwarded-Encrypted: i=1; AJvYcCWd9cwlAohS395EluLEnhkpuqNxDUJ3tkODAl5OB4EuK3FsvDfhKCJ0WveKe7sgzH05ttxLZXPXMI0K@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0QuPhKCnhBMsowZu8NAChTspPxuDKBOSgnnaFAimZzymxyp4Q
	80ESa9VSN57jUkOhiJAuSOk28ckTVgbdkgMTnuP4riehx+JtBFb3fseb
X-Gm-Gg: ASbGncuauns4FrjOH6RG9ta82qPDxCSRJbo4+Pn1IfM4rN60+xRsMdz5wTRxUXRFlyg
	oRI++/YlyPwBylJ2m74K4tGdlchWv/1GumRrq13QXHGDutSzCfMstRGk+/bqb7TZAeFiDeuHmY7
	aibihSoEbJiFJaECnvnCASsRg+7/2K7WyxbOWygj+k6HNmv0gWN6CLhK1Nn3+UnEa+/ttKZFyHd
	Ff238JuMyaCVUY+DBtlNdiLH52Htkz7viqdkDQ47Uo+/HIX35MsM0FJsto6IjhWL2/mGqHPG4Lt
	HD9VSV8OYTKxh8PbJ97edL5UMAqySENde6phZrcqyaSylBkCKNIKEupvCbJy+RhGRelrTHLb6GO
	uqn85sbNnRb9UQLcwvqVqn/KNUfgjVuV23nJZp41WuUK6F87qBmmQNh56hF0OgPPhN6lS17cHrl
	vQj9+dOfyX9PAQhz4izfckdf/q8Nth7Pj43MvQ0wqkAV5Czek=
X-Google-Smtp-Source: AGHT+IEWVgvs7HfQh1Jftv0/sg1EMetPp1p1pbe1p7lp0IBRgw/xws/S7S4QHSHoK5/x2kKFyy9WJQ==
X-Received: by 2002:a05:7022:1093:b0:11a:2ec0:dd02 with SMTP id a92af1059eb24-11c9d85fed4mr7996088c88.33.1764028101157;
        Mon, 24 Nov 2025 15:48:21 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db556csm74670928c88.1.2025.11.24.15.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:20 -0800 (PST)
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
Subject: [PATCH V3 0/6] block: ignore __blkdev_issue_discard() ret value
Date: Mon, 24 Nov 2025 15:48:00 -0800
Message-Id: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_154822_420964_928B7D13 
X-CRM114-Status: GOOD (  12.48  )
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

__blkdev_issue_discard() only returns value 0, that makes post call
error checking code dead. This patch series revmoes this dead code at
all the call sites and adjust the callers.

Please note that it doesn't change the return type of the function from
int to void in this series, it will be done once this series gets merged
smoothly.

For f2fs and xfs I've ran following test which includes discard
they produce same PASS and FAIL output with and without this patch
series.

  for-next (lblk-fnext)    discard-ret (lblk-discard)
  ---------------------    --------------------------
  FAIL f2fs/008            FAIL f2fs/008
  FAIL f2fs/014            FAIL f2fs/014
  FAIL f2fs/015            FAIL f2fs/015
  PASS f2fs/017            PASS f2fs/017
  PASS xfs/016             PASS xfs/016
  PASS xfs/288             PASS xfs/288
  PASS xfs/432             PASS xfs/432
  PASS xfs/449             PASS xfs/449
  PASS xfs/513             PASS xfs/513
  PASS generic/033         PASS generic/033
  PASS generic/038         PASS generic/038
  PASS generic/098         PASS generic/098
  PASS generic/224         PASS generic/224
  PASS generic/251         PASS generic/251
  PASS generic/260         PASS generic/260
  PASS generic/288         PASS generic/288
  PASS generic/351         PASS generic/351
  PASS generic/455         PASS generic/455
  PASS generic/457         PASS generic/457
  PASS generic/470         PASS generic/470
  PASS generic/482         PASS generic/482
  PASS generic/500         PASS generic/500
  PASS generic/537         PASS generic/537
  PASS generic/608         PASS generic/608
  PASS generic/619         PASS generic/619
  PASS generic/746         PASS generic/746
  PASS generic/757         PASS generic/757
 
For NVMeOF taret I've testing blktest with nvme_trtype=nvme_loop
and all the testcases are passing.

 -ck

Changes from V2:-

1. Add Reviewed-by: tags.
2. Split patch 2 into two separate patches dm and md.
3. Condense __blkdev_issue_discard() parameters for in nvmet patch.
4. Condense __blkdev_issue_discard() parameters for in f2fs patch.

Chaitanya Kulkarni (6):
  block: ignore discard return value
  md: ignore discard return value
  dm: ignore discard return value
  nvmet: ignore discard return value
  f2fs: ignore discard return value
  xfs: ignore discard return value

 block/blk-lib.c                   |  6 +++---
 drivers/md/dm-thin.c              | 12 +++++-------
 drivers/md/md.c                   |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c | 28 +++++++---------------------
 fs/f2fs/segment.c                 | 10 +++-------
 fs/xfs/xfs_discard.c              | 27 +++++----------------------
 fs/xfs/xfs_discard.h              |  2 +-
 7 files changed, 26 insertions(+), 63 deletions(-)

-- 
2.40.0


