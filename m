Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5AE103FF85
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EHf/QbKqs66MrNoaZKdYp3gGOrN6EGunMdMSQ21WXcw=; b=mzZwkeay+OOcwVqzjHKT/0jH6S
	Xo4jULtg8iCK6LJcYuQlss36aF+oViQE3aZd5C7d4Gd4rwT8M5gvi+Ou3qSp7+ih9ZCxIzlhwo6Zv
	00oWMM5ajKG49kKH62jPl9qvHz2DSvGIlbOgq+K/uY6nc79didIiNHTyHso1XLtrfSYp7XjurAhBP
	0o/JRX6gC6avO8aqKlxXeP1KgNuRE2FVsj35gGwSeA/qSw4teLbxb0pxWjuqpIwAMM70tak951n3W
	xrxv0pg88N2wUCV3pxjMbjZ8M6c6G5gQ+OvTTIHp06vV0TTcrHozkn6P0GnyuONgvlCldfQFwth3T
	DHHOK3XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Na-000000096Pt-2Hxz;
	Fri, 27 Feb 2026 20:24:06 +0000
Received: from mail-pl1-x663.google.com ([2607:f8b0:4864:20::663])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NX-000000096O9-0HMC
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:04 +0000
Received: by mail-pl1-x663.google.com with SMTP id d9443c01a7336-2addb3e6866so3874365ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223841; x=1772828641; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHf/QbKqs66MrNoaZKdYp3gGOrN6EGunMdMSQ21WXcw=;
        b=gpIzs8QQ4JCziOVfACyxb6IKQ/2/kXOU1obq6gdeOh9HbLmCgWkkjnNTuYrjuRc5/U
         5FZrTTPXuZ3MSi5DrE94xkbedLON0colCkWtVzLflghG+B96R+dMzh8e+Z9rTRQXyd9I
         FtVfIn93ppLxTubC0oJPvjekUtfcfaPungmLCvIVpxGCMqPyFH2/qr58UzmwIo0u52gw
         zP1UnasDU4KN2/zTlNKabdN7kcdrjF9b1CN7E991xsoCYSzFBNTAMfWFWCId02gqe7L8
         D/Z1p3BVW7TBKOAYjlVW/FKA40+ZpQabrUNK/sXBaj4n7u1L5Wq36WRblV97wFtwRA98
         R92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223841; x=1772828641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHf/QbKqs66MrNoaZKdYp3gGOrN6EGunMdMSQ21WXcw=;
        b=eDDmy2Y4BR4K8VIEiswfaK3D8ymQD7Mw7+cy+H+gfu2QqVzeaFleBnKRZVdtTBq2Pw
         BKl5qiyRHV9Q2uhSWy/722aYL3Cpsn6LEtl3oLxtve3RHb02zC0g0+ASyvkZpZ0bPQqb
         f19vzEz+2liZJT0lvLaU7fBdgxsPfxatalYp1KgfPm88Ljtnx16hu/EllstHK2vAmGlZ
         s2hYpZtndlaMiWjFO+3kLD7ht6JTN09kr2Is1ei7huI0OuNGJdMHbo2bQMqgvv/j1K7N
         GNl+AM5lnNFUxYC10CbWbdcTB6eFxcbvEJsCuuFK005xM5d8PUqP1zdIOYe8+x+BkchL
         rNig==
X-Gm-Message-State: AOJu0YzpWVrFZE7cYA0h7hFjK2AfI1lY3ySWLbVXeAIOcbJDSCVwVZ+K
	8RwnLZR5p5dG5sMQ7sRA6gqjB8e82NIjihpT9dSfB5AzSpIVgFJGL2XJ0DQimtC7sir+jPhTESo
	MQuhKaEzRfOzDzQreSNpVME7uI896yXE0T40LKxZx4+j3IRMCStsr
X-Gm-Gg: ATEYQzzcErKPfaSeMqmEzq9n4UxX8w3msMPT0bgdNYak/Ci8cZo2RlkDBGdwt1kah6p
	2J4jXZyS5N8C0EzEIGHVAmN0PtpI1LchVkeO59GbHfASIoZMkNLlKo9CoY7Ev4wsdNOLn6nKcXb
	NVrc5ASCzenOL4S/RqP3Kf31O1niiwtbrZkk4x3nres1GYgfvqQjSYQN2hev8nvowVd1U3Uqp7z
	cyBPyW9BdX7uN3fQaF9KYPyQEv5JTYyL2Ksh5TjPpX9MpU/QFDFDaLezBdcFhfuh7pm83WEDxwg
	vplMBUFxPzhGUC6/afRsBwnZ2opct3af4XxcNkpQUiALXOND1guZ7TFr+OwDy7jYT0pSkDBZc7I
	Cef5xAazyOk6ECIwfbPJ5BjJ7A2+/cC0Oi5NeIyM=
X-Received: by 2002:a17:90b:4c4e:b0:349:2cdd:434a with SMTP id 98e67ed59e1d1-35965ca17camr2861310a91.5.1772223841489;
        Fri, 27 Feb 2026 12:24:01 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3593dcb4b62sm750012a91.2.2026.02.27.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:01 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4E0E33402B2;
	Fri, 27 Feb 2026 13:24:00 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 419D3E420D8; Fri, 27 Feb 2026 13:24:00 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 0/8] nvme: set discard_granularity from NPDG/NPDA
Date: Fri, 27 Feb 2026 13:23:45 -0700
Message-ID: <20260227202354.1012322-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_122403_141044_9D35F939 
X-CRM114-Status: GOOD (  10.45  )
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

v5:
- Only issue NVM Command Set Specific Identify Namespace if controller
  version supports CNS value (Keith)
- Check for multiplication overflow (Keith)

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

 drivers/nvme/host/core.c          | 86 +++++++++++++++++++++----------
 drivers/nvme/host/nvme.h          |  6 +++
 drivers/nvme/target/admin-cmd.c   |  2 +
 drivers/nvme/target/io-cmd-bdev.c | 19 +++++--
 drivers/nvme/target/nvmet.h       |  2 +
 include/linux/nvme.h              | 15 +++++-
 6 files changed, 96 insertions(+), 34 deletions(-)

-- 
2.45.2


