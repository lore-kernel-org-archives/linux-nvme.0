Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29426E69191
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 21:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZgYkjMfGQhQSirOW/I/Kltv3QYr/gCeO7U1k2QLzp0=; b=hq/3LFGEGeuYwvC9KaRwXqMtpA
	O9RkUTrthdxX2Jlr9SjZpE/qAtMOjYoi/1FMDl06YJYsscoodOwz8l0gN1IlLdOIWtexINrEsLT9V
	eGtIJatasH0T/QWjJ7lNcVUsUHdDvR63i7FOR1rt1kug8/wpR/vAm9C2Z3x4rDPOu3s5NH4BlcYnl
	1T/tySkw0QJoymO+XK6RoU4xS2CXh0gQyKNTUdmupSzGXXmqoNiELsinKOrgoSIeUB1jjj6gpkggX
	BaUbwdoZoQG/PPW+KRRHSHyMMhDQpSlb9nvTJo4T59VhyZLd+dIbSFSsZYBt6GNuzdXOFnok6qPbB
	QO9KP2PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEatq-00000003K1r-28dg;
	Fri, 22 Nov 2024 21:09:10 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEato-00000003K1X-2O3S
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 21:09:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7B41BA41519;
	Fri, 22 Nov 2024 21:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E2C4CECE;
	Fri, 22 Nov 2024 21:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732309747;
	bh=zeo9E58IJwopEbyH4KMEk8UyvZ6VvHKNIKWK1GklwMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ioe1YIOOXk1orgEFpo+uwpfVdTnl2sYch4yvR51Lsno2C95n+JF0efE9X5WbFyfSM
	 Rmq77Crh2KFozPb57/Eu4BLq/uwbdlu0hpP+mgfRc+inueyzz07nwhE3eS8AyRyxEs
	 nV4ShmSTi7ESXIzbgZAGDGMKSiBQreqqcNEiZVFwn5fldvyOz7vXy/ue30A8eNI1Bq
	 fDL27TdeuFXJe7KfAB4I8xPtfTd51yKEnJgNSB5TbNs0BXQcYsyA+tK+j4f5mK74F5
	 VcprUrNxQV6Jt+2U32J9MfiUdEfvoEI4nC2CYZMKGrlq+XLNWvyRdyumcaAalTtoUO
	 vtYOLqfdMLDrQ==
Date: Fri, 22 Nov 2024 14:09:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
 <20241122121304.GA25877@lst.de>
 <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com>
 <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_130908_671405_2657C135 
X-CRM114-Status: GOOD (  13.37  )
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

On Fri, Nov 22, 2024 at 06:26:46PM +0000, Saeed Mirzamohammadi wrote:
> FYI, Tried disabling write zeros but still getting the same errors:
> [ 326.097275] operation not supported error, dev nvme2n1, sector 10624 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> [ 338.496217] nvme0n1: Dataset Management(0x9) @ LBA 10928, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> ... 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d3bde17c818d5..ad2ce6008062e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3425,7 +3425,8 @@ static const struct pci_device_id nvme_id_table[] = {
>                 .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                                 NVME_QUIRK_DEALLOCATE_ZEROES |
>                                 NVME_QUIRK_IGNORE_DEV_SUBNQN |
> -                               NVME_QUIRK_BOGUS_NID, },
> +                               NVME_QUIRK_BOGUS_NID |
> +                               NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>         { PCI_VDEVICE(INTEL, 0x0a55),   /* Dell Express Flash P4600 */
>                 .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                                 NVME_QUIRK_DEALLOCATE_ZEROES, },

Could you instead try deleting the NVME_QUIRK_DEALLOCATE_ZEROES quirk
for this device? The driver apparently uses this to assume you meant to
do a Discard, but it sounds like the device wants an actual Write Zeroes
command here.

