Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A28606EE8F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vJu+cGFZ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RvTxP1CA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=FH7Ei2gpGYo/m3TodoKUi5ug60pqHLusd8JZhBhloIA=; b=vJu+cGFZaGl5DRWhVnaqZgp8yJ
	K023ZJ1pA5uyoYgWQaqXFZQjT3Oey5In7D2xe62manaIrbmmBlGosJD0OFQzmZ3A/gjAzWRJKVgLT
	RL0xFv6/Yis4/X0ZLiW7PhlvB0xaDyFX2YzELYI16lbhAi/MiuE08qQMFmeJqtg32hgaMCCX1iu58
	gNZXwYgARCU4xhGn+l6R+Gu7K8YtShPF+54VPMIVMGsbZWEyFSH03UTvCNd0mMscNynJH+wpfkEEJ
	hWOgDgwzbRuvmXWE25SEdO/TDmtjxf7AbsLjcJMWl7xEwmhPNqoCetIzliYWVczxKJIoHsZLvVOzS
	apHUN3MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQSnD-00000001I9U-2Xk7;
	Mon, 09 Nov 2026 17:04:27 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQCwA-0000000GwiR-04Dd
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 00:08:41 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-4946589267bso11179f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2026 16:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182916; x=1794787716; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FH7Ei2gpGYo/m3TodoKUi5ug60pqHLusd8JZhBhloIA=;
        b=RvTxP1CAAtzmn6RYWeufmqUWReY4bgEXeWO5YOhr0aNQ7eJEFynDnKuS3qwMs+j3by
         RcVnA42eb1zZzrevj7IzrIZ4C/pg8R8r2DhLJTmOdHLRTfBovpnOOUtcQDPMJVt/QaGE
         MeudKEst8Zt9z5+X4A+VMFA7fYhyz65f1uEbSjOqMUZc2Q+1c/2OwxF36eAHmTY586X5
         SGy5pPvoPyHsE60+GbGJpuKxlhxutjiHYHCX7bFibZxb3g4wceWx4F3sFjac2E2t7rBI
         V5Fpqk0KuzSjHryxnNmug7us3RxVsCiA90c/gQDOod/hQAIHW+kpDBkTtrodddihvPas
         6CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182916; x=1794787716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FH7Ei2gpGYo/m3TodoKUi5ug60pqHLusd8JZhBhloIA=;
        b=0zpUDKsej8H0mKZgS5oIhGtUaPUxLuxMY71okKTPNfE4ik8767AZgtT0s0qcoUYYjY
         JPQgz6VfBMPxQEKtskHcspqbTikpYKDoom4N5AvGE7NOWo+p4C3pjIamAbDO4RZDFyh9
         zitBC9W+hZiXVWZo++y2a7Wvolz6LNVN2kMl7h+lyC49iNlS/NLhyVu6VSzIr7lF1/q7
         q+d3Yb6c3+D0/d+KGpuib8/IYMi/stCB3994nt7SfwaJ+kADD9ESFEiCEhNkg7xEG0UD
         xlF+016cnggdhZ96YsqMAFsdpCdQSnHrlOM1+PO89L9/qDzBIiXf8+8qvrNCGExkfBCo
         eSpw==
X-Forwarded-Encrypted: i=1; AL+hErGgONupag8CVZWbx/bMsc1FhLjYxjnW9br/xjSJoXrCBtBoshx6haZ2w2htoWNXY2103IGGJgDzPZgr@lists.infradead.org
X-Gm-Message-State: APuU4Z8eEyPJtRxzUy1hrmulYZv5OxRfLnUTrd7tkJL55J+iLPFEMPLX
	DQ1/PC63h603iTI68IoSfB5oLww8CJfJqPRABiFgb+XiUQIjgM+AKxo=
