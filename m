Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516BFE9A02C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 01:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CUfTsb5rmJvqQzp2mqu3jDKb9VPW1X5fRtaazVNqCUA=; b=haVJHZNRJUj3I6jQ/aQiLx4UdF
	NNVaFLjO6LGVfC+Tnn1pNZxgeszg/N+btFz8XGp3R3ahgqzYo2/nP/8cYhJGXTR2eokdKqLKQJ7HN
	vdcRFgGEAN7Ia0FQ8fs9IRxLdhhTmOoXZlemegLhiC+IHgp+NNF94gdVTM2Sf2cdl2wBVPnGG9zUS
	xEe/2vPtZsdWcgLHduBzv1UIw+jc2mNHjzAdirAM88338wwTgo8WOeTbSS4G3zJhJ4GVXE+H/EInb
	2RUWoW6s/v6ud2zAr7tNaxfPZ3DqL1LvAWS77QUZuqY34XBNa7rFnFsTfrZQwH1mjWL/p/3Ng2pcq
	M7q/dvvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vst52-0000000AhbH-3tNe;
	Thu, 19 Feb 2026 01:43:48 +0000
Received: from mail-yw1-x1161.google.com ([2607:f8b0:4864:20::1161])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vst50-0000000AhZY-0lmh
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 01:43:47 +0000
Received: by mail-yw1-x1161.google.com with SMTP id 00721157ae682-7963e8e0e44so204917b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 17:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771465425; x=1772070225; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUfTsb5rmJvqQzp2mqu3jDKb9VPW1X5fRtaazVNqCUA=;
        b=S/zqq1IEFnEd4pGSghIfXItoZgi356ekz4JT7Kn/JrdM0a5lz36ngRN7qLmkbb4WvR
         JBkJEyMVBq8JoH/LLA1JfsI9P4rxE+hTezlQ4Kh6ynOSJSAAEYQpnri0hngVszS5GFwU
         ZRxyYGtjZSQZHSLbUTJivBS8fXjT8bcTkWVn267Lo7fbrm06Eqh8XHuNzl0aVDxU69dp
         xeJ76bweUCPDmAry1yDync0ZJRQfU3gpCurERqCLSh9c/qJDzeW65WkNOKjbdvndtP8V
         O03s8kHTiRcdBglRhGGKweFnHmiqXUYdBOq9s9ZAjxREkMX/vI/5aifLymE1D7KBoOeW
         1T2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771465425; x=1772070225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUfTsb5rmJvqQzp2mqu3jDKb9VPW1X5fRtaazVNqCUA=;
        b=h38S4vQZ7txM2Urpig2elH6t4JTX0I/Loj2Grxo7SW8Aq8M9w7vUI4CjmBrEfE6Sp/
         zLq8SivcdDK2lKlVvOE4TkX+hnxhb6JWUxUg+yYBnTBqNmR/7EcDzAlb3DTbcv5i2vXc
         /WziJeu/zBtmq9PLqzn3Oar+Z4obPy8KII9Kk3rqBK3REzgDX0s8COdF8rkJtSUmWrj6
         hfDOG/ye8rbGQOrm2x4iPxRoFh4pP2KieXS8cu+g4w+iFRSGSBjRDck2mfiNr9agxoIV
         ICGZIJgv2wAf98Aud2fCYm9+ao/4NNRHh0vZyQw+y4TFB71xUfn6W5s5M5qBqydI8yh0
         JrrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEZDZcMe4iasuKqLiLrXG/Ji7dW8Vz5WSeSdzAGbD/JB1VqzYfL0EaOP1N2cyo6e0+hUb8oPocqjXP@lists.infradead.org
X-Gm-Message-State: AOJu0Yxa92SxJoHAniHiFleBB3m/UHMmHDPOA7jtAoaYJ9f1pXWQH6xO
	eADVfiNUjoH6SjM9fJrWJK4MYTm5eR75R1t80xwSEE86WtyXbmHueByIO0ZAGKHCLCBhZzlYwTC
	O2NqGyIe2fm2yR1kAevnBJYd5fjLbAUIZzKLC
X-Gm-Gg: AZuq6aL8Id5EE2xtKOc0FNkWW/Up5f+6RScj1Z3fi1F+V/GLxtj9WlGwbl6zB0aiz6Z
	IsplfOrLC4FfutLT/ySey52vTPiJSE/FlyJgNjRYxHyk6ZPQyuZc0ekr6vpJj0BHSc8SK0S0Rd+
	FQxFmEsjLZygGQJ19ScMfz2fwTP8X5bJWTDKTB4HYflT3dvlaZ6o6upsJsDYbqgykJOr/lAAhbH
	lpWyx+E1WsiReSwmwjXOwxdzJr1pV6pzEerOIV53aNp/D6B3yNvg2pv3VZsBaU2u3jsIbqm8Y6a
	UTe3gmNUtay1r0PPKVYW8v2yN+tjjswTJIuxCUOdC2EQvHeb9rFBmu/92DVzhYlcIFtUPachB4F
	cfdfQCr6NMsBmKs7ZdL8LRMV+T7yuvnA/7s+5KEyVLjQ/2VeonSsX3Q==
X-Received: by 2002:a05:690c:c50c:b0:797:df7c:3de8 with SMTP id 00721157ae682-797df7c60e3mr73200517b3.1.1771465424811;
        Wed, 18 Feb 2026 17:43:44 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7980516ad33sm705197b3.2.2026.02.18.17.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 17:43:44 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4C28634027F;
	Wed, 18 Feb 2026 18:43:43 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 39FFEE41D2F; Wed, 18 Feb 2026 18:43:43 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/4] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
Date: Wed, 18 Feb 2026 18:43:31 -0700
Message-ID: <20260219014335.9061-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_174346_225239_7C6968F1 
X-CRM114-Status: GOOD (  14.52  )
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

Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
requests issued to it to support iopoll. This prevents, for example,
using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
zero-copy buffer registrations are performed using a uring_cmd. There's
no technical reason why these non-iopoll uring_cmds can't be supported.
They will either complete synchronously or via an external mechanism
that calls io_uring_cmd_done(), so they don't need to be polled.

Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
even if their files don't implement ->uring_cmd_iopoll().

Use a new REQ_F_IOPOLL flag to track whether a request is using iopoll.
This makes the iopoll_queue opcode definition flag unnecessary.

The last commit removes an unnecessary IO_URING_F_IOPOLL check in
nvme_dev_uring_cmd() as NVMe admin passthru commands can be issued to
IORING_SETUP_IOPOLL io_urings now.

v2:
- Add REQ_F_IOPOLL request flag, remove redundant iopoll_queue
- Split IORING_OP_URING_CMD128 fix to a separate commit

Caleb Sander Mateos (4):
  io_uring: add REQ_F_IOPOLL
  io_uring: remove iopoll_queue from struct io_issue_def
  io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
  nvme: remove nvme_dev_uring_cmd() IO_URING_F_IOPOLL check

 drivers/nvme/host/ioctl.c      |  4 ----
 include/linux/io_uring_types.h |  3 +++
 io_uring/io_uring.c            | 10 ++++------
 io_uring/opdef.c               | 10 ----------
 io_uring/opdef.h               |  2 --
 io_uring/rw.c                  | 11 ++++++-----
 io_uring/uring_cmd.c           |  9 ++++-----
 7 files changed, 17 insertions(+), 32 deletions(-)

-- 
2.45.2


