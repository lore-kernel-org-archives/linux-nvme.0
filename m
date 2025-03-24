Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186F1C36005
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 20:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qTwm9kKLcwau7i+44COu+WxPnQuj//ctrEfQZj6FqwM=; b=Tabwxbtz08zVcUx6J1GC92A8Od
	8kFWe27oxrMFq7VZ/xaLBpfmlM/mPcB6/uAFlh3//uNn3Difb1RCeQQyDRO5OEC2rsz7NogCZNraT
	vDperPKViK2ULtkWtYhTdPW8zxWsgJb3eeqNreY2i8Ax0G2cS4Yr2zHdBpF8FgSW3V+a8+6izqNTm
	f4iji3qDsozT14KOTm0TdNMsH/J+IIo8enP8Hn5a6XVV1BPVYi01J7+d/nhcHVtMWpgIHgpcSS3d8
	9f8NtjKX98egxD/9Swof78v1Ia+41GmPPrkIzBhpfTzfRZO2kY7GcPLNhqf9ApO6jO3dIj0R3EyVU
	M1WjBEjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1two45-000000048tc-06uj;
	Mon, 24 Mar 2025 20:06:29 +0000
Received: from mail-ot1-x365.google.com ([2607:f8b0:4864:20::365])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1two3y-000000048rc-0gXd
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 20:06:24 +0000
Received: by mail-ot1-x365.google.com with SMTP id 46e09a7af769-72b7d7d9ed0so233203a34.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742846781; x=1743451581; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTwm9kKLcwau7i+44COu+WxPnQuj//ctrEfQZj6FqwM=;
        b=BB2r6gvG8cI8Ni4luFHJGBR2Jtmtq0LXsRsEtMhOIe/JDa2D4mpZTCQZqzSug3uWfw
         QWpF/FkUtMftnVc2nw2wL+6acYtPCAEU+UiGbcAgKHDkUU8lUOsK7+mphN4m5BWviVU3
         /bGbgpogYvzRvI0nsb6d1+R9zSKGnKNZHSNSRMiIn6+1KwatKAh9pEHsHIw+fv5jDBFe
         wMSPSLFVptwdLWokJJKiPYS51ugHCHSwE5gZLgrYsZgxvyTPLUxtNtKYRV5X0n3AzWXP
         H9JxKhOmlnPvV3QDqjyH0eAT6WShZa05chswe9qWuUjmijRYVvvj9clA3IxywAfdzAqP
         ocag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846781; x=1743451581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTwm9kKLcwau7i+44COu+WxPnQuj//ctrEfQZj6FqwM=;
        b=dps2k6Rh225/fsBaf/+X1jv4mjBHvnZx1Bu/oUDHGAwxUPtsTlEI/JogxE2ho8V1DD
         GSJKqZl3yKGfPdmrtI1bMNf3K9n6ZvXwVgu+TPYoElC0t3FiofMLJpImE3Q7K3/ZxJxu
         lgwwMP00smrjcJjfNw86jUW49b5+DBKwJoLVuPONrUfxLDEOL2ebLdfYTo18foLDLYXk
         nDsWZ/CpY6uLfjQBdbQ4ZCGtqeNM8wtKXocR+0PAD7sTNKASqUkw6rTAWEJvZyprQL0n
         dc8oc7AwqAnu20v8GyjDc13w8LvIhGxO+9DkQCJ+JIhTZb7KKyJH2MkUSstKHRSYKD45
         Ekng==
X-Forwarded-Encrypted: i=1; AJvYcCUY549Kcg8+CGCsWpubfDh1qywuXKc0peEy/3kFQWLxj2BhDYmRTEon1AQhdZf2IS7Tgk8RVaUAZU9f@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/C151dqtwqpA4/957szCgOOYUde6rlaagleRGjyL4S9fAxWeA
	cbziCuqOa76xOQOSesX5kt+14VN8iX/ED16mUewiIrPRj4vjugxQPlKuh5C2pewRmoCH7uPDbIC
	eSCp+3MCkDB5b8Pxmm1+NULQbBym3jAB3U0YdLK2EHYD1USzi
X-Gm-Gg: ASbGncuAaeEoEaF3RGeztkDt1UtihCAgwv2/vbXINqZR+7g5sdbQJQ35hVBUecvEdw9
	Xqzno8KKTV/HJuaojz4LGwZLlDO9B0nYTqKoAIn1q7aC309iZVBMMRfBffOwkbzPA4jpX7R1c3w
	V+amAaW9ggDrCxXAs6Ffjc9SFwYaMVWUxRu2Xvl9HkPEB2K0JcRom81DD6HbQONBYAlnCv4Gr4V
	NOKeQCy4cgIWOcOdpzl3XoBJPC1tLBnwFKc3uD6TuM45gDOJ8096Iqj9WavsQD9xLy9jo/c9Zr3
	MnXmV0xRkKu2Qw6w6KFTGaLiqyZh37T9cw==
X-Google-Smtp-Source: AGHT+IGbzC5rsYnWtKfoFuox71C8ckicLGxH9xUNA20u9la2CI41xNym4wlWLHGUxDyKBzS1y+QuAI2Xu6p3
X-Received: by 2002:a05:6830:2805:b0:728:b605:4bf9 with SMTP id 46e09a7af769-72c0af05ce6mr3394263a34.6.1742846780972;
        Mon, 24 Mar 2025 13:06:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-72c0abb89cesm76621a34.6.2025.03.24.13.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:06:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 23E1D340363;
	Mon, 24 Mar 2025 14:06:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1732DE40ADA; Mon, 24 Mar 2025 14:05:50 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/3] nvme_map_user_request() cleanup
Date: Mon, 24 Mar 2025 14:05:37 -0600
Message-ID: <20250324200540.910962-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_130622_202685_843485B8 
X-CRM114-Status: GOOD (  10.77  )
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

The series is based on block/for-6.15/io_uring, with commit 00817f0f1c45
("nvme-ioctl: fix leaked requests on mapping error") cherry-picked.

[1]: https://lore.kernel.org/io-uring/20250321184819.3847386-1-csander@purestorage.com/T/#u
[2]: https://lore.kernel.org/io-uring/20250321184819.3847386-4-csander@purestorage.com/
[3]: https://lore.kernel.org/all/20250224182128.2042061-1-kbusch@meta.com/T/#u

v3: Move the fixed buffer import before allocating a blk-mq request

v2: Fix iov_iter value passed to nvme_map_user_request()

Caleb Sander Mateos (3):
  nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
  nvme/ioctl: move blk_mq_free_request() out of nvme_map_user_request()
  nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()

 drivers/nvme/host/ioctl.c | 68 +++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

-- 
2.45.2


