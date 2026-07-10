Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07163C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2A6lyd2jd7ZCM97ZM7yJgAgaHnmHNrVF3oV741yC5EI=; b=YJ4M+qWA1lTRqNif4JKd15fq6+
	72Vfrzye9OjMjB67WHXmakP8tYWFXQLBzVfNCXAUqGNhH2rHRHTOJ5Wc776WlXA9de3TTIxaMQlVC
	X21njiJgI8hNCPrqZvemgo8kh5y/YIykyaIsF2aU0Fr2rfFI8Nbctq2eg4hOvIT6fSzDCiA4PRCg5
	5Jg/WN5p3k4lekYtjmQpsrZj4C0dpRTAS++gHf+XU+bAvO5p3DNdeKkNgkF/x47YRbOn/t0P9zhhk
	KkwcAv7i2llRrFMxasN8qXhTNpGzMjWiHQ9RU29ZLBwYBkN3nj570xHvhnY7wBRi44JzwVknaMrwY
	qTveRtQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi10U-00000003xfI-2IKT;
	Fri, 10 Jul 2026 02:30:26 +0000
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi10S-00000003xeh-2cCi
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 02:30:25 +0000
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-92edb12cdf2so21783585a.3
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2026 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650622; x=1784255422; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2A6lyd2jd7ZCM97ZM7yJgAgaHnmHNrVF3oV741yC5EI=;
        b=QrXmosR64Avf55maEVY5n3/FEaij/wFsyZNeKpz78t5ANy8RtcKeNYdUdlP+gIBAxr
         gDfXHxwFJuopcnxwzv7aQ+KU8r8+MpKF8rGwxfe9wKTulXRd76sBVXk+EFusUFPbAFdi
         kk6wflSYgEVUnEcN/7fuMXQlbIMsJyJt6TOqHmnQfAmCU7eNfn+Mt7bzFAYwhPFyu0XW
         epq/XbLAnGh6ejbsJfYiq/BT495sZ656b4j2Qb0qGfutynel5VlF39r47sAzKAyj5c0/
         h3QGuDUOaxWt51VKgLp3Qy+CO+JPX5wbYPQ6Mb1qRxxwWW6IXm8nMcGvKxV+5oS96qRp
         xMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650622; x=1784255422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2A6lyd2jd7ZCM97ZM7yJgAgaHnmHNrVF3oV741yC5EI=;
        b=Tu2LK6Gn5mRxWVsFrJJlb2J4PqQpxuoPRQdtEj4ZBKRJOA7eCml/3xVHyedD6JfLQQ
         gcM9831j9xkcLcGYx6lf7WeLijrhlrM2K1KVsX5aiXBltpME6yWt1AgagzvwRsl/QS61
         EQOebYN8X4o2jBh3ig6mxhpEpz9PkhIkFi2IdhoPrGrDbhAjtyJLwchhyrv4kb/Ijed0
         DljF63vxKMbF2U4l67l0TngjBaFJ73g4xjKO6v6bOmsoPAI0Z4KRlFzISrW461k/p2SU
         Lu4blDnS6Yv9DhkE0KuN8oIlgyu62JctnBLcIqr/8My8JsPAEq7V9kTK0jTEQ6Xdts1m
         EhDg==
X-Forwarded-Encrypted: i=1; AHgh+RoMRYriqNKYsrK1kTaDr7tV1t+VPpVs3PEoZfSSKa5XO7pJvGem9bb4jJW/PkIWdioxgbmlpv00o1yD@lists.infradead.org
X-Gm-Message-State: AOJu0YxzQuVozIehf2UcUWzWRucJzy6qSSS2vn1TaWZ/PTDR/bLVpeO/
	QJrzI6baVrVMBWYCAFX+H7zkQHA7Wqn6s0hkK9r6gLnc/USE0RLrp3TA
X-Gm-Gg: AfdE7cm26oS+CZIogk5JnKV7arecC+WRTjm7P34NMPQpqbFeaoStJhXMhONh05a2eKl
	ziSLpIK0A+G/jxMAXlC0f02+SiiEvGoOzAnR0Q9iT1h82nCe99sir2a+vaQDPAKEdVVg1mibrZo
	MtN2ucYi2Z3zTAIyMyXlHbla/t1IADTaJsVnEmPmSU63AV7Dc/DECdRY8mNtnPpiHv8KbXPeE4k
	oCRJdsIdwrAw36gCaTelwB5N80/xcjzkmDLno4pk/HwxNM7ggS/IRmBnhUx59au+RrvvZhRF6nX
	F6gmQ5uAz2vcFaSziImzv9IbVDnMZPOWFs6iEsprCjdtszIzYlQEIAkueodH+lHoXTnLPpucTF5
	NE2XSzb/N+fu8pDovb6YCGfNa5e2/E2Gor8wlHWpXEy2vFR1SVD4mDSOfv/3ulxoMdQLGkkLqpx
	JpgnXTp8N1ozyVqgBqlevt5vO0twj7nLpvv8V1YZKkOYB5Lp5956K6FPy9J6JIHT0SInNAyVVqM
	B9K12fJOj0VjhaB1Zzx7C/hyPD093Cb
X-Received: by 2002:a05:620a:270d:b0:92e:717f:e0b0 with SMTP id af79cd13be357-92ecf5b4811mr1052722885a.12.1783650622549;
        Thu, 09 Jul 2026 19:30:22 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm88854685a.28.2026.07.09.19.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:21 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] nvmet-pci: validate endpoint queue IDs
Date: Thu,  9 Jul 2026 22:30:13 -0400
Message-ID: <20260710023015.3744082-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_193024_692633_5D73FA56 
X-CRM114-Status: UNSURE (   9.50  )
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

A PCI root-complex host can crash an NVMe PCI endpoint target with
malformed queue IDs. The endpoint transport allocates its SQ/CQ arrays
using ctrl->nr_queues, which is capped by endpoint interrupt capacity,
but the common target admin validation only checks queue IDs against
subsys->max_qid. A host can therefore submit Create/Delete SQ/CQ commands
with qids that pass the common checks yet index past the smaller endpoint
transport arrays.

Patch 1 rejects queue IDs outside ctrl->nr_queues before the endpoint
SQ/CQ arrays are indexed. Patch 2 adds same-translation-unit KUnit/KASAN
coverage: a valid queue ID that must still be accepted and the
out-of-range Create/Delete SQ/CQ cases that must now be rejected.

Reproduced with the KUnit/KASAN test: the stock Create CQ path faults in
nvmet_pci_epf_create_cq() after nvmet_check_io_cqid() accepts qid 2 with
max_qid 8 and nr_queues 2; patched rejects the malformed cases while the
benign control still passes.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  nvmet-pci: validate queue IDs against endpoint queues
  nvmet-pci: add KUnit coverage for endpoint queue IDs

 drivers/nvme/target/Kconfig   |  11 +++
 drivers/nvme/target/pci-epf.c | 151 ++++++++++++++++++++++++++++++++--
 2 files changed, 157 insertions(+), 5 deletions(-)

--
2.53.0

