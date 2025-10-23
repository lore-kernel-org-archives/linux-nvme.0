Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2C8CCD1BF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 20:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=; b=WpCh3p71zum0O75oaHuNY/euz6
	c6oSMGAZaoinisxJ3St5aRDJnuL99KN64m+yc+NvRkus9UpECoafh+QAZ5NjSnxlflU9QggvDvv1c
	v9zPMpldA/itUy3zfNhx0PxZBmBHGnPAbGUgLsTlgUg6tnF2bMZplsJ5ED+JGbKRi4VnIGMRyu17M
	C+XJyveJAASls4aK9vny4bEHx/+Ex3NdyAhsZXu0+9BLiR9NawQm+6qK6riv9IYK1gBFSRwrisJC3
	XqJxuvtoL2vmbF1BPUDekU7Q+M2i6SzB2yLAzOTSFtsSWUlevNMjkeEMUvMzodQ7rYgYTnP6WKt62
	/7z0jJFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1lg-00000007W4D-3gQP;
	Thu, 23 Oct 2025 20:18:40 +0000
Received: from mail-ej1-x663.google.com ([2a00:1450:4864:20::663])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1ld-00000007W2i-0hLl
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 20:18:40 +0000
Received: by mail-ej1-x663.google.com with SMTP id a640c23a62f3a-b6d6027158eso14458166b.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250715; x=1761855515; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=;
        b=e/meWjwFcK3DR4ZUh2Z+zXmaN0R0/LQLlZgBWNMmx5eeiFK9UCPSdMsNi7ki5emnZu
         AvjTesnxwPMOp3/P4kX+FgRS+IoHmC0unk98CaliBNuyeebLsPI5fPliH2forNBSWq24
         X3GJhd2mjIkTon9RsLYn9FZ0o/BQH7za/0Ld0MpMYQSRxFWle2gWFZlapaYA9KauzeIQ
         w42nslqWhEF8FDqavmOYUKxO44f/AZlXxe7sdLBl8QicJJFn/ruvgLrZMfqYS42oudVA
         LRTkAPTFIq2a5JcpHw7ge6Mf6EKZPAVUTmr74B8C2jIB0Q0ovCPrwiVIXSoH6qKEijPW
         oEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250715; x=1761855515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cz0mQMPnFRMldaxGN9MCesCYr4t4w4JLIICl6X3LGRg=;
        b=l5NtgncQ7HW+Aibhs1YQ+5oMZwF7tysi8cjno5Zac97gJPc0q4a7TJGd6ICVO0bxH/
         uL/aFUDl6cGgAQe7TvmceYQnoTY5q5DeDIn5ojF/6GnKh9rMSMKBE8VnFdF37bv/iPK3
         VrUJQ+DCmu1OPh9GmLsKJ1axk9o7pBrir+3KPltsOVpIZHDoIFaB5SoWu6P8jkW1WwOw
         DhbhdnHICnn8hC25tW2/DO93kzqa4Ah5Fbs830VzmSxxsGPROeMHYG0aFHMLr9OZE7AG
         dbeMJtgo4z7X364MPMlOOYrn6chBDvMo/7823kbJ6IREC9WHCM0SOx1nwqTD7m0LKNDo
         LZsA==
X-Forwarded-Encrypted: i=1; AJvYcCVD12qoHTnQj6Ha92clL1E9qNDNOiY8LINMqMwLn9C36AnCggy57EQxathZcL1U9aYEapffz1QRZTig@lists.infradead.org
X-Gm-Message-State: AOJu0Yzjog1ISG9UN4RBWzSz3S9W+k7x1XMjFKqzXuZffqw4OJ0+ogot
	8qKL6Df3jeT9qtAR98OTgBKhbxvyz8s2RjcuhrixJ4VFZn3JX7JfuQI9JJ9fd/2d9nx7npxJR/M
	S2iZDFSfi0KUexkhIlshM6eFLcyxOE2Nvb3tEVmZ4RdCaXMacliWs
X-Gm-Gg: ASbGnctUiDxMZfCvJxjLmmKKcaB0KhYJCgPemUi49XXllMVtxpFCyMn9SlMY31jAavm
	EknWwaAdl3HSABNttzxHadU9RIK4DCJYf4pYYjcwWILRnl+xz6BwoLPCGF82TAOGQMsywhNwA4J
	uvTgYAibX0R4rak4kqRd9oFUKMKh7uLxqHQSzb2Zm+7jB/Om9VA5t8S4GnKyuxWUF+G/D6q7Lcl
	kpKsrXiK27f1Wy1QCFBSG8OlUOOhai2RTuBP6RHzisB9LtEnoyEvtOG8OM9dGV4zPUEj8wFtwrG
	M/EMJor7drRx+0xA45tM1CqhNt8SjdbasOmRrb/Oe90FHnHMHg7HnZm1tszPG/5zen9SOziN8Jg
	X5NSce8qaoBKW1XmT
X-Google-Smtp-Source: AGHT+IHXhL/uv6eUeaN2ZVLtqNjngQKnmQcL5o8MgXl81NLPuCh85qOP68iyVWTyOMVTjHd4V9x4RLM8fwMs
X-Received: by 2002:a17:907:9803:b0:b2d:a873:37d with SMTP id a640c23a62f3a-b6c722312e2mr832720966b.0.1761250715011;
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d5141d9dcsm15476066b.54.2025.10.23.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9317F340384;
	Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8CBBFE41B1D; Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
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
Subject: [PATCH v2 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Thu, 23 Oct 2025 14:18:27 -0600
Message-ID: <20251023201830.3109805-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_131838_038517_5CCAB59E 
X-CRM114-Status: UNSURE (   9.32  )
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

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd. Additionally avoid the 
io_should_terminate_tw() computation in callbacks that don't need it.

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  4 +++-
 drivers/block/ublk_drv.c       | 15 +++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 fs/btrfs/ioctl.c               |  4 +++-
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring.h       | 14 ++++++++++++++
 include/linux/io_uring/cmd.h   | 23 +++++++++++++----------
 include/linux/io_uring_types.h |  1 -
 io_uring/io_uring.h            | 13 -------------
 io_uring/uring_cmd.c           | 17 ++---------------
 10 files changed, 51 insertions(+), 52 deletions(-)

-- 
2.45.2


