Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24CAC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VqJsIc0SbJbGEuXy3GranTUcHueIpqcNhClDhLvd1Ak=; b=Zp1PzF+VN3u7YPc35pAz9oTFZw
	u881gnbnJdGPGe5uXfcOp1j2/y4vSyeWQssLc+QdFYe4++pHgXoyxL8maHIqzD6cC+1l5sH01h10b
	alr/AbRI8MyAzfhPFioiOcDUm7RbGeMDxz+zzCKwxf37K4cgvcqDLkrDwkLaQ/D9AbtQ5K9l+noRM
	9XdeHx/gu/bj6BM7gcD9x8IfaviwXspcklrBGKwQ2+l6jzdxNlsIy+2r1yUEqQ4Q5tNApfwU+M/5D
	9yJMxbXVPIpFKHfTob5+WeVR4cxHBUFrD9AZRUJHLLh0XIXYb5MF7+hz2TxsMyfDb1uGn502hRT01
	/TBUzv+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noW2H-003t2Z-Iw; Tue, 10 May 2022 20:00:45 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noW2F-003szM-9L
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 20:00:44 +0000
Received: by mail-pj1-x102a.google.com with SMTP id
 iq2-20020a17090afb4200b001d93cf33ae9so2871944pjb.5
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VqJsIc0SbJbGEuXy3GranTUcHueIpqcNhClDhLvd1Ak=;
 b=Bj4mkjtA9Qj5rl3Y0dDYgQPEFLrpHSmq+zVhPtmwzLfMjK2bH9bEY8MwXMSxhOJ/x5
 bDeUDLXCnXwE7SxfF4/Xd1NyT7Z9x2UnieVEeJhrEr0Si3wnAGshA6+2VBpEwSaFZT4a
 d5j4IG6QwHZUxAks8oM3IREcqUeLLfqF5qhLP2FVnp/ppBNX8lg/iXMp3kf02jT2/XwC
 o7tVW538wWsvV76Mkao8CroEEq5MDpw2J8XuD8ydc99mBnB7OMZNvfPkMfIgjAd//9P0
 OymrO/87qiV+i3vTJWPE3JtjD6RjgX7Az40KiyXFPKA54ietCpc936chTybDTeKpArPF
 4XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VqJsIc0SbJbGEuXy3GranTUcHueIpqcNhClDhLvd1Ak=;
 b=o0bDR+hJQPWPy1SVt1Ei4c6EpwKicCnuHy6lCGp9/YD2yTapjItRaPs1EYBvSa57Ji
 6tWNUmnPPOA8O3F70j9Jp7yd9IJOOl0M0fnjt6y6IplJhZn4km0u5cWhe+Qm2MtmijBd
 +TNT1+ubGmdcNmumfU5oCRJG5+CDH2m8iBAyES4qQvQlIAM/EW2OVzyn8CX7obpo3COo
 IZrLHKWBW2bnda11kUi38+NtU5uWay2icatoa/jQTMgZsMawrhQ26GhYjWC3LBvaAn+n
 qr/P2shaSMqu901D48eUD3zyzO2r9ZseBXuLGXyj/JWNTrDSQcdTXGfEOtJokyU0PyDD
 mNlw==
X-Gm-Message-State: AOAM533r15d4SF0vrWqS/xAvrmTnFhcpyPCqSRqD2mD543DfrvJ8edyn
 yNPmrrR9I65d9bkujr4BHANKrSO/Ubg=
X-Google-Smtp-Source: ABdhPJy3n/8nzMr4Ggjf4DWYHoVuCwuUYLoPVj1opnotMITyM3Dmx7x0ICa8tZfpIheoCrhDxTTNgg==
X-Received: by 2002:a17:90b:3646:b0:1d8:15c5:464b with SMTP id
 nh6-20020a17090b364600b001d815c5464bmr1532084pjb.63.1652212835584; 
 Tue, 10 May 2022 13:00:35 -0700 (PDT)
Received: from mail-ash-it-01.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 bh2-20020a170902a98200b0015e8d4eb2d2sm2422679plb.284.2022.05.10.13.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 13:00:35 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	James Smart <jsmart2021@gmail.com>
Subject: [PATCH 0/4] Add VMID support to nvme-fc transport and lpfc driver
Date: Tue, 10 May 2022 13:00:24 -0700
Message-Id: <20220510200028.37399-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_130043_351631_9FBA5965 
X-CRM114-Status: GOOD (  15.03  )
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

This patch adds vmid support to the nvme-fc transport.

Various virtualization technologies used in Fibre Channel
SAN deployments have the ability to identify and associate traffic
with specific virtualized applications. The T11 standard defines
an application services tag that can be added to FC traffic to aid
in identification and monitoring of traffic associated with the
applications.

VMID support is present in the kernel in blkcg, the SCSI fc transport
has tied into the infrastructure, and libvirt has been
updated to support the blkcg settings.  Refer to:
https://lore.kernel.org/all/20210608043556.274139-1-muneendra.kumar@broadcom.com/

This patch set ties the nvme-fc transport into the blkcg infrastructure
so that vmid tags can be added to nvme traffic. The patch set also
updates the lpfc driver to utilize the nvme-fc transport addition.

Although the patch adds a nvme interface, it is being sent to the SCSI
maintainers tree due to the lpfc dependencies.  As there is no other
consumer of the new interface, when the scsi tree merges with mainline,
the new interface will be picked up there.

Patches cut against scsi 5.19/scsi-queue tree with lpfc 14.2.0.3 patches
included.

James Smart (3):
  lpfc: commonize VMID code location
  lpfc: rework lpfc_vmid_get_appid() to be protocol independent
  lpfc: Add support for vmid tagging of NVMe I/Os

Muneendra (1):
  nvme-fc: Add new routine nvme_fc_io_getuuid

 drivers/nvme/host/fc.c         |  16 ++
 drivers/scsi/lpfc/Makefile     |   2 +-
 drivers/scsi/lpfc/lpfc_crtn.h  |   3 +
 drivers/scsi/lpfc/lpfc_nvme.c  |  45 ++++++
 drivers/scsi/lpfc/lpfc_scsi.c  | 263 +-----------------------------
 drivers/scsi/lpfc/lpfc_vmid.c  | 288 +++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  14 ++
 7 files changed, 371 insertions(+), 260 deletions(-)
 create mode 100644 drivers/scsi/lpfc/lpfc_vmid.c

-- 
2.26.2


