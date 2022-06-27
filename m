Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50523C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R3kUm8L8dbo5yxZeZHoWHUqyd3tAQAUvrkHml1MWaVQ=; b=fYUV8wG8SAfSO8+0ulr5BSZ4lg
	dusRl/oaxfIXLOxmc95vZvx9o9YMD1BG4AbPfKHmxICj14KHZBYbAky4VMO9C2zB+KhLm3VrqLAeC
	FRj/6uFdus3iDWniWgRsv4WF8YBdnqri5YjLMhJken5KYNBROWZoTpj8u+4+fmejwqVyezQ/cJO7H
	AdKD9+EEtxrqjQ7Ywj7h+1e846DDfO8yCGYZG4B9LMlsIRNCqXnTeBkxWqMUlRi+1pQeEp/HWmFsf
	yfOJ7huvDDA8iVUePCHy17pMYA/umnEM1RdYDpnFvY44T0SRoeTqjHLJCiSN4rEuSSFklSYh875EU
	kjljLX5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5jqf-00GhPK-S8; Mon, 27 Jun 2022 08:11:57 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5jln-00GdwL-Fs
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 08:06:57 +0000
Received: by mail-wr1-f43.google.com with SMTP id o4so7865813wrh.3
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jun 2022 01:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3kUm8L8dbo5yxZeZHoWHUqyd3tAQAUvrkHml1MWaVQ=;
        b=zWUx2o6lEPxuMNpaYJh8WHtbFbf1dRGkAkvIa09+1PGz4OLO/swiozE6nMOurP//b8
         PCatNWF3H68a3vstQZnC4kxOgKTH4ItCMveKJS1K6rUnnpEMlI4XfneC35Xagcb+WVNQ
         Eu52SbTitJWr4l49nJDE1I9Jbz0QJr8kajDDEe1z2JxTtX8yVRyto4NTCp/SRkuQ+SdO
         FMCzYoyOcsuFfyvWNQyUtOtd5+ovvbMrLf4PAVfDqa3FOlCplYdsq1m0in2g0oLou4YT
         Pke+ODVsDQwqpdtuyrn8aQWB6oboh62opbhO96a3zcSdtBgfe/7v2j4awrVAn9/EUqph
         00Gw==
X-Gm-Message-State: AJIora8+hUBGJ0jRgxZGSFb4AT5mYHjsmD/v7XH6WwxksklBYqLG2CpF
	ZJXaILFJWY/rQt6GJt8ZCXNDIy/wONw=
X-Google-Smtp-Source: AGRyM1shWndUoRmcf4X30agq6IrDiixTk+8LrBLdA1ntqaYAZED/ue7s1orwC8TPzeqo4duNMOijVg==
X-Received: by 2002:a05:6000:104f:b0:21a:3d3a:4d3d with SMTP id c15-20020a056000104f00b0021a3d3a4d3dmr10643933wrx.528.1656317212804;
        Mon, 27 Jun 2022 01:06:52 -0700 (PDT)
Received: from localhost.localdomain (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0acb00b00397342e3830sm13906894wmr.0.2022.06.27.01.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:06:52 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH nvme-cli] udev: re-read the discovery log page when a discovery controller reconnected
Date: Mon, 27 Jun 2022 11:06:50 +0300
Message-Id: <20220627080650.108936-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_010655_594485_EECC0024 
X-CRM114-Status: GOOD (  11.22  )
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

When using persistent discovery controllers, if the discovery
controller loses connectivity and manage to reconnect after a while,
we need to retrieve again the discovery log page in order to learn
about possible changes that may have occurred during this time as
discovery log change events were lost.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
index 434cc080ffe3..245e0d0dbad0 100644
--- a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
+++ b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
@@ -17,3 +17,10 @@ ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="0x70f002",\
 ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
   ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
   RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service"
+
+# A discovery controller just (re)connected, re-read the discovery log change to
+# check if there were any changes since it was last connected.
+ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="connected", ATTR{cntrltype}=="discovery", \
+  ENV{NVME_TRTYPE}=="*", ENV{NVME_TRADDR}=="*", \
+  ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
+  RUN+="@SYSTEMCTL@ --no-block start nvmf-connect@--device=$kernel\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"
-- 
2.34.1


