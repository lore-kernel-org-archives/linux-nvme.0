Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EDDC77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6btso1L71pcY+YPY7KZNXSdrcfDyGPFY3TrsX5cprdY=; b=dkbl4iX0U8QKMjvWsTvSV04uIG
	YJCbt0ia9QTaLAnYWUbu61Ww/yc4Kon2H0TnbrmjQ/rXVNNrDLbxOsQqITH3EWpeZzHWtkeeGYREF
	Kqa8Y58sOCXXkVG7hlblV27qZxkOCo5n0+GeGgOVfUDXRgyq1SFYyZ2/p+mGzbGg82iOfIkUrLaLM
	yt0H6NDrQY/2+wDgQQYyRGt7xklVxswdm+El4KwFls/IOqCPiV0+BIS7wlV7JhDfAhjV41GikJElE
	HiAnaOSuzkSuoXaIllUZPVrg7ieCgt95xYRKuUxit2TivD2pkro1sswJntlcOWImsgmATE3fhx84W
	Zv4MIG9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp54Q-004wRe-2m;
	Wed, 19 Apr 2023 10:29:50 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp54N-004wNE-1D
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 10:29:48 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-2efac435608so2857246f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 03:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900185; x=1684492185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6btso1L71pcY+YPY7KZNXSdrcfDyGPFY3TrsX5cprdY=;
        b=ZcW70WE5jxDe1BcTTbt15O0LCxy8AoLhXpp69THhFRdOfEuxwL3fjO110rJcMQ9LYB
         ccXAUYHfnxTlCB3/g3gB1nGz4w4c2u4lvppL8eQfsXPN6Ys7PyHfZG45Wlp6AknWTbS4
         G/hb+6P91XemAsX3hQ8w/yLCERE0oGZ97AYNi6tWBGn4lNRLAYree32hkYdHtscJB1ya
         AabEpP5osfpZ9pMp/sTb7W7MbkGnvyYzVcUokg0gWchjdyz4RbkHFc7jR8MnnkgpFdNh
         AJ8bWSMuK0atoj/y7fGUxb2px58zDCrH9I1u5T4K9M/6XQh4KP8Rkk2Im5SCvmG2Qztv
         eEsw==
X-Gm-Message-State: AAQBX9e7q7qy+kN7X4EeO6fu6dg3SfX2t8fGv30dtU87prf1EbylQQUE
	tT7uH0Jk3Ryp8HxWYAY10mo=
X-Google-Smtp-Source: AKy350YSXaxkNwcYpcVtkau7hNF6PvCrlceUhslw2AjAfKL1bNW7FBp7Icj95GLJy/s3X+EAgGXR7A==
X-Received: by 2002:adf:f9cd:0:b0:2f0:833:6acc with SMTP id w13-20020adff9cd000000b002f008336accmr3427087wrr.61.1681900184647;
        Wed, 19 Apr 2023 03:29:44 -0700 (PDT)
Received: from localhost (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b002f2782978d8sm15333574wru.20.2023.04.19.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 03:29:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	axboe@kernel.dk
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	ming.lei@redhat.com
Subject: [PATCH 0/2] io_uring: Pass whole sqe to commands
Date: Wed, 19 Apr 2023 03:29:28 -0700
Message-Id: <20230419102930.2979231-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_032947_420425_7C184BB1 
X-CRM114-Status: GOOD (  10.65  )
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

These two patches prepares for the sock support in the io_uring cmd, as
described in the following RFC:

	https://lore.kernel.org/lkml/20230406144330.1932798-1-leitao@debian.org/

Since the support described above depends on other refactors, such as the sock
ioctl() sock refactor[1], I would like to start integrating patches that have
consensus and can bring value right now.  This will also reduce the patchset
size later.

Regarding to these two patches, they are simple changes that turn io_uring cmd
subsystem more flexible (by passing the whole SQE to the command), and cleaning up an
unnecessary compile check.

These patches were tested by creating a filesyste and mounting an NVME disk
using ubdsrv/ublkb0.

[1] https://lore.kernel.org/lkml/ZD6Zw1GAZR28++3v@gmail.com/

Breno Leitao (2):
  io_uring: Pass whole sqe to commands
  io_uring: Remove unnecessary BUILD_BUG_ON

 drivers/block/ublk_drv.c  | 24 ++++++++++++------------
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/io_uring.h  |  2 +-
 io_uring/opdef.c          |  2 +-
 io_uring/uring_cmd.c      | 14 ++++++--------
 io_uring/uring_cmd.h      |  8 --------
 6 files changed, 21 insertions(+), 31 deletions(-)

-- 
2.34.1


