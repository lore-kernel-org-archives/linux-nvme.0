Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E54AC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 15 May 2022 20:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8YT6/dGyNYsxhCvi9klXlEMUjDAHsf0Xz72DC8aMZXk=; b=smI4NRT6clKepVyimq2l7gOzZ4
	pN6TeC9/ViWvl0vacH3wWUb6fnz/BDC2pfjvW20g9CbD3+/lOApfYqASZlVwpQ6BTq3iPyETmt/Bn
	4kobwmll3qg+/2f9xJ0wS6o9HTDGEml5Jpf7cf7ndEziH+kKCwJDlIBDZXUtuAhI5ZLyJoGZ6wMd7
	3t1/9PdHtlaiVc5na2Bo4G2ArVcS/WrJujJ+wIrwLNQGpTWh1iR0gYhUGdo20JQFa24VQ+ogPQvky
	AdBpX8CQJcx+5+WiFvrFjgpHhdl1O2JrFfziOOdQVYYk+8dFYQvX769UDVloNFFmio+1+83bXL8mX
	dqOaInJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqKcQ-004t0C-75; Sun, 15 May 2022 20:13:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqKcM-004szp-UE
 for linux-nvme@lists.infradead.org; Sun, 15 May 2022 20:13:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2B0F161164;
 Sun, 15 May 2022 20:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA70C385B8;
 Sun, 15 May 2022 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652645609;
 bh=AeTXABC5tMK+jQG83l3IOkl16iYsJPJzPD5JbUIJuO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ekOmcP4YmOGZ2gI0x/ZAhiHbpI9G0RVmWCIbpL+N2G77ycXkLtbeZtHNbd0Jmt/xy
 BvPqJiz/7ikKDbamQ7kh1Oi+0xzcS62QV1Zi8msTGZwWWRBudra2VNKclF8IHjhztC
 sHVwirZ+Fvc+BfFgDNzZC4s1Ya6hBSVrBhW4XAVSLbcNFF5Wqm+RfLg1nEYebmltGy
 wVNLABqn7dv/RMdCzVSbs+ZXI15iATzkM8ggEi/N+rBRYAHWxzLbu/KhiU2MyfArc6
 vaaHhuLdsIv2JSvtfz/Ja9d6QCKib2NjXJaIX+6zm5V/pNAzjVqOqm6JzzzraWC2XT
 oiY4NvtHf3T3g==
Date: Sun, 15 May 2022 14:13:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Marcos Scriven <marcos@scriven.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: My Western Digital SN850 appears to suffer from deep power state
 issues - considering submitting quirk patch.
Message-ID: <YoFe5vPKrewePNx/@kbusch-mbp>
References: <5ea81a6a-b510-40d2-9b32-036f263f75f3@www.fastmail.com>
 <YoFYIJ3/yEK1RGTK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoFYIJ3/yEK1RGTK@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220515_131331_056998_3832C957 
X-CRM114-Status: GOOD (  11.91  )
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

On Sun, May 15, 2022 at 01:44:32PM -0600, Keith Busch wrote:
> There might be additional things we could do at the PCIe level, like a slot
> reset on the downstream port, but I haven't seen evidence that type of
> escalation improves anything so far. It might be worth a shot, though.

Something like this:

---
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1392,6 +1392,15 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
 		nvme_dev_disable(dev, false);
+
+		if (csts == 0xffffffff) {
+			struct pci_dev *parent = to_pci_dev(dev->dev)->bus->self;
+
+			dev_warn(dev->ctrl.device, "link is inaccessible, attempt reset bus:%x\n",
+				parent->subordinate->number);
+			pci_reset_bus(parent);
+		}
+
 		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_DONE;
 	}
--

