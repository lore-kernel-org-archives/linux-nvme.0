Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF0DC021B2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qb82QdOEL9q3mJpzUxuc0KVFE2hzgugePghKxy0L8JA=; b=T+Z6XWwIvD19JCEXpnPz1nqI0s
	fEqQDAFkRCqYGHN/Fi2vm6rAKtGyMO8w9/NxfJL3LNbGARC6vdg5vPT+KNQqAGmwDFI1olYLJhFQz
	3m9THmyrsRjDyjwCpco5PVy3Dm+axDxZV1Ewy2lZT12srURlMYGdIv+rYIQoIAktkCA0dZ5a2I+pD
	Prr0N7hz7DhzF7bvxnxKUTRiWPmMZS5L5r+G/+6Qft1/1XSqTgQm3MSL/kyaHYy/I+sNCOBd3PU6G
	DrVF/HegoW7F7AtnhRWkncEy8KhpdsmbdII4kccPgEl12Ot0tg8FJU5gUM9vGWxHC3Tpitsq1N6OQ
	wKPqIIkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlGLa-00000003Pb2-2c8s;
	Thu, 20 Feb 2025 23:52:50 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlGLX-00000003Pa0-06Ty
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 23:52:49 +0000
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-220d132f16dso24222295ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 15:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740095565; x=1740700365; darn=lists.infradead.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb82QdOEL9q3mJpzUxuc0KVFE2hzgugePghKxy0L8JA=;
        b=NTmH3LVfCpJ8fQP+gFRhmSEb9QC7XRVg/BNzXVPi73heyDPo/usftIKl589NTooHNG
         Sm+Hbm68Ba3u7g+sE+Pfljb0p+KYzBfRjsaGChro5x6m+Zf5RWq1FLT0F3qGV5zJb+NR
         fxhvA7yR/Fnr7ZGzCOYeO3AtELoiljU2kCRWTgfaABkWA+HvoDbR9EaVUI+XDu6g+KXK
         JS3EVjiD2JX/XzA2Pz3DCjlPmQBWOsWTEi2WfZFVcS7TJFCQPMRSgxZZFhArmQxAzJWW
         LuHLPejoWdAWay3f60x89Zxq293PGZsojKjQO+qWaenax50XibzD5+MqweFIkUPiLUYw
         yrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095565; x=1740700365;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb82QdOEL9q3mJpzUxuc0KVFE2hzgugePghKxy0L8JA=;
        b=ZonVsQUk0daY47/dEULwtI8B98Xufme7Mj2qo4IR6aQfqfSarWhUDs4wO566WSZFTp
         DaKYZtmiFemmkmEdQaQJabOnN05gxuoxlMQFmLwp/sdVBXZhXw/B4F5h3/i4COqEclPx
         mGXFGdwyl8FSBqPyY8NyLjocuH6Tt1DECyBfhYSDQIho5AmAqynC3fibZSXAKAbAQquZ
         WkTr6xe8LU0gmHT4U2C+H4QvdpQPPBY6SCxkCc8YNwS6WjAHV2QPDJji6bm0l74OsVgU
         2D7Py5bGH7ywFpfUJ2h08NWL4TPf7aT9YbNxCEswu/DG27h7SxMefxDg7RQcZuvbeg27
         twUA==
X-Gm-Message-State: AOJu0Yzd6hCpgpb4w5UG3VYhdolxQn3lzG7CieTgSObytoZM/4pJBT4I
	q3VBGsdBqnA25u7YoKb5QQ2XFWiNXiekJPdU6MAIDGua37fSgicP4FRfWbOZ9CPCXVAQdaG8dGX
	v6bKrHZdj6xwQKdSa3FVnyFfcMCHw3+gt/vb6LgO9ZS/IFIQwcgj91QMxG/g4+iUFggEIfm21go
	PGjGfkhfoAnQhqPiriqsoWSUvh7WyBqtz8Hkr4/4rXHM+IoBrwesveYG5YhKtiLw==
X-Gm-Gg: ASbGnctqqjHNbq/7MNrOVC/m4rNjOefrnedxM9BdmxUhAJo/PtdRHxe8zVnRPIzM6Ov
	uChMGjlHqWmsP7OgG9uw+uw47EXvNmM15Y9kXTjYPMIr931Y2ABd5xk2Rwg4Hyxil7BpuPDPACv
	jZEEeRhocSruKZM3tFZxADB+b6HZOO82k5AMYrDdy5tbTXGwxR+oqjgbrmLYBM9ObBck6RfHKnV
	OhBE3tTmmJQ1KViYUpEXOstm+oBGCtuElw/Nt0WdVP33tI1ndoxNU2aVAhC+m3HiJqvEmQinRZ3
	IkTvkcSepy00/7P7zMWnE5NBsX5yGtstNBY2Ew==
X-Google-Smtp-Source: AGHT+IHPfERffkN1yiWBiHEUUXrcX2jWn6zdn8HouuINYaCsWF9tdVDrEmJti5NpNdDaRnhRRE2+Tg==
X-Received: by 2002:a05:6a00:3e1a:b0:730:9768:ccdf with SMTP id d2e1a72fcca58-73426ced023mr1243720b3a.14.1740095564969;
        Thu, 20 Feb 2025 15:52:44 -0800 (PST)
Received: from dev-xizhang2.dev.purestorage.com ([2620:125:9007:640:ffff::c49c])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm13610720b3a.75.2025.02.20.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:52:44 -0800 (PST)
From: Xinyu Zhang <xizhang@purestorage.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Xinyu Zhang <xizhang@purestorage.com>
Subject: [PATCH] nvme: map uring_cmd data even if address is 0
Date: Thu, 20 Feb 2025 16:51:01 -0700
Message-Id: <20250220235101.119852-1-xizhang@purestorage.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_155247_101645_1259342C 
X-CRM114-Status: GOOD (  15.42  )
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

When using kernel registered bvec fixed buffers, the "address" is
actually the offset into the bvec rather than userspace address.
Therefore it can be 0.
We can skip checking whether the address is NULL before mapping
uring_cmd data. Bad userspace address will be handled properly later when
the user buffer is imported.
With this patch, we will be able to use the kernel registered bvec fixed
buffers in io_uring NVMe passthru with ublk zero-copy support in
https://lore.kernel.org/io-uring/20250218224229.837848-1-kbusch@meta.com/T/#u.

Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 60383da86feda..724ab542b4c33 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -500,7 +500,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, ioucmd, vec);
-- 
2.17.1


