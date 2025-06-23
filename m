Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABEFC7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 17:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4d82Mq0wa1V9i8zkG3syikZnBBIltpTt60yz8LBgSOA=; b=S5/AqTY8nHoNfzUCXnsfnAARHF
	+2sWDqwdo7j8vaAg+oWXS7bwGqUy40vyruhpT7DPP8jvax0hdUEz5v/paMVbRItP7Xz9UGTUWj5tL
	6ufU4U2vzy+Nsj+IHpPcovcJsSzx0VKvKM7yUeaix/xCdxE/XR9Hmdyfwv46WIEC8IclKK0FDPa4w
	b/9BJak9yQsCI53EHDer+3szCbEeujwpzbwcuPVGwFZZx5N0wN+3CgiU4RnwUhr1AKpYphOURBG+Q
	8dBIV7Pa/VdaEtDC1B6wXslKsRvwuvMJZy3dWX8hZLo0MMYtvSZFzaW7tG2nu0tNTm3r10xA7rdAx
	GrleAUgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTkZk-00000003VLL-2IxU;
	Mon, 23 Jun 2025 17:03:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThIT-00000002t1O-0Yp3
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 13:33:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BBD9227A87; Mon, 23 Jun 2025 15:33:10 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:33:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: fix atomic limits check
Message-ID: <20250623133309.GA27241@lst.de>
References: <20250611055432.2401372-1-hch@lst.de> <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com> <20250616053627.GF1148@lst.de> <790a0419-4087-4181-b290-15db01ac1d34@oracle.com> <20250618053213.GA28614@lst.de> <9d0692b3-4d49-443f-b6f6-b13ec9a44f3b@oracle.com> <20250618171750.GA29321@lst.de> <89d34af5-6ad5-4579-8203-ac28d9432cf3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89d34af5-6ad5-4579-8203-ac28d9432cf3@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_063317_318605_C3EECA4C 
X-CRM114-Status: GOOD (  16.47  )
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

On Wed, Jun 18, 2025 at 11:30:20AM -0700, alan.adamson@oracle.com wrote:
>> Can you double check this really is your CTLR2?  At least for me
>> the async probing reorders nvme devices quite a lot with qemu.
>>
> CTRL 0 (nvme0) - AWUN=31 AWUPF=15       nvme1n2
> CTRL 1 (nvme1) - AWUN=31 AWUPF=31       nvme1n1
> CTRL 2 (nvme2) - AWUN=15 AWUPF=7         nvme1n3
> CTRL 3 (nvme3) - AWUN=15 AWUPF=15

Do you mean AWUN or AWUPF?  Because AWUN is totally irrelevant and
not even parsed by Linux.

> I rebooted and it probed differently.  Now CTRL2 is nvme1n3.  We know 
> CTRL2 is the same as nvme1n3 because awun and awupf from nvme id-ctrl 
> matches the qemu config (atomic.awun=15,atomic.awupf=7) for CTRL2 (nvme2).
>
> # nvme id-ctrl /dev/nvme1n3 | grep awun
> awun      : 15
> # nvme id-ctrl /dev/nvme1n3 | grep awupf
> awupf     : 7
> # cat /sys/block/nvme1n3/queue/atomic_write_max_bytes
> 8192

The code in nvme_configure_atomic_write calculates the values pretty
much directly from (N)AWUPF, so I don't see how it would get things
wrong.  Can you run your patched qemu setup with this debug printk
patch?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3da5ac71a9b0..245397b217f4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2033,6 +2033,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+		dev_info(ns->ctrl->device, "NAWUPF: %u, atomic_bs: %u\n",
+			le16_to_cpu(id->nabspf), atomic_bs);
 	} else {
 		/*
 		 * Use the controller wide atomic write unit.  This sucks
@@ -2042,6 +2044,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		 * values for different controllers in the subsystem.
 		 */
 		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+		dev_info(ns->ctrl->device, "AWUPF: %u, atomic_bs: %u\n",
+			ns->ctrl->subsys->awupf, atomic_bs);
 	}
 
 	lim->atomic_write_hw_max = atomic_bs;

