Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F0C606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pIpTBTSF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ArCR0gpS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=YHBFmHAZzkTNwhPEuQe/n0EZjSl7NRJ9RBTHgn7pG6g=; b=pIpTBTSFc+6VWGsA17kulnpQ4H
	uZNEd/y0T7aDRilXgZSNgfb+XRigA1s2DdbzlzDiGs9IIOiK3TBzS2K8fw4aQB3Ko5RjZVLXzf4kD
	fDSEa6iH4U2LtpyA8nIF645UX6Lnutm9+BwMxjHc8P9lhLjGWNNinAqIe9BKqEVGqvtiZJe4HY+45
	reieisVVceuVD1Kovnbc8cOwLZY3fEmqIC9XJP22HJDAPZvdo4Uh7k9ZBqCyM3IZhiuUENj4uMZo4
	8XaBdNpOIs0jElNQXuF3k/8HbxpdZlSWqeq/Gu4jh7SaF/ImLJlzFnysQ1Ou8JMqwsfr5KRPq+nUY
	iRGrxgGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu37-0000000EKcp-3Hl4;
	Thu, 22 Oct 2026 14:45:45 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu35-0000000EKcT-3Jjx
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 14:45:45 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-157fe9d771bso2498675c88.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680342; x=1793285142; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YHBFmHAZzkTNwhPEuQe/n0EZjSl7NRJ9RBTHgn7pG6g=;
        b=ArCR0gpSM+9wuFeY6ZZSRmA5FJEHp1FW1W3S+YE2Uu1TM/iRG0f71v1z0Ekiui+zJp
         QIzwN/LPpQnhTZ0w8/69mChOJuNLMDN29x81HVFUEJXHe8q1lkWW9Xy6cqAPlbks5gAS
         dbFqvkJ+6GrVkFSsmjki3RMnOXwu+OY6Xv7k7QwdHEtcPT51km9kC9ITF5g5FRyzCgO5
         Y0Lu1qjAYPu/xBmgPMKEsVYOuLXJa31Dm6/Kk8sBdjD/UXm0lDD6LwQz0OmZ7U1HWJkH
         KAAMSMA8GUqFX9OE1tiU90wEVnynndulnq+q1Gpp6xZxCmYNqb++xKXtBGPCb+Npx3/V
         wmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680342; x=1793285142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YHBFmHAZzkTNwhPEuQe/n0EZjSl7NRJ9RBTHgn7pG6g=;
        b=HhiKtwrd13wM16htXWpUYLRiRvfeQ5ps1rhpz6D42G3ztgkhvmAQ3Ved9f1v5x/qaW
         WWveTIDWU9Ld+Rqh8FHDyNz0bjGinPpIWcKV7Ucj8SO4MfnvL0erCHIe1/wFV/gq0QfE
         Rk/VEG5cet04KtRRKOCSPBokC4gLIu8RX8iuJsFAX6Jf1EZq6Aj1tj4nSnpu5g+51WBY
         Ce2Z15UGkNDdRCUWeyOVDJcoV5vPlG6i32x4EYtRb0+BDa3tUZCbWgGPz0Cr6XYzzzMA
         hZd9vBWE3xbfU18s2qxMVJWtWJekx6BR3oUiho49W+QvfiavBoSw2j9eom9GMbC3q5OZ
         pYug==
X-Forwarded-Encrypted: i=1; AKwUvBx/TGiFtsUX/DvggDDurE55jKoCZj24Q4SACWFPK/MyudCJw0wPKyH9pqhXccpgP/6A/hwEciDiObPR@lists.infradead.org
X-Gm-Message-State: AFq9FYL2k57esitzGN3TJdEXNLTKMjwpoyasdlHmAGK4ThTFwPHxe7zf
	NYt9oMRB6eCHIlQZlkmnVvlAG6yZSyVFb0/QvLXTBUd6FPhyz0CL3Vk=
