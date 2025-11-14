Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02ABCE7A8E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=; b=fFgpXBeglGeHvNKB2QE8X+wWzw
	F1Ss0eGK5AqRDOKxUMSHe49wr5qLvznCRuR6Hd/EJrcfICJWrrs0L1gCEa1+SH/hcjZDGLCg9M3ju
	wjsOsxO/RdDJ/999ZBJD+KE0WF3xT2rBQUDF80pGcQvwHvG4XP93kDrfXwVWXcrCyuLedl+F+5TVP
	PAPujWUpjGh+3LFBk6aDOKZovB0bZMfNdOyFPcUcKR+fFpGPtfMPX/Leb3BoINn1t2G4bsw60rpO7
	4sbQFbLQfWySlJV52tc/WS+weG637cytApNLB+5PjH1LHuJAOMXWh3XIhMfDKb7437+c+d/PFEIm7
	bJ/2BvNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJq0Z-0000000Bu4V-3zjI;
	Fri, 14 Nov 2025 09:22:19 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJq0X-0000000Bu3L-1Nut
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 09:22:18 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-29586626fbeso18073055ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763112133; x=1763716933; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=;
        b=OI+gKaR0DwtpGnuU+gFZ7/Ib7+rviWx/osWUcD34dsuCl+1UHXUJbTw03dta37MA1/
         z7aF55wYgi8/DFIufi4SGWuir/ntawJlzFvkWTM0R0XHEwXuOkvuw7OR1Hl4wXw9DMYo
         aY45HdoU5xA2XsOcpJjs5GftrNQF94uUyK2oUJ9wScSzBBOkGr8Hrs7cW9Zd1wjmahJy
         qe7ohM6Zt1tlD1w9HpsKEiLzBBMkvNh2Ax2G6tRYLlNdCrSdOLJnBqiVepPKa4VQ5o7V
         1AS/wIZQg6kb6x9XMLpK0MaodFpNtKc2cQya8p06l097RPI3LJv0kYvRdEZefp53uF+L
         0B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112133; x=1763716933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=;
        b=WKy2gihlKbCVYK9PbQXIfEUbgaGY6/efsZkg19V+fZWQLlMuEBM/OBEOzK5SxKp3vR
         +EILC6bDfLdLQsm/kWCWyi6EatLrnK63o5YV3QITaH6WszYkZAvOScy8F0efnNAVdRgB
         nRYp3PA+otZ14o0yIelrSBodv8Q6y+4WHVkdyYvvTVzFzqjlKiuEqtgWuAoeV5kmqe7U
         lTbakU70Xji649K83UwFenlHAtnSH/uTSPQ6YwDn6hYE6kvYwqel1cZ3U8OpKC23qbnZ
         pDjI35+pMHAkhTQc3dJgGexBlD75pvFcjToC3mNd03kg604mAP567Svdh+h8wHTGKXB9
         P5cA==
X-Forwarded-Encrypted: i=1; AJvYcCWGK1M1U+ysWlUauprkLt/c99prfFIB4UrvJwBTlT7LzJ3rJQI14QHIbt1ZeGuJg3UE1iVA1JqMJSTe@lists.infradead.org
X-Gm-Message-State: AOJu0YwXlZL/qJt6bpqvmEAZh5c19amTV43LAhTP1Sl96eC5GVcA+3YJ
	MqncJdLCVRArMU4emeh5nsQQv93fbyCcvxHFsgw7p+TymHuYTKIVLAhpKC3v2aRO9sY=
X-Gm-Gg: ASbGncvulEiaLCRBnGsgDmDELxgbBXmNsqMFKUA8ERtcffg/vHTclsj9ypJY4pJDl3j
	iDNup+dn6k4ICNXcKoZLrB1YWwahawFUHA2E2onGNiJhtVRe1VvvS9+/WGUFFdO/4u+tuxXrhkV
	3jN+ArKZymO5R5jDnrKGI36ZQOCHfuFDRDVdzXjVwc08txXPXwkxKe5m7Mx6wrtL7MaZMVnchH/
	Fu1YQRv+D+cCt6NftSntzhgxcvDAueYY2J7k+m7aumjLd26zimOdU3A04dPFZXNMlOxCTTAdWTS
	ZxGIa5u0j2RFNpfsuHMun3xJZ5RlC53bcheTsgtXSNshstmmTLKtoi2l6wK4a7YLUO8pV/48PYM
	tTbFWI6o5DbuPVCavLA0nXS51LJ36/ndkxSxLZGltS4aALPa7qiF7HpPXM/8H95iil7zm8INyHI
	H5wQsxxLytbJhNowz8VNpTAn0LUF4IGEfNeg==
X-Google-Smtp-Source: AGHT+IF+L62VoDL311ziY3WGmIGqOUF1aAOhbYoj7EpJUNyw6PsD2tlvnXHX5j5jjprmk+4XNcS2IQ==
X-Received: by 2002:a17:903:198b:b0:267:a95d:7164 with SMTP id d9443c01a7336-2986a76b6c5mr23867635ad.60.1763112133120;
        Fri, 14 Nov 2025 01:22:13 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm48725735ad.65.2025.11.14.01.22.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 01:22:12 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v3 0/2] block: enable per-cpu bio cache by default
Date: Fri, 14 Nov 2025 17:21:47 +0800
Message-Id: <20251114092149.40116-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_012217_372346_7ED2E901 
X-CRM114-Status: UNSURE (   8.11  )
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

For now, per-cpu bio cache was only used in the io_uring + raw block
device, filesystem also can use this to improve performance.
After discussion in [1], we think it's better to enable per-cpu bio cache
by default.

v3:
fix some build warnings.

v2:
enable per-cpu bio cache for passthru IO by default.

v1:
https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O3hjexFNb_tM+kEZA@mail.gmail.com/

[1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com/


Fengnan Chang (2):
  block: use bio_alloc_bioset for passthru IO by default
  block: enable per-cpu bio cache by default

 block/bio.c               | 26 ++++++-----
 block/blk-map.c           | 90 ++++++++++++++++-----------------------
 block/fops.c              |  4 --
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/fs.h        |  3 --
 io_uring/rw.c             |  1 -
 6 files changed, 49 insertions(+), 77 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.39.5 (Apple Git-154)


