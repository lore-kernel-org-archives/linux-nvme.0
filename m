Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BB2C7EE2C
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c/WsGoeYdsta1UG6dgZw3dmI3fN5/OIDDolXmg/WRRc=; b=N2sVa9g+vTgJEaeGc+4keYDmbP
	LdFjGKBz34al0R8V2Fzc+Iegg9Y8CeIS8xAc0/nxcCCa0Ao7A+xbAGHCftaJTeiSkgVrI24bjAVs0
	P4tn+0QBuYxwXlx87sSh+srxuYVURkaiZtiNcjaLd20QMEol2yiAmrMK6rP2SOJzQfxEPNJdQNNtP
	bXYmw5sJN7+tDMjcrmr9RgqSDEI+vVrJPCo4u0/4Z52IsXsiezJolZzsZdPCKaumxeHpMaYJrz1oZ
	QglgkyvHIwvhzYJbKIq+XvKz7F4TXLbaPl44SoQlv5yGLfo4bk7bsU+DXRBGF492hPudeJTZsZndo
	c33Cphxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyXlr-002BiQ-01;
	Mon, 15 May 2023 12:57:47 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyXll-002Bgq-25
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 12:57:42 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9659e9bbff5so2356576466b.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 May 2023 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684155458; x=1686747458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/WsGoeYdsta1UG6dgZw3dmI3fN5/OIDDolXmg/WRRc=;
        b=YU4eezWDd4O8MqB2M3V8utHWot7vHfTtP2uaqLS8d8wnxLQAU21hnJqPw7DOSQXoGS
         Bj3ryWBSX23baVEAbWvm27PTEdtODNMMXOb+rcJSLg6VAR/dwZr9sceBWMvIKwu24wWi
         vjSBiayGlYXtaSTGriB2o7b7yKpvFA2C5Hphe9C4xvSU5fGJh+VXKxEZxHGzYs1cfiov
         1dQyVezaNuVQhSLgzaUx2ZYWMZfQockOKQOtTRx0KTJ81RgkReS01eT+DBKUB1db8kH3
         LTPe7fqBXTL//cvJ75olUmcU0Feiz6kwgYNWKwwPYod2J7NkycnD5vcePClf/qzck4Y0
         u8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155458; x=1686747458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/WsGoeYdsta1UG6dgZw3dmI3fN5/OIDDolXmg/WRRc=;
        b=mCKr6+w/SRWxTLy6yb4JNGFxLtP5nzYSX+XNtS1pghcVNzqkumOgYWB4+PiW9Vl3DZ
         +piEfH3WhXQfJHzIaPXhunoCwb7JqShuty/4JL+PDsJPi0GxPgGrLsbrgm2b/uRTqUgX
         T9Bgyg8/plguUlLXguOYT2JgXIDU4Jb64PTm/LyvRyWNRtjMBFQaVhPxm7kBhXS/o2l1
         7oli0m++s+C6Lt5ywshq07SjMkbwOZATqIbDpCdQdJD/zyQGnpz5xg9r2oENSBb77UpV
         A2fVLdqo2EsFPdPIwKLuZOXWKfHjHPeNEIdPf9/DpSeV7W0+lyZRppxUmUpDN7v0OLqR
         4V7w==
X-Gm-Message-State: AC+VfDxoDhNIZIsRUP/Fg55Fljb29VbgH1WxMym9G2+p7O8d+rwbT/Mj
	Xwuva+gPG4e2dYp1d6kWbzj05hiFbYc=
X-Google-Smtp-Source: ACHHUZ4TEnFDdtXxeZc6ughmF/ZD5RUK/PID1KZQLAzF4qZ5PJ3lyI+mF6zlYitrqJDanrOFDFYZdQ==
X-Received: by 2002:a17:907:3f25:b0:969:edf8:f73b with SMTP id hq37-20020a1709073f2500b00969edf8f73bmr23011931ejc.60.1684155458207;
        Mon, 15 May 2023 05:57:38 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::2:6366])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090672cd00b0096ace7ae086sm4003685ejl.174.2023.05.15.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:57:37 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	axboe@kernel.dk
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	joshi.k@samsung.com,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next 0/2] Enable IOU_F_TWQ_LAZY_WAKE for passthrough
Date: Mon, 15 May 2023 13:54:41 +0100
Message-Id: <cover.1684154817.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_055741_683555_FDC4098A 
X-CRM114-Status: UNSURE (   8.50  )
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

Let cmds to use IOU_F_TWQ_LAZY_WAKE and enable it for nvme passthrough.

The result should be same as in test to the original IOU_F_TWQ_LAZY_WAKE [1]
patchset, but for a quick test I took fio/t/io_uring with 4 threads each
reading their own drive and all pinned to the same CPU to make it CPU
bound and got +10% throughput improvement.

[1] https://lore.kernel.org/all/cover.1680782016.git.asml.silence@gmail.com/

Pavel Begunkov (2):
  io_uring/cmd: add cmd lazy tw wake helper
  nvme: optimise io_uring passthrough completion

 drivers/nvme/host/ioctl.c |  4 ++--
 include/linux/io_uring.h  | 18 ++++++++++++++++--
 io_uring/uring_cmd.c      | 16 ++++++++++++----
 3 files changed, 30 insertions(+), 8 deletions(-)


base-commit: 9a48d604672220545d209e9996c2a1edbb5637f6
-- 
2.40.0


