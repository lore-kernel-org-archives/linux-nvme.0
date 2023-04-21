Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DBAC77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=drtJY3bzG70qwaMh3FrpvU2+Y1e1A4ULSdaEvu4w4Po=; b=uM48tjyToHih4ETZHKZMrQTMih
	PkxhV/eluTaFcjpzdnnK9uLwlDF0DQUY8tPblIMFtQNKtUJhtzPbtpIHFPCDywVKZIKQsrAQHVdFG
	0Y0396YvnLAW5sw8xmuMPfp2D9wOIUK5NHN3BujMgDA6HRC+ICHzwJZcUAwKGor6MjcPmPrDffKd4
	ZdetvnKLKgnJkmExD+Dg13ljRP+4yrfvSHOI/9JPVWCS5EuOFbfAj5CETts+XLJCRZO/1Tze3QNWf
	6oT20ZRgUIr8sCYkYOQ2hWqWgvSzMkvtvWpWD74DS5RLBCrZkDTLrZG2SvUNaSih+1wXW+3iUlwjO
	44ZhFtOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pppEG-00AmE2-1t;
	Fri, 21 Apr 2023 11:47:04 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pppE9-00AmBC-2P
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 11:46:59 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-2f939bea9ebso1501467f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Apr 2023 04:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682077615; x=1684669615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drtJY3bzG70qwaMh3FrpvU2+Y1e1A4ULSdaEvu4w4Po=;
        b=B0eTkB59uVGkORymljNLGbTPVCsyqokaiGBHLMkYFJsaJlIE83hUGGATfqjycqY+EZ
         TgsS+Y6PDlwCwdfAOpT3HQoEs1kQVZWmzmaaWS6+hxePnj1MlnZHKiyIyDsiJRtLYKWG
         cYnP89ZBwLqsUob2QsoUs1X2Pn3kXjx3vv3SQ9erF07PF1N6A/O/29SAUoeC80yoB1ZW
         SmlYZJKQ8SC7sdrGWJbsbMF2rtSupQghL/eDyeJitZHN+dLgw66RbeFDiZvSbDbXjf7i
         h1FJ6XCdOAj9a3+mfW8Mt+dy+kJjrG4ApLNeH3RvSzRO2O3cu1PlFp3ajNsPpyXMUfjR
         TzhQ==
X-Gm-Message-State: AAQBX9fGIQjX6yi56PIyOedbVmKpn7cc//UUeqlbrcRXXgHuPbkv244R
	nzNa8ifPZzI4ZAE79URdHEs=
X-Google-Smtp-Source: AKy350Z6FaO9dagmTH/zhPsTsiWB9kCDDLYbt3lKidgLFGw1aZUHkPY05gtP2GpQhwHrfkyzdSr6OQ==
X-Received: by 2002:a5d:5902:0:b0:2fd:1a81:6b0e with SMTP id v2-20020a5d5902000000b002fd1a816b0emr3474376wrd.33.1682077615300;
        Fri, 21 Apr 2023 04:46:55 -0700 (PDT)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id s13-20020adfeb0d000000b002fb6a79dea0sm4298485wrn.7.2023.04.21.04.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 04:46:54 -0700 (PDT)
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
Subject: [PATCH v2 0/3] io_uring: Pass the whole sqe to commands
Date: Fri, 21 Apr 2023 04:44:37 -0700
Message-Id: <20230421114440.3343473-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_044657_796097_4478CB80 
X-CRM114-Status: GOOD (  11.71  )
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

V1 -> V2 : 
  * Create a helper to return the size of the SQE

Breno Leitao (3):
  io_uring: Create a helper to return the SQE size
  io_uring: Pass whole sqe to commands
  io_uring: Remove unnecessary BUILD_BUG_ON

 drivers/block/ublk_drv.c  | 24 ++++++++++++------------
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/io_uring.h  |  2 +-
 io_uring/io_uring.h       |  3 +++
 io_uring/opdef.c          |  2 +-
 io_uring/uring_cmd.c      | 13 ++++---------
 io_uring/uring_cmd.h      |  8 --------
 7 files changed, 22 insertions(+), 32 deletions(-)

-- 
2.34.1


