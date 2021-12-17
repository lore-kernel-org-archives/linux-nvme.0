Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F53EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Dec 2021 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tv/MWcvXcHij8UlOsMSmCcDxTSvMgW5rXSjgkQciSWA=; b=pGKGRSdRAzZcEG8TiK/dheE6Rz
	mMppyToU2kR66nI6hMmYcitjPMjG6W2KS6qwlP7VWERpLvKyZIjVZpr5UXNjTE50XvSNzElVtGGn7
	geL4PfbhltaNsDFUYAymRZEXxAVHkIkq562ONtzEOZP6UwkfMrZGPBjs9mlhIYLMjjKOLGNmXZ1Qw
	8bAC/cAnChPAzDiQ5/b7DfzXIHNra2NKinkWHDBHlkP/uCgLsnmEEilStywpcAEdNSMBbkUPcWP+B
	g/4OIJdkftQ7AfqQG7NBeXI1zLFUIRGhdnU5/ihf58A/2Xnd4O7QpkIBQ89uEn1CVHlnoywWTBJYx
	Oo5TSo0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1myIyA-00C8ft-I6; Fri, 17 Dec 2021 19:32:42 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1myIy8-00C8f4-2J
 for linux-nvme@lists.infradead.org; Fri, 17 Dec 2021 19:32:41 +0000
Received: by mail-pj1-x102f.google.com with SMTP id
 f18-20020a17090aa79200b001ad9cb23022so3753006pjq.4
 for <linux-nvme@lists.infradead.org>; Fri, 17 Dec 2021 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tv/MWcvXcHij8UlOsMSmCcDxTSvMgW5rXSjgkQciSWA=;
 b=SDQFbvSB4U5yKnxlvRiYjXZWbaNN3ZNHZlNtOqJgTvuj35Qdj1tM5VANPtfKFPabXJ
 XYkiie3XLhqxL1ABl5rLMLQlIONcBuuLtwnKfZOoAeM9cExtm6mtfiAoR57R2iiVl9C3
 KZ5rEYnjVczUOOHICOMBVy8fqdvyI2A4SDMWyWy6o5pBqwLfu3jCwaFCbDgRdzLE6A++
 6gjU77zw3bMP9b2s4pCEIDum6i49Uw451xfUirvjWtxA1feHjxOR7VG+nFVYH1mAZm5M
 Bz/oTLlQVv6vW5zWFYT9O8ImA8UwkXKIBRa1hRaGor/3LBTJ/L23Hur52cDC2AoGwxrt
 Sfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tv/MWcvXcHij8UlOsMSmCcDxTSvMgW5rXSjgkQciSWA=;
 b=ny1A/9XinK5RB0F0CFptDcedsg0+9GfagFzuvNit3G8u8pUkXUDo1hGjE+cyFCWIni
 BDeScRXSibOAueP73AACIDeOmUNt47MQUykD/PuaVJReyH8IU8r5TH8ft/K8b/8L7vZB
 VmwKqpFDN1FVko4yniMoYlAvat7ONVhfW5pHfJQLace/lMwVRroHXJEu5bR++Co3vJVV
 Aan6+9zlXmoMnfHybNUN4XoIRe93yTJyVQjYo9pJYAwVPKDf4nKPOspGLoc/bappbmU8
 szEj0E6MvUzRcGBVRFu+Ol0aptYxRY/CBgPgNk+Q8/MZoyieRfGj0CnWTni3MAaKWckL
 sM3A==
X-Gm-Message-State: AOAM530/GK6chQH44cZTk3v3Iqfhu/MuTiaZy1j4pDAPGrRdQDor01mz
 e7benLKDohUgPkyrL7Ctu04Pk3DW8M8=
X-Google-Smtp-Source: ABdhPJz3awxxhERKZ++kRg7UVkrGXmB3CbBiPTP9zrn4wRstACLyXyfWOGQzjUF7Br2IgcqCzRrSZA==
X-Received: by 2002:a17:902:9a8c:b0:148:a00a:1eec with SMTP id
 w12-20020a1709029a8c00b00148a00a1eecmr4795160plp.61.1639769559238; 
 Fri, 17 Dec 2021 11:32:39 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id v25sm10331520pfg.175.2021.12.17.11.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Dec 2021 11:32:38 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: James Smart <jsmart2021@gmail.com>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH] nvme-cli: nvmf-connect@.service: Remove matching from default
 syntax
Date: Fri, 17 Dec 2021 11:32:32 -0800
Message-Id: <20211217193232.29034-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211217_113240_129524_BD68B8E2 
X-CRM114-Status: GOOD (  10.98  )
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

commit 53aab69a0add added the "--matching" argument to the systemd
connect script that issues connect-all to a discovery controller. When
this argument is used, only discovery log entries whose target port
traddr's match the traddr of the discovery controller will be connected
to.  This eliminates the ability to do referrals by the discovery
controller.

Revert the commit so that the "--matching" argument is not default
behavior.

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Martin Wilck <mwilck@suse.com>
---
 nvmf-autoconnect/systemd/nvmf-connect@.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmf-autoconnect/systemd/nvmf-connect@.service b/nvmf-autoconnect/systemd/nvmf-connect@.service
index 5fbf081..c60f146 100644
--- a/nvmf-autoconnect/systemd/nvmf-connect@.service
+++ b/nvmf-autoconnect/systemd/nvmf-connect@.service
@@ -11,4 +11,4 @@ Requires=nvmf-connect.target
 [Service]
 Type=simple
 Environment="CONNECT_ARGS=%i"
-ExecStart=/bin/sh -c "nvme connect-all --matching --quiet `/bin/echo -e '${CONNECT_ARGS}'`"
+ExecStart=/bin/sh -c "nvme connect-all --quiet `/bin/echo -e '${CONNECT_ARGS}'`"
-- 
2.26.2