X-Gm-Gg: AYBFou1rUXk7+2j1VSga8anrmCk0hgXVYZ04jv7ouuJ9GTsPLK44GNcaq3cPp4Wnv+n
	nAXTTLtv04JEfjTRjVo8FnRUWqLbd59bodXtIK98LzaXgTVhG71MIWAEIsQnLEhY7gM8mXPENV5
	dnn/+ouFQSYdhGBpNzpmKQakfF1gVMVn35IYlrte7jFDA437CR2hQFK3BIaNPKnBi+oGSDCWUlc
	ZTwZz6sk/8Wx0jdI925OEeknlpTyBWjTp/aK9ERUECE1agvn9yP9pEKtWLy+pDqsNNP3oWyORpL
	VAoefHl7BbxQO78yowO7i6jiw9PLrC6nkfJ0h8MO/2pu9W0/PRcmuo6B91cvTJ5V628gYZODx/R
	dgXRhii43JsGEseZ/kjsBkBj2ZskLMaB8br0LahzYRUO3W4fRHfekn2yiNurn23+NvBA1DUUdi9
	UkvQORDy/pwa6bA1QMbk31zIgH1o614fcz/Mn4OPytAuv4p2Tp9QlJ7UWV4+JkhPcUmlEHVAhfJ
	zZRKB0TaL12mJErzUBLYXnvi6jNJcwvPkSyGT6Ueb4Aw7lnVIiymvP3pB75cqAJYdDHM99cauWI
	lLuGrbofocsLWugzUrZmDwtUuCgCBcSKyn0QG+UvDC0=
X-Received: by 2002:a05:7022:286:20b0:191:17d6:ccdf with SMTP id a92af1059eb24-19117d6ccf9mr5773178c88.8.1792680342117;
        Thu, 22 Oct 2026 07:45:42 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:45:41 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v2 0/5] dma-buf backed NVMe passthrough I/O
Date: Thu, 22 Oct 2026 20:14:51 +0530
Message-ID: <20261022144501.2478417-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_074543_832169_13FC0B02 
X-CRM114-Status: GOOD (  11.22  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for dma-buf registered buffers in NVMe
uring_cmd passthrough.

It depends on this fix:
https://lore.kernel.org/io-uring/20261022132027.2293931-1-anuj1072538@gmail.com/

Patches 1-2 add import flags to the fixed buffer import helpers, so
uring_cmd users have to opt in to dma-buf. Patch 3 adds the io_uring
side, patch 4 lets the block layer map dma-buf iterators for
passthrough, and patch 5 enables it for the NVMe namespace character
device.

Tested with this liburing test:
https://github.com/anuj7781/liburing/tree/rw-dmabuf-pt

Changes since v1:
- split into io_uring, block and nvme patches (Christoph)
- pass import flags to io_import_reg_buf() and
  io_uring_cmd_import_fixed(), and make callers opt in to dma-buf
  (Christoph, Pavel)
- add io_uring_cmd_hw_done(), so nvme no longer handles the dma-buf
  map (Pavel)
- warn if task_work is queued with a dma-buf map attached (Pavel)
- make the -EREMOTEIO conversion explicit and comment it (Christoph)
- refuse dma-bufs larger than 4GiB on the character device

v1: https://lore.kernel.org/linux-nvme/20261016103453.1129150-1-anuj1072538@gmail.com/

Anuj Gupta (5):
  io_uring/rsrc: pass import flags to io_import_reg_buf()
  io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
  io_uring/uring_cmd: support dma-buf registered buffers
  block: map dma-buf iterators in blk_rq_map_user_iov()
  nvme: support dma-buf registered buffers for passthrough

 block/blk-map.c              | 15 ++++++++++++++-
 drivers/nvme/host/core.c     | 16 ++++++++++++++++
 drivers/nvme/host/ioctl.c    |  5 +++--
 drivers/scsi/scsi_bsg.c      |  2 +-
 fs/fuse/dev_uring.c          |  2 +-
 include/linux/io_uring/cmd.h | 14 ++++++++++++--
 io_uring/net.c               |  6 +++---
 io_uring/rsrc.c              |  6 +++---
 io_uring/rsrc.h              | 13 +++----------
 io_uring/rw.c                |  5 +++--
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++--
 11 files changed, 88 insertions(+), 27 deletions(-)


base-commit: fd13f31ac62abac4df2166bb0a6fbff53b288e0c
prerequisite-patch-id: 6ad52e1ffc603df71c6855926838f2df402c3ed1
-- 
2.43.0

