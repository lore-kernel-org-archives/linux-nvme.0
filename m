Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4272C44520
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zRXSsjetSNYmOmOpH4xZfFcfMKaYN7wbn4FF3fVhydY=; b=CUBBwzuEAPO4UG
	Wawvm1ke/UHiCCyMI+ZbGTzcLeSe/3PqaKn0yhwlW+x96JcxvlSCCYbPdBLCGq/CeZ1bKgTHVvyyi
	qsB5PDR3i0jii7gfRb7PeZ/57oCf1uHkTc7BkvZS3+W5keQgVEUslnoRTnpdtQY16yykHuw/E5ZoC
	BpBbHHxHl8nEEHLPZyl2l6ZIdAfXd8xD2sMTdk3qtLpLUII2JIPpnPxUaX4kkPV6HCe7RmeI8GfmW
	DFODbEOnOSV/YPW6xRGlA6+NxgrqTp4+Cc3+JPyBCEHM0Lfa2x1OMlHGGBvGbPgC9I91wj0dMSNK+
	AUrbnAa1/jJ7xbAnR4Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlquR-00000007OEu-2jyT;
	Mon, 20 Jul 2026 16:32:03 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlquO-00000007OEH-2hdV
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 16:32:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=zRXSsjetSNYmOmOpH4xZfFcfMKaYN7wbn4FF3fVhydY=; b=lu6ScZzex9t767shyeadjkHcFD
	jIqOWVpDXLzH+x+Mxens/YQbWgwnbTdrItugJiyyQ6s5a0eoVQO5pv5Fw6m7/ZqjaC/AsU+8agptk
	dxyBdIWv6+aOEcZ1V9TCQvVOAwQHWxCW+522D8Ub0p810QnoT2jAiWPhagI0ntygCSuHN/4t1vQWE
	rxV9WdalxfZcqnRe3d1Hm3UwixD+t7sIrnp7+NF7jfVcArBN/XIwcYuemobzZOoicHIwRzUWEvaXy
	Zh0QKgCHSo+BYE2Loz8uVv9nj0w+nW/oQdz3w04MRD43RSbz+0WbaYCp5+aLZIgU/YdJc+L9Oqr1q
	bizf4Ong==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wlquI-0000000B6Re-11GA;
	Mon, 20 Jul 2026 10:31:55 -0600
Message-ID: <66e72dfa-cb03-49ea-ac52-cb171edef6e4@deltatee.com>
Date: Mon, 20 Jul 2026 10:31:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260719105327.864949-1-mykola@meshstor.io>
 <20260719105327.864949-5-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260719105327.864949-5-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 4/7] md/raid1: don't use write-behind for P2PDMA bios
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_093200_685603_F82764EA 
X-CRM114-Status: GOOD (  11.27  )
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



On 2026-07-19 04:53, Mykola Marzhan wrote:
> alloc_behind_master_bio() copies the bio's data with bio_copy_data(),
> a CPU copy. P2PDMA pages are peer device (BAR) memory; generic code
> must not assume CPU load/store access to them is safe or fast on
> every architecture, and bouncing peer memory through the CPU defeats
> the point of a peer-to-peer transfer.
> 
> Skip write-behind for P2PDMA bios: they are written directly to all
> members, including write-mostly ones.  Ordering against write-behind
> I/O in flight to overlapping sectors is preserved: the non-behind
> clone path serializes on CollisionCheck rdevs (see the preceding
> fix), which covers these bios like any other write that bypasses
> write-behind.
> 
> Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Looks correct to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


