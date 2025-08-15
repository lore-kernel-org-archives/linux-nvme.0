Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3796ACA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5Ylcn4Wco/h8ojb6qCegLZ80xxCJcrayUH2qQLbr8Hc=; b=LlbJ0M6FBAm2gvEZ/uEKBZ3UFc
	aXA4Pe6hpudHLKQ5wSNpbeDrGjDvonoyie+NulmTcr96p2dPT4jMaeQfZafSBSaaO9dKcg3g5zxG8
	QhrRUDlMmWV2Opi2NTkCntaG/cnT7VcWG2pJwqRGv5K8YBMZgI1En+ymZ+SMWGIAIPWPGsd/vxvH7
	TVe0cc/YVDreE/SobMmtzPTsHazY56fPIDyau7MOtlFZfsL0AdlE0TZSNdfqu64zSX/5hC2e/pU5h
	j2EzQu9rmRoNRinPfpzXH11o6hf+bEf4KVNbzXOk/T2zMVlgi06kcilnvxTOZ/DBA7IIl0D0Qazq4
	+XOMOK+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un22Q-00000003YOa-3AkP;
	Fri, 15 Aug 2025 21:32:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un0vk-00000003T1h-3A1t
	for linux-nvme@bombadil.infradead.org;
	Fri, 15 Aug 2025 20:21:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5Ylcn4Wco/h8ojb6qCegLZ80xxCJcrayUH2qQLbr8Hc=; b=j/M9DxMyNMf1GlnQEZhxOq9Yei
	kR3eYUk1GV/hM7o0jmRYnLFp9BsZbTZaO87QI5uAoE7udZBOkXaGUNELuvU8LFBH7kZFIvVBh9P8T
	wtjoDZbX7zM1pslCf/3cOt25mzFiEMusH7wp5xTvB56e6RgR+LTJ5QKCq2wQ/33Ocbh81b6LsoSKE
	4apv3vC/TS9hMJAT2vcyFpoI/FPuILzdgV2KnLNlMKMODJxjEHLnutOC3podsV9lpsp/P/8grnOZ3
	P5IGM6qmwjrcXJ6gljDMyQZQt9ywRnqkMHfyZt9ruccNKMKq1LoYuTdEMne3iA8aJfEBUcfNqtjQi
	rQrz//lA==;
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un0vh-0000000Gp5z-1aLm
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 20:21:39 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3b9d41d6e34so51715f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 Aug 2025 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755289295; x=1755894095; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ylcn4Wco/h8ojb6qCegLZ80xxCJcrayUH2qQLbr8Hc=;
        b=JltBEhd0Bo9DtSzP4YGXoGSK+M32I4Vj7nsYCIhaz4DDeKZoobjF/X0NRTTOgBorDI
         W+/4aghCopm6lMTHh74bAvBTEYY3YC/28szX0P2Qw0ObAv7C19mPNZqZGF/Eashse9Ks
         BGmmu2eQxt//sUO9CVt/P7ObISuKMGyL1Qlg5QnjSICZullRU49Cienc9YG5KC4swLBE
         8I9KP01PrdGAQOjH3Rsl8c1b9AZJjDnkl8JLjZog4Fte2XhIP+dvyABcv9Ze897nGg+j
         1vTZTRtZYLPydR+Dio05hzVKeq2XS7SP1CCj8/lGHf1nMGTrB+TuTlnotEx1iFbwCseX
         8PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289295; x=1755894095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ylcn4Wco/h8ojb6qCegLZ80xxCJcrayUH2qQLbr8Hc=;
        b=WW8SvApi2+zP8UX47RSmoy0froEWBzNomOw2opDMeoRVSs1A5TAlwzzwibUOBUAHqL
         0iz48qOmlQ8CeNtxQO3TkNoB+jGQJEEAac/D/kiAaTcIHFBXfciNfFvTukAmni8n4tSL
         0CtZmporVbptDsk/SGIaN6vuMFlWS1b4/8kojkMse9VOKrvPFXfN15IvbU7UNhfXML54
         8Xli6PGAXy3WgjkHlTfJ9QZj/W3YqhUFUx+ijYUrxqcazMm42Nj6pJlqrUdSFeLRb/q7
         xRytyNohExiAxA2mZwFOJ0ssu3fz8Xn28pSfo0kfWwWERWoCXzQWr3/OVAaHyNE0zR3j
         kLag==
