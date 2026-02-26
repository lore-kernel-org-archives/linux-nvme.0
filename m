Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3AEFD8FFB
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P8Pf2k79HwheJjr29+InaR2lhFNdapyckaF87dy9zn0=; b=P6PI1MhIfha8kAi4JzCK+J4T3v
	/mNPDFrteLRMlh/IrKsOdo+3DNTF0hf/bAG/DPx+SREj4wIfyxx6gWZxgmDJlUFHQWwjeDBFiD7ce
	PmGkrS+FdEXR91Ptb5RV3E5ozI9gAKZZ11XrHYRuZ9Wvbj4jT+e/D6YYKLdtmvmypAuIUud7/ESmN
	GJbUya00escOBek9d16+ADRVeOb1FEmBVmeKD15DovPkOJM4nfdCQm3uxJO9eaAo6tjvuwpLwo0Ry
	4t3FC2tgKBR0pVjFLen7tpWBCfrpOiOD+D1jOWNprcaSzY1iPJYd87d4EeMTE6w75QLrIJVKm8VMy
	fI1NiaXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgev-000000070UC-06Eb;
	Thu, 26 Feb 2026 19:04:25 +0000
Received: from mail-ot1-x364.google.com ([2607:f8b0:4864:20::364])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvges-000000070RA-0HfQ
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:23 +0000
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-7d186e8e790so86457a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132660; x=1772737460; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8Pf2k79HwheJjr29+InaR2lhFNdapyckaF87dy9zn0=;
        b=Xaf2v+31enQ4Skd7INGxrmMJP6Krcii8GLinfucyiRxy1/zThmFtVQoRhRcJjZjb+5
         EasUbA5d1D/dZOZEMHOID6K6oaHP6EkGrzBObGso7/RD880kKp7o3XjWBJ4VtNN2PkY3
         09/vHB3ITkPX0by59+L+S9Mr5WgVjXAZwd5GZsl0QpGB+tHIpKmJDQTgcboWNBDgcULy
         oQpeHdE7xx4va3BtylDjdSemOoMNZirh4rVGkmhdVuptMp1s5p3qnLqMKZYLNEj/xsjF
         UQKlF02prqclCo27tthTh401C75fAgFCJAMLoQ/46oAL4QzhKRN9N7hYFLcQB/vzJFvh
         hs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132660; x=1772737460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8Pf2k79HwheJjr29+InaR2lhFNdapyckaF87dy9zn0=;
        b=CzIub53gWMwDWjwptPrCfrhYLGkOaoJWjkFyce9EZHyQsB+i7XCR8BzWxigCo8byIU
         IXVv2r/wlDfjAt2dYAFcVoNH3MvYgCE7VWD7Op2tKhLAA2b6ZM7jbZVo+hSpLYtiwXhn
         6+XlszyqLfizmmSwXwdcAg2p46lUjflUMO/6isvEd3FSfVDqBhboo2Ds6omdD3CnrHhz
         5YQgdO6jROaZxTMkffwLmvXtOMxo5+RuMpGVPnIrPyCpCJ/45AxFpHt8r9dH44GjyJIx
         UEVos8bG0aJKu4BWs0q9ONtF75QCcmVXIuDnTRJuWYQhgudhdfbGzMBzE4uh3wtJwqYR
         oHIg==
X-Gm-Message-State: AOJu0YykRF8mYUxo2X+SjuQEqXE23hKROWXPQPExoi3xMFBL/i7MvO+f
	ReMrR/HJ4ruyQhupAWTquBc2uUTU48YRhEN3p6ohXSq/5DlT8p6up64F/+3pzY+ujVlPAwinWkk
	w5neeuXhZw+9K9ujJA8WFEXuXgmolrWQdXH91
X-Gm-Gg: ATEYQzz1I/nZvqBXo7QqwOXUNaY1EBRJjBPoQvhYnkCaMAAl4rqjltF2eKeDQvKrWlK
	wnwLeURN4pLOUOuaJDuDMcUx0Faeu2zZLoFVP8QcMsEKvcDWapJlvvOgLluHCid4nPxgxhHKkc2
	XdSmbEMFpTyjkNHrGhUcBtiEuyqbmOfZTDaF+FmnEJCF5CYk37amB7/FoHg31lvCWBhzYaF8PvM
	6iBPye5uOd5QopeeBZyjUQhfraCEXZQHd+k39/9fJwiptwE40RbUrcxfhjNYMo7aZ3dh2/sgXTO
	cMIV23m7U7iFFWTfnrwmtzljg1f7UeYJJtkxbgDTeVZgpl59+qsCWVCKt+ixa5/ZOmsGejLC3IU
	Dm4SG6GsAy+LM6tnrguQvEKLDOKG/qeJpvL/ZRdXuDyv1i315lqcjqA==
X-Received: by 2002:a05:6830:7189:b0:7cf:e4a1:8b64 with SMTP id 46e09a7af769-7d591affc02mr205140a34.2.1772132660441;
        Thu, 26 Feb 2026 11:04:20 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d5865024ffsm329727a34.4.2026.02.26.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:20 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A3C87340245;
	Thu, 26 Feb 2026 12:04:19 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8BBE4E41254; Thu, 26 Feb 2026 12:04:19 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 0/8] nvme: set discard_granularity from NPDG/NPDA
Date: Thu, 26 Feb 2026 12:04:07 -0700
Message-ID: <20260226190416.297725-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110422_126597_68E7B795 
X-CRM114-Status: GOOD (  11.18  )
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

v4:
- Issue NVM Command Set Specific Identify Namespace regardless of
  controller version (Keith)

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

 drivers/nvme/host/core.c          | 90 ++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h          |  6 +++
 drivers/nvme/target/admin-cmd.c   |  2 +
 drivers/nvme/target/io-cmd-bdev.c | 19 +++++--
 drivers/nvme/target/nvmet.h       |  2 +
 include/linux/nvme.h              | 15 +++++-
 6 files changed, 96 insertions(+), 38 deletions(-)

-- 
2.45.2


