Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C170E6C5F7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2Qad7UAjPFB3sv8Qh6ihgGL7fJSwXVqBT9HWXeuX/QE=; b=ftgf+BqMikrULKaKuzYs2HyNgZ
	wLsDkJkqz5EvsG5ekHVRC0SKJk4kkHXixyv5gcnffwZq17EKjZNZNYO2P2oPlTu4EQXbL9z9ZZCX3
	sy7tOuknJiax/iN9aSP7yrbehD15MIATjm5q3J/li0OrRSb/fVl/jLtRGHkmJGYolVvRNVfw4qRsB
	o/RY2u7HOFtaEEWQNzifMHfyaWFd160jikMV5utQEuGq+rDwGLKQAiL0D9Ybp3FhwkAOOSs4eZH0Q
	RKB7ulQebUyYxmHnlphlcrMDlvy1iWrBulgTg0slC2f42YLxMLklBCexjRIIpX3uHegsR8aNnuIey
	bFkJQ3tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJgZ-000000087Wp-12L8;
	Tue, 03 Dec 2024 03:34:51 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJgX-000000087WS-0sgF
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 03:34:50 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-215b4681c94so6253755ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2024 19:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196888; x=1733801688; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qad7UAjPFB3sv8Qh6ihgGL7fJSwXVqBT9HWXeuX/QE=;
        b=Tbku/0HqOQJ6Z6fwUYjXHcNTtYGBnsQEbthown1NSJ1DkUW0LY/ri5ZEla/5MgS3Yy
         P2P6eU2LrHrDWPhRqGxGx3NgXfoRalD/ai48gJlGkN7DB/4X+MN2QKpCWsOHLPHR1rjQ
         I9xfMhfUHE5i8O5RA5FIJab9l8PpRJv0i1umnQles0YptLwPxsE34Ymr9yCtZAlzY1mp
         xtEeEJcTYRuSL52mJCfpuuDrLrtuS6JTHBXg5JNe2bn7Z6Ecu7+HBNs0MzFFlG5bOUS4
         yL/nll8wu69mWLGy11sHthW2145oCowa3HcvEjNQR+U7tt3T07RAIXNb4GE2MG4HEtSH
         Zmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196888; x=1733801688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Qad7UAjPFB3sv8Qh6ihgGL7fJSwXVqBT9HWXeuX/QE=;
        b=ESMd7jx9p9ocshiQMJIQIUnAfnBqMe9JYE6y/A17Z62+O70EGt8i6kkjS+3QD/gjRI
         zXVceapMM7XR5A4Avp6hl7zgkV3pGEKaxxyNyQ90T5zKyRugXKIn2Qd1DEJiyp2X6a0K
         BQ3L3bYes8kU+emve5UMJdSE/bfYfRyfwWOZ7wJA6l7FNzV0G/o5JNJxHZPMYpWhVGjh
         BxtPhtDbzyg7rvBqCiKRBRW1FXlQfysnV4Jis4lL/rDqWVAEAssR4h7qffRTquQa9moU
         FKJQ73yukTD4Csz2G4fGiE4OvGXOu6LFfynAv0VVg1WeY0XtT/PE9WRDt2fmeD4r+ajx
         +61g==
X-Forwarded-Encrypted: i=1; AJvYcCVydfJW75UMF/vw1nMXZAkZoUoQXA11dUg1umouTEGX/t1djIzc0NIOKoDvIo0TTgswLDjvXyP4HFrA@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6n9vWmGZ9BFYlRFBOEp8O3yTM993hnozOOlX9Vc3byrBiKmvt
	lloLAmP6IHAxNIijT19T/nWJElcj8wXF9hWM0pxGByLFCt5Oxu9q
X-Gm-Gg: ASbGncsqiz6P89uJX8Hm9fBgBtDr/l2nvVh05mmcnm01SxvGoIah945kPHspgOhs0q6
	YzCnn3flm0/52fABdVVy+nGHiW6NilgQgs9wtijhSZUgteGCIqtZRyv6gWGAYwf0Ry5d96+2bJ8
	Vr9gGM/8Ex7C3PkV6HTqGASOAG7zC6voLhp1DRT2IoYj0FVzrvuNljhWozI4Fk7TrZWSxTiujqk
	OuG5VSrX8+9cGABpHhibI6zF+MJoA19mOOl0isDBnpSJ9SELnnW8e/BE3X+ow==
X-Google-Smtp-Source: AGHT+IHYsCiulfikKq8SXVX55DiDBnsAUlHnBhrLpFkvJ5VkPE0a4ZqbrvjPdE5a1iYYNJH9GI4C2w==
X-Received: by 2002:a17:902:ec91:b0:215:8ab4:d00b with SMTP id d9443c01a7336-215bd10ebf5mr14939785ad.30.1733196887738;
        Mon, 02 Dec 2024 19:34:47 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:47 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 0/4] nvme: various bugs fix & code cleanup
Date: Tue,  3 Dec 2024 11:34:39 +0800
Message-Id: <cover.1733196360.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_193449_250683_5F7E6ED1 
X-CRM114-Status: UNSURE (   8.62  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Here try to fix the hang issue of nvme-rdma, memory leak issue of
nvme-tcp, and cleanup the relative code of nvme-tcp.

Chunguang.xu (4):
  nvme-tcp: fix the memleak while create new ctrl failed
  nvme-rdma: unquiesce admin_q before destroy it
  nvme-tcp: no need to quiesce admin_q in nvme_tcp_teardown_io_queues()
  nvme-tcp: simplify nvme_tcp_teardown_io_queues()

 drivers/nvme/host/rdma.c |  8 +-------
 drivers/nvme/host/tcp.c  | 17 +++++------------
 2 files changed, 6 insertions(+), 19 deletions(-)

-- 
2.25.1