X-Forwarded-Encrypted: i=1; AJvYcCUQAccgKNUnQpkP2bzqV55xCKCF/8nkHAbSMdN2vr5p3o4AuR9yxeME94ltMv4M/BcXqdhp6oknQMFp@lists.infradead.org
X-Gm-Message-State: AOJu0YyKsYhK8fvC/bqSrR/hvm6/TEKXW9kBnyrHbZYPxHi3z7NJvN/Z
	qLXbrNF1cksnCMiePw8Gequ4G0vs9Xl4sbRKTfm1vw54sByWM7lmk9s=
X-Gm-Gg: ASbGncufItGQW42bImCG4Idl9YoC0aKn83NaalY0mXX7IbSov9CTSpukuwuJxuZpTAF
	+osgCPJQIni7rM1m/035S1I+CD6ySDvv7meYbH3LvaMG0YuWYErsU6f0qcOwL0p2KxHXokpNYgP
	IUJWY8CdBGT+3NlSRqtqihsqjEMHWEfV5aQEKtpTmrPPl9BJjAmALTv3N5vfQHyABAY0F0q/1Qz
	DWIsck2o4hLE1NYEwmjYqynwLKiacMKQHtKcMB2Y5choKhXX3TlLQrOSO0v4LdDMYpNUaMj5dEp
	CXwPlnktVk3WL+UL7NbVxP7mBw3V/Kw3L1hje36FiB5n7XQhyAqpFt45wTD/rkDit4xrG52/C6t
	ZTgc9Fzpjqw+RQ1o4+GuHPRF3qRDj1yJvKZ1ylBzBUkXrUm+GbsNQEswYeqIu
X-Google-Smtp-Source: AGHT+IFljB5Ln/Tudt+a3E5R8ncefZQrJRNisqhDoxJaiqKOizwRXTpFBYvPTGGTkK7LobAriER9EQ==
X-Received: by 2002:a05:600c:1911:b0:458:bb2b:d74a with SMTP id 5b1f17b1804b1-45a21895d32mr12468775e9.5.1755289294539;
        Fri, 15 Aug 2025 13:21:34 -0700 (PDT)
Received: from localhost (67.red-80-39-24.staticip.rima-tde.net. [80.39.24.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78c221sm74372375e9.26.2025.08.15.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:21:34 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Wayne Berthiaume <Wayne.Berthiaume@dell.com>,
	Vasuki Manikarnike <vasuki.manikarnike@hpe.com>,
	Martin George <marting@netapp.com>,
	NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
	Zou Ming <zouming.zouming@huawei.com>,
	Li Xiaokeng <lixiaokeng@huawei.com>,
	Randy Jennings <randyj@purestorage.com>,
	Thomas Song <tsong@purestorage.com>,
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
	Simon Schricker <sschricker@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Wagner <wagi@monom.org>,
	Hannes Reinecke <hare@suse.de>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	NVME-ML <linux-nvme@lists.infradead.org>,
	SCSI-ML <linux-scsi@vger.kernel.org>,
	DM_DEVEL-ML <dm-devel@lists.linux.dev>
Subject: [PATCH] nvme-cli: nvmf-autoconnect: udev-rule: add a file for new arrays
Date: Fri, 15 Aug 2025 22:21:32 +0200
Message-ID: <20250815202133.51160-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_212137_592543_735083FA 
X-CRM114-Status: GOOD (  13.35  )
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


And it is unnecessary to set ctrl_loss_tmo to -1 for NVMe/TCP devices,
because it is the default.


Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>
Cc: Vasuki Manikarnike <vasuki.manikarnike@hpe.com>
Cc: Martin George <marting@netapp.com>
Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
Cc: Zou Ming <zouming.zouming@huawei.com>
Cc: Li Xiaokeng <lixiaokeng@huawei.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Thomas Song <tsong@purestorage.com>
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
Cc: Simon Schricker <sschricker@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@monom.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
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
 .../80-nvmf-storage_arrays.rules.in           | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in

diff --git a/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
new file mode 100644
index 00000000..a2c952a5
--- /dev/null
+++ b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
@@ -0,0 +1,33 @@
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
+## Pure
+# FlashArray
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="round-robin", ATTR{model}=="Pure Storage FlashArray"
+ACTION=="add|change", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{iopolicy}="queue-depth", ATTR{model}=="Pure Storage FlashArray"
+
+
+##### EOF
-- 
2.50.1

