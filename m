Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8089DEB64DC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jul 2023 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lPSms7Svt0v1FhaYrBtasQxf1zX/2vOpkMaaCXfzVv8=; b=bdCs17ui0CZogGU9NdNgUvCmkG
	4KMkEUkjOE4XWrLTcyPz8Cza/1QQXpmR7saaoDhMsJXT8VcnbwosjsxhnJkdl0Qn6dSJOUXh6ilg5
	/VELnAOvFb1rfONewAy50LdPYMAFN3YIi36H8GyJOfOnxnaNXI9P71GtHcGoZKf0F7K5odKairWbv
	iV1v9ZSfzrMguWpPbKxz4U0Cy60vcrW/H+q5AhjcNmL+t/rqjhXEQ0wL7Zg6uJ1q3lRorleoGGhvM
	qWtR8b9h3s1PoBYhlMKoJsj0tbDjkDiP3rTmDAZ/T0nrFlcXPuvdKJI0gcKhtXLy6zzTbBpvYeYi+
	EeNIfplA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qKIcJ-006GLq-02;
	Fri, 14 Jul 2023 13:13:51 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qKIcE-006GL6-0z
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jul 2023 13:13:47 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8bbcfd89aso11005795ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 14 Jul 2023 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689340424; x=1691932424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPSms7Svt0v1FhaYrBtasQxf1zX/2vOpkMaaCXfzVv8=;
        b=bNQIefppjIKFx2HPNJdWZwzu4OATM5y1y4LiD6TulYlcu56jrK+c5SB7HqUXz9pG9/
         hDVMAZg6iKi7PoVjsiB7rc1CcXKhawfmWm8dazwFZLsmnzUqAkXmFIANnx82k/t07rzb
         MJ91IlNG8xCEdVeCXIOPO9GiczWZjAAvguQ7H1RdSGd0Q9a6VtHYIH10dmykKYrMuBsT
         0PT5jvXjsMeyYhiXDacDPRG1vZ94QnpiRMbNqZKp08wMef9f5NwWoiFq3mal6w+KsNCK
         3US3dBBZqKyK33isSGsIP6cPmmLInGhg/7JRDVWO8iEWXq5mUXj7DOGd8RQxDqIee9gj
         4jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689340424; x=1691932424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPSms7Svt0v1FhaYrBtasQxf1zX/2vOpkMaaCXfzVv8=;
        b=lrEBSoHWNclu0W7SV+PZGTJ87oDVH1hUGl8FNnT0W9Mquftwl6plsg5LQPhL9yuQKW
         DycQDNZ0/WFjE9VQD1yyU/8dxDUqbBZyvjCMU/5iruxUEBZR/WTgz4dQe4GOFYAI0GZu
         gWUxyMDsQE60JtSburFFYreR6EWIbQr1Q9kFWr+rp6KXvRbOjY5tcYnkhARUL2tsUBUE
         cOSBDhkGknymat1YgsBllEuq6VbrV/MJ6wEyeaEPSivzsmBM2F5JLFMWEJv7qDBA/SGV
         Sw5+nO9OISJ3W/Xg5JLpp74HU+etb6tIL7KKhNj0t+9yL1//GTYjcyag8iQUXldVK2mf
         FaUg==
X-Gm-Message-State: ABy/qLZTnee4ldMfwmaojsYv+/FU9Yh7AMQ7iVm9n3ExJTuHHLyAz4QQ
	Ew9r4jJnAMKCes9Yk43vjTE=
X-Google-Smtp-Source: APBJJlGL9JGLy10O73QK3szm+DEF7SAKVndVH3a3mA6KEGtyxifInalzNWCIpWbxy0wzSqsUngr6tw==
X-Received: by 2002:a17:902:704c:b0:1ba:fe63:6616 with SMTP id h12-20020a170902704c00b001bafe636616mr3242178plt.6.1689340424527;
        Fri, 14 Jul 2023 06:13:44 -0700 (PDT)
Received: from localhost.localdomain ([103.156.184.205])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902b41500b001b3bf8001a9sm7777905plr.48.2023.07.14.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:13:44 -0700 (PDT)
From: Han Gao <highenthalpyh@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Han Gao <highenthalpyh@gmail.com>,
	David Xu <xuwd1@hotmail.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO MAP1602
Date: Fri, 14 Jul 2023 21:13:33 +0800
Message-ID: <20230714131333.5858-1-highenthalpyh@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230714_061346_344965_5985E21C 
X-CRM114-Status: GOOD (  12.90  )
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

4TB SSD with MAXIO MAP1602 controller is cannot by initialised
in nvme_enable_ctrl with a high probability, which causeds the system
to be unable to use SSD, and SSD device only be shown in lspci.

dmesg output of problem

----------
nvme nvme1: Device not ready; aborting initialisation, CSTS=0x0
----------

Problem and fix are verified with my MAP1602 controller SSD device.

Signed-off-by: Han Gao <highenthalpyh@gmail.com>
Signed-off-by: David Xu <xuwd1@hotmail.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf3..f75c27730bde 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3425,7 +3425,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
-- 
2.41.0


