Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0E2EE645A
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NS3A/wDXuHYPGPdB1h6Hg2EDWAf3KiCaSYmk3JexGv8=; b=Kr7f8vV+y2K3TeesL09IEvIbyP
	ROYEiE1VSFvr1gVR+0kyYsbeeDNoTqpQjGmS7HmSO58ceEM0JcK1vHQrUGLx6Cf4HuHzqPj0kiDdM
	vVES+gozOIJ+5rnNTXZMR+w41k+Dw/yvlsR7EZ+TN6MeC7XQnMjHMSffNmsX0nwyN8LzlpnsuorsM
	T7QA4PGTgEiNpfG/hs0EMsx8FBk4tnjtabzx2XfM5YS4Zpm4FqugbIX9em3FpHgMQfnP1vhcxbRyO
	d8UA6kahTw5wjr2UJhA5bQqFmUkPB1ccrnukrYZjpPxBKfrTMHK6oOFD0YKkBcghuj/sbhNHGOLus
	xSo/+7mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soeUu-0000000CEQ3-0OFU;
	Thu, 12 Sep 2024 07:44:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soeUs-0000000CEPF-0NzU
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 07:44:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8694D68AFE; Thu, 12 Sep 2024 09:44:07 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:44:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 06/10] block: provide helper for nr_integrity_segments
Message-ID: <20240912074407.GB8375@lst.de>
References: <20240911201240.3982856-1-kbusch@meta.com> <20240911201240.3982856-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911201240.3982856-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_004410_296586_762404F7 
X-CRM114-Status: GOOD (  10.36  )
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

On Wed, Sep 11, 2024 at 01:12:36PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide an integrity equivalent to blk_rq_nr_phys_segments().

Now that the field is unconditional the helper seems a bit pointless.
blk_rq_nr_phys_segments is mostly need for the special payload magic
for discard.


