Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCABCA0EE6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 03:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ru0e4pqocRWcS1MvPzlktvsHunErnNzt0vSfk38dJZI=; b=uy2HHN+OBaOqo+DHw671ECjvhU
	RDKW4U6eN/q5lTs38TEq15/mgUZDu1Ls/SEQtLQYLeZWmn1/uVgjEPU2QcU3IAsypr/wEIYHvNF9S
	R02QHF6YV9/FZNTjnL7/j4qlNiZ8WrhvzleIqSIk0HcT48dwSGdlbVOS+Uo2EiCoPjPD59h5LTpmq
	VbRF1XD0oSa9VVGl08JGVRjyr+pl6xhJVR+gRQEvoUbwcaMSJ9wsaZn6CaNMZBH/Z6J1kTCx3Kh1c
	t1Lp5kptYL+8YbQ8XQy4sXnGVDCEFOBAbH1Pqy2qSl8mcQRyqXrYX24SoRm39RF5/WVKf+xRLdbke
	qQgn2OGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowDp-0000000FhDi-2wus;
	Thu, 21 Aug 2025 03:44:17 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoKKZ-0000000AFJW-434a
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 11:16:45 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-45a1b003d05so873165e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Aug 2025 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755602202; x=1756207002; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru0e4pqocRWcS1MvPzlktvsHunErnNzt0vSfk38dJZI=;
        b=OElVtDbIqqvg1SswDrl+TY5xnt4YFipMIcmFmK/NZ6RaAR9FVvjFtGuthUOrb4Mu2+
         snhIl8rsnzSCBUT1A2XYyfv5Ev+YJOwZB1i5wXSTqsv3UDUVSegQe8q3l9186hmDMejO
         7vD3DRabJe0Tz354qSDJb1avMzT55AfDPmt2giL9fv9tbAmMEkyjhxs6pAhZDXiqYVyM
         xvcB+Kkk3gkeFio/PACp/ZzmJFO3TAYy4PoYG4Muv3gCEDDeewtMz6xli5GtZY+r3fph
         0oqdGHk+Bw0UGOtJVsqkVzPtBRdAAgI6YtqDrJwfgco1nQqlS058acVRmXnibpfjdnhV
         w9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602202; x=1756207002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru0e4pqocRWcS1MvPzlktvsHunErnNzt0vSfk38dJZI=;
        b=OlWwEJnK8hHau3Xzu2HAW6otmrx+edSlHa+hHUVgn/rR/fgOoT2HuvQeybhzQh3gx7
         X8mRpT38rEkmCCARDjZ18sI3owaFHuxF+nliG3yJ+qI4Tb49sWfDYENhQMJQdzg9icFT
         rj3woQzkH0029pEwW653fYmChGIGX8QpGx4xImy0ch5LW3CWODoRyTD/0aJBZtjOlI0X
         WwYfdzQWCRAhlt0epS7TYJrNRW0LtJdUjJ/TJ+v/zE318fd+POWgRpDYzAealGPWffry
         H0YLEmUMtyDJFSBOSnj0QGGovZQQ287n66baYIvay7NDXX39hr0Vy8cZY3QPl+pPiZ6j
         CT3g==
X-Forwarded-Encrypted: i=1; AJvYcCUtG2ZViVmmTNtZ6Mvb9//5JF/lR0cI+JrWAsCg01c1kzQdXXhFl77dCR6yVhrg4iIZ2+7ORwuGUIL5@lists.infradead.org
X-Gm-Message-State: AOJu0YzgM/a8D/uWw/kHknpF49L/8IM0BAypcPkJWr40F/5ELuN545og
	GqisdVDwebD1qZgCIDlUhu7iJ5Up1goby8SccP/wxqdm4KVFVSQmi3I=
X-Gm-Gg: ASbGncvTxwjj3QvD2KsNACBFEJuBE27HSERzVNzknGiBNOWVi7q0qNoyxWafZJoO2Ru
	WlK3xC+hfZPJUS2TFn9efcb0jVzL8oLoUmAT4ixeV4Jb2q0pLgxduwk2T22beXXJJau9oRt4hW4
	z3p/5bgLyt51wEz5InjHMDrQYZvAMS37ouiiRzdhDpEGAEcZY3whhtvd1cHwKEx9uN8CTVRmdtV
	NRZ5sl5JncaCqTR8e6YQBhyUOviT8NdOLB3+HuwTltyaaWMJqbpFrW06GRbRUZtQWcddxbomEd0
	+GaimgOmqsG08A3rn6qP1vXOGDOdhrSusM0Prb0nlNHBVAb3ClJ+hFvnMWM0n1yaQX24A7EMSwM
	bocIdZtBKd5k/fn9TfQd1Cu/mSlyy8LbZFsKssbg8mut3V3LctqbqKCcWFoLj
