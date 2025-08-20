Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AA2CA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 03:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oBgF4OquzXHZJ3H0RI6thUlJhwBomlwAaCvZIMnO3U0=; b=crqsq1pWH4qpMVVsjjyz7I2Lw0
	Gx2GcYEyzhIkmT0WUJfOw+V7PRL2FRqNpPhWJpbdvawsnBoYU/lF8cwhSUCFe36qIFI4/E72cTD9M
	Sf+Aj3z4E5azDXXKEOb/ce/cRFZKJUlBuzWBamXmPz0le/Gp5jg5Kf4rl126oX/8skO3n1Cv7cbBS
	9OF4V/yNiC8naSN5YnYg9Dw7gUrHGU1pzVKgiXJYwgHmQww01qw5+nXFiYUePVGGDarcGopqrS/f9
	i8h4V7BFDGe9fEcUsMi4meFnya+a0oWqFRweAlcwr2vfhjhlFBjc5N/FTXycl1ueS50zTsyfaU+ST
	6tJrgIOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowE8-0000000FhhB-1U1q;
	Thu, 21 Aug 2025 03:44:36 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoqQU-0000000Ezu4-1YV7
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 21:32:59 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3b9e410dbe2so43709f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 20 Aug 2025 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755725576; x=1756330376; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oBgF4OquzXHZJ3H0RI6thUlJhwBomlwAaCvZIMnO3U0=;
        b=FGC1ykDsCPixOnAZX//6vUoLQvqi+CfTawzH2l00tbfd1+7qVSFKjDqF19wcuQ5HkO
         55ttxHwSHzufYo8+XncFFGS+IpAKEjp5J/daRLnttrrgzvQShGv5JLPVST2b6uE/ttUC
         dDKKR71DzUgQr+OS3Z3IEymabQoECIXoeX1dQ0ooxXfj46VfwzxGClYbPbeTmxlkc8PZ
         doHjtM3GD4EX1qEZNOWo2npfFL+1wevdeNTJWlS6tuJC1D9ADqgyMKpTgBau4u+LukbD
         WrIMc/Lr6W3UVi+4uVWrENcgfJMWeWH6DjDCyA/i/vuUiJLgjcD9UEaPzCpZGxChwWaB
         9XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725576; x=1756330376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBgF4OquzXHZJ3H0RI6thUlJhwBomlwAaCvZIMnO3U0=;
        b=J0qoH/2p+4f/86fQRWVhxQ4YdTcrbCseVcVROb+fUe6j0qH70Px6+Y+pZIZ0ARhNTn
         Z8cnMlA5pFmkPjWfV1C9zipsgUc2Pa97M8e8LNFp1v5lW763bh3N5PEYnu/s5GllT2HY
         2FDp3+ef3LittiWBHTfgRPaiA8zjPe1+RlI7dxNj0FRXKoLR/jqY0GwpjduWjyeAd5+C
         oDTnhvZEFtNOE0KE0PCefwNoMOS4vP4I5dSLz9Lugy46JNKDP0rB0JixtSHuzFMlodE1
         gkT/PdFOKiEEsnN5FjEr5INvZzoVwimJMCI4Dbd2Y6I8HDHeS6THfFMH5ZBdvOQWkjaO
         EAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+dJq+2kMQREpI3tK3J5oZGthkb30T9ikxEx2hAgX/rCviHqXh28LtK/1bT1xMGatRgfiEyxBFJw/0@lists.infradead.org
X-Gm-Message-State: AOJu0YwJjkPZdR2UgbpKhP5fADwb2T9pa84WGdyDXrgEq7leravIQJ9J
	WePxxIYZIGiTC+g9W/bOrKmLMFzEylJsTjYRbh5VUWFDF27vNO72yUY=
X-Gm-Gg: ASbGncucFf9ZjJJpbcRi7f+R6xpCwEZiZGBGbfiRvGdPzwicqbiZs9o21pjct5apQJA
	RzLa4fawKvDWG69+flAeiaApCTeDWted6V7cCEDc5elxLWW7HxWtp2iPx/b66JEh2hKbxwFXSMb
	sj+yIMFyuRoYOhpSxtAO5CMw0GqSsdeNYEbG30FdLUyvaij2/NDRoIt0sYsrXLQdfjhiRdMHvqe
	i1CmtTbXrLOmII8OvdbtpvWibR7AhgHv/sA3nY+Ub+HdHgMO8aoFQVhIAilZFt20VYGAEkdtGL5
	vRTidiFsrAHZbWQUhMKIJMRLOPO5I02M8SmmmtuEI+lshz8QqtMkjh3HgRURBE7fUMlJ0uyWxpW
	WNRC1Wl0PG2Vx0Sr+RiWt1OFn+w02wlDYCIOAepw4iEtYIHPfmjUGR2iqSC0YBb29Tsp11CU=
X-Google-Smtp-Source: AGHT+IFpaHt+QNsQklADoGadGLHhabEswBSBpdvkzZPtjH45BGr00qhJfUN625Zw9+3cWWc9heSYhA==
X-Received: by 2002:a05:600c:4f83:b0:459:db79:2102 with SMTP id 5b1f17b1804b1-45b4d86bfd7mr76075e9.7.1755725576267;
        Wed, 20 Aug 2025 14:32:56 -0700 (PDT)
Received: from localhost (67.red-80-39-24.staticip.rima-tde.net. [80.39.24.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c54c8fsm47614545e9.16.2025.08.20.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:32:55 -0700 (PDT)
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
Subject: [PATCH v3] nvme-cli: nvmf-autoconnect: udev-rule: add a file for new arrays
Date: Wed, 20 Aug 2025 23:32:53 +0200
Message-ID: <20250820213254.220715-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_143258_415406_9C6A454B 
X-CRM114-Status: GOOD (  15.21  )
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


v3:
 - add Fujitsu/ETERNUS AB/HB
 - add Hitachi/VSP

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

This will be the last iteration of this patch, there are no more NVMe storage
array manufacturers.


Maybe these rules should be merged into this new file. ???
71-nvmf-hpe.rules.in
71-nvmf-netapp.rules.in
71-nvmf-vastdata.rules.in

---
 .../80-nvmf-storage_arrays.rules.in           | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in

diff --git a/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
new file mode 100644
index 00000000..ac5df797
--- /dev/null
+++ b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
@@ -0,0 +1,48 @@
+##### Storage arrays
+
+#### Set iopolicy for NVMe-oF
+### iopolicy: numa (default), round-robin (>=5.1), or queue-depth (>=6.11)
+
+## Dell EMC
+# PowerMax
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="EMC PowerMax"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="EMC PowerMax"
+# PowerStore
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="dellemc-powerstore"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="dellemc-powerstore"
+
+## Fujitsu
+# ETERNUS AB/HB
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="Fujitsu ETERNUS AB/HB Series"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="Fujitsu ETERNUS AB/HB Series"
+
+## Hitachi Vantara
+# VSP
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="HITACHI SVOS-RF-System"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="HITACHI SVOS-RF-System"
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


