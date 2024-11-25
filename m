Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6A9D3B7DD
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 06:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ivMhuXAmJVLlX2wjDr/8xx405DlTMnZ6SIqUm3lOGs=; b=k5bUF/3YVaAADOWZCeqnUvYNzE
	VH/Put5wXvcfsphoeynPzJu1ekk+L8zuut3I9xQqsx2T28ENARPXQsMk8OGtd5MXy0Sv+OTVtU8sj
	y+VFmuC0Y+1JDpuYEbGZo+CQtOKJZZNhcrEWoAWZfJdXN/RrrbGJmIRcQmrj/a/OAvjNx7miYC9rC
	ZelFN+H9IpzLRpGaER75CMu1Y47Ej5EC2fonfAwb/6IrO+AHv8XxB2Pq8ZizD0gYlqehDoXFv3t5C
	yIx6C+uZ1ri/Amw75h30w5niu9d6Rr6WfCHhwpmr/EnCjQUmppWnBTHWdr60UakazZTgeaouNieFX
	RZpmLyUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSsJ-00000007BGa-3rg1;
	Mon, 25 Nov 2024 06:47:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSsG-00000007BFh-3JbP
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 06:47:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A3ADF68D09; Mon, 25 Nov 2024 07:46:58 +0100 (CET)
Date: Mon, 25 Nov 2024 07:46:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241125064658.GA14937@lst.de>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com> <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com> <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk> <20241121113058.GA394828@pauld.westford.csb> <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk> <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com> <20241122121304.GA25877@lst.de> <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com> <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com> <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_224708_979160_D512904D 
X-CRM114-Status: GOOD (  16.22  )
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

On Fri, Nov 22, 2024 at 02:09:04PM -0700, Keith Busch wrote:
> Could you instead try deleting the NVME_QUIRK_DEALLOCATE_ZEROES quirk
> for this device? The driver apparently uses this to assume you meant to
> do a Discard, but it sounds like the device wants an actual Write Zeroes
> command here.

From the logs it sounds like the device does not support the DSM command
at all.  Which is a bit weird, but might be an odd OEM firmware of some
kind.  If that's the case, the patch below should fix it:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a8d32a4a5c3..ca57086ba038 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2068,7 +2068,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	lim->physical_block_size = min(phys_bs, atomic_bs);
 	lim->io_min = phys_bs;
 	lim->io_opt = io_opt;
-	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
+	if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
+	    (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
 		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
 		lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;