X-Gm-Gg: AYBFou1E4AxbTow1bjJzA/gpjRXb4ZoDStKLFdqhumKmVbrwIF0z2m1za8lvr6UEkZg
	0TwQKHGvns0OnDYXrFF2A998wDz9C1RjWJSk0hKVDd57LknTtt450BEGLs7mWPTFoAJLD6IH48r
	HPJZPYbOUQ8IFOyu3lKHBlSkJerhmImLOuM39ZvSt4crDcUlSx/KM01QTVGiRVvXlmo12H/Ti+L
	ghn/kn/xP3IXrM1gkOHTa5VX32uJCAnkHHAkraMBEMg/4BetCko8y54p9DGFC0f41qby9R3mfOs
	foGPfjI9taVMQLN+6U410pxy23z2elT4TBhKMKY00owTUHH4c7nYDfvRrcLePopSzVj8aBpIB8R
	FqHJLm0CetvVP8ATDp2qsKcyPT/PuJ+s/qAM0BnwDS5lJBLDbi/Ix6iOTa6f74z4DvpeluqyBwv
	CkQUm4RQqlZiEg4k1PaM91zy+ncWBR9Te8SlWWdhyfsVqx6f3N9GNrfOJePjdAd4HgBmS1BcH4u
	Xg+qMa9PJcUAWBkdsuLhOiti+hjA6a35nFAMG1TX9f88is2WeoIeG+iMxwqk0EyHkI8+X6qcWJZ
	GdU1g71zUwvMv5cceqZVjDKmugKbAasbarEVO5sbgoEoOaV5xEDBhlrERUg4ps+5kw==
X-Received: by 2002:a05:6000:2888:b0:48a:f5c5:d077 with SMTP id ffacd0b85a97d-49580eea5b6mr6921767f8f.2.1794182915678;
        Sun, 08 Nov 2026 16:08:35 -0800 (PST)
