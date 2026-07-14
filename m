Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB181C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qw/lT9y7ItB1KG5z1JnpfbuuqV+YOkJXg3H8nFfSkYU=; b=zED3QTAmMcKe9UTB2tiTOw5JtK
	KRfnzuAYGlPzVtikIIO9lrWQDM9MT+Hx1Sq21lIbrjZX9HjkrEcqpA1mteFl4VrxT/eXg7lkLdJiA
	CEPAA3bBwd1nVwZt2VaT87Yjxjarr5oz1yaCdiG9lC6qtTkMVowrVK8bXF4rYaArEZYrZE1fjNUZs
	XqKgfFlKHiXZazOis8QKvKw1n5hZ83RDV8Ifs7lLjKuY6skhbk9At5pB7o+ZqiU1n/7/pqQTboJDb
	fZL87YapDCZsPgboSavXjv1UaGOnYMbKUrXp04woGzhQqkTx7eAI+LsYVBbTzYxNHFza+yqtt1PXG
	EASVm+Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdSX-0000000CEGF-3X3g;
	Tue, 14 Jul 2026 13:46:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdSW-0000000CEFV-0tS3
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 13:46:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D70168B05; Tue, 14 Jul 2026 15:45:59 +0200 (CEST)
Date: Tue, 14 Jul 2026 15:45:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] block: use integrity interval instead of sector
 as seed
Message-ID: <20260714134558.GA714@lst.de>
References: <20260627054220.2174166-1-csander@purestorage.com> <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_064604_403260_3B81C54B 
X-CRM114-Status: GOOD (  28.05  )
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

On Sun, Jul 12, 2026 at 07:09:01PM -0400, Martin K. Petersen wrote:
> 
> Caleb,
> 
> > The block integrity layer currently sets the integrity seed (initial
> > reference tag) in units of 512-byte sectors.
> 
> ... because that is the fundamental addressing unit in the block layer.
> 
> > However, Type 1 and Type 2 ref tags are actually in units of integrity
> > intervals.
> 
> They are not in units of anything until they reach their final
> protection envelope.

If that is the assumption we need to clearly specify that somewhere,
and also explain why that is a good idea.

Most users of bip_set_seed seem to assume it is in integrity interval
units, see commits:

e4dc9a4c31fe10d1751c542702afc85be8a5c56a
c6e3f13398123a008cd2ee28f93510b113a32791
3d8b5a22d40435b4a7e58f06ae2cd3506b222898

so we'll need to find out a way to come up with interfaces that
just do the right thing.

> 
> > On devices with integrity interval size > 512 bytes, ref tags are
> > seeded incorrectly.
> 
> The bip seed is whatever the caller decides it should be. The integrity
> interval size is irrelevant. As is the destination LBA.
> 
> > But REQ_OP_ZONE_APPEND operations don't have their ref tags remapped,
> > so the ref tags using units of sectors will be stored to the device.
> 
> Then there's a problem with how we handle REQ_OP_ZONE_APPEND. For NVMe,
> the PIREMAP flag should address this issue by remapping the written ref
> tags based on their ultimate destination LBA.

PIREMAP expects the ref tag to be in logical block sized units.

> Fundamentally, you should be able to set the bip seed for any READ or
> WRITE bio to 42, regardless of logical block size, and have it work. If
> it doesn't, then that's a bug.
> 
> The fact that the block layer happens to know the start LBA or ZSLBA
> does not mean that callers above the block layer have access to the same
> information. Changing the block layer's integrity handling semantics is
> not the correct approach. Everything above the block layer depends on
> the existing, format-agnostic, semantics.

We have 4 callers above the block layer, and all of them know that the
see is the LBA.  For type 1 that is enforced by hardware, and all the
Linux code is basically based around a type 1 model, which is emulate
don type 2 PI and type 3 PI using the available means.


