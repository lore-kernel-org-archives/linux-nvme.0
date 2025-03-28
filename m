Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA29BC36013
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7gtA1OYyJE89rNT+H5TYqZMzvImVx4usYAUfSZyWv3w=; b=1L/Bd28ZKWzMNNR+w4cPRnfliw
	aShDlXEKqN5TSVCydtDoL66DsbJqErFckSEyVZ7xytxtWdHVkO/LlBO2efBwQspMwBP7dxVkvOmVP
	kE/W8tlrHs5WnrWkV8ZZwBAiNH+oFJs3ZkycFWg8oc6XPw1HMykwtpTHEdFtbr9+nu1viiipxXZ8l
	2MmOlpCZ9ntc4Un8akXJ//MOtXCCtRVbd5oRRELbUBJOxbCdSFnI+DuY6xp9Eow72kGg+vb2OtpfO
	mS7zEElKyH0gEwHvqGFHE8Bz+OArW1b/QcahuDam7GEiIn6kxih3ogGGSEqb3k7lumeKJEnZmOgHe
	AUHQeF/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyC2M-0000000DpEn-1D6j;
	Fri, 28 Mar 2025 15:54:26 +0000
Received: from mail-io1-xd68.google.com ([2607:f8b0:4864:20::d68])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyBvK-0000000Do8U-1jWZ
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 15:47:11 +0000
Received: by mail-io1-xd68.google.com with SMTP id ca18e2360f4ac-85b52d6e034so6393139f.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Mar 2025 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743176829; x=1743781629; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gtA1OYyJE89rNT+H5TYqZMzvImVx4usYAUfSZyWv3w=;
        b=WJxahtUFk1fj69tXCxV48FiKf4N3eT5PCeOExwb6HNIfYUdw04kRwsOg9WUx4g2Rro
         nnF413G/DGZmSMNWo8V+QxsL1IUtrD4ydbHuXIBfp0RqWxjO/OjhE/Ih8MW4ux5/HbYB
         BDr+pNXDbAU5pDEhc3weGUxDq0TQTW5Qzq184zD4jjLrDoIaPTcuBXxXloAorkXEv1vI
         i9gpPgdUj2PDuHCDXiC/BNz0I0lVh6A8e9vk5DT8J+v4aTNmYoVJKpOBc1kbJU8fyTkG
         WBKN3hEf4bLrm2jTwV5hI9Lt2l/PmWF0ssGC0Yfes6OGvgLwI2eQXASWXblov8wRhhB2
         fZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743176829; x=1743781629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gtA1OYyJE89rNT+H5TYqZMzvImVx4usYAUfSZyWv3w=;
        b=GwByDEUB3d9holtcYqgq94GqJQop2AZ2UaIMfx3OKq45pzjqyi+7e1JoH9F3zUITD0
         1K7ALB7QbkX/FG7ghva8BS2p/DqkHYVR5SFX1r/2e9LKT7hWVOvY66j4M0609lIsm2Nl
         T2sNDrWFIOBhy2rRaTU2mY07qdkRoHoY8viBBNBq5+qmE4ZimshW2frx6zGLyBzs049v
         iLkiNVkjAYEqbRtxeyrxW9Kz0qUL3IsWUsQl6kjpyqDCAPR7My3BwaTSBOZxf1yj7sMu
         A8xI09xznR0yvnyns+/GBDdxV731XrpWliceVtnepmmEj9MPL0uyfB3Y+QTTiwTKzYwE
         Xggw==
X-Forwarded-Encrypted: i=1; AJvYcCU9l7lqpui3gsFDAjD98puhxjBTt5IECK5NOudK01kbVlrP6lQfXrW007Yvpoq3gPU/POXGaE0Laoiq@lists.infradead.org
X-Gm-Message-State: AOJu0YzPKek0nbDIKU2bruzjvNfXoEoLF3AQ2CgFS/tadB1P1Xd5xd7X
	maKQ3PIHzaCh1rF7GcZxYq0URTPTB+nfVzZKJ6IjPLk3jc9CJ6EUrAOc2iv3bt+XuRIGmMK6h4e
	yYLb56C2POH/I/OjOPTdmHwliYmgxV6MT
X-Gm-Gg: ASbGnctMHipUgDsJAM1Viid7FvQwgcKt/vAVI8H4v3V0qcYd4W2j0oqoNkeaO+dYuIu
	osyxLBlRnmaOFrNHAFDn2wRNI8I0TD8BmUVH08wIcUdWOw+FooRULEtgtH8uWzfrnO+n0if8n09
	VGWblaicp+jv/J7hC+rtpXwDmpA40A8aZkgKb9cSX4xq9xtmaGdr+dXlDVAI/PWk9Pi8mGHVGkv
	cX0znWSI12rJkJbrOIC2yJBR1lIvpeTyVmpMaWuZkXkMrPFJch5W9WDNyQys+p0zuGCXrQCN1Ha
	enJ094zif8XXVMjVLQkKwdVQ6vq5hUoiJQJnoLhZ4GWwG6xm
X-Google-Smtp-Source: AGHT+IE12R3vBd9KmQtvrZk87CCQk21F2844/VQ6rL9De9RQ1rDN0EpXVNVc3dxmtWCMWiJIkiRKQtXilAro
X-Received: by 2002:a05:6602:15d2:b0:85a:e406:5836 with SMTP id ca18e2360f4ac-85e83e70bd4mr224753739f.5.1743176829103;
        Fri, 28 Mar 2025 08:47:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f46486e230sm268228173.45.2025.03.28.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:47:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 793B034018F;
	Fri, 28 Mar 2025 09:47:08 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 73065E40A9F; Fri, 28 Mar 2025 09:47:08 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 0/3] nvme_map_user_request() cleanup
Date: Fri, 28 Mar 2025 09:46:44 -0600
Message-ID: <20250328154647.2590171-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_084710_500386_38A1BB4C 
X-CRM114-Status: GOOD (  10.96  )
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

The first commit removes a WARN_ON_ONCE() checking userspace values.
The last 2 move code out of nvme_map_user_request() that belongs better
in its callers, and move the fixed buffer import before going async.
As discussed in [1], this allows an NVMe passthru operation submitted at
the same time as a ublk zero-copy buffer unregister operation to succeed
even if the initial issue goes async. This can improve performance of
userspace applications submitting the operations together like this with
a slow fallback path on failure. This is an alternate approach to [2],
which moved the fixed buffer import to the io_uring layer.

There will likely be conflicts with the parameter cleanup series Keith
posted last month in [3].

The series is based on for-6.15/io_uring, with commit 00817f0f1c45
("nvme-ioctl: fix leaked requests on mapping error") cherry-picked.

[1]: https://lore.kernel.org/io-uring/20250321184819.3847386-1-csander@purestorage.com/T/#u
[2]: https://lore.kernel.org/io-uring/20250321184819.3847386-4-csander@purestorage.com/
[3]: https://lore.kernel.org/all/20250224182128.2042061-1-kbusch@meta.com/T/#u

v4:
- Preserve the order of blk_mq_free_request() and nvme_passthru_end()
- Add Reviewed-by tags

v3: Move the fixed buffer import before allocating a blk-mq request

v2: Fix iov_iter value passed to nvme_map_user_request()

Caleb Sander Mateos (3):
  nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
  nvme/ioctl: move blk_mq_free_request() out of nvme_map_user_request()
  nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()

 drivers/nvme/host/ioctl.c | 68 +++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

-- 
2.45.2


