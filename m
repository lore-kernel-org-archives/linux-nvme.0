Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB97C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V+IVdOZj+IKR1vY71nwx8xVrdU6AHHZcBPA483+SabQ=; b=SEGNGtbAye0IajsXFSHptHrDa3
	PBCJlZCSJeyq3LQosZDj7ViOikYLI1RndmnbBEPeNfa6jR/VGwY6SBRcJ/0NIk5RzapFNvp0xBYQ6
	eIGOITMBTnixfRyD/e59T5cgw0Bxwy84ojmqcPSE/r6fmv0vmEY9bdIbmuhqL9am/i/kvQT14Cl/2
	XqilA06ZVcLGCGrXKCFQwKmqFHpmjrk5r6nBz2KWnR918C8E6ADaLICbIJnA1HNkScxQbmQSUOLEy
	h/g2u2R2g96wS8oGsOVlt85FcB8sGdm4qdSQ6G9TSEKuXqJEJipPL2Mmyo4Zqylb0laaj8EwQiUCL
	VuY6Ldww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oho1u-00HZ4U-3Y; Mon, 10 Oct 2022 08:20:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oho1r-00HZ2l-FN
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 08:20:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F66168AA6; Mon, 10 Oct 2022 10:20:44 +0200 (CEST)
Date: Mon, 10 Oct 2022 10:20:44 +0200
From: "hch@lst.de" <hch@lst.de>
To: Xander Li <Xander_Li@kingston.com.tw>
Cc: Bart Van Assche <bvanassche@acm.org>,
	"paulburton@kernel.org" <paulburton@kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ralf@linux-mips.org" <ralf@linux-mips.org>,
	"jhogan@kernel.org" <jhogan@kernel.org>,
	"christian@brauner.io" <christian@brauner.io>,
	"jeff_yang@kingston.corp-partner.google.com" <jeff_yang@kingston.corp-partner.google.com>,
	"dora_chueh@kingston.corp-partner.google.com" <dora_chueh@kingston.corp-partner.google.com>,
	"james_liu@kingston.corp-partner.google.com" <james_liu@kingston.corp-partner.google.com>,
	Vincent Wu <Vincent_Wu@kingston.com.tw>
Subject: Re: [patch] nvme-pci: disable Write_Zeroes on Kingston SSD
Message-ID: <20221010082044.GA23747@lst.de>
References: <CO1PR10MB4691DEAA88F86F001ACA5A1CCB5D9@CO1PR10MB4691.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR10MB4691DEAA88F86F001ACA5A1CCB5D9@CO1PR10MB4691.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_012051_695850_5E7EC037 
X-CRM114-Status: GOOD (  15.80  )
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

On Wed, Oct 05, 2022 at 10:01:11AM +0000, Xander Li wrote:
> 
> drivers/nvme/host/pci.c | 10 ++++++++++
> 
> 1 file changed, 10 insertions(+)
> 
> 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> 
> index 98864b853eef..d08c8c854f3a 100644
> 
> --- a/drivers/nvme/host/pci.c
> 
> +++ b/drivers/nvme/host/pci.c

This patch seems very white space damaged.

> 
> @@ -3503,6 +3503,16 @@ static const struct pci_device_id nvme_id_table[] = {
> 
>                 .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> 
>         { PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
> 
>                 .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> 
> +       { PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +       { PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +       { PCI_DEVICE(0x2646, 0x501A),   /* KINGSTON OM8PGP4xxxxP OS21005 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +       { PCI_DEVICE(0x2646, 0x501B),   /* KINGSTON OM8PGP4xxxxQ OS21005 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +       { PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
>         { PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
> 
>                 .driver_data = NVME_QUIRK_BOGUS_NID, },
> 
>         { PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
> 
> --
> 
> 2.25.1
> 
> 
> 
> 
> 
> 
> Xander Li
> Technical Resources Group
> Kingston Technology Far East Corp.
> Office Line:  +886-3-5641539 Ext.6135
> E-mail:  xander_li@kingston.com.tw<mailto:xander_li@kingston.com.tw>
> 
> This email and attachment(s) may contain material that is confidential, privileged and/or attorney work product for the sole use of the intended recipient. Any review, reliance or distribution by others or forwarding without express permission is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.
---end quoted text---