X-Google-Smtp-Source: AGHT+IEjJ0o5DGL4y9TOsIn9ugdBJNIj8kFoFW53rL7KFzsI7YsinGg3Plurh9O2DBq6QatfYXDUww==
X-Received: by 2002:a05:600c:1c92:b0:454:aac0:ce1e with SMTP id 5b1f17b1804b1-45b43e0086dmr8414275e9.4.1755602201497;
        Tue, 19 Aug 2025 04:16:41 -0700 (PDT)
Received: from localhost (67.red-80-39-24.staticip.rima-tde.net. [80.39.24.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c773e57sm222640615e9.23.2025.08.19.04.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:16:40 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Wayne Berthiaume <Wayne.Berthiaume@dell.com>,
	Vasuki Manikarnike <vasuki.manikarnike@hpe.com>,
	Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
	Martin George <marting@netapp.com>,
	NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
	Zou Ming <zouming.zouming@huawei.com>,
	Li Xiaokeng <lixiaokeng@huawei.com>,
	Randy Jennings <randyj@purestorage.com>,
	Jyoti Rani <jrani@purestorage.com>,
	Brian Bunker <brian@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marco Patalano <mpatalan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Wagner <wagi@monom.org>,
	Hannes Reinecke <hare@suse.de>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Christophe Varoqui <christophe.varoqui@opensvc.com>,
	BLOCK-ML <linux-block@vger.kernel.org>,
	NVME-ML <linux-nvme@lists.infradead.org>,
	SCSI-ML <linux-scsi@vger.kernel.org>,
	DM_DEVEL-ML <dm-devel@lists.linux.dev>
Subject: [PATCH v2] nvme-cli: nvmf-autoconnect: udev-rule: add a file for new arrays
Date: Tue, 19 Aug 2025 13:16:36 +0200
Message-ID: <20250819111638.252890-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_041644_007661_AAEC5524 
X-CRM114-Status: GOOD (  14.27  )
X-Mailman-Approved-At: Wed, 20 Aug 2025 20:44:16 -0700
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

One file per vendor, or device, is a bit excessive for two-four rules.


If possible, select round-robin (>=5.1), or queue-depth (>=6.11).
round-robin is a basic selector, and only works well under ideal conditions.

A nvme benchmark, round-robin vs queue-depth, shows how bad it is:
https://marc.info/?l=linux-kernel&m=171931850925572
https://marc.info/?l=linux-kernel&m=171931852025575
https://github.com/johnmeneghini/iopolicy/?tab=readme-ov-file#sample-data
https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf


[ctrl_loss_tmo default value is 600 (ten minutes)]


v2:
	- fix ctrl_loss_tmo commnent
	- add Infinidat/InfiniBox


Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>
Cc: Vasuki Manikarnike <vasuki.manikarnike@hpe.com>
Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
Cc: Martin George <marting@netapp.com>
Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
Cc: Zou Ming <zouming.zouming@huawei.com>
Cc: Li Xiaokeng <lixiaokeng@huawei.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Jyoti Rani <jrani@purestorage.com>
Cc: Brian Bunker <brian@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marco Patalano <mpatalan@redhat.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@monom.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
Cc: BLOCK-ML <linux-block@vger.kernel.org>
Cc: NVME-ML <linux-nvme@lists.infradead.org>
Cc: SCSI-ML <linux-scsi@vger.kernel.org>
Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---

Maybe these rules should be merged into this new file. ???
71-nvmf-hpe.rules.in
71-nvmf-netapp.rules.in
71-nvmf-vastdata.rules.in

---
 .../80-nvmf-storage_arrays.rules.in           | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in

diff --git a/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
new file mode 100644
index 00000000..ceabba31
--- /dev/null
+++ b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
@@ -0,0 +1,38 @@
+##### Storage arrays
+
+#### Set iopolicy for NVMe-oF
+### iopolicy: numa, round-robin (>=5.1), or queue-depth (>=6.11)
+
+## Dell EMC
+# PowerMax
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="EMC PowerMax"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="EMC PowerMax"
+# PowerStore
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="dellemc-powerstore"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="dellemc-powerstore"
+
+## Huawei
+# OceanStor
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="Huawei-XSG1"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="Huawei-XSG1"
+
+## IBM
+# FlashSystem (RamSan)
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="FlashSystem"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="FlashSystem"
+# FlashSystem (Storwize/SVC)
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="IBM*214"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="IBM*214"
+
+## Infinidat
+# InfiniBox
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="InfiniBox"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="InfiniBox"
+
+## Pure
+# FlashArray
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="Pure Storage FlashArray"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="Pure Storage FlashArray"
+
+
+##### EOF
-- 
2.50.1


