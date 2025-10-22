Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC820CCD1BE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=; b=F/Hj4iy2yuKlihL9zJA9upYw55
	dMVoVoXFZwx7t/xExOQgD3O6s4bj+6hw4WYdMyaPM9W/teGhG+w38YyncSob1PUYcX5wYZq+9lQVp
	aUIc2WASpnTtD4h6EyTMEpIO6tgnatnYxJq2f/sHVvCw3Pe/TJb1eEm3bHpQqik7a6TVQGfRVT7Lp
	yY6nvqWgwbzW6parXgpG/nVIB/Xu+DmuKq7Q0LM3JPMIDEJcJmVKcLuN5YsNOp4y86AuVzVGf4HEV
	IEfg2T9JTHlLM4eV5Evoj08XS6LASMYz38+9aAXdqV+QJJNkz52S23NMl1oo9XlyMcy304eNhozEW
	++lksP5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBi1a-00000004VwO-3om2;
	Wed, 22 Oct 2025 23:13:46 +0000
Received: from mail-lf1-x161.google.com ([2a00:1450:4864:20::161])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBi1W-00000004VtS-2wlM
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 23:13:44 +0000
Received: by mail-lf1-x161.google.com with SMTP id 2adb3069b0e04-592f2c6fe9eso21089e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Oct 2025 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174821; x=1761779621; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=;
        b=OM95uJMytz3861wbbMIxCFAviMyHp6iOy3AWTFJ10LwSiX9l7Vf+Oh37iVJ93SyZzv
         tBkA2go1tabvmYRnh2n+sdxr0Q6E1rRodqpf4R0Rizsaa4SzAmUHkmN50mVub8LF/7Eu
         +EFtxKl9BDdf3t5XFPkygofXab8Ot3E0e95Z5iijCMrAiMaQBzf9rs6X52pi1cLwyyfp
         XngEgQ7jrJhD/lDSw/ytb4UWvlORRQTnws9NUqjqdErNTwycjplWjhBtxYHm/DBTRlKt
         cSr2uS7Wiozmg6TgapOcSpx036LZRAksdONWwBmXHu+PyySLNeXHWpFPtzWJ9zCw0/w5
         0b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174821; x=1761779621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=;
        b=hAq0hvCeBI8N8VOryY+hgFDNcViGMPTOhY3XP2Dq3cZTXa5jZM8FygJsQ+Fo5n35yd
         b/1J9axfMDMLf4EczB6oCGxpwmo1BJIGUmnMeUVvJNX8To0c/dmUs+OeUMoqihhmSX+T
         ZK1H49pLx4OeZTKApJucymwRtPTpQlaFPYPc/3X14fV7GBqJOVgCC+sUUwWtg3gHJYkZ
         okwL/NKp7au+eZ+IX0UFKIawOkVKLsVSIRs54iFP4qpcIYn3e09kBifytkAf6iFY+g3p
         UUkM+cHtRGqrKHQBf4ZLdqsLytJrUSRYjgJwkJyKIgr9HiTAU2ilM81hJ6un5R/nJe5A
         avVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQNi+CC2bm3DopQb2ckNlKqwNYgrVbLy7DoAzvBIt6kg5K5Ab9OcrBW5S+pyt7gyX+EIwIVAS8cbTP@lists.infradead.org
X-Gm-Message-State: AOJu0YxyrWzlFv6IKF9qhrhRZiRzpyOOFHKnU0LqXVFB7OzGZvOS1jWs
	GUzAYHZ3LC1lqXKs1lj8sJVC0wRyvtdybzjJRxWUowdPgfLa+Zb1JB//VuEk5ppGIaOILjX8HGZ
	ncA2dOxWwcRdlTfh8t1DtoGzPynwRvLBN/QnyDqLpoPPzaEFoLvIs
X-Gm-Gg: ASbGncsUThm+ntQ413ohEUTTtZA7XMUiW8gtqC04SeRVYHWm089i1Ps/5JKKNwm60FP
	6crwFZZx8C7WNJE90/TA8xftl/JFnv7Y0n7gag8r8FN9eIEm+E8wGxQiPMI+Up2kD3nP3CFDbZF
	ML5z5XZqOEiLy3USGkwQMPCk+YM5byMdlYZrhixb2A/Vg89hs37pUP9Kda9y/v4MYu24xYBB0OF
	GiuLMs4CaS4Y5CeHViKoAcLFKptxgES+QaTqgP9b3PHyirZ28jTBEIdoBRBCCt/LShd2h93E0dM
	gTS+1poE+MlqVIo4rRlzBpfOcMp5iLi1WwaTUoY8Qrej3pw/b8hkQ3mWBUa4UMBRtpN5qWA8rx5
	ewBiAbJTb2e1TxFsk
X-Google-Smtp-Source: AGHT+IE8YXW1bqh82Pv83CqBL++4EorD9wKI8kSNSxyaHaZobY7QUQj2BR1bXjAEiGky/6dYa+2+odrIWp7W
X-Received: by 2002:a05:6512:131a:b0:57e:ed2d:190f with SMTP id 2adb3069b0e04-591d8598d06mr3612400e87.7.1761174820409;
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4aa2259sm40463e87.0.2025.10.22.16.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 86E1B340283;
	Wed, 22 Oct 2025 17:13:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7A5DAE4181C; Wed, 22 Oct 2025 17:13:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Wed, 22 Oct 2025 17:13:23 -0600
Message-ID: <20251022231326.2527838-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_161342_758729_6C170D68 
X-CRM114-Status: UNSURE (   8.68  )
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

Define a io_req_tw_func_t wrapper function around each io_uring_cmd_tw_t
function to avoid the additional indirect call and save 8 bytes in
struct io_uring_cmd. Additionally avoid the io_should_terminate_tw()
computation in uring_cmd task work callbacks that don't need it.

Caleb Sander Mateos (3):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  1 +
 drivers/block/ublk_drv.c       |  3 +++
 drivers/nvme/host/ioctl.c      |  1 +
 fs/btrfs/ioctl.c               |  1 +
 fs/fuse/dev_uring.c            |  3 ++-
 include/linux/io_uring.h       | 14 +++++++++++
 include/linux/io_uring/cmd.h   | 46 ++++++++++++++++++++++------------
 include/linux/io_uring_types.h |  1 -
 io_uring/io_uring.h            | 13 ----------
 io_uring/uring_cmd.c           | 17 ++-----------
 10 files changed, 54 insertions(+), 46 deletions(-)

-- 
2.45.2


