Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F3DC7EE23
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r3bfwAGdzZox0nAzfwe0N1qLqTcM9TeHkTSwpiTSRY0=; b=Z6Y9SmoNCcMOTdCr0H9n6C9doC
	niDvo0smFkx7GOeXee+pufk+uoXnTysch2hIkSY6GP8xaLmTwVxc5+j6N68w9K/pyYU9L4wsjFAgZ
	OLpsC1eMaJtt+wbR8AK9/42zBc/WufL3V8H2lCi681aY7DvHL4ch3d3LlK/LtDla333j9BBMnPRyX
	F6pHPiQ1ENggSxFpNUqPLW5Dm4q9QO2vZeiufXY8xBWFZTi1GcmT0/JdhP5rckxFYHeN40K9yCyGD
	lhgJpQSAnagkAyzPZ9u3buJDiRP/9xqzS5CDdPMpa2sRKqB1FpxvavlzuBgFYpKDf+TUhfiMhtM3M
	nGRVh/Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puXvR-007oGB-2o;
	Thu, 04 May 2023 12:19:09 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puXvN-007oDy-23
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 12:19:07 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so4355545e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 05:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683202744; x=1685794744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3bfwAGdzZox0nAzfwe0N1qLqTcM9TeHkTSwpiTSRY0=;
        b=j/SU0kfuvB0QwIlMm6qIO1wuGzKllAq5aTQgA6+hSahh4P0BlZ23jBTxpeI6HknmUX
         fkh9MaVEZnC6Vy110PFisHVa2XpN9HtdUXgb5RhYKeAy00obEVQkuKp9ZJbHop0lHL/F
         2mUrYagm+YQPGlCXlrwJsLH9XpktBBXfBOKDHTjCqodSf4RwgFMAk2PxcGLQlmfX+hFc
         ybbWLVmaRAadwS8d2G5nU07DafhJpIcz0vmdJ2bsUzzfYTuoBR/vAngdr5J6kO6Quomg
         0YNUSDX7MZNk9liWmhzC1HIaIeNcSqS0/ofPRhySzMT7gY/JhRN/PPhzJ6UMfnaZUqw3
         0y+A==
X-Gm-Message-State: AC+VfDyKWkDOxh1jqmN6EhlEfZ8+900flKNh4p2bALmiH9wM0P3Oc7IK
	iEmj3Lq/aqX8SKGGryraOrwJuvTKsBSkWw==
X-Google-Smtp-Source: ACHHUZ7+aTJs+OA6fdjH1WYQZ7Yvv4IhxhIXgBxFX3f1gp6uaNWvciZ8ApcS3InCHVUXHdGLqFWDgw==
X-Received: by 2002:a05:600c:2941:b0:3f2:5777:27d4 with SMTP id n1-20020a05600c294100b003f2577727d4mr16631789wmd.25.1683202743592;
        Thu, 04 May 2023 05:19:03 -0700 (PDT)
Received: from localhost (fwdproxy-cln-023.fbsv.net. [2a03:2880:31ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcc0c000000b003f17848673fsm4821518wmh.27.2023.05.04.05.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 05:19:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	hch@lst.de,
	axboe@kernel.dk,
	ming.lei@redhat.com
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	joshi.k@samsung.com,
	kbusch@kernel.org
Subject: [PATCH v4 0/3] io_uring: Pass the whole sqe to commands
Date: Thu,  4 May 2023 05:18:53 -0700
Message-Id: <20230504121856.904491-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_051905_676060_0F51E438 
X-CRM114-Status: GOOD (  13.26  )
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

These three patches prepare for the sock support in the io_uring cmd, as
described in the following RFC:

Link: https://lore.kernel.org/lkml/20230406144330.1932798-1-leitao@debian.org/

Since the support linked above depends on other refactors, such as the sock
ioctl() sock refactor, I would like to start integrating patches that have
consensus and can bring value right now.  This will also reduce the
patchset size later.

Regarding to these three patches, they are simple changes that turn
io_uring cmd subsystem more flexible (by passing the whole SQE to the
command), and cleaning up an unnecessary compile check.

These patches were tested by creating a file system and mounting an NVME disk
using ubdsrv/ublkb0.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

V1 -> V2 :
  * Create a helper to return the size of the SQE
V2 -> V3:
  * Transformed uring_sqe_size() into a proper function
  * Fixed some commit messages
  * Created a helper function for nvme/host to avoid casting
  * Added a fourth patch to avoid ublk_drv's casts by using a proper helper
V3 -> V4:
  * Create a function that returns a null pointer (io_uring_sqe_cmd()),
    and uses it to get the cmd private data from the sqe.

Breno Leitao (3):
  io_uring: Create a helper to return the SQE size
  io_uring: Pass whole sqe to commands
  io_uring: Remove unnecessary BUILD_BUG_ON

 drivers/block/ublk_drv.c  | 26 +++++++++++++-------------
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/io_uring.h  |  7 ++++++-
 io_uring/io_uring.h       | 10 ++++++++++
 io_uring/opdef.c          |  2 +-
 io_uring/uring_cmd.c      | 12 +++---------
 io_uring/uring_cmd.h      |  8 --------
 7 files changed, 34 insertions(+), 33 deletions(-)

-- 
2.34.1


