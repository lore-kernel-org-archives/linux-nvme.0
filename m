Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7F5CA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f7t2f88agrRS1B1iAJwzfiSnfOHeW10+a3UdQ2eynTw=; b=GXbBWgGtNwk3cf9H0Uglvi2GFg
	NnOG4OAbyvSN9GmuVulZdT+Ke30Jy3wnabXDVFxz6cukneigA5V4I6Qicq0ga7NsUlmxecs1YxZMB
	sz7G3jORYKfDdwlUCmVfs3mx1Wmd1Iyr3ep0Ry4GKC9Hi87iTGhh4KY4qhwUMiA2MItW5D7qhzlvk
	di1fqd+CEv4eJb/EYAY3U53CuAskEmV5bbak1Q/A5rfhd2R4NGYyhwN0P5O4ncQUzlwZXatPQEVvW
	4617VHXDMLYuou/3cpJ39C23Zjh7s6yASZVyHgFzvU1kPU4slXcgUcydv6qBJiEJnI0FGBqxFJSjs
	Tnt3hEQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDwn-00000000p6J-0ilM;
	Thu, 21 Aug 2025 22:39:53 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up8U7-0000000HaKy-1Cjx
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 16:49:56 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-45a1b0b4d13so1482895e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755794994; x=1756399794; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f7t2f88agrRS1B1iAJwzfiSnfOHeW10+a3UdQ2eynTw=;
        b=mq4P/P2tiOzbeSjBO8o/6Sgdxgql7u+ZCbSL6vCH+oXp2dzE2TIB+UffEv4vu8eV0T
         n077gHUUzz1rlHpeEBkDFbqpvJLU4ztC/oAa020Tm46R1RPDiN7f3rB2fTF4QOSooeN2
         ohgXL7RtzK8jzJS6nShIT8TaM87evvu+LHWy/AKW9/Syx+zMZADqF4P0DkWl8louFT/Z
         m0UU0GZ5+ur/XlCi3PTXlM8xXFQn72RxNbK36aH4aGYVNK5Vugx43xbvQ7HF7gfYaeQ3
         /ZS9RylC71tOBORURBncyddGfrvIFigrx4O2h+rsLeuiK5MF5yuchnBhLGoWfaay6+6J
         nbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794994; x=1756399794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7t2f88agrRS1B1iAJwzfiSnfOHeW10+a3UdQ2eynTw=;
        b=djAaC0ylw3fGxMnuuvhKJtKb8WqZ9F/W2E19+2gE71ZORPqQodvhubSppBWc9jDGGe
         CtJ+9Zu9RsChc2UY2TCj9JYcFHv28wGkaBvkNxxgQDHns6iIqfcO+1aRYHgJnSeNWO6U
         UeK4QThFeF/2QSe5aNPANuhf1MOnz96p+k9+W2NzqTajmzNfmL7Q91Cgrp1BLClEMidf
         v0LG2hRTrK+Fh2b1teKZfzP9tr7xveIKwogH6Em1AR2UJL1jliMGLXvLQdyT/iFF+nTT
         vX+DTbJY+oZ7ZUVxj0uMp3np15qq7D3BE79/RT9VZRH/7VZZPKfYyculGljrFGbO4F5d
         FLqA==
X-Forwarded-Encrypted: i=1; AJvYcCW9HYc35E3efQ1AOhXwc7oLVJMXszDDnmmTbvzgDM+AIoRnBdGiyAe7zOTwUDyJOfhamJcHxIQqICeE@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+PYLogel5YauoGIqOQPqHOzVQCj1iMnpL7fu6zCqglLyyPTK1
	ZK9Nlm+Qr9amyXYiJD1vsooIcKBcQvz3qfFLZNv6pWAKitJqZb2jEAE=
X-Gm-Gg: ASbGncup/X2JhlhkYwVzTgf+uUdJDSteBYAVF36ymwJDXnnLourRI7EYy3pgVunyT0F
	qoNpsV+71Dtcj3aeSKep8Oo5VyWSRH80rIENJwnaFR7ovAEkMXMN0xjqMeI58+UJ+JVA6eIAxV0
	z8ZJwKk6+vo2yqE5nM++EEiRC242Qkct/vZNzkrYtw9aUAq5m+NZXsh7yJJAH9rc+ztholDJwjJ
	lH55ehcJiGLIf6l4s2ormIGmL6+QL+eMXHWoiTtJawXpkbsVFYJDlBrROdMS5pQyumoWi/IZw7e
	YGbDhrqhIPeXAdk++BJXyRKTbhSnnESI9dAKNOJt29ZHq8S5sVjPoP4RjFjurkiAGifwhCyXBSZ
	IErYvJF+csNcleAiHChCDHHd9yOLBkQgrYpFHKn7ce2fyR4+I2QLDkU5lxG20
X-Google-Smtp-Source: AGHT+IEFCzGcsgNZSCK8jgQNmnNP6XuCcbIjfi+E7Ny9nmr/AplG4StiUki6eZCbqEcqFRU22rFM4Q==
X-Received: by 2002:a05:600c:a16:b0:459:ddd6:1cbf with SMTP id 5b1f17b1804b1-45b4d74b053mr15281275e9.0.1755794993528;
        Thu, 21 Aug 2025 09:49:53 -0700 (PDT)
Received: from localhost (67.red-80-39-24.staticip.rima-tde.net. [80.39.24.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dea2b9sm3562025e9.15.2025.08.21.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:49:53 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Wagner <wagi@monom.org>,
	BLOCK-ML <linux-block@vger.kernel.org>,
	NVME-ML <linux-nvme@lists.infradead.org>,
	SCSI-ML <linux-scsi@vger.kernel.org>,
	DM_DEVEL-ML <dm-devel@lists.linux.dev>
Subject: [PATCH] nvme-cli: add 80-nvmf-storage_arrays.rules
Date: Thu, 21 Aug 2025 18:49:51 +0200
Message-ID: <20250821164952.148153-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_094955_324199_0961C303 
X-CRM114-Status: UNSURE (   8.61  )
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

Missing from previous patch.

Cc: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@monom.org>
Cc: BLOCK-ML <linux-block@vger.kernel.org>
Cc: NVME-ML <linux-nvme@lists.infradead.org>
Cc: SCSI-ML <linux-scsi@vger.kernel.org>
Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
 meson.build  | 1 +
 nvme.spec.in | 1 +
 2 files changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 3afd8ba3..8c0877e1 100644
--- a/meson.build
+++ b/meson.build
@@ -270,6 +270,7 @@ udev_files = [
   '71-nvmf-hpe.rules',
   '71-nvmf-netapp.rules',
   '71-nvmf-vastdata.rules',
+  '80-nvmf-storage_arrays.rules',
 ]
 
 foreach file : udev_files
diff --git a/nvme.spec.in b/nvme.spec.in
index 5f7645d7..fa921f81 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -36,6 +36,7 @@ touch %{buildroot}@SYSCONFDIR@/nvme/hostid
 @UDEVRULESDIR@/71-nvmf-hpe.rules
 @UDEVRULESDIR@/71-nvmf-netapp.rules
 @UDEVRULESDIR@/71-nvmf-vastdata.rules
+@UDEVRULESDIR@/80-nvmf-storage_arrays.rules
 @DRACUTRILESDIR@/70-nvmf-autoconnect.conf
 @SYSTEMDDIR@/nvmf-connect@.service
 @SYSTEMDDIR@/nvmefc-boot-connections.service
-- 
2.51.0