Received: from localhost (69.red-80-39-28.staticip.rima-tde.net. [80.39.28.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495974660cfsm6755903f8f.38.2026.11.08.16.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:08:35 -0800 (PST)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	John Garry <john.garry@linux.dev>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
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
Subject: [PATCH] nvme-cli: nvmf-autoconnect: Consolidate vendor-specific NVMe-oF udev rules into a single file
Date: Mon,  9 Nov 2026 01:08:33 +0100
Message-ID: <20261109000834.513230-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_160838_112237_2A133271 
X-CRM114-Status: GOOD (  15.54  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:04:24 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace individual vendor udev rules (HPE, NetApp, and VAST Data) with
a unified 80-nvmf-storage_arrays.rules file, leaving the rules untouched.

This shifts execution to the 80 range for a logical sequence after base
discovery and autoconnect, while simplifying maintenance and packaging.

Cc: John Garry <john.garry@linux.dev>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>
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
BTW, there are two new I/O policies in development:
https://lore.kernel.org/linux-nvme/20260815173502.1185929-1-nilay@linux.ibm.com/
https://lore.kernel.org/linux-nvme/20261026111019.3724465-1-kanie@linux.alibaba.com/
---
 meson.build                                   |  4 +---
 nvme.spec.in                                  |  4 +---
 .../udev-rules/71-nvmf-hpe.rules.in           |  5 ----
 .../udev-rules/71-nvmf-netapp.rules.in        |  6 -----
 .../udev-rules/71-nvmf-vastdata.rules.in      |  5 ----
 .../80-nvmf-storage_arrays.rules.in           | 23 +++++++++++++++++++
 6 files changed, 25 insertions(+), 22 deletions(-)
 delete mode 100644 nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in
 delete mode 100644 nvmf-autoconnect/udev-rules/71-nvmf-netapp.rules.in
 delete mode 100644 nvmf-autoconnect/udev-rules/71-nvmf-vastdata.rules.in
 create mode 100644 nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in

diff --git a/meson.build b/meson.build
index 90356ad94..00e9ad1be 100644
--- a/meson.build
+++ b/meson.build
@@ -894,9 +894,7 @@ if want_nvme
     udev_files = {
         '65-persistent-net-nbft.rules': 'nvmf',
         '70-nvmf-keys.rules':           'nvmf-autoconnect',
-        '71-nvmf-hpe.rules':            'nvmf',
-        '71-nvmf-netapp.rules':         'nvmf',
-        '71-nvmf-vastdata.rules':       'nvmf',
+        '80-nvmf-storage_arrays.rules': 'nvmf',
     }
     if want_nvmf_autoconnect
         udev_files += {'70-nvmf-autoconnect.rules': 'nvmf-autoconnect'}
diff --git a/nvme.spec.in b/nvme.spec.in
index 23d3d3268..a37c1a08d 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -36,9 +36,7 @@ touch %{buildroot}@SYSCONFDIR@/nvme/hostid
 @UDEVRULESDIR@/65-persistent-net-nbft.rules
 @UDEVRULESDIR@/70-nvmf-autoconnect.rules
 @UDEVRULESDIR@/70-nvmf-keys.rules
-@UDEVRULESDIR@/71-nvmf-hpe.rules
-@UDEVRULESDIR@/71-nvmf-netapp.rules
-@UDEVRULESDIR@/71-nvmf-vastdata.rules
+@UDEVRULESDIR@/80-nvmf-storage_arrays.rules
 @DRACUTRULESDIR@/70-nvmf-autoconnect.conf
 @SYSTEMDDIR@/nvmf-connect@.service
 @SYSTEMDDIR@/nvmefc-boot-connections.service
diff --git a/nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in b/nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in
deleted file mode 100644
index b050dd502..000000000
--- a/nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in
+++ /dev/null
@@ -1,5 +0,0 @@
-# Set appropriate iopolicy for HPE Alletra Storage MP
-ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="HPE Alletra", ATTR{iopolicy}="round-robin"
-
-# Set ctrl_loss_tmo to -1 for HPE Alletra Storage MP NVMe/TCP
-ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{transport}=="tcp", ATTR{model}=="HPE Alletra", ATTR{ctrl_loss_tmo}="-1"
diff --git a/nvmf-autoconnect/udev-rules/71-nvmf-netapp.rules.in b/nvmf-autoconnect/udev-rules/71-nvmf-netapp.rules.in
deleted file mode 100644
index c76a3c434..000000000
--- a/nvmf-autoconnect/udev-rules/71-nvmf-netapp.rules.in
+++ /dev/null
@@ -1,6 +0,0 @@
-# Set appropriate iopolicy for NetApp ONTAP and NetApp E-Series
-ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="NetApp ONTAP Controller", ATTR{iopolicy}="queue-depth"
-ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="NetApp E-Series", ATTR{iopolicy}="round-robin"
-
-# Set ctrl_loss_tmo to -1 for NetApp ONTAP NVMe/TCP
-ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{transport}=="tcp", ATTR{model}=="NetApp ONTAP Controller", ATTR{ctrl_loss_tmo}="-1"
diff --git a/nvmf-autoconnect/udev-rules/71-nvmf-vastdata.rules.in b/nvmf-autoconnect/udev-rules/71-nvmf-vastdata.rules.in
deleted file mode 100644
index dcd6146d8..000000000
--- a/nvmf-autoconnect/udev-rules/71-nvmf-vastdata.rules.in
+++ /dev/null
@@ -1,5 +0,0 @@
-# Enable round-robin for Vast Data Block Subsystem
-ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="VASTData", ATTR{iopolicy}="round-robin"
-
-# Set ctrl_loss_tmo to -1 for Vast Data Block Controller
-ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{model}=="VASTData", ATTR{ctrl_loss_tmo}="-1"
diff --git a/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
new file mode 100644
index 000000000..1cd6c0c0b
--- /dev/null
+++ b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
@@ -0,0 +1,23 @@
+##### Storage arrays
+
+#### Set iopolicy for NVMe-oF
+### iopolicy: numa (default), round-robin (>=5.1), or queue-depth (>=6.11)
+
+## HPE
+# Alletra 9000 / Alletra Storage MP / GreenLake Block Storage MP
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="HPE Alletra", ATTR{iopolicy}="round-robin"
+ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{transport}=="tcp", ATTR{model}=="HPE Alletra", ATTR{ctrl_loss_tmo}="-1"
+
+## NetApp
+# ONTAP AFF/ASA Series
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="NetApp ONTAP Controller", ATTR{iopolicy}="queue-depth"
+ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{transport}=="tcp", ATTR{model}=="NetApp ONTAP Controller", ATTR{ctrl_loss_tmo}="-1"
+# E/EF-Series
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="NetApp E-Series", ATTR{iopolicy}="round-robin"
+
+## VAST Data
+# Block Subsystem
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="VASTData", ATTR{iopolicy}="round-robin"
+ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{model}=="VASTData", ATTR{ctrl_loss_tmo}="-1"
+
+##### EOF
-- 
2.56.0


