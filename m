Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D939CC7EE21
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Apr 2023 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDvF+4jn75c0U/4/y4sFW3z5VmXzCZCBCvnk0YKahgs=; b=keVEjxpKy43W6h0afnBJujmIMz
	GRroZb9cRQkJ7WSKpwS2BSg3hr5bIRrFNG6GYfSr0cVOih6zr1lQnuwcqEy2GCbNT468y8V+D495L
	AHCksUHuIG9bvHVZrkzDBewOxEpsStCu+AeyEAaSzPaGoCZvllQtp0vhRflcsutlSWAQklwUb6clf
	acJjexQtDSFKgorELPGbwjpw66/6bw6TBb65C4NClKcPCcNpM9wnKtck/QM+7ws09rF5ZWdr15WRu
	X5wxLzTOUWDPSSB9gIRjDG57JUf/QTIQCCKfyV4qb9xpHO2lFkUkSBsaW+/38I7QSjCpVhMDYhzuB
	8oHycFug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pt89p-00EHnv-2X;
	Sun, 30 Apr 2023 14:36:09 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pt89n-00EHnD-16
	for linux-nvme@lists.infradead.org;
	Sun, 30 Apr 2023 14:36:08 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f1738d0d4cso8660615e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Apr 2023 07:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682865365; x=1685457365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDvF+4jn75c0U/4/y4sFW3z5VmXzCZCBCvnk0YKahgs=;
        b=YHfNaKAWVm7skgW3sItpIMhEVouQ3rfWgMWlF5dIur5GQ23S2G1HL2SSW6Q/76AZBy
         eB5c+OL4XjfYm1W/a7J3nHn/tKLu4U3nBxJ/S4LfRmWuP3ICrlpDlqkfCDct5tkLEyRl
         o7wBPFab6H8guCNPbdZDXSHwMo/Mn4lE/mEeDzTi6TqUVlGVW1KFjkef8pY7dFMmVXBG
         oR452Vv12YzTw7t2uEKT8Q6QhguwSPDcONzJfiS9MPLctwG8StAFefrxDw3aeY6jVsNm
         7r23zb+an1bA0I1c9XgQU2+CvrVRr54tW7RdK0io2+FE9Z/wQV3hd/74+2NzI+D9wGWK
         JsEQ==
X-Gm-Message-State: AC+VfDw/r82pQyMYFQqvufcHb06HqWNS3ZVLuHhCMnNlqyAV5jrZVQ7y
	aeFIRZ62Y5z67IuksNajFB4=
X-Google-Smtp-Source: ACHHUZ6U+r3db8m41a6zCKCOVuqsc8/ZfYMBGuFIxgonr34g47cljfqoJluo9jKELqhg+WCaxYAT3A==
X-Received: by 2002:a5d:6e83:0:b0:2f7:e3aa:677a with SMTP id k3-20020a5d6e83000000b002f7e3aa677amr7785255wrz.46.1682865364669;
        Sun, 30 Apr 2023 07:36:04 -0700 (PDT)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id z18-20020adfe552000000b002f3e1122c1asm26079134wrm.15.2023.04.30.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 07:36:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	ming.lei@redhat.com
Cc: leit@fb.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	joshi.k@samsung.com,
	hch@lst.de,
	kbusch@kernel.org
Subject: [PATCH v3 0/4] io_uring: Pass the whole sqe to commands
Date: Sun, 30 Apr 2023 07:35:28 -0700
Message-Id: <20230430143532.605367-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_073607_425124_3FF1E096 
X-CRM114-Status: GOOD (  12.04  )
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

	https://lore.kernel.org/lkml/20230406144330.1932798-1-leitao@debian.org/

Since the support linked above depends on other refactors, such as the sock
ioctl() sock refactor[1], I would like to start integrating patches that have
consensus and can bring value right now.  This will also reduce the patchset
size later.

Regarding to these three patches, they are simple changes that turn
io_uring cmd subsystem more flexible (by passing the whole SQE to the
command), and cleaning up an unnecessary compile check.

These patches were tested by creating a file system and mounting an NVME disk
using ubdsrv/ublkb0.

[1] ZD6Zw1GAZR28++3v@gmail.com/">https://lore.kernel.org/lkml/ZD6Zw1GAZR28++3v@gmail.com/

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

V1 -> V2 :
  * Create a helper to return the size of the SQE
V2 -> V3:
  * Transformed uring_sqe_size() into a proper function
  * Fixed some commit messages
  * Created a helper function for nvme/host to avoid casting
  * Added a fourth patch to avoid ublk_drv's casts by using a proper helper

Breno Leitao (4):
  io_uring: Create a helper to return the SQE size
  io_uring: Pass whole sqe to commands
  io_uring: Remove unnecessary BUILD_BUG_ON
  block: ublk_drv: Add a helper instead of casting

 drivers/block/ublk_drv.c  | 36 ++++++++++++++++++++++++------------
 drivers/nvme/host/ioctl.c |  8 +++++++-
 include/linux/io_uring.h  |  2 +-
 io_uring/io_uring.h       | 10 ++++++++++
 io_uring/opdef.c          |  2 +-
 io_uring/uring_cmd.c      | 13 ++++---------
 io_uring/uring_cmd.h      |  8 --------
 7 files changed, 47 insertions(+), 32 deletions(-)

-- 
2.34.1


