Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61037CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kmprfFlDlZNdLdLsWAx3RXKKM6s9jiwhRynsOf1e1lY=; b=FQ0KtmvDoCrxwyapJ8uWrPE8ia
	AgHi8FN3AjMgVQZ+IRFFRvcyF2TyJ1ptksMD1tEdsCAjFNInXLuqVQ/tXoogOYacFDW3tOwzrit6w
	e4xOKvJTUV0G1ODuVcG/i0VXZePDvSjMBnWz+mRRXDKGB2Tbq0tVaGZYGXGKQs1ep5WNWy/cuV7oV
	Nj6o9Jkt7n91C10b3ASHPoQjR4v8xHAwXE7jL3Uyz0jQwBlsVshHqSZJBTY9whC49WkvSklGLFZQV
	MEptfcrEkmalp2jbekWTXr2Y+CX+9GlYdywffyu3cTgqF5Wm34vSGGC1lPX4DSYgm29wEg6fuYLZ/
	OMqxh7yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFtCy-00000009nNd-3Vxi;
	Mon, 03 Nov 2025 11:58:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFtCw-00000009nMn-1c6t
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 11:58:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51433227A87; Mon,  3 Nov 2025 12:58:41 +0100 (CET)
Date: Mon, 3 Nov 2025 12:58:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, hare@suse.de, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Message-ID: <20251103115841.GA16274@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-4-alistair.francis@wdc.com> <20251031140541.GB17006@lst.de> <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_035846_568923_1B3B6AF2 
X-CRM114-Status: GOOD (  20.68  )
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

On Mon, Nov 03, 2025 at 11:47:23AM +1000, Alistair Francis wrote:
> On Sat, Nov 1, 2025 at 12:05 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Oct 30, 2025 at 01:51:14PM +1000, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > > This can be done by writing the queue ID to te sysfs file.
> > >
> > > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> > >
> > > Note that only QID 0 (admin queue) is supported.
> >
> > Why pass the queue ID then instead of a boolean value?
> 
> I liked the explicitness of passing a queue ID instead of a bool and
> it allows supporting more queues in the future if that changes in the
> spec.
> 
> I can change it to a bool instead if that's preferred?

I find an "echo 0" for a simple one-shot sysfs file rather confusing.
Given that we're not likely to grow anything else I'd vote against
doing it, but this is no hard NAK if there is consensus to do it
this way by others.

