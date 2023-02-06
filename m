Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4820C05027
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qihn4R9/QYw1DR4TIx9K/LFPch43FLQE8jsHUWjBAA0=; b=3JHERAxvqg7onLTZLL+ISLjJni
	ZyVC7x1ccxYWfPlXYOw2ifmS4+mMQo4FN/BTdl6U8k//ubyVfcgQj0jt07f9k9oDQjry8IfnTWTkc
	jZM9u4PbtTGoN+O2do9T3QyMkTf0DZYc5MJLrdyc8lg5K8TTyIk9Pve+5HBVSDEUx9MazBWbBJDJp
	/3ixU8c+OlowjgU3YzKhkwqagbowOczibMp/QybKzZLYv8UQjz8uvwCmgGNnPF0tLzobJjHQZ5pAt
	ywXdZb0sykLH6xPxoyZ+Rw1Efvn/VKlMJNB3gP3NnraWoD/SBcZklIx3s19NLzNfWKfPWPl/MVj2O
	fhigBLXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP4GC-009IQc-4L; Mon, 06 Feb 2023 16:22:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP4G4-009INn-9k
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 16:22:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 97FC260F60;
	Mon,  6 Feb 2023 16:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867AFC433D2;
	Mon,  6 Feb 2023 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675700536;
	bh=ADo37gjbAEvYaNbVYiOSFN6wdTKY4vFN449UsIhzcqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtMivYzkPBnQ61K2q4IoUFXq8Pshc4t/wYzToa6LkbWb9rnngAsPYqGev8csJFfpO
	 INs9I3D3FxE+M0w/UYqXi3iP/5uHm9RI6EUzcTwxfy3YpgdfTaDtBKYVHHp+e+HQbM
	 y9/vLZtNGwnTXkf9Yw2AmcGSnGNbrbfi3w7hDrq7UQeNpceZukzc/u6yutnWg3W9ZR
	 MGDE+5Ze1fVVl9KSWay0/WJOTmH6HN6B0VVwrm1v0Kl9EqelzzNSDYQDtUzV6Rw6Bb
	 iaUSrRL+h532+l3b5Nt/pKfkixKNJu9QVRcBbmp8bBQbfuYv+4K5NkduTjNeQiIQCc
	 CyWp6CNZ3x6og==
Date: Mon, 6 Feb 2023 09:22:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>,
	"Grochowski, Maciej" <Maciej.Grochowski@sony.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Lewis, Nathaniel" <Nathaniel.Lewis@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
References: <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230202101818.GB14931@lst.de>
 <BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
 <BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
 <CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
 <BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
 <20230206154218.GA12556@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206154218.GA12556@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_082220_430235_56458DCF 
X-CRM114-Status: GOOD (  21.88  )
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

On Mon, Feb 06, 2023 at 04:42:18PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 06, 2023 at 03:02:20PM +0100, Javier.gonz@samsung.com wrote:
> > Is there a chance we can get a quirk for this for this FW. Seems like an
> > issue on our side that is creating problems.
> 
> So waht would the quirk look like?  This would have to be something in
> the core PCIe code, not NVMe as far as I can tell.

Yeah, I'm assuming it's a PCI level quirk because the remove-rescan was
successful at reinitializing. The remove-rescan should do a very similiar
config space setup and nvme startup as an AER recovery, so I'm guessing this is
a matter of timing. If so, the below is how I'd imagine the quirk may look.

But if this idea isn't successful, it'd be bit a more work to figure out what
sequence this device wants to happen in order to complete recovery.

---
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fba95486caaf2..f642e7029e0e9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5054,7 +5054,10 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
 	 * this to 2ms to ensure that we meet the minimum requirement.
 	 */
-	msleep(2);
+	if (dev->quirks & <NEW_SB_DELAY_QUIRK_BIT>)
+		msleep(100);
+	else
+		msleep(2);
 
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
@@ -5066,7 +5069,10 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	 * be re-initialized.  PCIe has some ways to shorten this,
 	 * but we don't make use of them yet.
 	 */
-	ssleep(1);
+	if (dev->quirks & <NEW_SB_DELAY_QUIRK_BIT>)
+		ssleep(5);
+	else
+		ssleep(1);
 }
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
--

