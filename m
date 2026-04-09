Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C899AE9DE60
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=odLFO39bXhfg9n43tA+hKLrtmKzFX/8QBMkrTA1i9ik=; b=NXjh8DbHZfXYcvOOaQZ01gZxl+
	GLCmpF1vJA2IU5yfqvTCAtDkOVv/+FIPKDsZv3/lirZT4YKr7AqIDyce7uIrhUbgDiIWXNKJMA1RU
	8lXYeF/Cgjvh+ZjaM3c/mjXZ/FIZ7lxrrucq30zLlrdUm2PI0HydZdBMA1yIGZqgFPFgH6ldZhw07
	nS2ksn8D0/1UY5JcCqSGWBLY3BX38qSEZGjV+agRiVjUa1Zgq08xDHQVcD6YirTzj87yGw6pemyAv
	A+ccEiJ8hgf4DfGKMJzPmUl75lkZM9SBAaQJ5wm34pAMiCOPZv310dhVpFO7fU+0vlb1KlAuG37Ef
	pnaf5MQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAkY6-00000009vWk-0EHp;
	Thu, 09 Apr 2026 08:15:38 +0000
Received: from out28-41.mail.aliyun.com ([115.124.28.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAkY3-00000009vVa-1iet
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 08:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1775722528; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=odLFO39bXhfg9n43tA+hKLrtmKzFX/8QBMkrTA1i9ik=;
	b=fkIdK6ifi0m0pFas0sUpXBX9jdS9L7uqjG53PGo55DwvWEnQCJZiHRvPIJKfIxBtbrN6S9wEmFuLuw8RamsMPwucn9QVzirRHRL1o/h+Z6RtdRBFxpr672hb9boVrJWUNFzSmhUgtMbLAJxPhLsJpnm8Nlk+vBvd+sVhp+unqGJmr9OgJsp/wCqyZujUQdCdKtH8OUqvyvMhtEJ/haH/jTXDd391HP/1HRerdrdO9zX//lFMqIII1mwHRyYgENPTl8H2Fp1DlRtXhTjlYozwYdEQXH6omazaUSnQj82TeRRzrJgJo7pjUlx4W+fQxTvAPPPK3RnsHriJsUjYl+7S0w==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7834899|0.1379718;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.139457-0.00582877-0.854715;FP=10759842631866930947|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=me@alancui.cc;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.h8BWd5o_1775722525;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.h8BWd5o_1775722525 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 16:15:26 +0800
From: Alan Cui <me@alancui.cc>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808 (Samsung
 PM981/983/970 EVO Plus )
Date: Thu, 09 Apr 2026 16:15:25 +0800
Message-ID: <9600680.CDJkKcVGEf@alanarchdesktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_011535_633672_349FAA03 
X-CRM114-Status: UNSURE (   6.06  )
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

The firmware for Samsung 970 Evo Plus / PM981 / PM983 does not support SUBNQN. 
Make quirks to suppress warnings.

# nvme id-ctrl /dev/nvme1n1
NVME Identify Controller:
vid       : 0x144d
ssvid     : 0x144d
sn        : ***     
mn        : Samsung SSD 970 EVO Plus 500GB          
fr        : 2B2QEXM7

mcdqpc    : 0
subnqn    : 
ioccsz    : 0

Signed-off-by: Alan Cui <me@alancui.cc>
---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa..d4e68cf9a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3375,6 +3375,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c5f, 0x0540),	/* Memblaze Pblaze4 adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+	{ PCI_DEVICE(0x144d, 0xa808),	/* Samsung PM981/983 */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */




