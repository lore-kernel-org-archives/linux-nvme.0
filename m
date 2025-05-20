Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C95BC3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lHXawegenCUiIGgYUGaRvRBgqP3mwjLK1SkCNTwowG8=; b=XzP/ti52cxJxE1QTe/O+3xmLSV
	GDU7urbsH+oCx2zvsHKoxnr0ais3iJvHd3PROybxA/NpFsuy9xEujPYUg3DzlQqPPRPoJwH7qwQUr
	zc14tJ4gtzSQHTHvENujom03xs5HMaW96MtbBo5TTGVGO/6VSGUd9NThwBlkgFHcpI+//xUFmQ9BX
	7Q1p/BvAk1PcnrSPdGokbX10nc8kF4i3xZ0Vzt1F20FKo7ek+GH4j8H/xK9yowmPkuRkyNdQpE4c9
	m7a2Y13863bYk3vAAWQa1ZRGNgW6veUGNRK1gEG5vMGAmNHLYXvtjYYE2KAD0T/xPS9a+0bxG9aoC
	aBD2mfAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOrj-0000000DKtB-1YH1;
	Tue, 20 May 2025 15:26:51 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOf3-0000000DISE-1TdM
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:13:46 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso1018027666b.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747754023; x=1748358823; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHXawegenCUiIGgYUGaRvRBgqP3mwjLK1SkCNTwowG8=;
        b=H1NTkYj5eJ5rnP75xMP/oJSTpbaqGRmRcF8Dxr2I2BHIfV6w2tOH1nPEoCKX5IOGGX
         a3VVjfli/U8BRdRVtNKONJbs/3g4UzzPCgmkBqU+lhSsQP1lF6TenkbQEQHxJedQOEzo
         0ciU6cSxMm2R4KHwSi/N6wu/1t1qQBWXjYDwfxoGl7sFHLUgivHWMvVnVX1CWQg87zi3
         6ApEkK+1ok3RJftbZwopyTiHENgTYDMIjsH0xjpf4wCirreHX9whgTJRpf/HDixJdIwG
         sN+3keWBuJVTjU80yRebm1qL9k0n+GU+l2obdhjfGbzqhbqZqhgHH02AExtAvIVTlZkY
         1/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754023; x=1748358823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHXawegenCUiIGgYUGaRvRBgqP3mwjLK1SkCNTwowG8=;
        b=kXGjTdYDLtDktX8NVwJ8WhMZlhubb0tMoLGo5j9WvaVzFiw/xnOBsRIAaxhjTPHaOa
         7BX77OhDOPn55xJQX3KwwsbEQQz/OX//vccAoYbguYV1Wk8ENBJey3waDtR2/virXYCU
         lXSaggH7+HDoOWjwGcBrSoZZNTrqhNzR1FGO8rpt6Ripvb79C19/+LSJAxVI4pE9/c8C
         m6hgwwnl0NQfIra7KbLXezdWuuAUaqpkP6V5QW0jINvcgtjUUYMJGabpSHKYawqIgldi
         o52GLLRBZI5NSa29m7cWK18N80BBdHr3ku0mDdo3n8XSo6jJMsi+i3rwuxwzd7JPi8dQ
         l2kw==
X-Forwarded-Encrypted: i=1; AJvYcCWI8u3ZVpssIqQ/VhTZ6hreYCDYl/UopXoSzLoXgPT5J16VR7IUXXHESBZ2B+PSaFAccOFMi5LuouRJ@lists.infradead.org
X-Gm-Message-State: AOJu0YzgHrSre3P0XiDTmXa6sa7quylI9wvM+mPAuKJWBoEwkDBpi7CQ
	UuNea1p8yG2bwinLNQ3wz5hMM4SDibS+cOEU6hA1/W3ddkVKdrualiICNTX8cw==
X-Gm-Gg: ASbGncsbxGwTyASEHOVJC5QXBMmtHhUIQ8QP5UspJ6RDxoyIqB1lnGqVFEvVMHbWN7h
	zblgvUWO2VxUEPK2B+ziZ9RGfsePOy9P/jVVRhfRONO+8SbBtqy9/NkraDzxpMyMwnnCKbwY1zD
	SKwZ1O3YXKfa0NPNdq+MtVoLAOrKfBeeuv/TPN/r3Q536ARH3AU53PVgPcxcztS9Ak+vRL2tyta
	H5Jcb23/KJ2TFL5hEZSUYkjDzr3gC0CJyhoEdoLgi9K17fo14yCWgI4co7jo9JfmUBs4vK9/n5A
	vipdTb3i/QKmhu2wvtsFE6gU52tshPzrOg==
X-Google-Smtp-Source: AGHT+IFIrqD1fxx6JGa2pUbbhgc9N6bc1pK9TK7taW7ikcCqlRLzfamn/OTdILkXqh+Y+mzMfAI9/Q==
X-Received: by 2002:a17:907:7f16:b0:ad5:5210:749c with SMTP id a640c23a62f3a-ad5521075fbmr1019506766b.22.1747754023030;
        Tue, 20 May 2025 08:13:43 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:e7c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04aed7sm746314266b.9.2025.05.20.08.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:13:42 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: asml.silence@gmail.com,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/1] nvme: fix implicit bool to flags conversion
Date: Tue, 20 May 2025 16:14:49 +0100
Message-ID: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_081345_387666_9A6D1A84 
X-CRM114-Status: GOOD (  13.95  )
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

nvme_map_user_request() takes flags as the last argument, but
nvme_uring_cmd_io() shoves a bool "vec" into it. It behaves as
expected because bool is converted to 0/1 and NVME_IOCTL_VEC is
defined as 1, but it's better to pass flags explicitly.

Fixes: 7b7fdb8e2dbc1 ("nvme: replace the "bool vec" arguments with flags in the ioctl path")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index ca86d3bf7ea4..f29107d95ff2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -521,7 +521,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr, d.data_len,
 			nvme_to_user_ptr(d.metadata), d.metadata_len,
-			map_iter, vec);
+			map_iter, vec ? NVME_IOCTL_VEC : 0);
 		if (ret)
 			goto out_free_req;
 	}
-- 
2.49.0


