Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EC6EF5862
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QL2ryiCUVfF0yvlCDe2HZGFa6PV7tL4QK7zbVcKn8Kg=; b=H+IEq0hiKa1aKJmwt5UgFlAVT1
	Hn1cZn++kvtCA0VhQEwSlS+r4SXj40vzqJEuGGmtrpC+5RBsqK6Wzn5KzMzyjfUSruC4XB55NV1Vo
	n86mQXAopCk2fprBN8UsTtb29d5urVEAM6TfUF7bzpVLvtzG6TSZa7KUwn/tWvYl3c2fth61RDWtb
	bVdhPaSJzQxd+yGLYt42pTQ9uBmQsbE5onzofVxKpnov5ZqvKQuCDaoYot+RxN5LhJ7HKOw05nl+y
	L8jcoojluUXAIJdOhwe9IqRje/5XkfZWr+qWbXW3tEqWRBH3fqifkSe1AK+NQNnoMCnps8bO4wT6D
	ODmntawg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw04-00000002SIV-26c0;
	Tue, 24 Feb 2026 17:15:08 +0000
Received: from mail-vs1-xe64.google.com ([2607:f8b0:4864:20::e64])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvzy-00000002SED-3jnc
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:04 +0000
Received: by mail-vs1-xe64.google.com with SMTP id ada2fe7eead31-5fdf39de3d3so320877137.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953301; x=1772558101; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QL2ryiCUVfF0yvlCDe2HZGFa6PV7tL4QK7zbVcKn8Kg=;
        b=TEWMuBNcJ9gcboF2pPhKrel6xiXdIzb0UCfHZaOPaBRr4Tzj5Tgw1UsF/jecFZ1y6V
         iRk0KCcAL7mW+1W6XXs+KY6vUWIGo+AW0GPTb6P6KHpZpodcXHLMLQZlVqpmqvI6/oaO
         BO1MXeS8ow3KxmZqqvE7Brf8AKAVHP8jLfGcpM6oJSIver/RPmS/mk5lhsfaMgb5Zr0J
         phHT8YSHTKQv84lU4JtobkvkuhGQf5S2LlC929qEQoCIoEGxdVXkWEbuWhd8qiAJ2y0X
         IpxxOR12cS9zgGXIgDELw/CvRJaEG+6mA963SIdZv3QRd5ZHA6i8I4OaEoxfI3sZK0m6
         DNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953301; x=1772558101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL2ryiCUVfF0yvlCDe2HZGFa6PV7tL4QK7zbVcKn8Kg=;
        b=lJnUhM67bleoFGnfgUXNx1BuuUXVQ/6HZFeYU2/RZxUdx5KtLFN8pz8yAiqqUW6VUj
         oMEuWEybK+JWIhjZgu7tJdauM5jT8Iv28xUJddTHlofG/NF35yBh5MddGiGQyBKBOTpQ
         SeV668Bw/zu/9sWq35Ri/KlpjlT4Zkp0Y9szUsKDbTBtq6odykTEQEqQzeCxutUhm3Jb
         T9G4Q3GkCEZD4puEYGuM/OBrgem2hb+yO33ALy5GyMC1lKwBSuV2HzVW/XFkmfP/6lZW
         cSaJmW+DUgMZFyEflJG8yDLwVUmUzh4g7+6i1ec2LoAUysUu6gdBlnaokxItOuYLuNaS
         GnBQ==
X-Gm-Message-State: AOJu0YzikKkujUskVZkMWev9X2YqR1EXno/PCmiBDROlim8DBzxDZjlu
	ITRu90KWZv1caEU9C61qucs4WXoEaN2OdQ/PoINYGdpwivi9kSLxaX3rOn5ZpRW1F7qov9LLTVP
	M//gOLEBFaXxrLB+PwTu5MIPfljFuDRIWVZMbAvDlCsohPjBfax41
X-Gm-Gg: ATEYQzw5DjORk4zxzRiYqF4ocljiYtjA/zNZCSoQn9Vk6YdchFES7ph2jWi6yG9y3ug
	9YWeki1pMNFaCINkSw4BOK73wemeMux78zs0q02GU8inao4tFBnKm3cSVh3sFz51zMLcTsA5Uye
	Alkvqc7Dux/szqDD9Bf7+vClUMyBXLwyCE6yKoOjNUsBE8uiRr+hZRK5cn9jO4CzahAL6XGLs+m
	rQ/CGJgd0K2EVsVwt6nW/u0a/m4+E70MYqeBkyC6YzhOhcWqn/GWfveID2mKfaxUql38mycDh9B
	moJbaO+1ZuGp+Gh4+tMSzssDSGSDV8WRDr+7aIkZHTmcQwb4WPQJkVftJ/qawmfAm/VJBdTiTJr
	hgERZ3p8JmvqbUV+sR64HOlwv3q23jSrZL5maykE=
X-Received: by 2002:a05:6102:1606:b0:5ec:95a0:6aac with SMTP id ada2fe7eead31-5feb3012075mr2528095137.4.1771953301460;
        Tue, 24 Feb 2026 09:15:01 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-94da8b19a3fsm872261241.8.2026.02.24.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:01 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C54C5340705;
	Tue, 24 Feb 2026 10:15:00 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B6404E41254; Tue, 24 Feb 2026 10:15:00 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/8] nvme: set discard_granularity from NPDG/NPDA
Date: Tue, 24 Feb 2026 10:14:29 -0700
Message-ID: <20260224171437.3175993-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091502_956581_3D167442 
X-CRM114-Status: GOOD (  10.80  )
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

NVMe block devices always report the logical block size for the
discard_granularity queue limit. However, more accurate values may be
available in the NPDG/NPDA fields of the Identify Namespace structure or
the NPDGL/NPDAL fields of the NVM Command Set Specific Identify
Namespace structure. So use these values to compute discard_granularity.

Also fix the use of the OPTPERF field to better comply with version 2.1
of the NVMe spec.

Update the target side to report NPDGL and NPDAL as well, in case the
discard granularity doesn't fit in the 16-bit NPDG and NPDA fields.

v3:
- Introduce from0based() (Christoph)
- Fix merge conflict resolution (Keith)
- Add more comments (Christoph)
- Add Reviewed-by tags (Christoph)

v2:
- Only use low bit of OPTPERF on pre-2.1 controllers (Christoph)
- Add Reviewed-by tags (Christoph)

Caleb Sander Mateos (8):
  nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
  nvme: fold nvme_config_discard() into nvme_update_disk_info()
  nvme: update nvme_id_ns OPTPERF constants
  nvme: always issue I/O Command Set specific Identify Namespace
  nvme: add from0based() helper
  nvme: set discard_granularity from NPDG/NPDA
  nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
  nvmet: report NPDGL and NPDAL

 drivers/nvme/host/core.c          | 85 +++++++++++++++++++++----------
 drivers/nvme/host/nvme.h          |  6 +++
 drivers/nvme/target/admin-cmd.c   |  2 +
 drivers/nvme/target/io-cmd-bdev.c | 19 +++++--
 drivers/nvme/target/nvmet.h       |  2 +
 include/linux/nvme.h              | 15 +++++-
 6 files changed, 95 insertions(+), 34 deletions(-)

-- 
2.45.2


