Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE95FA373D
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TEfpt3shKtDtUgAI58VHX5BrHV8U0s5+ShuT+jsFWXY=; b=ZJ2VyzDxA4yC5HPNNttIS4dneH
	BvlyzszYs2xW6wU7yGCaZ0tC5RXaWNmeNj8L59gMq8gfhsnSZ+aokdAyM9/WdbkaHqUUHV2pAb59A
	dDjSczblueyT4tX5UckE/WWIWVUl9eM+nDJmEgdVQqTG9p1GuX/N4C5F81K4joeC24PTOEg8k5AUp
	i8hKSC5zHHHzCCpDsz18HUN6hGASeKd4iM4iIUOFtqR+r5y3Ys81B/JA9zejvZmVjDtseKmohciie
	CkVjpf348Kh3fZw2kOWcPEWDchNIrr4yR7Zxywp5V6KeULuKu83hQE3JjzrmB0tlaBnDiqNZJXWbp
	5rZmkXNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3YQ-00E7wV-4B; Sun, 30 Oct 2022 08:20:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3YN-00E7uG-Ei
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:20:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1D8968AA6; Sun, 30 Oct 2022 09:20:20 +0100 (CET)
Date: Sun, 30 Oct 2022 09:20:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH v3 12/19] block,nvme,scsi,dm: Add blk_status to pr_ops
 callouts
Message-ID: <20221030082020.GC4774@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-13-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-13-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_012023_673042_BBC8B992 
X-CRM114-Status: GOOD (  14.50  )
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

On Wed, Oct 26, 2022 at 06:19:38PM -0500, Mike Christie wrote:
> To handle both cases and keep userspace compatibility, this patch adds a
> blk_status_t arg to the pr_ops callouts. The lower levels will convert
> their device specific error to the blk_status_t then the upper levels
> can easily check that code without knowing the device type. Adding the
> extra return value will then allow us to not break userspace which expects
> a negative -Exyz error code if the command fails before it's sent to the
> device or a device/driver specific value if the error is > 0.

I really hate this double error return.  What -E* statuses that matter
can be returned without a BLK_STS_* equivalent that we couldn't convert
to and from?

