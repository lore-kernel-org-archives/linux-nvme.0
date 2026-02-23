Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BFDEC110E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bvVS//J2RIviT1EM5PNeofKo+JkNGh+uX8BdQ0DJA+0=; b=FVRl7HCpfxFKyQ+EyL1IZvAX8+
	O04CS0DMHyyrhB137Eur62UeKgAVqQXxznaGMVBlrePW2AlWf0uYD9qzLokiC5i0QPryqhqYomqup
	V83bJurd+PCqd0kw0ct+ITjQd4EMXk4wmWXg/Xy10umurTyQD54jCwwlhlIqvhxhigph/xUjUQrW9
	PlUzx4H62HYkISDOD1FnRig1AXu2feuj8FHhSM4mkszOJ0hFdiVSlEEfhP69RQLhkr3e73oa3YXe/
	lrH+Xu+9dfi+uVUb9BKMqeJp3/1bgYwiM1Pzpn74RUxCJxt6UNEQRjbaFnRG9X8RDHq79FTpvKyTW
	GWLPVrjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZfL-00000000m5x-2oXF;
	Mon, 23 Feb 2026 17:24:15 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZfJ-00000000m4p-30cj
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:24:14 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso2318157b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867453; x=1772472253; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvVS//J2RIviT1EM5PNeofKo+JkNGh+uX8BdQ0DJA+0=;
        b=ljt4+biBsHX1XNmw3J986ukijUgJpU6Aczze5aVtRgtnxVe50Iu9ucmB/cer8/BSp4
         94rmkzBV3r4gteelN3lfDEpJTwoG+I716ci3nfgw5/sn33HmQBSVemhWACY20P41F6p+
         Tz4gBfNwPbRDrSJ+664uz88e+yabmmEIeoFG6Ir0pCCiTkSFuKmRmrFjVbvzOf9GZmZS
         ZgElhRnSGpvy2JuAQ/EB6K5FTHDVkIDY5OFL/IaQzH5RbpIgqD4NOHZbRM0cC1svX9vf
         AxGS+DU4dUan9MYVolK9XRsiQ9FoHYGGaetIktweFYBwH+hIdJbpG+vyxBCjLFE1pCAN
         kMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867453; x=1772472253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvVS//J2RIviT1EM5PNeofKo+JkNGh+uX8BdQ0DJA+0=;
        b=qpVvk1dsKbau6J9qYjUjdaoPp3ptMxngyrFecGjQL1CAMU7tOQfP2PjONH8LJ03T0n
         +qyCUeBTNrN3Fy2L78KaLiPBD5Pe2ZLVDYZFSwOdHg2giv3lBB0GfOQs9O4ZqyzDe4HE
         O9vtUCSEFQ8wk3Kl+muLtRO7NsUBTbmZq6HshnMDRKkwgcH57BVGvVGtuLFvEkKUKB7m
         EuUWAmsB7nnbrqJOaiT9x8R5/qD0zpvizXCCzLCrye5HNUrt10jhCN4loqW1DXsuriSP
         y5KlyfoyXGbt7k3P3pT8WXUgKVFNOZyINr5+VoTiPhvDXxEgT/Fyj/J0Z4kZ2T5oRmnp
         5FrA==
X-Gm-Message-State: AOJu0YzctVTya8bHu2QZllYSwLakyYiUIVr6BfmAiKhF+WDH9phxocIC
	yC590Dd+7oNLVrUu3uwXGsJB/r0e73pOBnMZ37kgAKIPhDiotZPZpzy6KpTd11Doryg=
X-Gm-Gg: AZuq6aJfSrvG3o5A4DvVOF/3ieVYw23jyiMGln5HIDw5rgNJ1Qf3y4YnSTa+9JS3Hie
	iSZgc+6O2UuOJw/E73EGicAXWtsNuuVnq3l4P9+9t2kaQvpxZ1ED0ng4KLNTvPOTvUn1CqIXzzh
	qQG4Kn1381rY+pd67fxS6Frbcmgq07ZPUMn/Or24xsYKKbbYgtHvuejkfO6jlOGrv7PsM14cAPD
	PDMRUbIT5zJkKsJvCmP3ecaJKOmpYY1FnURyzt+/GjaY9l9g73k6g8Y3jIzfimqjHBGWx2ToCao
	8CGITBz09Ype8HXaj4J7cjBcIGsOLs7acwCvSkFz12Pdd4kYJvhbXjz2NEPE9GiQrLtU/1zwzpC
	kKzHoR/6oeO3W3NnpWdPGR4ZSgzbWFY07tHLKcPbFlhWETYhhqsI0UjWEb+pIsShPZnbfC29nU0
	YytF40IjLno6HSuige6EB/IDhDlFdwDNo=
X-Received: by 2002:a05:6a20:2593:b0:38e:9ae0:3d5f with SMTP id adf61e73a8af0-39545ea4176mr8013265637.17.1771867452758;
        Mon, 23 Feb 2026 09:24:12 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b724321esm7802332a12.16.2026.02.23.09.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:24:12 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 6.1.y 0/2] Fix incorrect backport of nvme-fc ioerr_work cancel_work_sync()
Date: Mon, 23 Feb 2026 22:54:03 +0530
Message-Id: <20260223172405.292040-1-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_092413_752072_0FD21A17 
X-CRM114-Status: UNSURE (   9.79  )
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

The backport of upstream commit 0a2c5495b6d1 ("nvme: nvme-fc: Ensure
->ioerr_work is cancelled in nvme_fc_delete_ctrl()") to linux-6.1.y
was incorrectly applied as commit 3d81beae4753.

The original upstream fix moves the cancel_work_sync(&ctrl->ioerr_work)
call within nvme_fc_delete_ctrl() to after nvme_fc_delete_association(),
so that ->ioerr_work is not running when the nvme_fc_ctrl object is
freed. However, the stable backport mistakenly placed the
cancel_work_sync() call in nvme_fc_reset_ctrl_work() instead of
nvme_fc_delete_ctrl(), leaving the original bug unfixed while
introducing an unnecessary change to the reset path.

This series reverts the broken backport and then applies the fix
correctly.

Jaskaran Singh (2):
  Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
  nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.7


