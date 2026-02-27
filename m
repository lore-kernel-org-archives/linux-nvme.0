Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB971039895
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4pe4RREd+BTPRgbiC807YGAMUFduYLhwjMogn+PjJEc=; b=fJmz02IFNcLSW1azpxtvS42FlN
	AuumBktcVyzNEa5mj07FZIMsXTpeSTjl/b58Uo2eQ50tt+WAZDDDELk8iCANo/7V6W5U6GuYJbxIC
	kF4rKg9lexEeuE9w5h7gFMivlhpm1+9ZO+K65TlPjBgRIk+JqG89c7Gxf0aUhPx/LggPmiyXlu8UV
	ojgO7XVj8+Wgb6zhAzzb7B6Hk+o2pShQCnbuG1qHUHqNo2cLAWczSJM2P/2W76SPhOT1aynP5sc9H
	CmwGBO07aM4jardcg90U1lhE5KV9ZeJYs1fuYAxkoPGR7D7rz3WliszBBouhTNuIHn2wqTIs+pDth
	vt7Rh96Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Nj-000000096Ur-11Ji;
	Fri, 27 Feb 2026 20:24:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Ni-000000096T3-033g
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 20:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4pe4RREd+BTPRgbiC807YGAMUFduYLhwjMogn+PjJEc=; b=m8YN6EK5XZILVhVy6lx57MZTLm
	xf1VdXJXx5Oqaya4RM//O6SYIdXZv9Pblrc8c+LEWPV6h8c5+VqS5kiHLJ60f9H4+9j3QvpZouZym
	A5Qc6oE1C/mc/wgUu+/TY2I3v3eRCMeAm0uYccQ68TEfYGpS/QyP0egMyBfKBf1e6YFkH06ciZ9AD
	cxqqwvVbm1Cc23jgDGJ8rKpECBk5Osb7jchtqQtEJMLwCCpXDP+1kw39aYsJtvgbyTxXmMe8OV5p2
	5Y5ga8eHtancTtz967yuN6IgLXHYK1wuTShPC6qymvZISmFCr1xtXHsX43L0/jyJIWgrKsMRdybt0
	0jd0DRVQ==;
Received: from mail-pl1-x661.google.com ([2607:f8b0:4864:20::661])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NZ-0000000Dt78-2L0x
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:12 +0000
Received: by mail-pl1-x661.google.com with SMTP id d9443c01a7336-2a9633ef0d6so3103035ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223842; x=1772828642; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pe4RREd+BTPRgbiC807YGAMUFduYLhwjMogn+PjJEc=;
        b=R3kdIHw0p9ZIEapDyzrcY9d/DJ0/8I8ka/7qn/54cOA8cpBBaxpQY5Y8oR3GdFPent
         owY4EbqZ6wSQbRexAUvnmrng2P4wXdnsgadVfy+xfttYztGyGUvbjsxPK3WNtl0nFLlx
         FTGQZptqTJROMev85Zb0bWBPxa9ljfNryH5ZWD/QwQRgfZh8dyfBcZGit3RgCyLwSap+
         eVcVUamLHTvnRpcZ/nmlbhflCUdt9w+zKAM7q40LupZh+741T/U3daVGzjTBp9tjF+kM
         GVxK6TZLEmBP8MNrGmUMB/YkOeqXjQuKMBSB/O6alEUf1SVOJTal68mYoJfxjkA2xbhr
         wxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223842; x=1772828642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pe4RREd+BTPRgbiC807YGAMUFduYLhwjMogn+PjJEc=;
        b=fvSsjae2rFKM+dy7qpkoxtDj9BkfMMLbifrPK+ICdiUX45fdB15c0tOlEFoPthGwTw
         ioHcvIdiBDsAUKrhgBeLXrz2kbLTPFYwOB9x3w/bahf5aNKnpRDkA8UWHCcVFVjSDXUR
         8K8G55ZZIDcF/Dkhj5kwmQu4FgofLvCvtvhNXceSfhKUQDrYGYVwrpGml1Te47fAnzDp
         sTfruz8+h+G5Nfiln/LxEjYU7j8g9By9QevKRLXyp9TNptofMnTC//397ZsyoAvRUGIr
         1Aqr4RR6Lf/skmtcBzVnI3UWdUZNMVj5opU0zjRuyy176kCcuf3O0gHhEOl5pbkwxgzj
         2P8A==
X-Gm-Message-State: AOJu0YwAlL4wSwRq/tOZDvrus/C1rt0WPbSboGDvEZ6d1o2R2L0Q6W9u
	wZ/9RkBH05dbEUsAR/0wHHxMUmNG8EVCh9ppz4XaDI3rPt4r3hhmbHkTYcN1s4yRY51RTKmFNA0
	Nl9YVKrFIpxBHhapmlToAgKM1zdFbWzZzw2KCNTHTDG2NpKnnMqRF
X-Gm-Gg: ATEYQzzrE8JcxntiM+EH1LOJ9nMvXcoYuf5yRJy8M6MaC9UaoGgGY24sR819ymQOTvi
	gyHWgvKPhl4AsWbLRuwJhv5NAFx/aEXMaTvh1/vAsaYafQJO39/Jl7ouhf9n1Rvmd2eOUHDfx7W
	fLN+KutqmXUU7yw71Cq3dqPjt4SigbMl8eL+RG3av4O2btebfLeFfqnf8Vb795ZOePkmH3S3kHF
	KgShgA33TCm0ssJcdsGLAv0NjTJFbxVwU3h63PU3Up+JFHsvNC6sKfLW9vlEfj/sxhKZ+XsBo8f
	QpzBjn/itF72PUxMa5q4DenasUP9N40C2Efz9q3UEjAbttr46HHJMpGj0V1n46q65MEQEoQSwzQ
	J0kGbeUG2CSAQanXnIc6E2+5oIwIXy0Yk81JJgYg=
X-Received: by 2002:a17:902:f650:b0:2ad:e300:df0f with SMTP id d9443c01a7336-2ae2e4770b7mr31860275ad.4.1772223842043;
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb267621sm7698445ad.20.2026.02.27.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D8870342243;
	Fri, 27 Feb 2026 13:24:00 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D3EB5E420D8; Fri, 27 Feb 2026 13:24:00 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 4/8] nvme: always issue I/O Command Set specific Identify Namespace
Date: Fri, 27 Feb 2026 13:23:49 -0700
Message-ID: <20260227202354.1012322-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_202410_555629_D263C3B0 
X-CRM114-Status: GOOD (  16.69  )
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

Currently, the I/O Command Set specific Identify Namespace structure is
only fetched for controllers that support extended LBA formats. This is
because struct nvme_id_ns_nvm is only used by nvme_configure_pi_elbas(),
which is only called when the ELBAS bit is set in the CTRATT field of
the Identify Controller structure.

However, the I/O Command Set specific Identify Namespace structure will
soon be used in nvme_update_disk_info(), so always try to obtain it in
nvme_update_ns_info_block(). This Identify structure is first defined in
NVMe spec version 2.0, but controllers reporting older versions could
still implement it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bff6f26d7bcf..c3b24fcb2274 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2352,11 +2352,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		ret = -ENXIO;
 		goto out;
 	}
 	lbaf = nvme_lbaf_index(id->flbas);
 
-	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
+	if (nvme_id_cns_ok(ns->ctrl, NVME_ID_CNS_CS_NS)) {
 		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
 		if (ret < 0)
 			goto out;
 	}
 
-- 
2.45.2


