Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E0FC624D7
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TXye3s8M7BBJFOvpLi+6gbf2riGSXQocruinG92HPCg=; b=oIjReQa5TMutkofNVTD9+zmZv5
	sBUWkpMjdeqdX0iTh1e+BBjYeXOUABEKJ2DxBHDFnVnG3QnExkfXQRjEMT5aeDlgsugKH/8KUqb/y
	uAO/+GcBPqTR/pCl0FDBKRa1eEpIWb7KVV5Kdag6O+9c9Nbg7suLmH0a+ZMAQSirMCZvb7Ky1b72l
	14yYN59pIAzp6SgKu2XQUQ2/YezBPhox4mHHfDAqQ3wklzTLmYddUCV7ctYsPeZIMT6MXD/bjDqDU
	97sDMKCNlK2/UBM3FcZCjTBRvE0RcJekaZgzJQvOk5PIOXZuIG0TE0LlCYhrSgYhkQscKwa6nElAZ
	8XQDtExA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ttO-0000000G460-0etv;
	Wed, 02 Sep 2026 22:57:18 +0000
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ttL-0000000G44j-3TVK
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 22:57:17 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-38f0f3c8da5so273722a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 02 Sep 2026 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788389834; x=1788994634; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TXye3s8M7BBJFOvpLi+6gbf2riGSXQocruinG92HPCg=;
        b=ZKZEFMPN5zpfCEvMEggd3QT+1StMxu5z3Q8ex7GwsZj0gmXJDdFbu294hk7+jKZ9WH
         c+aAiTo9g+rEMS3mAjd5APSSIUVjvxborFdTtR94fwoh7hZCVkIZQ99bePpOu6+IsNKB
         GywPQ1Wcz+svKFmUqG06CSoCHF0PoxQCavW90VwA9wCDzpMT+s8NpDqpEjuUyjzHO6Iz
         Yde58vFKJAKE8WBnaGllXo5EVmC7K1EcKMfbOcn/LeK2FQ7+BMYRfEZfzoM6zOkcSV1t
         koUbWKoPbE3TQBoui2z6DbTsEcH7BBG1o3E7DAJJvwMveK638n+jY9OMo6wghMqMCqac
         +ChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788389834; x=1788994634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXye3s8M7BBJFOvpLi+6gbf2riGSXQocruinG92HPCg=;
        b=EdVqkdWCzFRAJ0EvyhdTp+SUIm6TV0AaCoBm84MvWvI0CkCoZFSXUbdkWvUhjzN8r9
         Nh1sXginhgu7Mdtyl9ZpNYj769tM0J7g/MPM+V+3+g08lHH3CzZrEFhcVZeGNvkzVl2j
         tPv5M5uU3YaqlFuMNBm1MEEGrr90y9ZP0c/BV/8/Z2E6nOUuA5B/oO7o16JhTJZWcqkS
         LyJrlaLfG5L/YM1CHunNirEeOH8MjyTeRLDQp2iLIffo5nPRvyyf+gXKLBvigTGEldUS
         Bdkk2bzteEM2YmrHZDHOtX1K5bWddZOyaEPwITYIs3A01gRI6GxZyKssl8a7qtImB3tk
         Rq5w==
X-Forwarded-Encrypted: i=1; AKwUvBxfqyOsXkIwlxaVg/+5G+ceGiKG6J3W3nwf0aryfSYANLtobV3OuWeJbG/voGumzAPdulq/3QpiwYPv@lists.infradead.org
X-Gm-Message-State: AFuF++kinfw/g6D2gcWZ4n6J9/TJOjs8PxQ+NSrzUwdMXazXjfPjog1+
	I9mPTt67A3ur1d9wqTN9Y35Jh5ieniUqEkG/lYsJObAJvUJQsBsOQVejU4ZqjYc5ASAQAJB+IT0
	0YA2xqZOVeQttsyzqjrEfAhqK2n0oT9v6sq3m
X-Gm-Gg: AYBFou2478BySo97hCmM6cKdfWPlyUlRrZxNGlJRTV0zbSYSdx7vSjZLsySTpWXQCWB
	cC4wUfohDwJBneppmS2ICO0FB0A+UsJiAuAoddnmkP2ZAu07Rl1b+XBsEUKkXb0ordnSatJmAT0
	1A9qqYO7xWHU+B0W+rWz4FQ8WU4VPSbIiVKVn4rmr2Re5CbJhPmIvjWY4X+iSszgUfUJcTAXcJv
	z82n1NZUWDS6lJvF+YETNUd+P7TUubTHAoTXlh+KQyiZYiTS/pgQhCVyZyc2ZiynZ86++RjSpCi
	aJ99BNdhkRzF4FxNbQWPZs5wmDxZ/4ohdMsf4whdRrJBbDC9s07dCMnfFUCnvvMuPRa6i+KFXvi
	13U0QzZHiOcvgN/9GKlq8gbciM4ygFOi3
X-Received: by 2002:a17:90b:39ae:b0:381:77cd:38ca with SMTP id 98e67ed59e1d1-39aee1b3eebmr7025118a91.4.1788389834421;
        Wed, 02 Sep 2026 15:57:14 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b0e6550bbsm187875a91.7.2026.09.02.15.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:57:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 564F54001C;
	Wed,  2 Sep 2026 16:57:13 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 46D07E40404; Wed,  2 Sep 2026 16:57:13 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/2] io_uring passthru: set result on blk-mq request completion
Date: Wed,  2 Sep 2026 16:57:06 -0600
Message-ID: <20260902225708.2379840-1-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_155716_026480_17AD78EF 
X-CRM114-Status: GOOD (  12.10  )
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

io_uring NVMe passthru currently receives the NVMe status and result in
the blk-mq request completion callback nvme_uring_cmd_end_io() but
doesn't post the io_uring CQE until the io_uring task work callback
nvme_uring_task_cb(). The status and result must be plumbed through
struct nvme_uring_cmd_pdu, taking up 16 bytes of the 32 available.

Store the status and result on the io_uring request in
nvme_uring_cmd_end_io() instead of nvme_uring_task_cb() so it doesn't
need to be passed through struct nvme_uring_cmd_pdu.

v2:
- Keep io_uring_cmd_done{,32}() wrappers to reduce changes in uring_cmd
  implementations (Joanne)

v1: https://lore.kernel.org/io-uring/20260827185722.3234622-1-csander@purestorage.com/

Caleb Sander Mateos (2):
  io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
  nvme/ioctl: call io_uring_cmd_set_res32() in ->end_io()

 drivers/nvme/host/ioctl.c    | 19 +++++++++----------
 include/linux/io_uring/cmd.h | 23 +++++++++++++++++------
 io_uring/uring_cmd.c         | 33 ++++++++++++++++++---------------
 3 files changed, 44 insertions(+), 31 deletions(-)

-- 
2.55.0


