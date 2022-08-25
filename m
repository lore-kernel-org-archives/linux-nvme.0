Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE70C28D13
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 06:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tJ9RD4xnfO+35nVgFNZJlXTAwQ0dcmcDcymeGJI3+20=; b=F35zuVrSc/l0D/TeCNFvN0hYwb
	BNAo3ssNlV0uA6Toyp+Mt+wFUjuTkQ3ktHC5rlG6aWbM6rBzOWbsC3oRG7clESu+Y9FqypZB1zSal
	4XY3uRpHkSZ46AOkW9ShK+B5Ufm2t4hflmDXkOK0yH3Ors8iCQj5yDe4dzSuzva2WprJI3ZoqocI7
	1cPBzfYZQE62an+4GVzPoLIgj5Yf8Fp8hK0irEzgaLw5biuHgp3p2P8zmB2XWBiDkZqVgFFB1uUDs
	HXx15xWtUkWM3nw3OSuO38d3lBQYYK8AmgeIohVjPHYQlo5pVjCsA3SleV5wYoVQIagpio7J7kxCo
	bgrZ3cEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR6ei-0080eT-V6; Thu, 25 Aug 2022 06:47:56 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR6ef-0080Zn-FA
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 06:47:55 +0000
Received: by mail-ej1-x635.google.com with SMTP id d21so18324032eje.3
        for <linux-nvme@lists.infradead.org>; Wed, 24 Aug 2022 23:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=tJ9RD4xnfO+35nVgFNZJlXTAwQ0dcmcDcymeGJI3+20=;
        b=eFZSsHiZDZAs3jtTwi0D+E6NpzG7VwoB3RU3+3b3ux3DtSKnXPG+WSWlrOZ/1/r2n3
         9ZpnHub1YfM0M1PDYRAvuSf/gpLkcqzcYhyyi4UIv1nuTAtmCZLyw1y0rjdEOcagNYLR
         3y5u8ixwElr4TrcehcLviEWrkXuGtr6vRn8GCfYZmx/8YQ0Lh4I2Dj4MUlUwLBVFnq5Z
         upLhqEZjzTtg0KaBX9bDSLLIF6NAhje/WsP8Pn7NruWDRCcQ9lhXC3dbjbPUr2ZAOH7o
         hhK9hg5+OsuHF1djNJ/HOwCgCgA+MSG2a38nEw6/IXDc4Fov2fKLVUnWcbuQJnu9PmAE
         DcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=tJ9RD4xnfO+35nVgFNZJlXTAwQ0dcmcDcymeGJI3+20=;
        b=N4fdyhBKgXJ1vEEgWsbaLmDn65NovVy7SQKDqBZytNcLwubU0/MHD8TNjgQkLmGm5a
         TqwK7qUc6OUycDgYtkjwcBmaM+2YN/Xx37qK0TClM5TQgrwmx6A3OAIHXLsse5z0J1im
         vnv32rN38GqtQaH4EAB+zt8VJpOh4zCcZQNwdg0O1sFOaYQyeOlf71a9L113KOET4Iv7
         3KLiReHIQ5ZL8Qw+5/uH+hzFb6XjmkOzHVIx4BcyWjUgKl+SnydshtLbqzAk9rNTpkf/
         YEGqSS/+3ZIeJgAq+n1Urfix2nkSB3FEvkks/HtMvhdBYilj6UMkbWx50hgodIeaZ6r0
         Rf6A==
X-Gm-Message-State: ACgBeo2+PwkkcvB1ZMj7x7RP8xxFiwOWx3jbk4VaLlnqgk6Voc0nIiKl
	tfpNMIM4HhRVUDasuvYBnDeFyA==
X-Google-Smtp-Source: AA6agR7UlTSHrzl2TlSPNjaDcyNaP3pod9xxes0+jAGEaInCY8HQk5OZaFGM8f4qmxwJsyIpK+ZBTA==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr1458692ejc.243.1661410068958;
        Wed, 24 Aug 2022 23:47:48 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906a40500b0073100dfa7b0sm2063564ejz.8.2022.08.24.23.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:47:48 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: hch@infradead.org,
	axboe@kernel.dk,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] Nvme: Fix dma_map_sg error check
Date: Thu, 25 Aug 2022 08:47:45 +0200
Message-Id: <20220825064747.22521-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_234753_523575_7E15BDAF 
X-CRM114-Status: GOOD (  12.32  )
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

Hi, all,

While working on a bugfix on RTRS[1], I noticed there are quite a few other
drivers have the same problem, due to the fact dma_map_sg return 0 on error,
not like most of the cases, return negative value for error.

I "grep -A 5 dma_map_sg' in kernel tree, and audit/fix the one I feel is buggy,
hence this patchset. As suggested by Christoph, this is for Nvme subsystem.

Thanks!

[1] https://lore.kernel.org/linux-rdma/20220818105355.110344-1-haris.iqbal@ionos.com/T/#t

Jack Wang (2):
  nvme-rdma: Fix error check for ib_dma_map_sg
  nvme-fc: Fix the error check for dma_map_sg

 drivers/nvme/host/fc.c   | 2 +-
 drivers/nvme/host/rdma.c | 4 ++--
 drivers/nvme/target/fc.c | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.34.1


