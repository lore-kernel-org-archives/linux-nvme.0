Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76045C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jan 2022 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BlPsJQF6w95TYMV7kIVyZ9NRoUvlo4VZyhhGBux+ZJk=; b=Mvhi/Coyy1KUtI9+P4l3WAFPrf
	lYO2CGG3mmn+QvWi5EB8QeMnmD5SOA691Y/9idbXvPQdhOA21GD5yK8bwwTDqF0ljzQtZC9Vry7Er
	7e3hUiRy0STDHPxWY+A3pfvPWgYmPUxVSEnn1H/5tI8t6eseMQ/UBvmURoAHl0SdLA1SeR0bb7Sy1
	vF9e09x/8phm3u6ol+Qy5GC61huY8JTHaUiMEpTHanOllXf+dZ5vp+1+gweI7WvinyfW6myeA2XX/
	k0DE8WTlfSywDtlJAj8Bzw/POhJ57S3jIi5Qv7+wxTmKWnLpigzauzePYFBmsJ8mtIEnjdBjqHDYP
	5JmuCceQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nAdsd-00D5iF-30; Thu, 20 Jan 2022 20:17:59 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nAdsV-00D5hv-7B
 for linux-nvme@lists.infradead.org; Thu, 20 Jan 2022 20:17:52 +0000
Received: by mail-pj1-x102a.google.com with SMTP id
 b1-20020a17090a990100b001b14bd47532so6850728pjp.0
 for <linux-nvme@lists.infradead.org>; Thu, 20 Jan 2022 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BlPsJQF6w95TYMV7kIVyZ9NRoUvlo4VZyhhGBux+ZJk=;
 b=d6xUHpdZIieaGU97YO7Tv9OrD+DIdYl2fFz7HxJDv/htSNa6ZIQxBqMmKbHk7Td2oi
 36tofJyMY7/HvCPz0eLGrgglakAdNe5sfHwKygLYnr6ixRvNRL+fPxU4piuwGnVndzFz
 UHrVizGN7ByJQEqcRrH25N0wcvs0+y95Cr5Iq9rivhN6jDVaHOzolwWveP8hVLD9iZeS
 UijNvpptTMxhXg+nGT7BONBVvoZ3y/DQDMvG1fUv0fiG5E2345KnbjZx1WyaEcwB3Jjy
 vvObs3MWAcoZJnhQtKUxt4+9OnmYBMjEUPMQ4hKAr6qunlo5veDTKpe4euSZ0wREBXHR
 13Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BlPsJQF6w95TYMV7kIVyZ9NRoUvlo4VZyhhGBux+ZJk=;
 b=LVM//hXUmtEaVYNArAktCOjPhz4uYvOv9AatgSz6aPzhalmkzc4bzcDhbhCmatlvxO
 6+PeZuhYi2FHGP2G8gsnvJPdbJiYRGwKNV9/R+x8g7V4e79i0/vK6pUdA3hm+6wLcKm5
 vjDzHdjSk4gFBkdi9JRfxDZJPPeGvASgR6lGQLZZtePb4Fyl/Ul1gi1Xr0XlqXkTQYqV
 s1GubPZSzpDT5JUuTTyHAcwE4VaZfN8wjm0PCao4wEQHcOpzaDovgx7aPICqAwErc2ej
 7ejXZOou4lTJd6ymhWex95Y5VMrakUr+1JVnuS0xKawWw6kKbUWcAVZXpTEopKulHmGI
 K+cg==
X-Gm-Message-State: AOAM530uBBq6XthFw9ZB2U3wCJ5NOETkxgGwmCuWyelph248YzbwRC/1
 +Y9kOhTZu/Ba8tNXA0xm/WNmaq3LCAk=
X-Google-Smtp-Source: ABdhPJxvuKyuc/8G6MX98+TcxExF9Wu1y/YhijW1WT4MWngHbqCZYHXZfUoDoSaYT5BWD4gxxwfsHw==
X-Received: by 2002:a17:902:70cb:b0:14a:b8e7:4437 with SMTP id
 l11-20020a17090270cb00b0014ab8e74437mr656271plt.41.1642709865384; 
 Thu, 20 Jan 2022 12:17:45 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id p10sm505859pgr.5.2022.01.20.12.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 12:17:45 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: James Smart <jsmart2021@gmail.com>, stable@vger.kernel.org,
 Uday Shankar <ushankar@purestorage.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme-fabrics: Fix state check in nvmf_ctlr_matches_baseopts()
Date: Thu, 20 Jan 2022 12:17:37 -0800
Message-Id: <20220120201737.65390-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220120_121751_308744_65BB9E5C 
X-CRM114-Status: GOOD (  11.38  )
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

From: Uday Shankar <ushankar@purestorage.com>

Controller deletion/reset, immediately followed by or concurrent with
a reconnect, is hard failing the connect attempt resulting in a
complete loss of connectivity to the controller.

In the connect request, fabrics looks for an existing controller with
the same address components and aborts the connect if a controller
already exists and the duplicate connect option isn't set. The match
routine filters out controllers that are dead or dying, so they don't
interfere with the new connect request.

When NVME_CTRL_DELETING_NOIO was added, it missed updating the state
filters in the nvmf_ctlr_matches_baseopts() routine. Thus, when in this
new state, it's seen as a live controller and fails the connect request.

Correct by adding the DELETING_NIO state to the match checks.

Fixes: ecca390e8056 ("nvme: fix deadlock in disconnect during scan_work and/or ana_work")
Cc: <stable@vger.kernel.org> # v5.7+
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
CC: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index c3203ff1c654..1e3a09cad961 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -170,6 +170,7 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
 {
 	if (ctrl->state == NVME_CTRL_DELETING ||
+	    ctrl->state == NVME_CTRL_DELETING_NOIO ||
 	    ctrl->state == NVME_CTRL_DEAD ||
 	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
 	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
-- 
2.26.2


